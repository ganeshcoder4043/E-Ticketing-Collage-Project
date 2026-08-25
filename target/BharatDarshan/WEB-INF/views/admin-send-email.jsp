<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Email - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .email-container {
            max-width: 700px;
            margin: 40px auto;
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }
        .email-header {
            display: flex;
            align-items: center;
            gap: 15px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 25px;
        }
        .email-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #f37021;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            font-weight: bold;
        }
        .email-header-info .name {
            font-weight: 700;
            color: #0e374e;
        }
        .email-header-info .email {
            color: #64748b;
            font-size: 0.9rem;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            font-size: 14px;
            color: #334155;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
        }
        .form-group input:focus, .form-group textarea:focus {
            border-color: #0e374e;
            outline: none;
            box-shadow: 0 0 0 3px rgba(14,55,78,0.15);
        }
        .form-group textarea {
            resize: vertical;
            min-height: 150px;
        }
        .btn-send {
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
        .btn-send:hover {
            background: #d95b10;
        }
        .btn-back {
            background: #e2e8f0;
            color: #1e293b;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-back:hover {
            background: #cbd5e1;
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
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">
    <div class="email-container">
        <div class="email-header">
            <div class="email-avatar">
                ${userDetails.firstName.charAt(0)}${userDetails.lastName.charAt(0)}
            </div>
            <div class="email-header-info">
                <div class="name">${userDetails.fullName}</div>
                <div class="email">${userDetails.email}</div>
            </div>
        </div>

        <h2 style="color:#0e374e;font-size:1.5rem;margin-bottom:20px;">✉️ Send Email</h2>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/send-email" method="post">
            <input type="hidden" name="userId" value="${userDetails.id}">

            <div class="form-group">
                <label>To</label>
                <input type="text" value="${userDetails.fullName} (${userDetails.email})" disabled style="background:#f1f5f9;">
            </div>

            <div class="form-group">
                <label>Subject</label>
                <input type="text" name="subject" placeholder="Enter email subject" required>
            </div>

            <div class="form-group">
                <label>Message</label>
                <textarea name="message" placeholder="Write your message here..." required></textarea>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn-send">✉️ Send Email</button>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn-back">← Back</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>