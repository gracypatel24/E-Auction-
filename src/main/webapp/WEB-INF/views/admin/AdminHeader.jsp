<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    // Get current page from URL or parameter
    String currentPage = request.getParameter("page");
    if(currentPage == null || currentPage.isEmpty()) {
        String uri = request.getRequestURI();
        if(uri.contains("dashboard")) currentPage = "dashboard";
        else if(uri.contains("users")) currentPage = "users";
        else if(uri.contains("products")) currentPage = "products";
        else if(uri.contains("category")) currentPage = "categories";
        else if(uri.contains("bids")) currentPage = "bids";
        else if(uri.contains("payments")) currentPage = "payments";
        else if(uri.contains("mail")) currentPage = "mail";
        else if(uri.contains("profile")) currentPage = "profile";
        else if(uri.contains("userTypes")) currentPage = "userTypes";
        else currentPage = "dashboard";
    }
    request.setAttribute("currentPage", currentPage);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Auction Admin - ${pageTitle}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: #f4f7fc;
            display: flex;
        }
        
        .main-content {
            flex: 1;
            margin-left: 250px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .navbar {
            background: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 99;
        }
        
        .nav-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .menu-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 20px;
            color: #2d3748;
            cursor: pointer;
        }
        
        .page-title {
            font-size: 20px;
            font-weight: 600;
            color: #2d3748;
        }
        
        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
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
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 18px;
        }
        
        .user-info {
            text-align: right;
        }
        
        .user-name {
            font-weight: 600;
            color: #2d3748;
            font-size: 14px;
        }
        
        .user-role {
            font-size: 12px;
            color: #667eea;
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
        
        .content-area {
            padding: 30px;
            flex: 1;
        }
        
        .footer {
            background: white;
            padding: 15px 30px;
            text-align: center;
            color: #718096;
            border-top: 1px solid #e2e8f0;
        }
        
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
            
            .menu-toggle {
                display: block;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="AdminSidebar.jsp"/>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <div class="navbar">
            <div class="nav-left">
                <button class="menu-toggle" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="page-title">${pageTitle}</div>
            </div>
            <div class="nav-right">
                <!-- Messages Icon -->
                <div class="mail-icon" onclick="window.location.href='${pageContext.request.contextPath}/admin/mail'">
                    <i class="far fa-envelope"></i>
                    <c:if test="${unreadCount > 0}">
                        <span class="mail-badge">${unreadCount}</span>
                    </c:if>
                </div>
                
                <!-- User Dropdown with Profile and Logout -->
                <div class="user-dropdown" id="userDropdown">
                    <div class="user-profile" onclick="toggleDropdown()">
                        <div class="user-info">
                            <div class="user-name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                            <div class="user-role">${sessionScope.user.userType.userTypeName}</div>
                        </div>
                        <div class="user-avatar">
                            ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                        </div>
                    </div>
                    
                    <div class="dropdown-menu" id="dropdownMenu">
                        <a href="${pageContext.request.contextPath}/admin/profile" class="dropdown-item">
                            <i class="fas fa-user"></i> My Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/mail" class="dropdown-item">
                            <i class="fas fa-envelope"></i> Messages
                            <c:if test="${unreadCount > 0}">
                                <span style="margin-left: auto; background: #dc3545; color: white; padding: 2px 6px; border-radius: 10px; font-size: 11px;">${unreadCount}</span>
                            </c:if>
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Content Area (closed in footer) -->
        <div class="content-area">