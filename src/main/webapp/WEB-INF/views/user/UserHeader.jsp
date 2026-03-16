<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* User Header Styles */
    .user-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        height: 70px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 30px;
        position: fixed;
        top: 0;
        right: 0;
        left: 250px;
        z-index: 99;
        box-shadow: 0 2px 20px rgba(102, 126, 234, 0.3);
        transition: all 0.3s ease;
    }
    
    .logo-area {
        display: flex;
        align-items: center;
    }
    
    .logo-text {
        font-size: 24px;
        font-weight: 700;
        color: white;
        margin: 0;
    }
    
    .logo-text span {
        color: #ffd700;
        font-weight: 800;
    }
    
    .header-right {
        display: flex;
        align-items: center;
        gap: 25px;
    }
    
    /* Notification Icon */
    .notification-icon {
        position: relative;
        cursor: pointer;
    }
    
    .notification-icon i {
        font-size: 22px;
        color: white;
    }
    
    .notification-badge {
        position: absolute;
        top: -8px;
        right: -8px;
        background: #ff4757;
        color: white;
        font-size: 11px;
        font-weight: 600;
        padding: 3px 6px;
        border-radius: 50%;
        border: 2px solid white;
    }
    
    /* User Profile */
    .user-profile {
        display: flex;
        align-items: center;
        gap: 15px;
        background: rgba(255, 255, 255, 0.15);
        padding: 5px 15px 5px 10px;
        border-radius: 40px;
        cursor: pointer;
        transition: all 0.3s;
        border: 1px solid rgba(255, 255, 255, 0.2);
    }
    
    .user-profile:hover {
        background: rgba(255, 255, 255, 0.25);
    }
    
    .user-avatar {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid white;
    }
    
    .avatar-text {
        width: 45px;
        height: 45px;
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
    
    .user-info {
        line-height: 1.3;
    }
    
    .user-name {
        display: block;
        color: white;
        font-weight: 600;
        font-size: 14px;
    }
    
    .user-role {
        display: block;
        color: rgba(255, 255, 255, 0.8);
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    /* Logout Button */
    .logout-btn {
        background: rgba(255, 255, 255, 0.15);
        color: white;
        padding: 8px 16px;
        border-radius: 30px;
        text-decoration: none;
        font-size: 13px;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 8px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        transition: all 0.3s;
    }
    
    .logout-btn:hover {
        background: #ff4757;
        border-color: #ff4757;
    }
    
    .logout-btn i {
        font-size: 14px;
    }
</style>

<!-- User Header -->
<header class="user-header">
    <div class="logo-area">
        <h2 class="logo-text">E<span>-Auction</span></h2>
    </div>
    
    <div class="header-right">
        <!-- Notification Bell -->
        <div class="notification-icon">
            <i class="fas fa-bell"></i>
            <span class="notification-badge">${winningBidsCount}</span>
        </div>
        
        <!-- User Profile -->
        <div class="user-profile">
            <c:choose>
                <c:when test="${not empty sessionScope.user.profilePicURL}">
                    <img src="${sessionScope.user.profilePicURL}" alt="profile" class="user-avatar">
                </c:when>
                <c:otherwise>
                    <div class="avatar-text">
                        ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="user-info">
                <span class="user-name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
                <span class="user-role">${sessionScope.user.role}</span>
            </div>
        </div>
        
        <!-- Logout Button -->
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</header>