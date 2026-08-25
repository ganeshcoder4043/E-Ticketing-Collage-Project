<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Cancel Ticket #${booking.bookingId} — BharatDarshan" />
<c:set var="activePage" value="bookings" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding: 40px 0 60px;">
    <div style="max-width: 600px; margin: 0 auto;">

        <!-- Breadcrumb -->
        <div style="margin-bottom: 20px;">
            <p style="font-size: 0.85rem; color: var(--color-text-muted);">
                <a href="${pageContext.request.contextPath}/home" style="color: var(--color-primary); text-decoration: none;">Home</a> &gt; 
                <a href="${pageContext.request.contextPath}/my-bookings" style="color: var(--color-primary); text-decoration: none;">My Bookings</a> &gt; 
                <span>Cancel Ticket #${booking.bookingId}</span>
            </p>
        </div>

        <div style="background: white; border-radius: 12px; box-shadow: var(--shadow-md); border: 1px solid var(--color-border); padding: 32px;">

            <!-- Header -->
            <div style="margin-bottom: 20px;">
                <span class="badge badge-cancelled" style="margin-bottom: 8px;">Cancellation Request</span>
                <h1 style="font-size: 1.6rem; font-weight: 800; color: #b91c1c;">
                    Cancel Ticket Reservation
                </h1>
                <p style="font-size: 0.88rem; color: var(--color-text-muted);">
                    Review your refund calculation and confirm ticket cancellation.
                </p>
            </div>

            <!-- Booking Overview Card -->
            <div style="background-color: #f8fafc; border: 1.5px solid #e2e8f0; border-radius: 8px; padding: 18px; margin-bottom: 24px;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span style="font-size: 0.85rem; color: #64748b;">Monument:</span>
                    <strong style="color: #0f172a;">${booking.monument.name}</strong>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span style="font-size: 0.85rem; color: #64748b;">Date of Visit:</span>
                    <strong style="color: #0f172a;">${booking.tourDate} (${booking.departureTime})</strong>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span style="font-size: 0.85rem; color: #64748b;">Visitors:</span>
                    <strong style="color: #0f172a;">${booking.adult} Adult(s), ${booking.child} Child(ren)</strong>
                </div>
                <div style="display: flex; justify-content: space-between; border-top: 1px solid #e2e8f0; padding-top: 10px;">
                    <span style="font-size: 0.85rem; color: #64748b;">Original Paid Amount:</span>
                    <strong style="color: #0f172a;">₹ <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></strong>
                </div>
            </div>

            <!-- Refund Calculation Breakdown -->
            <div style="background-color: #fef2f2; border: 1.5px solid #fecaca; border-radius: 8px; padding: 18px; margin-bottom: 24px;">
                <h4 style="font-size: 0.95rem; font-weight: 700; color: #991b1b; margin-bottom: 12px;">
                    Refund Calculation (ASI Standard 80% Refund Policy)
                </h4>

                <div style="display: flex; flex-direction: column; gap: 8px; font-size: 0.88rem;">
                    <div style="display: flex; justify-content: space-between;">
                        <span>Total Paid Fare:</span>
                        <span>₹ <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></span>
                    </div>
                    <div style="display: flex; justify-content: space-between; color: #dc2626;">
                        <span>Cancellation Fee (20%):</span>
                        <span>- ₹ <fmt:formatNumber value="${deductedAmount}" pattern="#,##0.00" /></span>
                    </div>
                    <div style="display: flex; justify-content: space-between; border-top: 1.5px solid #fecaca; padding-top: 8px; font-weight: 800; font-size: 1.05rem; color: #15803d;">
                        <span>Refund Amount:</span>
                        <span>₹ <fmt:formatNumber value="${refundAmount}" pattern="#,##0.00" /></span>
                    </div>
                </div>
            </div>

            <!-- Cancellation Form (POST) -->
            <form action="${pageContext.request.contextPath}/cancel-booking" method="post">
                <input type="hidden" name="bookingId" value="${booking.bookingId}">

                <div class="form-group" style="margin-bottom: 18px;">
                    <label class="form-label" for="cancelReason">Reason for Cancellation</label>
                    <select id="cancelReason" name="cancelReason" class="form-select" required>
                        <option value="Change of Travel Itinerary">Change of Travel Itinerary</option>
                        <option value="Personal Emergency / Health Issue">Personal Emergency / Health Issue</option>
                        <option value="Weather / Transport Disruption">Weather / Transport Disruption</option>
                        <option value="Booked by Mistake / Wrong Date">Booked by Mistake / Wrong Date</option>
                        <option value="Other Reasons">Other Reasons</option>
                    </select>
                </div>

                <div style="margin-bottom: 24px;">
                    <label style="display: flex; align-items: flex-start; gap: 10px; font-size: 0.85rem; color: #475569; cursor: pointer;">
                        <input type="checkbox" name="confirmCancel" value="yes" required style="margin-top: 3px; width: 18px; height: 18px;">
                        <span>
                            I confirm that I want to cancel this booking. I understand that the e-ticket will be invalidated immediately and refund will be credited back.
                        </span>
                    </label>
                </div>

                <div style="display: flex; gap: 12px;">
                    <button type="submit" class="btn btn-danger btn-lg" style="flex: 1;">
                        Confirm Cancellation &rarr;
                    </button>
                    <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-outline-navy btn-lg" style="flex: 1;">
                        Keep Ticket
                    </a>
                </div>
            </form>

        </div>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
