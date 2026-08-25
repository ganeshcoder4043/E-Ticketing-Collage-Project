<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile - BharatDarshan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .profile-header {
            display: flex;
            align-items: center;
            gap: 20px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 25px;
        }
        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #f37021;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: bold;
        }
        .profile-name {
            font-size: 24px;
            font-weight: 700;
            color: #0e374e;
        }
        .profile-email {
            color: #64748b;
            font-size: 14px;
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
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #0e374e;
            outline: none;
            box-shadow: 0 0 0 3px rgba(14,55,78,0.15);
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }
        .btn-save {
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
        .btn-save:hover {
            background: #d95b10;
        }
        .btn-cancel {
            background: #e2e8f0;
            color: #1e293b;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-cancel:hover {
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
        .tab-buttons {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 15px;
        }
        .tab-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            background: transparent;
            cursor: pointer;
            font-weight: 600;
            font-size: 15px;
            color: #64748b;
            transition: all 0.2s;
        }
        .tab-btn.active {
            background: #0e374e;
            color: white;
        }
        .tab-btn:hover:not(.active) {
            background: #f1f5f9;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            color: #0e374e;
            text-decoration: none;
            font-weight: 600;
        }
        .back-btn:hover {
            text-decoration: underline;
        }
        .gender-group {
            display: flex;
            gap: 15px;
            padding-top: 5px;
        }
        .gender-group label {
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: normal;
            font-size: 14px;
            cursor: pointer;
        }
        @media (max-width: 600px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            .profile-header {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<!-- Include Header/Navbar -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="main-content">
    <div class="container">
        <div class="profile-container">
            <div class="profile-header">
                <div class="profile-avatar">
                    ${user.firstName.charAt(0)}${user.lastName.charAt(0)}
                </div>
                <div>
                    <div class="profile-name">${user.firstName} ${user.lastName}</div>
                    <div class="profile-email">${user.email}</div>
                    <div style="font-size:14px;color:#64748b;margin-top:5px;">Member since ${user.createdAt}</div>
                </div>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <!-- Tabs -->
            <div class="tab-buttons">
                <button class="tab-btn active" onclick="showTab('profile-tab')">Edit Profile</button>
                <button class="tab-btn" onclick="showTab('password-tab')">Change Password</button>
            </div>

            <!-- Tab 1: Edit Profile -->
            <div id="profile-tab" class="tab-content active">
                <form action="${pageContext.request.contextPath}/update-profile" method="post">
                    <input type="hidden" name="action" value="update">

                    <div class="form-row">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" name="firstName" value="${user.firstName}" required>
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" name="lastName" value="${user.lastName}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Gender</label>
                        <div class="gender-group">
                            <label><input type="radio" name="gender" value="Male" ${user.gender == 'Male' ? 'checked' : ''}> Male</label>
                            <label><input type="radio" name="gender" value="Female" ${user.gender == 'Female' ? 'checked' : ''}> Female</label>
                            <label><input type="radio" name="gender" value="Other" ${user.gender == 'Other' ? 'checked' : ''}> Other</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" value="${user.email}" required>
                    </div>

                    <div class="form-group">
                        <label>Contact Number</label>
                        <input type="text" name="contact" value="${user.contact}" required>
                    </div>

                    <div class="form-group">
                        <label>Date of Birth</label>
                        <input type="date" name="dob" value="${user.dob}" required>
                    </div>

                    <button type="submit" class="btn-save">Save Changes</button>
                </form>
            </div>

            <!-- Tab 2: Change Password -->
            <div id="password-tab" class="tab-content">
                <form action="${pageContext.request.contextPath}/update-profile" method="post">
                    <input type="hidden" name="action" value="change-password">

                    <div class="form-group">
                        <label>Current Password</label>
                        <input type="password" name="oldPassword" required>
                    </div>

                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" name="newPassword" required>
                        <small style="color:#64748b;font-size:12px;">Minimum 6 characters</small>
                    </div>

                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <input type="password" name="confirmPassword" required>
                    </div>

                    <button type="submit" class="btn-save">Change Password</button>
                </form>
            </div>

            <a href="${pageContext.request.contextPath}/home" class="back-btn">← Back to Home</a>
        </div>
    </div>
</div>

<!-- Include Footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
    function showTab(tabId) {
        // Hide all tabs
        document.querySelectorAll('.tab-content').forEach(tab => {
            tab.classList.remove('active');
        });
        // Remove active class from all buttons
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.remove('active');
        });
        // Show selected tab
        document.getElementById(tabId).classList.add('active');
        // Add active class to clicked button
        event.target.classList.add('active');
    }
</script>

</body>
</html>