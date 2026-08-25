<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Citizen Registration — BharatDarshan" />
<c:set var="activePage" value="register" />
<jsp:include page="common/header.jsp" />

<div class="container" style="padding: 40px 0 60px;">
    <div style="max-width: 600px; margin: 0 auto;">

        <div style="background: white; border-radius: 12px; box-shadow: var(--shadow-md); border: 1px solid var(--color-border); padding: 32px;">

            <!-- Header -->
            <div style="text-align: center; margin-bottom: 24px;">
                <div class="emblem-badge" style="margin: 0 auto 12px; width: 48px; height: 48px; font-size: 1.2rem;">ASI</div>
                <h2 style="font-size: 1.6rem; font-weight: 800; color: var(--color-primary);">Citizen Registration</h2>
                <p style="font-size: 0.88rem; color: var(--color-text-muted); margin-top: 4px;">
                    Create your profile for fast, paperless ASI E-Ticket reservations
                </p>
            </div>

            <!-- Registration Form (POST) -->
            <form action="${pageContext.request.contextPath}/register" method="post">

                <!-- First & Last Name -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                    <div class="form-group">
                        <label class="form-label" for="firstName">First Name *</label>
                        <input type="text" id="firstName" name="firstName" class="form-control" placeholder="e.g. Rahul" required value="${firstName}">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="lastName">Last Name *</label>
                        <input type="text" id="lastName" name="lastName" class="form-control" placeholder="e.g. Sharma" required value="${lastName}">
                    </div>
                </div>

                <!-- Email & Contact -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                    <div class="form-group">
                        <label class="form-label" for="email">Email Address *</label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="name@example.com" required value="${email}">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="contact">Mobile Number *</label>
                        <input type="tel" id="contact" name="contact" class="form-control" placeholder="10-digit mobile" maxlength="10" required value="${contact}">
                    </div>
                </div>

                <!-- Gender & Date of Birth -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                    <div class="form-group">
                        <label class="form-label" for="gender">Gender *</label>
                        <select id="gender" name="gender" class="form-select" required>
                            <option value="">-- Select Gender --</option>
                            <option value="M" ${gender == 'M' ? 'selected' : ''}>Male</option>
                            <option value="F" ${gender == 'F' ? 'selected' : ''}>Female</option>
                            <option value="O" ${gender == 'O' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="dob">Date of Birth *</label>
                        <input type="date" id="dob" name="dob" class="form-control" required value="${dob}">
                    </div>
                </div>

                <!-- Passwords -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 24px;">
                    <div class="form-group">
                        <label class="form-label" for="password">Create Password *</label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Min. 6 characters" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="confirmPassword">Confirm Password *</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Re-type password" required>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-bottom: 16px;">
                    Create Account &rarr;
                </button>
            </form>

            <!-- Link to Login -->
            <div style="text-align: center; margin-top: 16px; font-size: 0.9rem; color: #64748b; border-top: 1px solid #f1f5f9; padding-top: 16px;">
                Already registered with BharatDarshan? 
                <a href="${pageContext.request.contextPath}/login" style="color: var(--color-primary); font-weight: 700; text-decoration: none;">
                    Sign In
                </a>
            </div>

        </div>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
