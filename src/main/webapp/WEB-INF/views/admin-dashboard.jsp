<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BharatDarshan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .admin-hero {
            background: linear-gradient(135deg, #0e374e, #1a4f70);
            color: white;
            padding: 40px 0;
            text-align: center;
            border-bottom: 4px solid #f37021;
        }
        .admin-hero h1 {
            font-size: 2rem;
            font-weight: 800;
        }
        .admin-hero p {
            color: #cbd5e1;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 30px 0;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }
        .stat-card .number {
            font-size: 2rem;
            font-weight: 800;
            color: #f37021;
        }
        .stat-card .label {
            color: #64748b;
            font-size: 0.9rem;
        }
        .admin-content {
            padding: 30px 0;
        }
        .admin-content h2 {
            color: #0e374e;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .user-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        .user-table th {
            background: #0e374e;
            color: white;
            padding: 12px 15px;
            text-align: left;
        }
        .user-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #e2e8f0;
        }
        .user-table tr:hover td {
            background: #f8fafc;
        }
        .badge-admin {
            background: #f37021;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
        }
        .badge-user {
            background: #e2e8f0;
            color: #475569;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
        }
        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .search-bar input {
            flex: 1;
            padding: 10px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
        }
        .search-bar input:focus {
            border-color: #0e374e;
            outline: none;
        }
        .search-bar button {
            background: #f37021;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }
        .search-bar button:hover {
            background: #d95b10;
        }
        .btn-email {
            background: #0e374e;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.8rem;
        }
        .btn-email:hover {
            background: #1a4f70;
        }
        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-success {
            background: #f0fdf4;
            color: #166534;
            border: 1px solid #bbf7d0;
        }
        .alert-error {
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .user-table {
                font-size: 0.85rem;
            }
            .user-table th, .user-table td {
                padding: 8px 10px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Admin Hero -->
<section class="admin-hero">
    <div class="container">
        <h1>🛡️ Admin Dashboard</h1>
        <p>Manage users, view bookings, and send notifications</p>
    </div>
</section>

<!-- Stats -->
<div class="container">
    <div class="stats-grid">
        <div class="stat-card">
            <div class="number">${userCount}</div>
            <div class="label">Total Users</div>
        </div>
        <div class="stat-card">
            <div class="number">${bookingCount}</div>
            <div class="label">Total Bookings</div>
        </div>
        <div class="stat-card">
            <div class="number">${monumentCount}</div>
            <div class="label">Monuments</div>
        </div>
        <div class="stat-card">
            <div class="number">${adminCount}</div>
            <div class="label">Admins</div>
        </div>
    </div>
</div>

<!-- User List -->
<div class="container admin-content">
    <h2>👥 Registered Users</h2>

    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <!-- Search Bar -->
    <div class="search-bar">
        <form action="${pageContext.request.contextPath}/admin/users" method="get" style="display:flex;width:100%;gap:10px;">
            <input type="text" name="search" placeholder="Search by name or email..." value="${param.search}">
            <button type="submit">Search</button>
            <a href="${pageContext.request.contextPath}/admin/users" class="btn-secondary" style="padding:10px 20px;background:#e2e8f0;color:#1e293b;border-radius:8px;text-decoration:none;font-weight:600;">Reset</a>
        </form>
    </div>

    <!-- User Table -->
    <div class="table-responsive">
        <table class="user-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Role</th>
                    <th>Joined</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>${user.contact}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.role == 'admin'}">
                                            <span class="badge-admin">Admin</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-user">User</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${user.createdAt}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/user-details?id=${user.id}" class="btn-email">View</a>
                                    <a href="${pageContext.request.contextPath}/admin/send-email?id=${user.id}" class="btn-email">Email</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" style="text-align:center;color:#64748b;padding:30px;">
                                No users found.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>