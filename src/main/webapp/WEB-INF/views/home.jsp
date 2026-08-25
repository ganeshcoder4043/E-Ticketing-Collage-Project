<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="BharatDarshan — National Monument E-Ticketing Portal" />
<c:set var="activePage" value="home" />
<jsp:include page="common/header.jsp" />

<!-- Hero Section with Search Engine -->
<section class="hero-section">
    <div class="container hero-content">
        <span class="hero-tag">Archaeological Survey of India</span>
        <h1 class="hero-title">Experience India's Timeless Heritage</h1>
        <p class="hero-subtitle">
            Book instant, verified digital entry tickets to over 3,600+ ASI centrally protected monuments and UNESCO World Heritage Sites.
        </p>

        <!-- Fast Search Form Component (GET method for pure HTML search) -->
        <div class="search-card">
            <form action="${pageContext.request.contextPath}/monuments" method="get">
                <div class="search-form-grid">
                    <!-- Search by Keyword -->
                    <div class="form-group" style="text-align: left;">
                        <label class="form-label">Search Monument or City</label>
                        <input type="text" name="q" class="form-control" placeholder="e.g. Taj Mahal, Red Fort, Agra..." value="${paramQuery}">
                    </div>

                    <!-- Filter by State -->
                    <div class="form-group" style="text-align: left;">
                        <label class="form-label">State / Region</label>
                        <select name="state" class="form-select">
                            <option value="ALL">All States</option>
                            <c:forEach var="st" items="${states}">
                                <option value="${st}">${st}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Filter by Type -->
                    <div class="form-group" style="text-align: left;">
                        <label class="form-label">Monument Category</label>
                        <select name="type" class="form-select">
                            <option value="ALL">All Categories</option>
                            <c:forEach var="tp" items="${types}">
                                <option value="${tp}">${tp}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Submit Button -->
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary btn-block" style="height: 42px;">
                            Search Tickets
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- Heritage Key Highlights -->
<section style="background: white; padding: 30px 0; border-bottom: 1px solid var(--color-border);">
    <div class="container">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; text-align: center;">
            <div style="padding: 10px;">
                <h3 style="font-size: 1.8rem; font-weight: 800; color: var(--color-saffron);">3,690+</h3>
                <p style="font-size: 0.88rem; color: var(--color-text-muted); font-weight: 600;">Centrally Protected Monuments</p>
            </div>
            <div style="padding: 10px;">
                <h3 style="font-size: 1.8rem; font-weight: 800; color: var(--color-primary);">42</h3>
                <p style="font-size: 0.88rem; color: var(--color-text-muted); font-weight: 600;">UNESCO World Heritage Sites</p>
            </div>
            <div style="padding: 10px;">
                <h3 style="font-size: 1.8rem; font-weight: 800; color: var(--color-green);">100%</h3>
                <p style="font-size: 0.88rem; color: var(--color-text-muted); font-weight: 600;">Paperless Digital E-Ticketing</p>
            </div>
            <div style="padding: 10px;">
                <h3 style="font-size: 1.8rem; font-weight: 800; color: #7c3aed;">Zero Line</h3>
                <p style="font-size: 0.88rem; color: var(--color-text-muted); font-weight: 600;">Instant QR / Barcode Gate Access</p>
            </div>
        </div>
    </div>
</section>

