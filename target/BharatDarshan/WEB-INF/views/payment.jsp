<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Payment Options — BharatDarshan" />
<c:set var="activePage" value="monuments" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding: 30px 0 60px;">

    <!-- Breadcrumb & Step Progress -->
    <div style="margin-bottom: 20px;">
        <p style="font-size: 0.85rem; color: var(--color-text-muted);">
            <a href="${pageContext.request.contextPath}/home" style="color: var(--color-primary); text-decoration: none;">Home</a> &gt; 
            <a href="${pageContext.request.contextPath}/monuments" style="color: var(--color-primary); text-decoration: none;">Monuments</a> &gt; 
            <span>Payment Options</span>
        </p>
    </div>

    <!-- Booking Progress Indicator -->
    <div style="display: flex; justify-content: center; margin-bottom: 30px;">
        <div style="display: flex; align-items: center; gap: 12px; font-size: 0.9rem; font-weight: 700;">
            <div style="display: flex; align-items: center; gap: 6px; color: var(--color-green);">
                <span style="width: 28px; height: 28px; border-radius: 50%; background: var(--color-green); color: white; display: flex; align-items: center; justify-content: center;">&#10004;</span>
                <span>Date &amp; Visitors</span>
            </div>
            <span style="color: #cbd5e1;">&mdash;&mdash;&gt;</span>
            <div style="display: flex; align-items: center; gap: 6px; color: var(--color-saffron);">
                <span style="width: 28px; height: 28px; border-radius: 50%; background: var(--color-saffron); color: white; display: flex; align-items: center; justify-content: center;">2</span>
                <span>Payment Options</span>
            </div>
            <span style="color: #cbd5e1;">&mdash;&mdash;&gt;</span>
            <div style="display: flex; align-items: center; gap: 6px; color: #94a3b8;">
                <span style="width: 28px; height: 28px; border-radius: 50%; background: #e2e8f0; color: #64748b; display: flex; align-items: center; justify-content: center;">3</span>
                <span>E-Ticket</span>
            </div>
        </div>
    </div>

    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 30px;">

        <!-- Left: Payment Modes Form (Pure CSS interactive tabs) -->
        <div style="background: white; border-radius: 12px; border: 1px solid var(--color-border); padding: 28px; box-shadow: var(--shadow-sm);">
            
            <h2 style="font-size: 1.4rem; font-weight: 800; color: var(--color-primary); margin-bottom: 6px;">
                Select Payment Method
            </h2>
            <p style="font-size: 0.88rem; color: var(--color-text-muted); margin-bottom: 24px;">
                All transactions are encrypted with 256-bit SSL gateway security.
            </p>

            <form action="${pageContext.request.contextPath}/process-payment" method="post">

                <!-- Hidden CSS Radio Controllers for Pure-CSS Tab Switching -->
                <input type="radio" id="mode-credit" name="paymentMode" value="CREDIT_CARD" class="mode-radio-input" ${empty selectedMode or selectedMode == 'CREDIT_CARD' ? 'checked' : ''}>
                <input type="radio" id="mode-debit" name="paymentMode" value="DEBIT_CARD" class="mode-radio-input" ${selectedMode == 'DEBIT_CARD' ? 'checked' : ''}>
                <input type="radio" id="mode-netbank" name="paymentMode" value="NET_BANKING" class="mode-radio-input" ${selectedMode == 'NET_BANKING' ? 'checked' : ''}>
                <input type="radio" id="mode-cash" name="paymentMode" value="CASH" class="mode-radio-input" ${selectedMode == 'CASH' ? 'checked' : ''}>

                <!-- Radio Button Labels Header -->
                <div class="payment-mode-radios" style="grid-template-columns: repeat(4, 1fr);">
                    <label for="mode-credit" class="mode-radio-label">
                        <span style="font-size: 1.3rem;">&#128179;</span>
                        <span>Credit Card</span>
                    </label>

                    <label for="mode-debit" class="mode-radio-label">
                        <span style="font-size: 1.3rem;">&#128179;</span>
                        <span>Debit Card</span>
                    </label>

                    <label for="mode-netbank" class="mode-radio-label">
                        <span style="font-size: 1.3rem;">&#127963;</span>
                        <span>Net Banking</span>
                    </label>

                    <label for="mode-cash" class="mode-radio-label">
                        <span style="font-size: 1.3rem;">&#128181;</span>
                        <span>Cash / Counter</span>
                    </label>
                </div>

                <!-- Pure CSS Dynamic Tab Forms Container -->
                <div class="payment-forms-container" style="background-color: #f8fafc; border: 1.5px solid #e2e8f0; border-radius: 8px; padding: 20px; margin-bottom: 24px;">
                    
                    <!-- TAB 1: Credit Card -->
                    <div class="tab-content-credit">
                        <h4 style="font-size: 1rem; font-weight: 700; color: var(--color-primary); margin-bottom: 16px;">
                            Enter Credit Card Details
                        </h4>

                        <div class="form-group" style="margin-bottom: 14px;">
                            <label class="form-label">Card Number</label>
                            <input type="text" name="cardNumber" class="form-control" placeholder="XXXX-XXXX-XXXX-XXXX" maxlength="19" value="4532 8921 4410 8823">
                        </div>

                        <div class="form-group" style="margin-bottom: 14px;">
                            <label class="form-label">Card Holder Name</label>
                            <input type="text" name="cardHolderName" class="form-control" placeholder="Name as printed on card" value="${booking.user.fullName}">
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 14px;">
                            <div class="form-group">
                                <label class="form-label">Expiry (MM/YYYY)</label>
                                <input type="text" name="expiryDate" class="form-control" placeholder="12/2028" maxlength="7" value="12/2028">
                            </div>
                            <div class="form-group">
                                <label class="form-label">CVV / Security Code</label>
                                <input type="password" name="ccvNo" class="form-control" placeholder="3 digits" maxlength="4" value="882">
                            </div>
                        </div>
                    </div>

                    <!-- TAB 2: Debit Card -->
                    <div class="tab-content-debit">
                        <h4 style="font-size: 1rem; font-weight: 700; color: var(--color-primary); margin-bottom: 16px;">
                            Enter Debit Card (ATM Card) Details
                        </h4>

                        <div class="form-group" style="margin-bottom: 14px;">
                            <label class="form-label">Debit Card Number</label>
                            <input type="text" name="cardNumber" class="form-control" placeholder="XXXX-XXXX-XXXX-XXXX" maxlength="19" value="5241 6320 9182 4589">
                        </div>

                        <div class="form-group" style="margin-bottom: 14px;">
                            <label class="form-label">Card Holder Name</label>
                            <input type="text" name="cardHolderName" class="form-control" placeholder="Name as printed on card" value="${booking.user.fullName}">
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 14px;">
                            <div class="form-group">
                                <label class="form-label">Expiry (MM/YYYY)</label>
                                <input type="text" name="expiryDate" class="form-control" placeholder="08/2029" maxlength="7" value="08/2029">
                            </div>
                            <div class="form-group">
                                <label class="form-label">CVV / PIN</label>
                                <input type="password" name="ccvNo" class="form-control" placeholder="3 digits" maxlength="4" value="459">
                            </div>
                        </div>
                    </div>

                    <!-- TAB 3: Net Banking -->
                    <div class="tab-content-netbank">
                        <h4 style="font-size: 1rem; font-weight: 700; color: var(--color-primary); margin-bottom: 16px;">
                            Select Your Bank
                        </h4>

                        <div class="form-group">
                            <label class="form-label">Choose Bank</label>
                            <select name="bankName" class="form-select">
                                <option value="SBI">State Bank of India (SBI)</option>
                                <option value="HDFC">HDFC Bank</option>
                                <option value="ICICI">ICICI Bank</option>
                                <option value="PNB">Punjab National Bank (PNB)</option>
                                <option value="BOB">Bank of Baroda</option>
                                <option value="AXIS">Axis Bank</option>
                                <option value="CANARA">Canara Bank</option>
                            </select>
                        </div>
                        <p style="font-size: 0.82rem; color: var(--color-text-muted); margin-top: 10px;">
                            You will simulate secure authentication through the selected bank portal.
                        </p>
                    </div>

                    <!-- TAB 4: Cash at Counter -->
                    <div class="tab-content-cash">
                        <h4 style="font-size: 1rem; font-weight: 700; color: var(--color-primary); margin-bottom: 12px;">
                            Cash Payment at ASI Gate Counter / Spot UPI
                        </h4>
                        <p style="font-size: 0.88rem; color: #475569; line-height: 1.6;">
                            Reserve your e-ticket slot online now. You can deposit cash or scan the gate UPI QR code at the dedicated fast-track ASI counter upon arrival.
                        </p>
                        <div style="margin-top: 12px; font-weight: 600; color: var(--color-green); font-size: 0.85rem;">
                            &#10004; Instant slot reservation confirmed.
                        </div>
                    </div>

                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary btn-lg btn-block">
                    Confirm &amp; Complete Booking (₹ <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" />) &rarr;
                </button>
            </form>

        </div>

        <!-- Right: Order & Booking Summary Breakdown -->
        <div>
            <div style="background: white; border-radius: 12px; border: 1.5px solid var(--color-border); padding: 24px; box-shadow: var(--shadow-sm); position: sticky; top: 90px;">
                <h3 style="font-size: 1.15rem; font-weight: 700; color: var(--color-primary); margin-bottom: 16px; border-bottom: 1px solid #f1f5f9; padding-bottom: 10px;">
                    Booking Summary
                </h3>

                <div style="display: flex; flex-direction: column; gap: 12px; font-size: 0.9rem; color: #475569; margin-bottom: 20px;">
                    <div>
                        <span style="font-size: 0.75rem; font-weight: 700; color: var(--color-text-muted); text-transform: uppercase;">Monument</span>
                        <div style="font-weight: 700; color: #0f172a; font-size: 1.05rem;">${booking.monument.name}</div>
                        <div style="font-size: 0.8rem; color: var(--color-text-muted);">${booking.monument.city}, ${booking.monument.state}</div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; padding-top: 8px; border-top: 1px solid #f1f5f9;">
                        <div>
                            <span style="font-size: 0.75rem; font-weight: 700; color: var(--color-text-muted); text-transform: uppercase;">Visit Date</span>
                            <div style="font-weight: 600; color: #0f172a;">${booking.tourDate}</div>
                        </div>
                        <div>
                            <span style="font-size: 0.75rem; font-weight: 700; color: var(--color-text-muted); text-transform: uppercase;">Slot</span>
                            <div style="font-weight: 600; color: #0f172a; font-size: 0.82rem;">${booking.departureTime}</div>
                        </div>
                    </div>

                    <div style="padding-top: 8px; border-top: 1px solid #f1f5f9;">
                        <span style="font-size: 0.75rem; font-weight: 700; color: var(--color-text-muted); text-transform: uppercase;">Visitors</span>
                        <div style="font-weight: 600; color: #0f172a;">
                            ${booking.adult} Adult(s) &bull; ${booking.child} Child(ren)
                        </div>
                    </div>

                    <div style="padding-top: 8px; border-top: 1px solid #f1f5f9;">
                        <span style="font-size: 0.75rem; font-weight: 700; color: var(--color-text-muted); text-transform: uppercase;">Lead Visitor</span>
                        <div style="font-weight: 600; color: #0f172a;">${booking.contactPersonDetails}</div>
                    </div>

                    <div style="display: flex; justify-content: space-between; align-items: baseline; border-top: 2px solid #e2e8f0; padding-top: 14px; margin-top: 6px;">
                        <strong style="font-size: 1.1rem; color: var(--color-primary);">Total Fare to Pay:</strong>
                        <strong style="font-size: 1.5rem; color: var(--color-saffron);">
                            ₹ <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" />
                        </strong>
                    </div>
                </div>

                <div class="alert alert-info" style="font-size: 0.82rem; margin-bottom: 0; padding: 10px 14px;">
                    &#128274; 100% money-back refund guarantee in accordance with ASI cancellation rules.
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
