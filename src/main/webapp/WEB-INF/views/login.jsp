<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Citizen Login — BharatDarshan" />
<c:set var="activePage" value="login" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding: 40px 0 60px;">
    <div style="max-width: 460px; margin: 0 auto;">

        <div style="background: white; border-radius: 12px; box-shadow: var(--shadow-md); border: 1px solid var(--color-border); padding: 32px;">

            <!-- Header -->
            <div style="text-align: center; margin-bottom: 24px;">
                <div class="emblem-badge" style="margin: 0 auto 12px; width: 48px; height: 48px; font-size: 1.2rem;">ASI</div>
                <h2 style="font-size: 1.6rem; font-weight: 800; color: var(--color-primary);">Citizen Login</h2>
                <p style="font-size: 0.88rem; color: var(--color-text-muted); margin-top: 4px;">
                    Access your ASI E-Tickets and Booking History
                </p>
            </div>

            <!-- Login Form (POST) -->
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group" style="margin-bottom: 16px;">
                    <label class="form-label" for="email">Registered Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="name@example.com" required value="${enteredEmail}">
                </div>

                <div class="form-group" style="margin-bottom: 20px;">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-bottom: 16px;">
                    Sign In to Portal &rarr;
                </button>
            </form>

            <!-- Test Credentials Quick-Info -->
            <div style="background: #f8fafc; border: 1px dashed #cbd5e1; border-radius: 8px; padding: 12px; font-size: 0.82rem; color: #475569; margin-top: 16px;">
                <strong style="color: var(--color-primary); display: block; margin-bottom: 4px;">Demo Credentials for Viva / Testing:</strong>
                <div><strong>Email:</strong> rahul.sharma@example.com</div>
                <div><strong>Password:</strong> Admin@123</div>
            </div>

            <!-- Link to Register -->
            <div style="text-align: center; margin-top: 24px; font-size: 0.9rem; color: #64748b; border-top: 1px solid #f1f5f9; padding-top: 16px;">
                Don't have an account? 
                <a href="${pageContext.request.contextPath}/register" style="color: var(--color-primary); font-weight: 700; text-decoration: none;">
                    Register Now
                </a>
            </div>

        </div>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
