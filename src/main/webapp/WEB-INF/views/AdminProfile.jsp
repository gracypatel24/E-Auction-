<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
        }
        
        /* Header */
        .header {
            background: white;
            height: 70px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            position: fixed;
            top: 0;
            right: 0;
            left: 250px;
            z-index: 99;
        }
        
        .header-left { display: flex; align-items: center; }
        .header-title { font-size: 20px; font-weight: 600; color: #333; }
        .header-title span { color: #667eea; }
        
        .header-right { display: flex; align-items: center; gap: 25px; }
        
        /* Navigation Links */
        .nav-links {
            display: flex;
            gap: 20px;
            margin-right: 20px;
        }
        
        .nav-link-item {
            color: #495057;
            text-decoration: none;
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .nav-link-item:hover {
            background: #f0f3ff;
            color: #667eea;
        }
        
        .nav-link-item i {
            margin-right: 5px;
        }
        
        /* Mail Icon */
        .mail-icon {
            position: relative;
            cursor: pointer;
            font-size: 20px;
            color: #495057;
        }
        
        .mail-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #dc3545;
            color: white;
            font-size: 10px;
            padding: 2px 5px;
            border-radius: 50%;
        }
        
        /* User Profile Dropdown */
        .user-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .user-profile:hover {
            background: #f0f3ff;
        }
        
        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .user-info {
            text-align: right;
        }
        
        .user-info .name {
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        
        .user-info .role {
            font-size: 12px;
            color: #667eea;
        }
        
        .dummy-logo {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 20px;
        }
        
        .dropdown-menu {
            position: absolute;
            right: 0;
            top: 50px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            width: 200px;
            display: none;
            z-index: 1000;
        }
        
        .dropdown-menu.show {
            display: block;
        }
        
        .dropdown-item {
            padding: 12px 20px;
            color: #495057;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }
        
        .dropdown-item:hover {
            background: #f0f3ff;
            color: #667eea;
        }
        
        .dropdown-item i {
            width: 20px;
            color: #667eea;
        }
        
        .dropdown-divider {
            height: 1px;
            background: #f0f0f0;
            margin: 5px 0;
        }
        
        /* Sidebar */
        .sidebar {
            width: 250px;
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            z-index: 100;
            overflow-y: auto;
        }
        
        .sidebar-menu { list-style: none; padding: 20px 0; }
        
        .profile-section {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #f0f0f0;
            margin-bottom: 10px;
        }
        
        .nav-item { margin: 5px 15px; border-radius: 10px; }
        .nav-item:hover { background: #f0f3ff; }
        .nav-item.active { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .nav-item.active .nav-link { color: white; }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #495057;
            text-decoration: none;
            font-weight: 500;
        }
        
        .nav-link i { margin-right: 12px; }
        
        /* Main Content */
        .main-content {
            margin-left: 250px;
            margin-top: 70px;
            padding: 30px;
            min-height: calc(100vh - 70px);
        }
        
        .profile-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
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
        }
        
        .profile-header h2 {
            color: #333;
            margin-bottom: 5px;
        }
        
        .profile-header .role {
            color: #667eea;
            font-weight: 600;
        }
        
        .info-row {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .info-label {
            width: 150px;
            color: #6c757d;
            font-weight: 500;
        }
        
        .info-value {
            flex: 1;
            color: #333;
            font-weight: 500;
        }
        
        .btn-edit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            margin-top: 20px;
            cursor: pointer;
            width: 100%;
        }
    </style>
</head>
<body>

<!-- Header with Navigation -->
<header class="header">
    <div class="header-left">
        <div class="header-title">
            <span>E-Auction</span> Admin
        </div>
    </div>
    
    <div class="header-right">
        <!-- Navigation Links -->
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin-dashboard" class="nav-link-item">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/listProduct" class="nav-link-item">
                <i class="fas fa-gavel"></i> Auctions
            </a>
            <a href="${pageContext.request.contextPath}/listCategory" class="nav-link-item">
                <i class="fas fa-tags"></i> Categories
            </a>
            <a href="${pageContext.request.contextPath}/listUser" class="nav-link-item">
                <i class="fas fa-users"></i> Users
            </a>
        </div>
        
        <!-- Mail Icon -->
        <div class="mail-icon" onclick="window.location.href='${pageContext.request.contextPath}/admin/mail'">
            <i class="far fa-envelope"></i>
            <span class="mail-badge">3</span>
        </div>
        
        <!-- User Dropdown -->
        <div class="user-dropdown" id="userDropdown">
            <div class="user-profile" onclick="toggleDropdown()">
                <div class="user-info">
                    <div class="name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                    <div class="role">${sessionScope.user.role}</div>
                </div>
                <c:choose>
                    <c:when test="${not empty sessionScope.user.profilePicURL}">
                        <img src="${sessionScope.user.profilePicURL}" alt="profile">
                    </c:when>
                    <c:otherwise>
                        <div class="dummy-logo">
                            ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Dropdown Menu -->
            <div class="dropdown-menu" id="dropdownMenu">
                <a href="${pageContext.request.contextPath}/admin/profile" class="dropdown-item">
                    <i class="fas fa-user"></i> My Profile
                </a>
                <a href="${pageContext.request.contextPath}/admin/settings" class="dropdown-item">
                    <i class="fas fa-cog"></i> Settings
                </a>
                <a href="${pageContext.request.contextPath}/admin/mail" class="dropdown-item">
                    <i class="fas fa-envelope"></i> Messages
                    <span style="margin-left: auto; background: #dc3545; color: white; padding: 2px 6px; border-radius: 10px; font-size: 11px;">3</span>
                </a>
                <div class="dropdown-divider"></div>
                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </div>
</header>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-menu">
        <div class="profile-section">
            <c:choose>
                <c:when test="${not empty sessionScope.user.profilePicURL}">
                    <img src="${sessionScope.user.profilePicURL}" alt="profile" style="width:45px; height:45px; border-radius:50%; margin-right:12px;">
                </c:when>
                <c:otherwise>
                    <div class="dummy-logo" style="width:45px; height:45px; font-size:18px; margin-right:12px;">
                        ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                    </div>
                </c:otherwise>
            </c:choose>
            <div>
                <div style="font-weight: 600;">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                <div style="font-size: 12px; color: #667eea;">${sessionScope.user.role}</div>
            </div>
        </div>

        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listProduct">
                <i class="fas fa-gavel"></i> Auctions
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listCategory">
                <i class="fas fa-tags"></i> Categories
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listUser">
                <i class="fas fa-users"></i> Users
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/newUserType">
                <i class="fas fa-user-tag"></i> User Types
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/mail">
                <i class="fas fa-envelope"></i> Messages
                <span style="margin-left: auto; background: #dc3545; color: white; padding: 2px 8px; border-radius: 10px; font-size: 11px;">3</span>
            </a>
        </div>
        <div class="nav-item" style="margin-top: 20px;">
            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="profile-container">
        <div class="profile-header">
            <c:choose>
                <c:when test="${not empty sessionScope.user.profilePicURL}">
                    <img src="${sessionScope.user.profilePicURL}" class="profile-avatar">
                </c:when>
                <c:otherwise>
                    <div class="dummy-logo" style="width:120px; height:120px; font-size:48px; margin:0 auto 20px;">
                        ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                    </div>
                </c:otherwise>
            </c:choose>
            <h2>${sessionScope.user.firstName} ${sessionScope.user.lastName}</h2>
            <div class="role">${sessionScope.user.role}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Email</div>
            <div class="info-value">${sessionScope.user.email}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Contact Number</div>
            <div class="info-value">${sessionScope.user.contactNum != null ? sessionScope.user.contactNum : 'Not provided'}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Gender</div>
            <div class="info-value">${sessionScope.user.gender != null ? sessionScope.user.gender : 'Not specified'}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Birth Year</div>
            <div class="info-value">${sessionScope.user.birthYear != null ? sessionScope.user.birthYear : 'Not specified'}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Member Since</div>
            <div class="info-value">${sessionScope.user.createdAt}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Account Status</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${sessionScope.user.active}">
                        <span style="color: #28a745;">Active</span>
                    </c:when>
                    <c:otherwise>
                        <span style="color: #dc3545;">Inactive</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <button class="btn-edit" onclick="window.location.href='${pageContext.request.contextPath}/admin/edit-profile'">
            <i class="fas fa-edit"></i> Edit Profile
        </button>
    </div>
</div>

<script>
    function toggleDropdown() {
        document.getElementById('dropdownMenu').classList.toggle('show');
    }
    
    // Close dropdown when clicking outside
    window.onclick = function(event) {
        if (!event.target.matches('.user-profile') && !event.target.matches('.user-profile *')) {
            var dropdowns = document.getElementsByClassName('dropdown-menu');
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }
</script>

</body>
</html>