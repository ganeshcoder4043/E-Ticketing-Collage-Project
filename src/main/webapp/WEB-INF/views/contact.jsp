<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - BharatDarshan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .contact-hero {
            background: linear-gradient(135deg, #0e374e, #1a4f70);
            color: white;
            padding: 50px 0;
            text-align: center;
            border-bottom: 4px solid #f37021;
        }
        .contact-hero h1 {
            font-size: 2.5rem;
            font-weight: 800;
        }
        .contact-hero p {
            color: #cbd5e1;
            max-width: 600px;
            margin: 10px auto 0;
        }
        .contact-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            padding: 50px 0;
        }
        .contact-info {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }
        .contact-info h2 {
            color: #0e374e;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .contact-detail {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }
        .contact-detail:last-child {
            border-bottom: none;
        }
        .contact-detail .icon {
            font-size: 24px;
            width: 40px;
            text-align: center;
        }
        .contact-detail .label {
            font-weight: 600;
            color: #0e374e;
        }
        .contact-detail .value {
            color: #64748b;
        }
        .contact-form {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }
        .contact-form h2 {
            color: #0e374e;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .contact-form .form-group {
            margin-bottom: 18px;
        }
        .contact-form .form-group label {
            display: block;
            font-weight: 600;
            font-size: 14px;
            color: #334155;
            margin-bottom: 5px;
        }
        .contact-form .form-group input,
        .contact-form .form-group textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
        }
        .contact-form .form-group input:focus,
        .contact-form .form-group textarea:focus {
            border-color: #0e374e;
            outline: none;
            box-shadow: 0 0 0 3px rgba(14,55,78,0.15);
        }
        .contact-form .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }
        .btn-submit {
            background: #f37021;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-submit:hover {
            background: #d95b10;
        }
        .map-container {
            margin-top: 30px;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }
        .map-container iframe {
            width: 100%;
            height: 300px;
            border: none;
        }
        @media (max-width: 768px) {
            .contact-grid {
                grid-template-columns: 1fr;
            }
            .contact-hero h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Hero Section -->
<section class="contact-hero">
    <div class="container">
        <h1>📞 Contact Us</h1>
        <p>Have questions? Need help with your booking? Reach out to us anytime.</p>
    </div>
</section>

<!-- Contact Grid -->
<div class="container">
    <div class="contact-grid">
        <!-- Contact Info -->
        <div class="contact-info">
            <h2>📌 Get in Touch</h2>

            <div class="contact-detail">
                <span class="icon">📍</span>
                <div>
                    <div class="label">Address</div>
                    <div class="value">Archaeological Survey of India<br>Janpath, New Delhi - 110011</div>
                </div>
            </div>

            <div class="contact-detail">
                <span class="icon">📞</span>
                <div>
                    <div class="label">Helpline</div>
                    <div class="value">1800-11-2233 (Toll Free)</div>
                </div>
            </div>

            <div class="contact-detail">
                <span class="icon">📧</span>
                <div>
                    <div class="label">Email</div>
                    <div class="value">support@bharatdarshan.gov.in</div>
                </div>
            </div>

            <div class="contact-detail">
                <span class="icon">🕐</span>
                <div>
                    <div class="label">Working Hours</div>
                    <div class="value">Mon-Fri: 9:00 AM - 6:00 PM IST</div>
                </div>
            </div>

            <div class="contact-detail">
                <span class="icon">🏛️</span>
                <div>
                    <div class="label">Website</div>
                    <div class="value">www.bharatdarshan.gov.in</div>
                </div>
            </div>
        </div>

        <!-- Contact Form -->
        <div class="contact-form">
            <h2>✉️ Send a Message</h2>

            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/contact" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="Enter your full name" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="Enter your email address" required>
                </div>
                <div class="form-group">
                    <label>Subject</label>
                    <input type="text" name="subject" placeholder="Enter subject" required>
                </div>
                <div class="form-group">
                    <label>Message</label>
                    <textarea name="message" placeholder="Write your message here..." required></textarea>
                </div>
                <button type="submit" class="btn-submit">Send Message →</button>
            </form>
        </div>
    </div>

    <!-- Map -->
    <div class="map-container">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3501.947123456789!2d77.2167!3d28.6129!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390ce2daa9eb4d0b%3A0x717971125923e5d!2sArchaeological%20Survey%20of%20India!5e0!3m2!1sen!2sin!4v1700000000000"
                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
        </iframe>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>