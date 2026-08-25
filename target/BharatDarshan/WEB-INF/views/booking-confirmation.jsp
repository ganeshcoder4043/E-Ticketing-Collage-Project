<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Booking Confirmed — BharatDarshan" />
<c:set var="activePage" value="bookings" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding: 40px 0 60px;">
    <div style="max-width: 650px; margin: 0 auto;">

        <div style="background: white; border-radius: 12px; box-shadow: var(--shadow-md); border: 1px solid var(--color-border); padding: 36px; text-align: center;">

            <!-- Success Badge -->
            <div style="width: 64px; height: 64px; border-radius: 50%; background-color: #dcfce7; color: #15803d; font-size: 2rem; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; border: 2px solid #bbf7d0;">
                &#10004;
            </div>

            <h1 style="font-size: 1.8rem; font-weight: 800; color: var(--color-primary); margin-bottom: 6px;">
                Booking Confirmed!
            </h1>
            <p style="font-size: 0.95rem; color: var(--color-text-muted); margin-bottom: 24px;">
                Your ASI Monument E-Ticket has been successfully generated and issued.
            </p>

            <!-- Booking Summary Box -->
            <div style="background-color: #f8fafc; border: 1.5px solid #e2e8f0; border-radius: 8px; padding: 20px; text-align: left; margin-bottom: 28px;">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                    <div>
                        <span class="ticket-cell-label">E-Ticket / Booking ID</span>
                        <div style="font-size: 1.15rem; font-weight: 800; color: var(--color-saffron); font-family: monospace;">
                            #${confirmedBooking.bookingId}
                        </div>
                    </div>
                    <div>
                        <span class="ticket-cell-label">Date of Visit</span>
                        <div class="ticket-cell-val">${confirmedBooking.tourDate}</div>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px; border-top: 1px solid #f1f5f9; padding-top: 12px;">
                    <div>
                        <span class="ticket-cell-label">Monument</span>
                        <div class="ticket-cell-val">${confirmedBooking.monument.name}</div>
                        <div style="font-size: 0.8rem; color: var(--color-text-muted);">${confirmedBooking.monument.city}, ${confirmedBooking.monument.state}</div>
                    </div>
                    <div>
                        <span class="ticket-cell-label">Slot</span>
                        <div class="ticket-cell-val">${confirmedBooking.departureTime}</div>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; border-top: 1px solid #f1f5f9; padding-top: 12px;">
                    <div>
                        <span class="ticket-cell-label">Total Visitors</span>
                        <div class="ticket-cell-val">
                            ${confirmedBooking.adult} Adult(s) + ${confirmedBooking.child} Child(ren)
                        </div>
                    </div>
                    <div>
                        <span class="ticket-cell-label">Total Paid</span>
                        <div class="ticket-cell-val" style="color: var(--color-green); font-size: 1.1rem;">
                            ₹ <fmt:formatNumber value="${confirmedBooking.totalAmount}" pattern="#,##0.00" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div style="display: flex; gap: 12px; justify-content: center; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/e-ticket?id=${confirmedBooking.bookingId}" class="btn btn-primary btn-lg" style="flex: 1; min-width: 200px;">
                    &#128424; View &amp; Print E-Ticket
                </a>
                <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-outline-navy btn-lg" style="flex: 1; min-width: 200px;">
                    My Bookings History
                </a>
            </div>

        </div>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
