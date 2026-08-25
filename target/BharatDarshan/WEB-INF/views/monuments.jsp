<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="Explore ASI Monuments — BharatDarshan" />
<c:set var="activePage" value="monuments" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding-top: 30px; padding-bottom: 50px;">

    <!-- Page Title & Breadcrumb -->
    <div style="margin-bottom: 24px;">
        <p style="font-size: 0.85rem; color: var(--color-text-muted);">
            <a href="${pageContext.request.contextPath}/home" style="color: var(--color-primary); text-decoration: none;">Home</a> &gt; Explore Monuments
        </p>
        <h1 style="font-size: 2rem; font-weight: 800; color: var(--color-primary); margin-top: 4px;">
            Centrally Protected Monuments &amp; Heritage Sites
        </h1>
        <p style="color: var(--color-text-muted); font-size: 0.95rem;">
            Filter and book entry tickets for ASI archaeological wonders across all Indian circles.
        </p>
    </div>

    <!-- Filter Bar (Pure HTML GET Form) -->
    <div class="search-card" style="margin-bottom: 30px; border: 1px solid var(--color-border);">
        <form action="${pageContext.request.contextPath}/monuments" method="get">
            <div style="display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1fr auto; gap: 12px; align-items: flex-end;">
                <!-- Keyword search -->
                <div class="form-group">
                    <label class="form-label">Search by Name or City</label>
                    <input type="text" name="q" class="form-control" placeholder="e.g. Fort, Temple, Agra..." value="${paramQuery}">
                </div>

                <!-- State Filter -->
                <div class="form-group">
                    <label class="form-label">State / Region</label>
                    <select name="state" class="form-select">
                        <option value="ALL">All States</option>
                        <c:forEach var="st" items="${states}">
                            <option value="${st}" ${paramState == st ? 'selected' : ''}>${st}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Category Filter -->
                <div class="form-group">
                    <label class="form-label">Category</label>
                    <select name="type" class="form-select">
                        <option value="ALL">All Categories</option>
                        <c:forEach var="tp" items="${types}">
                            <option value="${tp}" ${paramType == tp ? 'selected' : ''}>${tp}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Max Price Filter -->
                <div class="form-group">
                    <label class="form-label">Max Entry Fare (₹)</label>
                    <input type="number" name="maxPrice" class="form-control" placeholder="e.g. 50" min="0" step="5" value="${paramMaxPrice}">
                </div>

                <!-- Action Buttons -->
                <div class="form-group" style="display: flex; gap: 8px;">
                    <button type="submit" class="btn btn-primary" style="height: 42px;">
                        Apply Filter
                    </button>
                    <a href="${pageContext.request.contextPath}/monuments" class="btn btn-outline-navy" style="height: 42px;">
                        Reset
                    </a>
                </div>
            </div>
        </form>
    </div>

    <!-- Filter Results Header -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid var(--color-border); padding-bottom: 10px;">
        <div style="font-weight: 700; color: #334155;">
            Showing <span style="color: var(--color-saffron);">${resultCount}</span> monuments found
        </div>
        <c:if test="${not empty paramQuery or not empty paramState or not empty paramType or not empty paramMaxPrice}">
            <div style="font-size: 0.85rem; color: var(--color-text-muted);">
                Active Filters Applied
            </div>
        </c:if>
    </div>

    <!-- Monuments Grid -->
    <c:choose>
        <c:when test="${not empty monuments}">
            <div class="monuments-grid">
                <c:forEach var="monument" items="${monuments}">
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
                                    <c:when test="${monument.specification.length() > 90}">
                                        ${monument.specification.substring(0, 90)}...
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
        </c:when>
        <c:otherwise>
            <!-- Empty Results Placeholder -->
            <div style="background: white; border: 1px dashed #cbd5e1; border-radius: 12px; padding: 60px 20px; text-align: center; margin: 30px 0;">
                <div style="font-size: 3rem; margin-bottom: 12px;">&#128269;</div>
                <h3 style="font-size: 1.3rem; font-weight: 700; color: var(--color-primary); margin-bottom: 8px;">No Monuments Found</h3>
                <p style="color: var(--color-text-muted); font-size: 0.95rem; max-width: 450px; margin: 0 auto 20px;">
                    We couldn't find any monuments matching your filter criteria. Try adjusting your keyword or clearing filters.
                </p>
                <a href="${pageContext.request.contextPath}/monuments" class="btn btn-primary">
                    Clear All Filters
                </a>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<jsp:include page="common/footer.jsp" />
