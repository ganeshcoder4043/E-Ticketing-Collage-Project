<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Book E-Ticket — ${monument.name}" />
<c:set var="activePage" value="monuments" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding: 30px 0 60px;">

    <!-- Breadcrumbs -->
    <div style="margin-bottom: 20px;">
        <p style="font-size: 0.85rem; color: var(--color-text-muted);">
            <a href="${pageContext.request.contextPath}/home" style="color: var(--color-primary); text-decoration: none;">Home</a> &gt; 
            <a href="${pageContext.request.contextPath}/monuments" style="color: var(--color-primary); text-decoration: none;">Monuments</a> &gt; 
            <a href="${pageContext.request.contextPath}/monument-detail?id=${monument.mouId}" style="color: var(--color-primary); text-decoration: none;">${monument.name}</a> &gt; 
            <span>Book Tickets</span>
        </p>
    </div>

    <!-- Booking Progress Indicator -->
    <div style="display: flex; justify-content: center; margin-bottom: 30px;">
        <div style="display: flex; align-items: center; gap: 12px; font-size: 0.9rem; font-weight: 700;">
            <div style="display: flex; align-items: center; gap: 6px; color: var(--color-saffron);">
                <span style="width: 28px; height: 28px; border-radius: 50%; background: var(--color-saffron); color: white; display: flex; align-items: center; justify-content: center;">1</span>
                <span>Select Date &amp; Visitors</span>
            </div>
            <span style="color: #cbd5e1;">&mdash;&mdash;&gt;</span>
            <div style="display: flex; align-items: center; gap: 6px; color: #94a3b8;">
                <span style="width: 28px; height: 28px; border-radius: 50%; background: #e2e8f0; color: #64748b; display: flex; align-items: center; justify-content: center;">2</span>
                <span>Payment</span>
            </div>
            <span style="color: #cbd5e1;">&mdash;&mdash;&gt;</span>
            <div style="display: flex; align-items: center; gap: 6px; color: #94a3b8;">
                <span style="width: 28px; height: 28px; border-radius: 50%; background: #e2e8f0; color: #64748b; display: flex; align-items: center; justify-content: center;">3</span>
                <span>E-Ticket</span>
            </div>
        </div>
    </div>

    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 30px;">

        <!-- Left: Form -->
        <div style="background: white; border-radius: 12px; border: 1px solid var(--color-border); padding: 28px; box-shadow: var(--shadow-sm);">
            
            <!-- Monument Mini Banner -->
            <div style="display: flex; gap: 16px; align-items: center; padding-bottom: 20px; border-bottom: 1px solid #f1f5f9; margin-bottom: 24px;">
                <img src="${not empty monument.imageUrl ? monument.imageUrl : 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800'}" 
                     alt="${monument.name}" 
                     style="width: 80px; height: 80px; border-radius: 8px; object-fit: cover;" />
                <div>
                    <span class="monument-badge" style="position: static; display: inline-block; margin-bottom: 4px;">${monument.type}</span>
                    <h2 style="font-size: 1.4rem; font-weight: 800; color: var(--color-primary);">${monument.name}</h2>
                    <p style="font-size: 0.85rem; color: var(--color-text-muted);">&#128205; ${monument.city}, ${monument.state}</p>
                </div>
            </div>

            <!-- Booking Form (POST) -->
            <form action="${pageContext.request.contextPath}/book-ticket" method="post">
                <input type="hidden" name="mouId" value="${monument.mouId}">

                <h3 style="font-size: 1.1rem; font-weight: 700; color: var(--color-primary); margin-bottom: 16px;">
                    1. Visit Schedule
                </h3>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 24px;">
                    <!-- Tour Date -->
                    <div class="form-group">
                        <label class="form-label" for="tourDate">Date of Visit *</label>
                        <input type="date" id="tourDate" name="tourDate" class="form-control" 
                               min="${minDate}" max="${maxDate}" 
                               value="${not empty selectedDate ? selectedDate : minDate}" required>
                    </div>

                    <!-- Slot / Time -->
                    <div class="form-group">
                        <label class="form-label" for="departureTime">Visiting Slot *</label>
                        <select id="departureTime" name="departureTime" class="form-select" required>
                            <option value="Forenoon (06:00 AM - 12:00 PM)" ${selectedTime == 'Forenoon (06:00 AM - 12:00 PM)' ? 'selected' : ''}>
                                Forenoon (06:00 AM - 12:00 PM)
                            </option>
                            <option value="Afternoon (12:00 PM - 06:00 PM)" ${selectedTime == 'Afternoon (12:00 PM - 06:00 PM)' ? 'selected' : ''}>
                                Afternoon (12:00 PM - 06:00 PM)
                            </option>
                        </select>
                    </div>
                </div>

                <h3 style="font-size: 1.1rem; font-weight: 700; color: var(--color-primary); margin-bottom: 16px;">
                    2. Visitor Counts
                </h3>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 24px;">
                    <!-- Adults -->
                    <div class="form-group">
                        <label class="form-label" for="adult">
                            Adults (15+ Years) * &mdash; ₹<fmt:formatNumber value="${monument.fare}" pattern="#,##0.00" />
                        </label>
                        <input type="number" id="adult" name="adult" class="form-control" min="1" max="20" 
                               value="${not empty selectedAdult ? selectedAdult : '1'}" required>
                    </div>

                    <!-- Children -->
                    <div class="form-group">
                        <label class="form-label" for="child">
                            Children (&lt; 15 Years) &mdash; FREE
                        </label>
                        <input type="number" id="child" name="child" class="form-control" min="0" max="20" 
                               value="${not empty selectedChild ? selectedChild : '0'}">
                    </div>
                </div>

                <h3 style="font-size: 1.1rem; font-weight: 700; color: var(--color-primary); margin-bottom: 16px;">
                    3. Contact Person Information
                </h3>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 24px;">
                    <div class="form-group">
                        <label class="form-label" for="contactName">Lead Visitor Name *</label>
                        <input type="text" id="contactName" name="contactName" class="form-control" 
                               placeholder="e.g. Rahul Sharma" 
                               value="${not empty contactName ? contactName : sessionScope.user.fullName}" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="contactPhone">Mobile Number *</label>
                        <input type="tel" id="contactPhone" name="contactPhone" class="form-control" 
                               placeholder="10-digit mobile number" 
                               value="${not empty contactPhone ? contactPhone : sessionScope.user.contact}" required>
                    </div>
                </div>

                <!-- Terms -->
                <div style="margin-bottom: 24px;">
                    <label style="display: flex; align-items: flex-start; gap: 10px; font-size: 0.88rem; color: #475569; cursor: pointer;">
                        <input type="checkbox" name="terms" value="accepted" checked required style="margin-top: 3px; width: 18px; height: 18px;">
                        <span>
                            I agree to the <strong>ASI Monument Entry Guidelines</strong> and declare that the visitor details provided match the government photo ID to be presented at the gate.
                        </span>
                    </label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary btn-lg btn-block">
                    Proceed to Payment Options &rarr;
                </button>
            </form>

        </div>

        <!-- Right: Fare Summary Card -->
        <div>
            <div style="background: white; border-radius: 12px; border: 1.5px solid var(--color-border); padding: 24px; box-shadow: var(--shadow-sm); position: sticky; top: 90px;">
                <h3 style="font-size: 1.15rem; font-weight: 700; color: var(--color-primary); margin-bottom: 16px; border-bottom: 1px solid #f1f5f9; padding-bottom: 10px;">
                    Fare Structure
                </h3>

                <div style="display: flex; flex-direction: column; gap: 12px; font-size: 0.92rem; color: #475569; margin-bottom: 20px;">
                    <div style="display: flex; justify-content: space-between;">
                        <span>Adult Base Fare:</span>
                        <strong>₹ <fmt:formatNumber value="${monument.fare}" pattern="#,##0.00" /></strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Child Fare (&lt; 15 yrs):</span>
                        <strong style="color: var(--color-green);">FREE (₹0.00)</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>ASI Conservation Cess:</span>
                        <strong>Included</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between; border-top: 1px solid #f1f5f9; padding-top: 12px; font-size: 1.05rem; color: var(--color-primary);">
                        <strong>Ticket Format:</strong>
                        <strong style="color: var(--color-saffron);">Digital QR E-Ticket</strong>
                    </div>
                </div>

                <div class="alert alert-info" style="font-size: 0.82rem; margin-bottom: 0; padding: 10px 14px;">
                    &#128274; Tickets once confirmed can be printed immediately or accessed any time under "My Bookings".
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
