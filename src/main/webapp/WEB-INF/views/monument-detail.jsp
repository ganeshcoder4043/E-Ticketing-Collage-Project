<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="${monument.name} — Ticket Details & Specifications" />
<c:set var="activePage" value="monuments" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding-top: 30px; padding-bottom: 60px;">

    <!-- Breadcrumb Navigation -->
    <div style="margin-bottom: 20px;">
        <p style="font-size: 0.85rem; color: var(--color-text-muted);">
            <a href="${pageContext.request.contextPath}/home" style="color: var(--color-primary); text-decoration: none;">Home</a> &gt; 
            <a href="${pageContext.request.contextPath}/monuments" style="color: var(--color-primary); text-decoration: none;">Monuments</a> &gt; 
            <span>${monument.name}</span>
        </p>
    </div>

    <!-- Main Detail Layout -->
    <div class="detail-layout">

        <!-- Left Column: Monument Image, Descriptions, Specifications -->
        <div>
            <div class="detail-card">
                <!-- Large Monument Image -->
                <div class="detail-img-container">
                    <img src="${not empty monument.imageUrl ? monument.imageUrl : 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=1200'}" 
                         alt="${monument.name}" 
                         class="detail-img" />
                    <span class="monument-badge" style="font-size: 0.85rem; padding: 6px 14px;">
                        ${monument.type}
                    </span>
                </div>

                <!-- Content Body -->
                <div class="detail-body">
                    <h1 style="font-size: 2.2rem; font-weight: 800; color: var(--color-primary); margin-bottom: 6px;">
                        ${monument.name}
                    </h1>
                    <p style="color: var(--color-text-muted); font-size: 1rem; margin-bottom: 20px; display: flex; align-items: center; gap: 8px;">
                        <span>&#128205;</span> ${monument.location}, ${monument.city}, ${monument.state}
                    </p>

                    <!-- Specification Grid -->
                    <div class="spec-list">
                        <div class="spec-item">
                            <span class="spec-title">Circle / Location</span>
                            <span class="spec-val">${monument.city}, ${monument.state}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-title">Category / Type</span>
                            <span class="spec-val">${monument.type}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-title">Visiting Timings</span>
                            <span class="spec-val">${monument.timings}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-title">ASI Circle Helpdesk</span>
                            <span class="spec-val">+91 ${monument.contact}</span>
                        </div>
                    </div>

                    <!-- Historical Specification -->
                    <div style="margin-bottom: 24px;">
                        <h3 style="font-size: 1.2rem; font-weight: 700; color: var(--color-primary); margin-bottom: 8px;">
                            Key Architectural Highlights
                        </h3>
                        <p style="font-size: 0.95rem; color: #334155; line-height: 1.6; background-color: #f0f7fa; padding: 12px 16px; border-left: 4px solid var(--color-primary); border-radius: 4px;">
                            ${monument.specification}
                        </p>
                    </div>

                    <!-- Comprehensive Description -->
                    <div style="margin-bottom: 24px;">
                        <h3 style="font-size: 1.2rem; font-weight: 700; color: var(--color-primary); margin-bottom: 8px;">
                            About the Monument
                        </h3>
                        <p style="font-size: 0.95rem; color: #475569; line-height: 1.7;">
                            ${monument.description}
                        </p>
                    </div>

                    <!-- ASI Visitor Guidelines Alert -->
                    <div class="alert alert-info" style="margin-bottom: 0;">
                        <div>
                            <strong style="display: block; margin-bottom: 4px;">ASI Entry Rules &amp; Regulations:</strong>
                            <ul style="padding-left: 18px; font-size: 0.85rem; line-height: 1.5;">
                                <li>All visitors must carry a valid Photo ID proof matching the E-Ticket details.</li>
                                <li>Children under 15 years of age are permitted free entry upon showing age proof.</li>
                                <li>Commercial filming and drone cameras are strictly prohibited without prior ASI permission.</li>
                                <li>Preserve monument sanctity: Eating and littering inside historical structures is prohibited.</li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- Right Column: Sticky Booking Widget -->
        <div>
            <div class="booking-widget">
                <h3 style="font-size: 1.2rem; font-weight: 700; color: var(--color-primary); margin-bottom: 12px;">
                    E-Ticket Booking
                </h3>

                <div class="widget-price-header">
                    <div>
                        <span style="font-size: 0.8rem; color: var(--color-text-muted); text-transform: uppercase; font-weight: 700;">Entry Fare</span>
                        <div class="widget-fare">
                            ₹ <fmt:formatNumber value="${monument.fare}" pattern="#,##0.00" />
                        </div>
                    </div>
                    <span style="font-size: 0.85rem; color: #64748b;">Per Adult Indian / Citizen</span>
                </div>

                <div style="margin-bottom: 20px; font-size: 0.9rem; color: #475569; display: flex; flex-direction: column; gap: 8px;">
                    <div style="display: flex; justify-content: space-between;">
                        <span>Adult Fare:</span>
                        <strong style="color: #0f172a;">₹ <fmt:formatNumber value="${monument.fare}" pattern="#,##0.00" /></strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Child Fare (&lt; 15 yrs):</span>
                        <strong style="color: var(--color-green);">FREE (₹0.00)</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Ticket Delivery:</span>
                        <strong style="color: #0f172a;">Instant Digital E-Ticket</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Gate Verification:</span>
                        <strong style="color: #0f172a;">QR / Barcode Scan</strong>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/book-ticket?mouId=${monument.mouId}" class="btn btn-primary btn-block btn-lg">
                    Book Tickets Now &rarr;
                </a>

                <div style="text-align: center; margin-top: 16px;">
                    <span style="font-size: 0.78rem; color: #64748b;">
                        &#128274; 100% Secure Government E-Ticketing System
                    </span>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
