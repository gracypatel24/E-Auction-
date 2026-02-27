<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Navbar -->
<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
  <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
    <a class="navbar-brand brand-logo mr-5" href="${pageContext.request.contextPath}/admin-dashboard">
      <img src="${pageContext.request.contextPath}/assets/skydash/images/logo.svg" class="mr-2" alt="logo"/>
      <span style="font-weight: 700; color: #667eea;">E-Auction</span>
    </a>
    <a class="navbar-brand brand-logo-mini" href="${pageContext.request.contextPath}/admin-dashboard">
      <img src="${pageContext.request.contextPath}/assets/skydash/images/logo-mini.svg" alt="logo"/>
    </a>
  </div>
  <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
      <span class="icon-menu"></span>
    </button>
    
    <ul class="navbar-nav navbar-nav-right">
      <!-- Notifications -->
      <li class="nav-item dropdown">
        <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
          <i class="icon-bell mx-0"></i>
          <span class="count bg-danger">4</span>
        </a>
        <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
          <p class="mb-0 font-weight-normal float-left dropdown-header">Notifications</p>
          <a class="dropdown-item preview-item">
            <div class="preview-thumbnail">
              <div class="preview-icon bg-success">
                <i class="ti-gavel mx-0"></i>
              </div>
            </div>
            <div class="preview-item-content">
              <h6 class="preview-subject font-weight-normal">New Bid Placed</h6>
              <p class="font-weight-light small-text mb-0 text-muted">On Vintage Watch</p>
            </div>
          </a>
          <a class="dropdown-item preview-item">
            <div class="preview-thumbnail">
              <div class="preview-icon bg-warning">
                <i class="ti-user mx-0"></i>
              </div>
            </div>
            <div class="preview-item-content">
              <h6 class="preview-subject font-weight-normal">New User Registered</h6>
              <p class="font-weight-light small-text mb-0 text-muted">John Doe joined</p>
            </div>
          </a>
          <a class="dropdown-item preview-item">
            <div class="preview-thumbnail">
              <div class="preview-icon bg-info">
                <i class="ti-alarm-clock mx-0"></i>
              </div>
            </div>
            <div class="preview-item-content">
              <h6 class="preview-subject font-weight-normal">Auction Ending Soon</h6>
              <p class="font-weight-light small-text mb-0 text-muted">5 auctions in 1 hour</p>
            </div>
          </a>
        </div>
      </li>
      
      <!-- Profile -->
      <li class="nav-item nav-profile dropdown">
        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
          <c:choose>
            <c:when test="${not empty sessionScope.user.profilePicURL}">
              <img src="${sessionScope.user.profilePicURL}" alt="profile"/>
            </c:when>
            <c:otherwise>
              <img src="${pageContext.request.contextPath}/assets/skydash/images/faces/face28.jpg" alt="profile"/>
            </c:otherwise>
          </c:choose>
        </a>
        <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
          <a class="dropdown-item" href="${pageContext.request.contextPath}/viewUser?userId=${sessionScope.user.userId}">
            <i class="ti-user text-primary"></i> Profile
          </a>
          <a class="dropdown-item" href="#">
            <i class="ti-settings text-primary"></i> Settings
          </a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
            <i class="ti-power-off text-primary"></i> Logout
          </a>
        </div>
      </li>
    </ul>
    
    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
      <span class="icon-menu"></span>
    </button>
  </div>
</nav>