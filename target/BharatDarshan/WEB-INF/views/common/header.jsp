<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'BharatDarshan — ASI E-Ticketing Portal'}</title>
    <!-- Core Application Pure CSS (Zero JavaScript) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>

    <!-- Indian Tricolor Top Accent -->
    <div class="gov-tricolor-bar"></div>

    <!-- Official Portal Top Sub-bar -->
    <div class="gov-top-bar">
        <div class="container" style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <strong>Government of India</strong> &bull; Ministry of Culture &bull; Archaeological Survey of India (ASI)
            </div>
            <div>
                National E-Ticketing Portal &bull; Helpline: 1800-11-2233
            </div>
        </div>
    </div>

    <!-- Main Navigation Bar -->
    <nav class="navbar">
        <div class="container navbar-inner">
            <!-- Brand Logo -->
            <a href="${pageContext.request.contextPath}/home" class="brand-logo">
                <div class="emblem-badge">ASI</div>
                <div>
                    <span class="brand-title">BharatDarshan</span>
                    <span class="brand-subtitle">Monument E-Ticketing</span>
                </div>
            </a>

            <!-- Navigation Links -->
           <ul class="nav-menu">
               <li>
                   <a href="${pageContext.request.contextPath}/home" class="nav-link ${activePage == 'home' ? 'active' : ''}">Home</a>
               </li>
               <li>
                   <a href="${pageContext.request.contextPath}/monuments" class="nav-link ${activePage == 'monuments' ? 'active' : ''}">Monuments</a>
               </li>
               <li>
                   <a href="${pageContext.request.contextPath}/service" class="nav-link ${activePage == 'service' ? 'active' : ''}">Services</a>
               </li>
               <li>
                   <a href="${pageContext.request.contextPath}/about" class="nav-link ${activePage == 'about' ? 'active' : ''}">About</a>
               </li>
               <li>
                   <a href="${pageContext.request.contextPath}/contact" class="nav-link ${activePage == 'contact' ? 'active' : ''}">Contact</a>
               </li>

               <c:choose>
                   <c:when test="${not empty sessionScope.user}">
                       <li>
                           <a href="${pageContext.request.contextPath}/my-bookings" class="nav-link ${activePage == 'bookings' ? 'active' : ''}">My Bookings</a>
                       </li>
                       <li>
                           <div class="user-badge" onclick="window.location.href='${pageContext.request.contextPath}/profile'" style="cursor:pointer;">
                               <span class="user-avatar">${sessionScope.user.firstName.substring(0,1)}</span>
                               <span style="font-size: 0.88rem; font-weight: 600; color: #f8fafc;">${sessionScope.user.firstName}</span>
                               <span style="font-size: 10px; color: #93c5fd; margin-left: 4px;">▼</span>
                           </div>
                       </li>
                       <li>
                           <a href="${pageContext.request.contextPath}/logout" class="btn-nav-outline" style="font-size: 0.85rem;">Logout</a>
                       </li>
                   </c:when>
                   <c:otherwise>
                       <li>
                           <a href="${pageContext.request.contextPath}/login" class="nav-link ${activePage == 'login' ? 'active' : ''}">Login</a>
                       </li>
                       <li>
                           <a href="${pageContext.request.contextPath}/register" class="btn-nav-primary">Register</a>
                       </li>
                   </c:otherwise>
               </c:choose>
           </ul>
        </div>
    </nav>

    <!-- Global Flash Notification Messages -->
    <div class="container" style="margin-top: 16px;">
        <c:if test="${not empty sessionScope.flashSuccess}">
            <div class="alert alert-success">
                <span>&#10004;</span>
                <span>${sessionScope.flashSuccess}</span>
            </div>
            <% session.removeAttribute("flashSuccess"); %>
        </c:if>

        <c:if test="${not empty sessionScope.flashError}">
            <div class="alert alert-error">
                <span>&#9888;</span>
                <span>${sessionScope.flashError}</span>
            </div>
            <% session.removeAttribute("flashError"); %>
        </c:if>

        <c:if test="${not empty sessionScope.authMessage}">
            <div class="alert alert-info">
                <span>&#9432;</span>
                <span>${sessionScope.authMessage}</span>
            </div>
            <% session.removeAttribute("authMessage"); %>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <span>&#9888;</span>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <span>&#10004;</span>
                <span>${successMessage}</span>
            </div>
        </c:if>
    </div>

    <!-- Main Body Container -->
    <main class="main-content">