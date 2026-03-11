<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
        
        <li class="nav-item active">
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

        <li class="nav-item">
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