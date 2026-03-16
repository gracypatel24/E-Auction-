<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* User Sidebar Styles */
    .user-sidebar {
        width: 250px;
        background: white;
        box-shadow: 2px 0 20px rgba(0, 0, 0, 0.05);
        position: fixed;
        left: 0;
        top: 0;
        bottom: 0;
        z-index: 100;
        overflow-y: auto;
        transition: all 0.3s ease;
    }
    
    .sidebar-header {
        padding: 30px 20px;
        text-align: center;
        border-bottom: 1px solid #f0f0f0;
        background: linear-gradient(135deg, #667eea10 0%, #764ba210 100%);
    }
    
    .user-avatar-large {
        width: 90px;
        height: 90px;
        margin: 0 auto 15px;
    }
    
    .user-avatar-large img {
        width: 90px;
        height: 90px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #667eea;
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }
    
    .avatar-large-text {
        width: 90px;
        height: 90px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 36px;
        font-weight: 600;
        margin: 0 auto;
        border: 3px solid white;
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }
    
    .user-info-large {
        margin-top: 15px;
    }
    
    .user-fullname {
        font-size: 18px;
        font-weight: 700;
        color: #333;
        margin-bottom: 5px;
    }
    
    .user-email {
        color: #6c757d;
        font-size: 13px;
        background: #f8f9fa;
        padding: 5px 10px;
        border-radius: 20px;
        display: inline-block;
    }
    
    /* Navigation Menu */
    .sidebar-nav {
        padding: 20px 0;
    }
    
    .nav-menu {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .nav-item {
        margin: 8px 15px;
        border-radius: 12px;
        transition: all 0.3s;
    }
    
    .nav-item:hover {
        background: #f0f3ff;
    }
    
    .nav-item.active {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
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
        padding: 12px 18px;
        color: #495057;
        text-decoration: none;
        font-weight: 500;
        position: relative;
        border-radius: 12px;
    }
    
    .nav-link i {
        width: 25px;
        color: #667eea;
        font-size: 18px;
        transition: all 0.3s;
    }
    
    .nav-link span {
        flex: 1;
        font-size: 14px;
    }
    
    .nav-badge {
        background: #ff4757;
        color: white;
        padding: 3px 8px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        min-width: 22px;
        text-align: center;
    }
    
    /* Logout Item */
    .nav-item.logout {
        margin-top: 30px;
        border-top: 1px solid #f0f0f0;
        padding-top: 10px;
    }
    
    .nav-item.logout .nav-link {
        color: #dc3545;
    }
    
    .nav-item.logout .nav-link i {
        color: #dc3545;
    }
    
    .nav-item.logout:hover {
        background: #f8d7da;
    }
    
    /* Sidebar Footer */
    .sidebar-footer {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        padding: 15px 20px;
        border-top: 1px solid #f0f0f0;
        background: white;
        font-size: 12px;
        color: #6c757d;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .online-indicator {
        width: 8px;
        height: 8px;
        background: #28a745;
        border-radius: 50%;
        display: inline-block;
        animation: pulse 2s infinite;
    }
    
    @keyframes pulse {
        0% { box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.7); }
        70% { box-shadow: 0 0 0 6px rgba(40, 167, 69, 0); }
        100% { box-shadow: 0 0 0 0 rgba(40, 167, 69, 0); }
    }
</style>

<!-- User Sidebar -->
<aside class="user-sidebar">
    <div class="sidebar-header">
        <div class="user-avatar-large">
            <c:choose>
                <c:when test="${not empty sessionScope.user.profilePicURL}">
                    <img src="${sessionScope.user.profilePicURL}" alt="profile">
                </c:when>
                <c:otherwise>
                    <div class="avatar-large-text">
                        ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="user-info-large">
            <div class="user-fullname">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
            <div class="user-email">${sessionScope.user.email}</div>
        </div>
    </div>
    
    <nav class="sidebar-nav">
        <ul class="nav-menu">
            <li class="nav-item ${currentPage == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            
            <li class="nav-item ${currentPage == 'auctions' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/listProduct" class="nav-link">
                    <i class="fas fa-gavel"></i>
                    <span>Browse Auctions</span>
                </a>
            </li>
            
            <li class="nav-item ${currentPage == 'mybids' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/user/my-bids" class="nav-link">
                    <i class="fas fa-list"></i>
                    <span>My Bids</span>
                    <c:if test="${winningBidsCount > 0}">
                        <span class="nav-badge">${winningBidsCount}</span>
                    </c:if>
                </a>
            </li>
            
            <li class="nav-item ${currentPage == 'won' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/user/won-auctions" class="nav-link">
                    <i class="fas fa-trophy"></i>
                    <span>Won Auctions</span>
                    <c:if test="${wonAuctionsCount > 0}">
                        <span class="nav-badge" style="background: #ffc107; color: #333;">${wonAuctionsCount}</span>
                    </c:if>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/profile" class="nav-link">
                    <i class="fas fa-user"></i>
                    <span>My Profile</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/settings" class="nav-link">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
            </li>
            
            <li class="nav-item logout">
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </li>
        </ul>
    </nav>
    
    <div class="sidebar-footer">
        <span class="online-indicator"></span>
        <span>Online</span>
        <span style="margin-left: auto;">v1.0.0</span>
    </div>
</aside>