<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - BharatDarshan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .about-hero {
            background: linear-gradient(135deg, #0e374e, #1a4f70);
            color: white;
            padding: 60px 0;
            text-align: center;
            border-bottom: 4px solid #f37021;
        }
        .about-hero h1 {
            font-size: 2.5rem;
            font-weight: 800;
        }
        .about-hero p {
            color: #cbd5e1;
            max-width: 700px;
            margin: 10px auto 0;
        }
        .about-section {
            padding: 50px 0;
        }
        .about-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 40px;
        }
        .about-content h2 {
            color: #0e374e;
            font-size: 1.8rem;
            margin-bottom: 15px;
        }
        .about-content p {
            color: #475569;
            font-size: 1rem;
            line-height: 1.8;
            margin-bottom: 15px;
        }
        .about-stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }
        .stat-card .number {
            font-size: 2.5rem;
            font-weight: 800;
            color: #f37021;
        }
        .stat-card .label {
            color: #64748b;
            font-size: 0.9rem;
            margin-top: 5px;
        }
        .about-mission {
            background: #f8fafc;
            padding: 50px 0;
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
        }
        .about-mission h2 {
            text-align: center;
            color: #0e374e;
            font-size: 1.8rem;
            margin-bottom: 30px;
        }
        .mission-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
        }
        .mission-item {
            text-align: center;
            padding: 20px;
        }
        .mission-item .icon {
            font-size: 40px;
            margin-bottom: 15px;
        }
        .mission-item h3 {
            color: #0e374e;
            font-size: 1.1rem;
        }
        .mission-item p {
            color: #64748b;
            font-size: 0.9rem;
        }
        .about-team {
            padding: 50px 0;
        }
        .about-team h2 {
            text-align: center;
            color: #0e374e;
            font-size: 1.8rem;
            margin-bottom: 30px;
        }
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
        }
        .team-member {
            text-align: center;
            padding: 20px;
            background: white;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }
        .team-member .avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #0e374e;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: bold;
            margin: 0 auto 15px;
        }
        .team-member h4 {
            color: #0e374e;
            margin-bottom: 5px;
        }
        .team-member p {
            color: #64748b;
            font-size: 0.85rem;
        }
        @media (max-width: 768px) {
            .about-grid {
                grid-template-columns: 1fr;
            }
            .mission-grid {
                grid-template-columns: 1fr;
            }
            .about-hero h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Hero Section -->
<section class="about-hero">
    <div class="container">
        <h1>🏛️ About BharatDarshan</h1>
        <p>India's official digital monument ticketing platform — bringing India's rich cultural heritage to your fingertips.</p>
    </div>
</section>

<!-- About Content -->
<div class="container about-section">
    <div class="about-grid">
        <div class="about-content">
            <h2>🇮🇳 Preserving India's Heritage</h2>
            <p>
                <strong>BharatDarshan</strong> is the official e-ticketing portal of the
                <strong>Archaeological Survey of India (ASI)</strong>, under the Ministry of Culture,
                Government of India. Our mission is to make India's rich cultural heritage accessible
                to everyone — from history enthusiasts to casual tourists.
            </p>
            <p>
                With over <strong>3,600+ centrally protected monuments</strong> across India, including
                40+ UNESCO World Heritage Sites, BharatDarshan offers a seamless, secure, and
                convenient way to book entry tickets online.
            </p>
            <p>
                Whether you're planning a visit to the iconic <strong>Taj Mahal</strong>, the ancient
                <strong>Ajanta Caves</strong>, or the majestic <strong>Red Fort</strong>, BharatDarshan
                ensures your entry is just a click away.
            </p>
        </div>
        <div class="about-stats">
            <div class="stat-card">
                <div class="number">3,600+</div>
                <div class="label">Monuments</div>
            </div>
            <div class="stat-card">
                <div class="number">40+</div>
                <div class="label">UNESCO Sites</div>
            </div>
            <div class="stat-card">
                <div class="number">10M+</div>
                <div class="label">Tickets Booked</div>
            </div>
            <div class="stat-card">
                <div class="number">100%</div>
                <div class="label">Digital Experience</div>
            </div>
        </div>
    </div>
</div>

<!-- Mission Section -->
<section class="about-mission">
    <div class="container">
        <h2>🎯 Our Mission</h2>
        <div class="mission-grid">
            <div class="mission-item">
                <div class="icon">🏛️</div>
                <h3>Preserve Heritage</h3>
                <p>Protect and preserve India's cultural monuments for future generations.</p>
            </div>
            <div class="mission-item">
                <div class="icon">📱</div>
                <h3>Digital Access</h3>
                <p>Make heritage accessible through modern digital ticketing solutions.</p>
            </div>
            <div class="mission-item">
                <div class="icon">🌍</div>
                <h3>Global Reach</h3>
                <p>Showcase India's rich history to the world through seamless booking.</p>
            </div>
        </div>
    </div>
</section>

<!-- Team Section -->
<section class="container about-team">
    <h2>👥 Our Team</h2>
    <div class="team-grid">
        <div class="team-member">
            <div class="avatar">A</div>
            <h4>Dr. Arjun Sharma</h4>
            <p>Director, ASI</p>
        </div>
        <div class="team-member">
            <div class="avatar">P</div>
            <h4>Prof. Priya Mehta</h4>
            <p>Heritage Expert</p>
        </div>
        <div class="team-member">
            <div class="avatar">V</div>
            <h4>Vikram Singh</h4>
            <p>Tech Lead</p>
        </div>
        <div class="team-member">
            <div class="avatar">R</div>
            <h4>Ritu Agarwal</h4>
            <p>Customer Support</p>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>