<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .detail-container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }
        .detail-header {
            display: flex;
            align-items: center;
            gap: 20px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 25px;
        }
        .detail-avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: #f37021;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: bold;
        }
        .detail-name {
            font-size: 22px;
            font-weight: 700;
            color: #0e374e;
        }
        .detail-email {
            color: #64748b;
        }
        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .detail-item {
            padding: 12px;
            background: #f8fafc;
            border-radius: 8px;
        }
        .detail-item .label {
            font-size: 0.8rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
        }
        .detail-item .value {
            font-size: 1rem;
            font-weight: 600;
            color: #0e374e;
            margin-top: 4px;
        }
        .btn-back {
            display: inline-block;
            margin-top: 20px;
            background: #e2e8f0;
            color: #1e293b;
            padding: 10px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
        }
        .btn-back:hover {
            background: #cbd5e1;
        }
        .btn-email {
            background: #f37021;
            color: white;
            padding: 10px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            margin-left: 10px;
        }
        .btn-email:hover {
            background: #d95b10;
        }
        @media (max-width: 600px) {
            .detail-grid {
                grid-template-columns: 1fr;
            }
            .detail-header {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">
    <div class="detail-container">
        <div class="detail-header">
            <div class="detail-avatar">
                ${userDetails.firstName.charAt(0)}${userDetails.lastName.charAt(0)}
            </div>
            <div>
                <div class="detail-name">${userDetails.fullName}</div>
                <div class="detail-email">${userDetails.email}</div>
                <div>
                    <c:choose>
                        <c:when test="${userDetails.role == 'admin'}">
                            <span class="badge-admin">Admin</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge-user">User</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="detail-grid">
            <div class="detail-item">
                <div class="label">User ID</div>
                <div class="value">#${userDetails.id}</div>
            </div>
            <div class="detail-item">
                <div class="label">Gender</div>
                <div class="value">${userDetails.gender}</div>
            </div>
            <div class="detail-item">
                <div class="label">Contact</div>
                <div class="value">${userDetails.contact}</div>
            </div>
            <div class="detail-item">
                <div class="label">Date of Birth</div>
                <div class="value">${userDetails.dob}</div>
            </div>
            <div class="detail-item">
                <div class="label">Joined</div>
                <div class="value">${userDetails.createdAt}</div>
            </div>
            <div class="detail-item">
                <div class="label">Status</div>
                <div class="value" style="color:#15803d;">✅ Active</div>
            </div>
        </div>

        <div style="margin-top:20px;">
            <a href="${pageContext.request.contextPath}/admin/users" class="btn-back">← Back to Users</a>
            <a href="${pageContext.request.contextPath}/admin/send-email?id=${userDetails.id}" class="btn-email">✉️ Send Email</a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>