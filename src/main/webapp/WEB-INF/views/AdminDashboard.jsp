<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
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
        
        .header-left {
            display: flex;
            align-items: center;
        }
        
        .header-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
        }
        
        .header-title span {
            color: #667eea;
        }
        
        .header-right {
            display: flex;
            align-items: center;
            gap: 25px;
        }
        
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
        
        /* User Dropdown */
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
        
        .sidebar-menu {
            list-style: none;
            padding: 20px 0;
            margin: 0;
        }
        
        .profile-section {
            display: flex;
            align-items: center;
            padding: 20px;
            margin-bottom: 10px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .profile-section img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 12px;
        }
        
        .profile-text .name {
            font-weight: 600;
            color: #333;
            margin-bottom: 2px;
        }
        
        .profile-text .role {
            font-size: 12px;
            color: #667eea;
        }
        
        .nav-item {
            margin: 5px 15px;
            border-radius: 10px;
            transition: all 0.3s;
        }
        
        .nav-item:hover {
            background: #f0f3ff;
        }
        
        .nav-item.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .nav-item.active .nav-link {
            color: white;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #495057;
            text-decoration: none;
            font-weight: 500;
        }
        
        .nav-link i {
            margin-right: 12px;
            font-size: 18px;
            min-width: 20px;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 250px;
            margin-top: 70px;
            padding: 30px;
            background: #f4f7fc;
            min-height: calc(100vh - 70px);
        }
        
        /* Welcome Card */
        .welcome-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            padding: 30px;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }
        
        .welcome-card h2 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .date-badge {
            background: rgba(255,255,255,0.2);
            padding: 10px 20px;
            border-radius: 10px;
            display: inline-block;
        }
        
        /* Stats Cards */
        .stats-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            flex: 1;
            min-width: 200px;
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: all 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(102,126,234,0.2);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }
        
        .stat-icon.blue { background: rgba(102,126,234,0.1); color: #667eea; }
        .stat-icon.green { background: rgba(40,167,69,0.1); color: #28a745; }
        .stat-icon.orange { background: rgba(255,193,7,0.1); color: #ffc107; }
        .stat-icon.red { background: rgba(220,53,69,0.1); color: #dc3545; }
        
        .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: #333;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 14px;
            font-weight: 500;
        }
        
        /* Quick Actions */
        .quick-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .quick-action-btn {
            flex: 1;
            min-width: 150px;
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            text-decoration: none;
            color: #495057;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s;
        }
        
        .quick-action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.2);
            color: #667eea;
        }
        
        .quick-action-btn i {
            font-size: 28px;
            margin-bottom: 8px;
            display: block;
            color: #667eea;
        }
        
        .quick-action-btn span {
            font-weight: 600;
            font-size: 13px;
        }
        
        /* Section Title */
        .section-title {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .view-all-link {
            color: #667eea;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
        }
        
        /* Tables */
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table thead th {
            border-bottom: 2px solid #667eea;
            color: #495057;
            font-weight: 600;
            font-size: 13px;
            padding: 12px 10px;
            text-align: left;
        }
        
        .table tbody td {
            padding: 12px 10px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .badge {
            padding: 5px 10px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .badge-success { background: #d4edda; color: #155724; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-info { background: #d1ecf1; color: #0c5460; }
        .badge-primary { background: #007bff; color: white; }
        
        .product-thumb {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            margin-right: 10px;
        }
        
        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .btn-action {
            padding: 4px 10px;
            border-radius: 5px;
            font-size: 11px;
            margin: 0 2px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-view { background: #e7f3ff; color: #004085; }
        .btn-edit { background: #fff3cd; color: #856404; }
        
        .footer {
            background: white;
            padding: 20px;
            border-radius: 15px;
            margin-top: 30px;
            text-align: center;
            color: #6c757d;
        }
    </style>
</head>
<body>

<!-- Header -->
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
        <a href="${pageContext.request.contextPath}/admin/mail" class="mail-icon" style="color: #495057;">
            <i class="far fa-envelope"></i>
            <span class="mail-badge">3</span>
        </a>
        
        <!-- User Dropdown -->
        <div class="user-dropdown" id="userDropdown">
            <div class="user-profile" onclick="toggleDropdown()">
                <div class="user-info">
                    <div class="name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                    <div class="role">${sessionScope.user.role}</div>
                </div>
                <c:choose>
                    <c:when test="${not empty sessionScope.user.profilePicURL}">
                        <img src="${sessionScope.user.profilePicURL}" alt="profile" style="width:40px; height:40px; border-radius:50%;">
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
        <!-- Profile Section -->
        <div class="profile-section">
            <c:choose>
                <c:when test="${not empty sessionScope.user.profilePicURL}">
                    <img src="${sessionScope.user.profilePicURL}" alt="profile">
                </c:when>
                <c:otherwise>
                    <div class="dummy-logo" style="width:45px; height:45px; font-size:18px; margin-right:12px;">
                        ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="profile-text">
                <div class="name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                <div class="role">${sessionScope.user.role}</div>
            </div>
        </div>

        <!-- Navigation Items -->
        <div class="nav-item active">
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
    
    <!-- Welcome Card -->
    <div class="welcome-card">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2>Welcome back, ${sessionScope.user.firstName} ${sessionScope.user.lastName}!</h2>
                <p>Here's what's happening with your auction platform today.</p>
            </div>
            <div class="col-md-4 text-right">
                <div class="date-badge">
                    <div style="font-size: 24px; font-weight: 700;"><%= new java.text.SimpleDateFormat("dd").format(new java.util.Date()) %></div>
                    <div style="font-size: 14px;"><%= new java.text.SimpleDateFormat("MMMM yyyy").format(new java.util.Date()) %></div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Statistics Cards -->
    <div class="stats-row">
        <!-- Total Auctions Card -->
        <a href="${pageContext.request.contextPath}/listProduct" class="stat-card">
            <div class="stat-icon blue"><i class="fas fa-gavel"></i></div>
            <div>
                <div class="stat-value">${totalProducts}</div>
                <div class="stat-label">Total Auctions</div>
            </div>
        </a>
        
        <!-- Total Users Card -->
        <a href="${pageContext.request.contextPath}/listUser" class="stat-card">
            <div class="stat-icon green"><i class="fas fa-users"></i></div>
            <div>
                <div class="stat-value">${totalUsers}</div>
                <div class="stat-label">Total Users</div>
            </div>
        </a>
        
        <!-- Categories Card -->
        <a href="${pageContext.request.contextPath}/listCategory" class="stat-card">
            <div class="stat-icon orange"><i class="fas fa-tags"></i></div>
            <div>
                <div class="stat-value">${totalCategories}</div>
                <div class="stat-label">Categories</div>
            </div>
        </a>
        
        <!-- Active Auctions Card -->
        <a href="${pageContext.request.contextPath}/listProduct?status=ACTIVE" class="stat-card">
            <div class="stat-icon red"><i class="fas fa-clock"></i></div>
            <div>
                <div class="stat-value">${activeAuctions}</div>
                <div class="stat-label">Live Auctions</div>
            </div>
        </a>
    </div>
    
    <!-- Quick Actions -->
    <div class="quick-actions">
        <a href="${pageContext.request.contextPath}/newProduct" class="quick-action-btn">
            <i class="fas fa-plus-circle"></i>
            <span>Create Auction</span>
        </a>
        <a href="${pageContext.request.contextPath}/newCategory" class="quick-action-btn">
            <i class="fas fa-folder-plus"></i>
            <span>Add Category</span>
        </a>
        <a href="${pageContext.request.contextPath}/newUserType" class="quick-action-btn">
            <i class="fas fa-user-plus"></i>
            <span>Add User Type</span>
        </a>
        <a href="${pageContext.request.contextPath}/listUser" class="quick-action-btn">
            <i class="fas fa-user-cog"></i>
            <span>Manage Users</span>
        </a>
    </div>
    
    <!-- Recent Auctions Section -->
    <div class="section-title">
        <div><i class="fas fa-gavel"></i> Recent Auctions</div>
        <a href="${pageContext.request.contextPath}/listProduct" class="view-all-link">View All <i class="fas fa-arrow-right"></i></a>
    </div>
    
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Category</th>
                    <th>Current Bid</th>
                    <th>Bids</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${recentAuctions}" var="auction">
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center;">
                                <img src="${auction.imageUrl}" class="product-thumb" alt="${auction.title}">
                                <strong>${auction.title}</strong>
                            </div>
                        </td>
                        <td>${auction.category}</td>
                        <td><strong>$${auction.currentBid}</strong></td>
                        <td><span class="badge badge-primary">${auction.bidCount}</span></td>
                        <td>${auction.endDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${auction.status == 'ACTIVE'}">
                                    <span class="badge badge-success">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-warning">${auction.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/viewProduct?productId=${auction.productId}" class="btn-action btn-view">
                                <i class="fas fa-eye"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty recentAuctions}">
                    <tr>
                        <td colspan="7" class="text-center py-4">
                            <i class="fas fa-gavel" style="font-size: 40px; color: #ccc;"></i>
                            <p class="mt-2">No auctions found</p>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    
    <!-- Recent Users Section -->
    <div class="section-title">
        <div><i class="fas fa-users"></i> Recent Users</div>
        <a href="${pageContext.request.contextPath}/listUser" class="view-all-link">View All <i class="fas fa-arrow-right"></i></a>
    </div>
    
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Joined</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${recentUsers}" var="user">
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center;">
                                <img src="${user.profilePicURL != null ? user.profilePicURL : 'https://via.placeholder.com/35x35/667eea/ffffff?text='.concat(user.firstName.charAt(0))}" 
                                     class="user-avatar">
                                <strong>${user.firstName} ${user.lastName}</strong>
                            </div>
                        </td>
                        <td>${user.email}</td>
                        <td><span class="badge badge-info">${user.role}</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${user.active}">
                                    <span class="badge badge-success">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger">Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${user.createdAt}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/viewUser?userId=${user.userId}" class="btn-action btn-view">
                                <i class="fas fa-eye"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty recentUsers}">
                    <tr>
                        <td colspan="6" class="text-center py-4">
                            <i class="fas fa-users" style="font-size: 40px; color: #ccc;"></i>
                            <p class="mt-2">No users found</p>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        &copy; 2026 E-Auction. All rights reserved.
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>