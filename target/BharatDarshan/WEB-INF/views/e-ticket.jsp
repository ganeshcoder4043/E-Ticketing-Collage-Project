<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="E-Ticket #${booking.bookingId} — ${booking.monument.name}" />
<c:set var="activePage" value="bookings" />
<jsp:include page="common/header.jsp" />

<div class="container ticket-print-container" style="padding-top: 20px; padding-bottom: 60px;">

    <!-- Top Action Bar (Hidden in Print) -->
    <div class="no-print" style="max-width: 800px; margin: 0 auto 16px; display: flex; justify-content: space-between; align-items: center;">
        <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-outline-navy btn-sm">
            &larr; Back to My Bookings
        </a>
        <div style="font-size: 0.85rem; color: #475569; background: #e0f2fe; padding: 6px 14px; border-radius: 6px; border: 1px solid #bae6fd;">
            <strong>Print Instructions:</strong> Press <kbd style="background: white; border: 1px solid #94a3b8; padding: 2px 6px; border-radius: 4px; font-weight: bold;">Ctrl + P</kbd> to Print or Save as PDF.
        </div>
    </div>

    <!-- Official ASI E-Ticket Sheet -->
    <div class="ticket-wrapper">
        
        <!-- Header -->
        <div class="ticket-header">
            <div style="display: flex; align-items: center; gap: 14px;">
                <div class="emblem-badge" style="background: white; color: var(--color-primary); font-size: 1.1rem; width: 44px; height: 44px;">
                    ASI
                </div>
                <div>
                    <div class="ticket-header-title">ARCHAEOLOGICAL SURVEY OF INDIA</div>
                    <div class="ticket-header-sub">Government of India &bull; Ministry of Culture &bull; E-Ticketing Division</div>
                </div>
            </div>

            <div style="text-align: right;">
                <div style="font-size: 0.72rem; text-transform: uppercase; color: #cbd5e1;">E-Ticket No.</div>
                <div class="ticket-no-badge">
                    ASI-${booking.bookingId}
                </div>
            </div>
        </div>

        <!-- Ticket Body -->
        <div class="ticket-body">
            
            <!-- Row 1: Monument Details -->
            <div class="ticket-grid">
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Monument Name</span>
                    <span class="ticket-cell-val" style="font-size: 1.1rem; color: var(--color-primary);">
                        ${booking.monument.name}
                    </span>
                </div>
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Circle / Location</span>
                    <span class="ticket-cell-val">${booking.monument.city}, ${booking.monument.state}</span>
                </div>
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Monument Category</span>
                    <span class="ticket-cell-val">${booking.monument.type}</span>
                </div>
            </div>

            <!-- Row 2: Visit & Reservation Schedule -->
            <div class="ticket-grid">
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Date of Visit</span>
                    <span class="ticket-cell-val" style="color: var(--color-saffron); font-size: 1.05rem;">
                        ${booking.tourDate}
                    </span>
                </div>
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Visiting Slot</span>
                    <span class="ticket-cell-val">${booking.departureTime}</span>
                </div>
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Monument Hours</span>
                    <span class="ticket-cell-val" style="font-size: 0.85rem;">${booking.monument.timings}</span>
                </div>
            </div>

            <!-- Row 3: Visitor & Fare Details -->
            <div class="ticket-grid">
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Lead Visitor Name</span>
                    <span class="ticket-cell-val">${booking.contactPersonDetails}</span>
                </div>
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Visitor Breakdown</span>
                    <span class="ticket-cell-val">
                        ${booking.adult} Adult(s), ${booking.child} Child(ren)
                    </span>
                </div>
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Total Amount Paid</span>
                    <span class="ticket-cell-val" style="color: var(--color-green); font-size: 1.1rem;">
                        ₹ <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" />
                    </span>
                </div>
            </div>

            <!-- Row 4: Transaction & Booking Meta -->
            <div class="ticket-grid" style="border-bottom: none; margin-bottom: 8px;">
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Payment Mode</span>
                    <span class="ticket-cell-val">
                        <c:choose>
                            <c:when test="${not empty booking.paymentMode}">
                                ${booking.paymentMode.formattedMode}
                            </c:when>
                            <c:otherwise>Online / Card</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Booking Date &amp; Time</span>
                    <span class="ticket-cell-val" style="font-size: 0.88rem;">${booking.bookingDate}</span>
                </div>
                <div class="ticket-cell">
                    <span class="ticket-cell-label">Booking Status</span>
                    <span class="ticket-cell-val">
                        <c:choose>
                            <c:when test="${booking.status == 1}">
                                <span class="badge badge-confirmed">ACTIVE / CONFIRMED</span>
                            </c:when>
                            <c:when test="${booking.status == 2}">
                                <span class="badge badge-cancelled">CANCELLED</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-completed">COMPLETED</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <!-- Authentic Verification Code (Pure CSS Barcode & Simulated QR Box) -->
            <div class="ticket-barcode-box">
                <div class="qr-code-graphic"></div>
                <div style="font-family: monospace; font-size: 0.85rem; font-weight: bold; color: #334155; margin-top: 4px;">
                    SECURE GATE VERIFICATION QR &bull; ID: ASI-${booking.bookingId}-${booking.sessionId}
                </div>
                <div class="barcode-strip"></div>
            </div>

            <!-- Terms & Security Notice -->
            <div class="ticket-instructions">
                <strong>Important Entry Conditions:</strong>
                <ol style="padding-left: 16px; margin-top: 4px;">
                    <li>This digital E-Ticket is valid only for the date and slot mentioned above.</li>
                    <li>The lead visitor must carry original Government Photo ID (Aadhaar, Passport, Voter ID, Driving License).</li>
                    <li>E-Ticket is non-transferable and can be presented directly on mobile or as a physical printout.</li>
                    <li>Entry closes 30 minutes before official monument closing time.</li>
                </ol>
            </div>

        </div>

    </div>

</div>

<jsp:include page="common/footer.jsp" />
