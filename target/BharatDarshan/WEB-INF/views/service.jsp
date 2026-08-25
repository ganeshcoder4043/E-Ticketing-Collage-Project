<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Services - BharatDarshan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .services-hero {
            background: linear-gradient(135deg, #0e374e, #1a4f70);
            color: white;
            padding: 60px 0;
            text-align: center;
            border-bottom: 4px solid #f37021;
        }
        .services-hero h1 {
            font-size: 2.5rem;
            font-weight: 800;
        }
        .services-hero p {
            font-size: 1.1rem;
            color: #cbd5e1;
            max-width: 700px;
            margin: 10px auto 0;
        }
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            padding: 50px 0;
        }
        .service-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
        }
        .service-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        .service-card h3 {
            font-size: 1.25rem;
            color: #0e374e;
            margin-bottom: 10px;
        }
        .service-card p {
            color: #64748b;
            font-size: 0.95rem;
            line-height: 1.6;
        }
        .service-features {
            background: #f8fafc;
            padding: 40px 0;
            border-top: 1px solid #e2e8f0;
        }
        .service-features ul {
            list-style: none;
            padding: 0;
            max-width: 700px;
            margin: 0 auto;
        }
        .service-features ul li {
            padding: 12px 0;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1rem;
        }
        .service-features ul li:last-child {
            border-bottom: none;
        }
        .service-features ul li::before {
            content: "✅";
            font-size: 1.2rem;
        }
        @media (max-width: 600px) {
            .services-hero h1 {
                font-size: 1.8rem;
            }
            .services-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Hero Section -->
<section class="services-hero">
    <div class="container">
        <h1>🏛️ Our Services</h1>
        <p>Book instant, verified digital entry tickets to over 3,600+ ASI centrally protected monuments and UNESCO World Heritage Sites.</p>
    </div>
</section>

<!-- Services Grid -->
<div class="container">
    <div class="services-grid">
        <div class="service-card">
            <div class="service-icon">🎟️</div>
            <h3>Instant E-Ticketing</h3>
            <p>Book tickets instantly for any monument across India. Get digital tickets on your email and phone.</p>
        </div>
        <div class="service-card">
            <div class="service-icon">🏛️</div>
            <h3>3,600+ Monuments</h3>
            <p>Access to all ASI centrally protected monuments including UNESCO World Heritage Sites across India.</p>
        </div>
        <div class="service-card">
            <div class="service-icon">📱</div>
            <h3>Digital QR Tickets</h3>
            <p>Get QR code based digital tickets that can be scanned directly at the monument entry gate.</p>
        </div>
        <div class="service-card">
            <div class="service-icon">🔄</div>
            <h3>Easy Cancellation</h3>
            <p>Cancel your booking easily with full refund policy. Manage your bookings from your dashboard.</p>
        </div>
        <div class="service-card">
            <div class="service-icon">📊</div>
            <h3>Booking History</h3>
            <p>View all your past and upcoming bookings. Download e-tickets anytime from your account.</p>
        </div>
        <div class="service-card">
            <div class="service-icon">🛡️</div>
            <h3>Secure Payments</h3>
            <p>Multiple payment options including Credit/Debit Cards, Net Banking, and UPI with 100% secure transactions.</p>
        </div>
    </div>
</div>

<!-- Features Section -->
<section class="service-features">
    <div class="container">
        <h2 style="text-align:center;color:#0e374e;font-size:1.8rem;margin-bottom:20px;">Why Choose BharatDarshan?</h2>
        <ul>
            <li>Official ASI E-Ticketing Portal — 100% Government Approved</li>
            <li>No Waiting in Queue — Skip the line with pre-booked tickets</li>
            <li>Student & Child Discount — Special fares for students and children</li>
            <li>24/7 Booking — Book tickets anytime, anywhere</li>
            <li>Real-Time Availability — Check ticket availability instantly</li>
            <li>Dedicated Helpline — Call 1800-11-2233 for any assistance</li>
        </ul>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>