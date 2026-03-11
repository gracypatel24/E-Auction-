<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Won Auctions - E-Auction</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        /* ===== PARTICIPANT STYLES ===== */
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            background: #f8f9fc;
            overflow-x: hidden;
        }

        /* ===== HEADER STYLES ===== */
        .participant-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            position: fixed;
            top: 0;
            right: 0;
            left: 260px;
            z-index: 1000;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .participant-header.sidebar-collapsed {
            left: 70px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .toggle-sidebar {
            background: transparent;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .toggle-sidebar:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .page-title {
            color: white;
            font-size: 18px;
            font-weight: 500;
        }

        .page-title i {
            margin-right: 10px;
            font-size: 20px;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .search-box {
            position: relative;
            width: 300px;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.7);
            font-size: 16px;
        }

        .search-box input {
            width: 100%;
            height: 45px;
            background: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            padding: 0 20px 0 45px;
            color: white;
            font-size: 14px;
            transition: all 0.3s;
        }

        .search-box input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .search-box input:focus {
            background: rgba(255, 255, 255, 0.25);
            outline: none;
            border-color: rgba(255, 255, 255, 0.4);
        }

        .notification-icon {
            position: relative;
            cursor: pointer;
            color: white;
            font-size: 22px;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .notification-icon:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .notification-badge {
            position: absolute;
            top: 5px;
            right: 8px;
            background: #f5365c;
            color: white;
            font-size: 10px;
            font-weight: 600;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #764ba2;
        }

        .user-dropdown {
            position: relative;
            display: inline-block;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
            padding: 5px 15px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 30px;
            transition: all 0.3s;
        }

        .user-profile:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .user-info {
            text-align: right;
        }

        .user-name {
            color: white;
            font-weight: 600;
            font-size: 14px;
            line-height: 1.2;
        }

        .user-role {
            color: rgba(255, 255, 255, 0.8);
            font-size: 11px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
        }

        .dummy-avatar {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #667eea;
            font-weight: 700;
            font-size: 18px;
            border: 2px solid white;
        }

        .dropdown-menu {
            position: absolute;
            top: 60px;
            right: 0;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            width: 240px;
            padding: 10px 0;
            display: none;
            z-index: 1001;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
            gap: 12px;
            transition: all 0.3s;
            font-size: 14px;
        }

        .dropdown-item:hover {
            background: #f8f9fa;
            color: #667eea;
        }

        .dropdown-item i {
            width: 20px;
            color: #667eea;
            font-size: 16px;
        }

        .dropdown-divider {
            height: 1px;
            background: #e9ecef;
            margin: 8px 0;
        }

        /* ===== SIDEBAR STYLES ===== */
        .participant-sidebar {
            width: 260px;
            background: white;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            z-index: 1001;
            box-shadow: 2px 0 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .participant-sidebar.collapsed {
            width: 70px;
        }

        .participant-sidebar.collapsed .sidebar-logo span,
        .participant-sidebar.collapsed .menu-title,
        .participant-sidebar.collapsed .user-info-text,
        .participant-sidebar.collapsed .badge {
            display: none;
        }

        .participant-sidebar.collapsed .nav-link {
            justify-content: center;
            padding: 15px 0;
        }

        .participant-sidebar.collapsed .nav-link i {
            margin: 0;
            font-size: 20px;
        }

        .participant-sidebar.collapsed .user-profile-sidebar {
            padding: 15px 0;
            justify-content: center;
        }

        .sidebar-logo {
            height: 70px;
            display: flex;
            align-items: center;
            padding: 0 20px;
            border-bottom: 1px solid #f0f0f0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .sidebar-logo a {
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #667eea;
            font-size: 20px;
            font-weight: 700;
        }

        .sidebar-logo span {
            color: white;
            font-weight: 700;
            font-size: 18px;
        }

        .user-profile-sidebar {
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 1px solid #f0f0f0;
            margin-bottom: 20px;
        }

        .user-avatar-sidebar {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            object-fit: cover;
        }

        .dummy-avatar-sidebar {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 18px;
        }

        .user-info-text .name {
            font-weight: 600;
            color: #333;
            font-size: 14px;
            margin-bottom: 3px;
        }

        .user-info-text .email {
            font-size: 11px;
            color: #6c757d;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .menu-category {
            padding: 15px 20px 5px;
            color: #6c757d;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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

        .nav-item.active .nav-link i {
            color: white;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #495057;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s;
        }

        .nav-link i {
            margin-right: 12px;
            font-size: 18px;
            min-width: 20px;
            color: #667eea;
            transition: all 0.3s;
        }

        .badge {
            margin-left: auto;
            background: #f5365c;
            color: white;
            padding: 3px 8px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 600;
        }

        /* ===== MAIN CONTENT AREA ===== */
        .main-wrapper {
            margin-left: 260px;
            padding-top: 70px;
            min-height: 100vh;
            background: #f8f9fc;
            transition: all 0.3s ease;
        }

        .main-wrapper.sidebar-collapsed {
            margin-left: 70px;
        }

        .content-area {
            padding: 30px;
        }

        /* ===== PAGE HEADER ===== */
        .page-header {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h2 {
            color: #333;
            font-size: 24px;
            font-weight: 700;
            margin: 0;
        }

        .page-header h2 span {
            color: #667eea;
        }

        .winner-badge {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 14px;
        }

        /* ===== AUCTION GRID ===== */
        .auction-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .winner-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
            border: 2px solid #28a745;
            position: relative;
        }

        .winner-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(40, 167, 69, 0.15);
        }

        .winner-badge-top {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #28a745;
            color: white;
            padding: 5px 15px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            z-index: 10;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .winner-badge-top i {
            margin-right: 5px;
        }

        .winner-image {
            height: 200px;
            width: 100%;
            object-fit: cover;
            border-bottom: 3px solid #28a745;
        }

        .winner-details {
            padding: 25px;
        }

        .winner-title {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }

        .winner-amount {
            font-size: 28px;
            font-weight: 700;
            color: #28a745;
            margin-bottom: 15px;
        }

        .winner-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .winner-info p {
            margin-bottom: 8px;
            color: #495057;
            font-size: 14px;
        }

        .winner-info i {
            color: #28a745;
            width: 22px;
            margin-right: 5px;
        }

        .btn-view {
            background: #28a745;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            text-decoration: none;
            display: block;
            text-align: center;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s;
        }

        .btn-view:hover {
            background: #218838;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #5a6268;
            color: white;
        }

        /* ===== EMPTY STATE ===== */
        .empty-state {
            background: white;
            border-radius: 15px;
            padding: 60px 20px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }

        .empty-state i {
            font-size: 80px;
            color: #ffc107;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            color: #333;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #6c757d;
            margin-bottom: 25px;
        }

        /* ===== FOOTER STYLES ===== */
        .participant-footer {
            background: white;
            padding: 20px 30px;
            border-radius: 15px 15px 0 0;
            box-shadow: 0 -5px 20px rgba(0, 0, 0, 0.02);
            margin-top: 30px;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .copyright {
            color: #6c757d;
            font-size: 13px;
        }

        .copyright i {
            color: #f5365c;
            margin: 0 3px;
        }

        .footer-links {
            display: flex;
            gap: 20px;
        }

        .footer-links a {
            color: #6c757d;
            text-decoration: none;
            font-size: 13px;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #667eea;
        }

        .social-links {
            display: flex;
            gap: 10px;
        }

        .social-links a {
            width: 35px;
            height: 35px;
            background: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #667eea;
            text-decoration: none;
            transition: all 0.3s;
        }

        .social-links a:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        /* ===== BACK BUTTON ===== */
        .back-link {
            text-align: center;
            margin: 20px 0;
        }

        /* ===== RESPONSIVE STYLES ===== */
        @media (max-width: 992px) {
            .participant-header {
                left: 0;
            }
            
            .main-wrapper {
                margin-left: 0;
            }
            
            .participant-sidebar {
                transform: translateX(-100%);
            }
            
            .participant-sidebar.show {
                transform: translateX(0);
            }
        }

        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .search-box {
                display: none;
            }
            
            .footer-content {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="participant-header">
        <div class="header-left">
            <button class="toggle-sidebar" onclick="toggleSidebar()">
                <i class="fas fa-bars"></i>
            </button>
            <div class="page-title">
                <i class="fas fa-trophy"></i> Won Auctions
            </div>
        </div>
        
        <div class="header-right">
            <!-- Search Box -->
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search auctions...">
            </div>
            
            <!-- Notification -->
            <div class="notification-icon">
                <i class="far fa-bell"></i>
                <span class="notification-badge">3</span>
            </div>
            
            <!-- User Dropdown -->
            <div class="user-dropdown">
                <div class="user-profile" onclick="toggleDropdown()">
                    <div class="user-info">
                        <div class="user-name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                        <div class="user-role">${sessionScope.user.role}</div>
                    </div>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.profilePicURL}">
                            <img src="${sessionScope.user.profilePicURL}" alt="profile" class="user-avatar">
                        </c:when>
                        <c:otherwise>
                            <div class="dummy-avatar">
                                ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Dropdown Menu -->
                <div class="dropdown-menu" id="userDropdown">
                    <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">
                        <i class="fas fa-user"></i> My Profile
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-question-circle"></i> Help
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
    <aside class="participant-sidebar" id="participantSidebar">
        <div class="sidebar-logo">
            <a href="${pageContext.request.contextPath}/participant/dashboard">
                <div class="logo-icon">E</div>
                <span>E-Auction</span>
            </a>
        </div>

        <!-- User Profile -->
        <div class="user-profile-sidebar">
            <c:choose>
                <c:when test="${not empty sessionScope.user.profilePicURL}">
                    <img src="${sessionScope.user.profilePicURL}" alt="profile" class="user-avatar-sidebar">
                </c:when>
                <c:otherwise>
                    <div class="dummy-avatar-sidebar">
                        ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="user-info-text">
                <div class="name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                <div class="email">${sessionScope.user.email}</div>
            </div>
        </div>
        
        <ul class="sidebar-menu">
            <li class="menu-category">MAIN</li>
            
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/participant/dashboard">
                    <i class="fas fa-home"></i>
                    <span class="menu-title">Dashboard</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/listProduct">
                    <i class="fas fa-gavel"></i>
                    <span class="menu-title">Browse Auctions</span>
                </a>
            </li>

            <li class="menu-category">MY ACTIVITY</li>

            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/participant/my-bids">
                    <i class="fas fa-list"></i>
                    <span class="menu-title">My Bids</span>
                    <span class="badge">${totalBids}</span>
                </a>
            </li>

            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/participant/won-auctions">
                    <i class="fas fa-trophy"></i>
                    <span class="menu-title">Won Auctions</span>
                    <span class="badge">${wonCount}</span>
                </a>
            </li>

            <li class="menu-category">ACCOUNT</li>

            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                    <i class="fas fa-user"></i>
                    <span class="menu-title">My Profile</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-cog"></i>
                    <span class="menu-title">Settings</span>
                </a>
            </li>

            <li class="nav-item" style="margin-top: 20px;">
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span class="menu-title">Logout</span>
                </a>
            </li>
        </ul>
    </aside>

    <!-- Main Wrapper -->
    <div class="main-wrapper" id="mainWrapper">
        <div class="content-area">
            <!-- Page Header -->
            <div class="page-header">
                <h2><span>Won</span> Auctions</h2>
                <span class="winner-badge"><i class="fas fa-trophy"></i> ${wonCount} Wins</span>
            </div>
            
            <c:choose>
                <c:when test="${empty wonAuctions}">
                    <!-- Empty State -->
                    <div class="empty-state">
                        <i class="fas fa-trophy"></i>
                        <h3>No Won Auctions Yet</h3>
                        <p class="text-muted">Keep bidding! Your winning auction is just around the corner.</p>
                        <a href="${pageContext.request.contextPath}/listProduct" class="btn-primary btn-sm" style="padding: 12px 30px; background: #667eea; color: white; text-decoration: none; border-radius: 8px;">
                            <i class="fas fa-gavel"></i> Browse Auctions
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Winners Grid -->
                    <div class="auction-grid">
                        <c:forEach items="${wonAuctions}" var="bid">
                            <div class="winner-card">
                                <div class="winner-badge-top">
                                    <i class="fas fa-crown"></i> WINNER
                                </div>
                                <img src="${bid.product.imageUrl}" class="winner-image" alt="Auction">
                                <div class="winner-details">
                                    <div class="winner-title">${bid.product.title}</div>
                                    <div class="winner-amount">$${bid.bidAmount}</div>
                                    
                                    <div class="winner-info">
                                        <p><i class="fas fa-tag"></i> ${bid.product.category}</p>
                                        <p><i class="far fa-clock"></i> Won on: ${bid.bidTime}</p>
                                        <p><i class="fas fa-check-circle"></i> Status: <span style="color: #28a745; font-weight: 600;">WON</span></p>
                                    </div>
                                    
                                    <a href="${pageContext.request.contextPath}/viewProduct?productId=${bid.productId}" 
                                       class="btn-view">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <!-- Back to Dashboard -->
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/participant/dashboard" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
            
            <!-- Footer -->
            <footer class="participant-footer">
                <div class="footer-content">
                    <div class="copyright">
                        &copy; 2026 <strong>E-Auction</strong>. Made with <i class="fas fa-heart"></i> for auction lovers
                    </div>
                    
                    <div class="footer-links">
                        <a href="#">About Us</a>
                        <a href="#">Terms</a>
                        <a href="#">Privacy</a>
                        <a href="#">Contact</a>
                    </div>
                    
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Toggle Sidebar
        function toggleSidebar() {
            const sidebar = document.getElementById('participantSidebar');
            const header = document.querySelector('.participant-header');
            const mainWrapper = document.getElementById('mainWrapper');
            
            if (sidebar && header && mainWrapper) {
                sidebar.classList.toggle('collapsed');
                header.classList.toggle('sidebar-collapsed');
                mainWrapper.classList.toggle('sidebar-collapsed');
            }
        }
        
        // Toggle Dropdown
        function toggleDropdown() {
            const dropdown = document.getElementById('userDropdown');
            if (dropdown) {
                dropdown.classList.toggle('show');
            }
        }
        
        // Close dropdown when clicking outside
        window.onclick = function(event) {
            if (!event.target.matches('.user-profile') && !event.target.matches('.user-profile *')) {
                const dropdowns = document.getElementsByClassName('dropdown-menu');
                for (let i = 0; i < dropdowns.length; i++) {
                    if (dropdowns[i].classList.contains('show')) {
                        dropdowns[i].classList.remove('show');
                    }
                }
            }
        }
    </script>
</body>
</html>