<!-- Featured Monuments Showcase -->
<section style="padding: 60px 0;">
    <div class="container">
        <div class="section-header">
            <span class="section-tag">Explore India</span>
            <h2 class="section-title">Iconic Heritage Monuments</h2>
            <div class="section-divider"></div>
        </div>

        <div class="monuments-grid">
            <c:forEach var="monument" items="${featuredMonuments}">
                <div class="monument-card">
                    <div class="monument-card-img-wrapper">
                        <img src="${not empty monument.imageUrl ? monument.imageUrl : 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800'}" 
                             alt="${monument.name}" 
                             class="monument-card-img" />
                        <span class="monument-badge">${monument.type}</span>
                        <span class="monument-fare-tag">
                            ₹ <fmt:formatNumber value="${monument.fare}" pattern="#,##0.00" />
                        </span>
                    </div>

                    <div class="monument-card-body">
                        <h3 class="monument-title">${monument.name}</h3>
                        <p class="monument-location">
                            <span>&#128205;</span> ${monument.city}, ${monument.state}
                        </p>
                        <p class="monument-snippet">
                            <c:choose>
                                <c:when test="${monument.specification.length() > 80}">
                                    ${monument.specification.substring(0, 80)}...
                                </c:when>
                                <c:otherwise>
                                    ${monument.specification}
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <div class="monument-card-footer">
                            <a href="${pageContext.request.contextPath}/monument-detail?id=${monument.mouId}" class="btn btn-outline-navy btn-sm">
                                View Details
                            </a>
                            <a href="${pageContext.request.contextPath}/book-ticket?mouId=${monument.mouId}" class="btn btn-primary btn-sm">
                                Book Ticket &rarr;
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div style="text-align: center; margin-top: 40px;">
            <a href="${pageContext.request.contextPath}/monuments" class="btn btn-navy btn-lg">
                View All Protected Monuments &rarr;
            </a>
        </div>
    </div>
</section>

<!-- Information & Step-by-Step Ticketing Flow -->
<section style="background-color: #f1f5f9; padding: 50px 0; border-top: 1px solid var(--color-border);">
    <div class="container">
        <div class="section-header">
            <span class="section-tag">How It Works</span>
            <h2 class="section-title">4 Simple Steps to Your E-Ticket</h2>
            <div class="section-divider"></div>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 24px;">
            <div style="background: white; padding: 24px; border-radius: 8px; border-top: 4px solid var(--color-primary); box-shadow: var(--shadow-sm);">
                <div style="font-size: 1.5rem; font-weight: 800; color: var(--color-primary); margin-bottom: 8px;">01</div>
                <h4 style="margin-bottom: 8px; color: #0f172a;">Search &amp; Select</h4>
                <p style="font-size: 0.88rem; color: #64748b;">Find your desired monument from our state-wise verified ASI directory.</p>
            </div>

            <div style="background: white; padding: 24px; border-radius: 8px; border-top: 4px solid var(--color-saffron); box-shadow: var(--shadow-sm);">
                <div style="font-size: 1.5rem; font-weight: 800; color: var(--color-saffron); margin-bottom: 8px;">02</div>
                <h4 style="margin-bottom: 8px; color: #0f172a;">Pick Date &amp; Visitors</h4>
                <p style="font-size: 0.88rem; color: #64748b;">Select your visit date, time slot (Forenoon/Afternoon), and visitor count.</p>
            </div>

            <div style="background: white; padding: 24px; border-radius: 8px; border-top: 4px solid var(--color-green); box-shadow: var(--shadow-sm);">
                <div style="font-size: 1.5rem; font-weight: 800; color: var(--color-green); margin-bottom: 8px;">03</div>
                <h4 style="margin-bottom: 8px; color: #0f172a;">Secure Payment</h4>
                <p style="font-size: 0.88rem; color: #64748b;">Pay seamlessly via Credit Card, Debit Card, Net Banking, or Cash Counter.</p>
            </div>

            <div style="background: white; padding: 24px; border-radius: 8px; border-top: 4px solid #7c3aed; box-shadow: var(--shadow-sm);">
                <div style="font-size: 1.5rem; font-weight: 800; color: #7c3aed; margin-bottom: 8px;">04</div>
                <h4 style="margin-bottom: 8px; color: #0f172a;">Print E-Ticket</h4>
                <p style="font-size: 0.88rem; color: #64748b;">Download and print your official E-Ticket with QR/Barcode for quick gate scanning.</p>
            </div>
        </div>
    </div>
</section>

<jsp:include page="common/footer.jsp" />
