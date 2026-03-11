<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Header -->
<header class="participant-header">
    <div class="header-left">
        <button class="toggle-sidebar" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        <div class="page-title">
            <i class="fas fa-home"></i> Dashboard
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