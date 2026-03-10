<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 600px;
            padding: 40px;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin-bottom: 20px;
            border: 4px solid #667eea;
            object-fit: cover;
        }
        .dummy-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 48px;
            font-weight: 700;
            margin: 0 auto 20px;
            border: 4px solid white;
        }
        .profile-header h2 {
            color: #333;
            margin-bottom: 5px;
        }
        .profile-header .role {
            color: #667eea;
            font-weight: 600;
            font-size: 14px;
        }
        .info-row {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-label {
            width: 140px;
            color: #6c757d;
            font-weight: 500;
        }
        .info-value {
            flex: 1;
            color: #333;
            font-weight: 500;
        }
        .status-active {
            color: #28a745;
            font-weight: 600;
        }
        .status-inactive {
            color: #dc3545;
            font-weight: 600;
        }
        .btn-dashboard {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            margin-top: 20px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-dashboard:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.4);
        }
    </style>
</head>
<body>
    <div class="profile-card">
        <div class="profile-header">
            <c:choose>
                <c:when test="${not empty user.profilePicURL}">
                    <img src="${user.profilePicURL}" class="profile-avatar">
                </c:when>
                <c:otherwise>
                    <div class="dummy-avatar">
                        ${user.firstName.charAt(0)}${user.lastName.charAt(0)}
                    </div>
                </c:otherwise>
            </c:choose>
            <h2>${user.firstName} ${user.lastName}</h2>
            <div class="role">${user.role}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Email</div>
            <div class="info-value">${user.email}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Contact Number</div>
            <div class="info-value">${user.contactNum != null ? user.contactNum : 'Not provided'}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Gender</div>
            <div class="info-value">${user.gender != null ? user.gender : 'Not specified'}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Birth Year</div>
            <div class="info-value">${user.birthYear != null ? user.birthYear : 'Not specified'}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Member Since</div>
            <div class="info-value">${user.createdAt}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Account Status</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${user.active}">
                        <span class="status-active">● Active</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-inactive">● Inactive</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <c:if test="${not empty userDetail}">
            <div class="info-row">
                <div class="info-label">City</div>
                <div class="info-value">${userDetail.city != null ? userDetail.city : 'Not specified'}</div>
            </div>
            <div class="info-row">
                <div class="info-label">State</div>
                <div class="info-value">${userDetail.state != null ? userDetail.state : 'Not specified'}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Country</div>
                <div class="info-value">${userDetail.country != null ? userDetail.country : 'Not specified'}</div>
            </div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/participant/dashboard" class="btn-dashboard">
            <i class="fas fa-home"></i> Back to Dashboard
        </a>
    </div>
</body>
</html>