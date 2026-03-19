<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    String currentPage = request.getParameter("page");
    if(currentPage == null || currentPage.isEmpty()) {
        currentPage = "dashboard";
    }
    request.setAttribute("currentPage", currentPage);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Auction User - ${pageTitle}</title>
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
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
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
            color: #48bb78;
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
            color: #48bb78;
        }
        
        .dropdown-item i {
            width: 20px;
            color: #48bb78;
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
    <jsp:include page="UserSidebar.jsp"/>
    
    <div class="main-content">
        <div class="navbar">
            <div class="nav-left">
                <button class="menu-toggle" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="page-title">${pageTitle}</div>
            </div>
            <div class="nav-right">
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
                        <a href="${pageContext.request.contextPath}/user/profile" class="dropdown-item">
                            <i class="fas fa-user-circle"></i> My Profile
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="content-area">