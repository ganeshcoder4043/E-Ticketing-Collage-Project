<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="My Bookings — BharatDarshan" />
<c:set var="activePage" value="bookings" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding: 30px 0 60px;">

    <!-- Page Header -->
    <div style="margin-bottom: 24px; display: flex; justify-content: space-between; align-items: flex-end; flex-wrap: wrap; gap: 12px;">
        <div>
            <p style="font-size: 0.85rem; color: var(--color-text-muted);">
                <a href="${pageContext.request.contextPath}/home" style="color: var(--color-primary); text-decoration: none;">Home</a> &gt; My Bookings
            </p>
            <h1 style="font-size: 2rem; font-weight: 800; color: var(--color-primary); margin-top: 4px;">
                My Monument E-Tickets
            </h1>
            <p style="color: var(--color-text-muted); font-size: 0.95rem;">
                Manage your ASI monument bookings, download printable e-tickets, or request cancellations.
            </p>
        </div>

        <a href="${pageContext.request.contextPath}/monuments" class="btn btn-primary">
            + Book Another Monument
        </a>
    </div>

    <!-- Bookings Table / List -->
    <c:choose>
        <c:when test="${not empty bookings}">
            <div class="table-responsive" style="box-shadow: var(--shadow-sm);">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Ticket ID</th>
                            <th>Monument</th>
                            <th>Visit Date &amp; Slot</th>
                            <th>Visitors</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th style="text-align: right;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${bookings}">
                            <tr>
                                <!-- Ticket ID -->
                                <td>
                                    <strong style="font-family: monospace; color: var(--color-primary); font-size: 0.95rem;">
                                        #${b.bookingId}
                                    </strong>
                                    <div style="font-size: 0.75rem; color: var(--color-text-muted);">
                                        <fmt:formatDate value="${b.bookingDate}" pattern="dd MMM yyyy" />
                                    </div>
                                </td>

                                <!-- Monument -->
                                <td>
                                    <div style="font-weight: 700; color: #0f172a;">${b.monument.name}</div>
                                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">&#128205; ${b.monument.city}, ${b.monument.state}</div>
                                </td>

                                <!-- Date & Slot -->
                                <td>
                                    <div style="font-weight: 600; color: #1e293b;">${b.tourDate}</div>
                                    <div style="font-size: 0.78rem; color: var(--color-text-muted);">${b.departureTime}</div>
                                </td>

                                <!-- Visitors -->
                                <td>
                                    <span style="font-weight: 600;">${b.totalTickets} total</span>
                                    <div style="font-size: 0.75rem; color: var(--color-text-muted);">
                                        (${b.adult} Adult, ${b.child} Child)
                                    </div>
                                </td>

                                <!-- Amount -->
                                <td>
                                    <strong style="color: var(--color-green);">
                                        ₹ <fmt:formatNumber value="${b.totalAmount}" pattern="#,##0.00" />
                                    </strong>
                                </td>

                                <!-- Status -->
                                <td>
                                    <c:choose>
                                        <c:when test="${b.status == 1}">
                                            <span class="badge badge-confirmed">Confirmed</span>
                                        </c:when>
                                        <c:when test="${b.status == 2}">
                                            <span class="badge badge-cancelled">Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-completed">Completed</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- Actions -->
                                <td style="text-align: right;">
                                    <div style="display: inline-flex; gap: 6px;">
                                        <a href="${pageContext.request.contextPath}/e-ticket?id=${b.bookingId}" class="btn btn-outline-navy btn-sm">
                                            &#128424; E-Ticket
                                        </a>

                                        <c:if test="${b.status == 1}">
                                            <a href="${pageContext.request.contextPath}/cancel-booking?id=${b.bookingId}" class="btn btn-danger btn-sm">
                                                Cancel
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Empty State -->
            <div style="background: white; border: 1px dashed #cbd5e1; border-radius: 12px; padding: 60px 20px; text-align: center; margin: 20px 0;">
                <div style="font-size: 3rem; margin-bottom: 12px;">&#127915;</div>
                <h3 style="font-size: 1.3rem; font-weight: 700; color: var(--color-primary); margin-bottom: 8px;">No Bookings Yet</h3>
                <p style="color: var(--color-text-muted); font-size: 0.95rem; max-width: 450px; margin: 0 auto 20px;">
                    You haven't reserved any monument e-tickets yet. Explore our protected heritage sites across India!
                </p>
                <a href="${pageContext.request.contextPath}/monuments" class="btn btn-primary">
                    Explore Monuments Now &rarr;
                </a>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<jsp:include page="common/footer.jsp" />
