<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | Admin Dashboard</title>
  
  <!-- Skydash Theme CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
  
  <style>
    /* ===== GLOBAL STYLES ===== */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f4f7fc;
      overflow-x: hidden;
    }
    
    /* ===== HEADER STYLES ===== */
    .custom-header {
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
      transition: all 0.3s;
    }
    
    .custom-header.expanded {
      left: 70px;
    }
    
    .header-left {
      display: flex;
      align-items: center;
    }
    
    /* Three Line Menu Icon */
    .menu-toggle {
      background: transparent;
      border: none;
      width: 40px;
      height: 40px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 6px;
      cursor: pointer;
      border-radius: 8px;
      transition: all 0.3s;
      margin-right: 20px;
    }
    
    .menu-toggle:hover {
      background: #f0f3ff;
    }
    
    .menu-toggle .line {
      width: 25px;
      height: 3px;
      background: #667eea;
      border-radius: 3px;
      transition: all 0.3s;
    }
    
    .menu-toggle.collapsed .line:nth-child(1) {
      transform: translateY(9px) rotate(45deg);
    }
    
    .menu-toggle.collapsed .line:nth-child(2) {
      opacity: 0;
    }
    
    .menu-toggle.collapsed .line:nth-child(3) {
      transform: translateY(-9px) rotate(-45deg);
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
    
    .notification-icon {
      position: relative;
      cursor: pointer;
    }
    
    .notification-icon i {
      font-size: 22px;
      color: #6c757d;
    }
    
    .notification-badge {
      position: absolute;
      top: -5px;
      right: -5px;
      background: #dc3545;
      color: white;
      font-size: 10px;
      padding: 2px 5px;
      border-radius: 50%;
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
    
    /* ===== SIDEBAR STYLES ===== */
    .sidebar {
      width: 250px;
      background: white;
      box-shadow: 2px 0 10px rgba(0,0,0,0.05);
      transition: all 0.3s;
      position: fixed;
      left: 0;
      top: 0;
      bottom: 0;
      z-index: 100;
      overflow-y: auto;
    }
    
    .sidebar.collapsed {
      width: 70px;
    }
    
    .sidebar.collapsed .menu-title,
    .sidebar.collapsed .menu-arrow,
    .sidebar.collapsed .profile-text {
      display: none;
    }
    
    .sidebar.collapsed .nav-link {
      justify-content: center;
      padding: 15px 0;
    }
    
    .sidebar.collapsed .nav-link i {
      margin: 0;
      font-size: 20px;
    }
    
    .sidebar.collapsed .profile-section {
      padding: 15px 0;
      justify-content: center;
    }
    
    .sidebar.collapsed .profile-section img {
      margin-right: 0 !important;
    }
    
    /* Scrollbar styling */
    .sidebar::-webkit-scrollbar {
      width: 5px;
    }
    
    .sidebar::-webkit-scrollbar-track {
      background: #f1f1f1;
    }
    
    .sidebar::-webkit-scrollbar-thumb {
      background: #667eea;
      border-radius: 5px;
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
    
    .profile-text {
      flex: 1;
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
      transition: all 0.3s;
    }
    
    .nav-link i {
      margin-right: 12px;
      font-size: 18px;
      min-width: 20px;
      text-align: center;
    }
    
    .menu-arrow {
      margin-left: auto;
      font-size: 12px;
      transition: transform 0.3s;
    }
    
    .sub-menu {
      list-style: none;
      padding-left: 45px;
      margin: 5px 0;
    }
    
    .sub-menu .nav-link {
      padding: 8px 15px;
      font-size: 14px;
    }
    
    /* ===== MAIN CONTENT ===== */
    .main-content {
      margin-left: 250px;
      margin-top: 70px;
      padding: 30px;
      background: #f4f7fc;
      min-height: calc(100vh - 70px);
      transition: all 0.3s;
    }
    
    .main-content.expanded {
      margin-left: 70px;
    }
    
    /* ===== STATISTICS CARDS - HORIZONTAL ALIGNMENT ===== */
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
      box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
      transition: all 0.3s;
      display: flex;
      align-items: center;
      gap: 20px;
    }
    
    .stat-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 30px rgba(102, 126, 234, 0.15);
    }
    
    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 28px;
      flex-shrink: 0;
    }
    
    .stat-icon.blue {
      background: rgba(102, 126, 234, 0.1);
      color: #667eea;
    }
    
    .stat-icon.green {
      background: rgba(40, 167, 69, 0.1);
      color: #28a745;
    }
    
    .stat-icon.orange {
      background: rgba(255, 193, 7, 0.1);
      color: #ffc107;
    }
    
    .stat-icon.red {
      background: rgba(220, 53, 69, 0.1);
      color: #dc3545;
    }
    
    .stat-info {
      flex: 1;
    }
    
    .stat-value {
      font-size: 28px;
      font-weight: 700;
      color: #333;
      margin-bottom: 5px;
    }
    
    .stat-label {
      color: #6c757d;
      font-size: 14px;
      font-weight: 500;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    
    .stat-change {
      margin-top: 8px;
      font-size: 12px;
    }
    
    .stat-change.positive {
      color: #28a745;
    }
    
    .stat-change.negative {
      color: #dc3545;
    }
    
    /* ===== WELCOME CARD ===== */
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
    
    .welcome-card p {
      opacity: 0.9;
      margin-bottom: 0;
    }
    
    /* ===== SECTION TITLES ===== */
    .section-title {
      font-size: 18px;
      font-weight: 700;
      color: #333;
      margin-bottom: 20px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    
    .section-title i {
      color: #667eea;
      margin-right: 8px;
    }
    
    .view-all-link {
      color: #667eea;
      text-decoration: none;
      font-size: 13px;
      font-weight: 500;
    }
    
    /* ===== TABLES ===== */
    .table-container {
      background: white;
      border-radius: 15px;
      padding: 20px;
      box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
      margin-bottom: 30px;
      overflow-x: auto;
    }
    
    .table {
      width: 100%;
      border-collapse: collapse;
    }
    
    .table thead th {
      border-top: none;
      border-bottom: 2px solid #667eea;
      color: #495057;
      font-weight: 600;
      font-size: 13px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      padding: 12px 10px;
      text-align: left;
      white-space: nowrap;
    }
    
    .table tbody td {
      padding: 12px 10px;
      border-bottom: 1px solid #f0f0f0;
      color: #6c757d;
      white-space: nowrap;
    }
    
    .badge {
      padding: 5px 10px;
      border-radius: 30px;
      font-size: 11px;
      font-weight: 600;
      white-space: nowrap;
    }
    
    .badge-success {
      background: #d4edda;
      color: #155724;
    }
    
    .badge-warning {
      background: #fff3cd;
      color: #856404;
    }
    
    .badge-info {
      background: #d1ecf1;
      color: #0c5460;
    }
    
    .btn-action {
      padding: 4px 10px;
      border-radius: 5px;
      font-size: 11px;
      margin: 0 2px;
      border: none;
      cursor: pointer;
    }
    
    .btn-view {
      background: #e7f3ff;
      color: #004085;
    }
    
    .btn-edit {
      background: #fff3cd;
      color: #856404;
    }
    
    .product-thumb {
      width: 35px;
      height: 35px;
      border-radius: 8px;
      margin-right: 10px;
    }
    
    /* ===== QUICK ACTIONS ===== */
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
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      transition: all 0.3s;
    }
    
    .quick-action-btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.2);
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
    
    /* ===== ACTIVITY LIST ===== */
    .activity-list {
      list-style: none;
      padding: 0;
      margin: 0;
    }
    
    .activity-item {
      display: flex;
      align-items: center;
      padding: 12px 0;
      border-bottom: 1px solid #f0f0f0;
    }
    
    .activity-item:last-child {
      border-bottom: none;
    }
    
    .activity-icon {
      width: 40px;
      height: 40px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 16px;
      margin-right: 12px;
      flex-shrink: 0;
    }
    
    .activity-icon.blue {
      background: rgba(102, 126, 234, 0.1);
      color: #667eea;
    }
    
    .activity-content {
      flex: 1;
    }
    
    .activity-title {
      font-weight: 600;
      color: #333;
      font-size: 14px;
      margin-bottom: 3px;
    }
    
    .activity-time {
      font-size: 11px;
      color: #999;
    }
    
    /* ===== FOOTER ===== */
    .footer {
      background: white;
      padding: 20px;
      border-radius: 15px;
      margin-top: 30px;
      color: #6c757d;
      font-size: 13px;
      text-align: center;
    }
  </style>
</head>

<body>
  <!-- Header -->
  <header class="custom-header" id="header">
    <div class="header-left">
      <!-- Three Line Menu Icon -->
      <button class="menu-toggle" id="menuToggle" onclick="toggleSidebar()">
        <span class="line"></span>
        <span class="line"></span>
        <span class="line"></span>
      </button>
      <div class="header-title">
        <span>E-Auction</span> Admin
      </div>
    </div>
    
      <!-- User Profile -->
      <div class="user-profile">
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
    </div>
  </header>

  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
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

      <!-- Dashboard -->
      <div class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">
          <i class="ti-dashboard"></i>
          <span class="menu-title">Dashboard</span>
        </a>
      </div>

      <!-- Auctions -->
      <div class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/listProduct">
          <i class="ti-gavel"></i>
          <span class="menu-title">Auctions</span>
        </a>
      </div>

      <!-- Categories -->
      <div class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/listCategory">
          <i class="ti-layout"></i>
          <span class="menu-title">Categories</span>
        </a>
      </div>

      <!-- Users -->
      <div class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/listUser">
          <i class="ti-user"></i>
          <span class="menu-title">Users</span>
        </a>
      </div>

      <!-- Reports -->
      <div class="nav-item">
        <a class="nav-link" href="#">
          <i class="ti-bar-chart"></i>
          <span class="menu-title">Reports</span>
        </a>
      </div>

      <!-- Settings -->
      <div class="nav-item">
        <a class="nav-link" href="#">
          <i class="ti-settings"></i>
          <span class="menu-title">Settings</span>
        </a>
      </div>

      <!-- Logout -->
      <div class="nav-item" style="margin-top: 20px;">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="ti-power-off"></i>
          <span class="menu-title">Logout</span>
        </a>
      </div>
    </div>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="mainContent">
    
    <!-- Welcome Card -->
    <div class="welcome-card">
      <div class="row align-items-center">
        <div class="col-md-8">
          <h2>Welcome back, ${sessionScope.user.firstName} ${sessionScope.user.lastName}!</h2>
          <p>Here's what's happening with your auction platform today.</p>
        </div>
        <div class="col-md-4 text-right">
          <div class="date-badge" style="background: rgba(255,255,255,0.2); padding: 10px 20px; border-radius: 10px; display: inline-block;">
            <div style="font-size: 24px; font-weight: 700; line-height: 1;"><%= new java.text.SimpleDateFormat("dd").format(new java.util.Date()) %></div>
            <div style="font-size: 14px; opacity: 0.9;"><%= new java.text.SimpleDateFormat("MMMM yyyy").format(new java.util.Date()) %></div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Statistics Cards - Horizontally Aligned -->
    <div class="stats-row">
      <!-- Total Auctions Card -->
      <div class="stat-card">
        <div class="stat-icon blue">
          <i class="ti-gavel"></i>
        </div>
        <div class="stat-info">
          <div class="stat-value">${totalProducts != null ? totalProducts : 156}</div>
          <div class="stat-label">Total Auctions</div>
          <div class="stat-change positive">
            <i class="ti-arrow-up"></i> 12% from last month
          </div>
        </div>
      </div>
      
      <!-- Active Users Card -->
      <div class="stat-card">
        <div class="stat-icon green">
          <i class="ti-user"></i>
        </div>
        <div class="stat-info">
          <div class="stat-value">${totalUsers != null ? totalUsers : 2843}</div>
          <div class="stat-label">Active Users</div>
          <div class="stat-change positive">
            <i class="ti-arrow-up"></i> 8% from last month
          </div>
        </div>
      </div>
      
      <!-- Categories Card -->
      <div class="stat-card">
        <div class="stat-icon orange">
          <i class="ti-layout"></i>
        </div>
        <div class="stat-info">
          <div class="stat-value">${totalCategories != null ? totalCategories : 24}</div>
          <div class="stat-label">Categories</div>
          <div class="stat-change positive">
            <i class="ti-arrow-up"></i> 3 new this week
          </div>
        </div>
      </div>
      
      <!-- Live Auctions Card -->
      <div class="stat-card">
        <div class="stat-icon red">
          <i class="ti-timer"></i>
        </div>
        <div class="stat-info">
          <div class="stat-value">${activeAuctions != null ? activeAuctions : 42}</div>
          <div class="stat-label">Live Auctions</div>
          <div class="stat-change negative">
            <i class="ti-arrow-down"></i> 5 ending today
          </div>
        </div>
      </div>
    </div>
    
    <!-- Quick Actions -->
    <div class="quick-actions">
      <a href="${pageContext.request.contextPath}/newProduct" class="quick-action-btn">
        <i class="ti-plus"></i>
        <span>Create Auction</span>
      </a>
      <a href="${pageContext.request.contextPath}/newCategory" class="quick-action-btn">
        <i class="ti-folder"></i>
        <span>Add Category</span>
      </a>
      <a href="#" class="quick-action-btn">
        <i class="ti-file"></i>
        <span>Generate Report</span>
      </a>
      <a href="${pageContext.request.contextPath}/listUser" class="quick-action-btn">
        <i class="ti-user"></i>
        <span>Manage Users</span>
      </a>
    </div>
    
    <!-- Recent Auctions Table -->
    <div class="section-title">
      <div>
        <i class="ti-gavel"></i> Recent Auctions
      </div>
      <a href="${pageContext.request.contextPath}/listProduct" class="view-all-link">View All <i class="ti-arrow-right"></i></a>
    </div>
    
    <div class="table-container">
      <table class="table">
        <thead>
          <tr>
            <th>Auction</th>
            <th>Category</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Current Bid</th>
            <th>Bids</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              <div class="d-flex align-items-center">
                <img src="https://via.placeholder.com/35x35/667eea/ffffff?text=R" class="product-thumb">
                <strong>Vintage Rolex Watch</strong>
              </div>
            </td>
            <td>Watches</td>
            <td>2024-03-01</td>
            <td>2024-03-05</td>
            <td><strong class="text-primary">$2,450</strong></td>
            <td><span class="badge badge-info">12</span></td>
            <td><span class="badge badge-success">Active</span></td>
            <td>
              <button class="btn-action btn-view"><i class="ti-eye"></i></button>
              <button class="btn-action btn-edit"><i class="ti-pencil"></i></button>
            </td>
          </tr>
          <tr>
            <td>
              <div class="d-flex align-items-center">
                <img src="https://via.placeholder.com/35x35/28a745/ffffff?text=F" class="product-thumb">
                <strong>Ferrari 488 GTB</strong>
              </div>
            </td>
            <td>Cars</td>
            <td>2024-03-10</td>
            <td>2024-03-12</td>
            <td><strong class="text-primary">$245,000</strong></td>
            <td><span class="badge badge-info">24</span></td>
            <td><span class="badge badge-success">Active</span></td>
            <td>
              <button class="btn-action btn-view"><i class="ti-eye"></i></button>
              <button class="btn-action btn-edit"><i class="ti-pencil"></i></button>
            </td>
          </tr>
          <tr>
            <td>
              <div class="d-flex align-items-center">
                <img src="https://via.placeholder.com/35x35/dc3545/ffffff?text=P" class="product-thumb">
                <strong>Picasso Original Sketch</strong>
              </div>
            </td>
            <td>Art</td>
            <td>2024-03-15</td>
            <td>2024-03-17</td>
            <td><strong class="text-primary">$12,500</strong></td>
            <td><span class="badge badge-info">8</span></td>
            <td><span class="badge badge-warning">Upcoming</span></td>
            <td>
              <button class="btn-action btn-view"><i class="ti-eye"></i></button>
              <button class="btn-action btn-edit"><i class="ti-pencil"></i></button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    
    <!-- Two Column Layout -->
    <div class="row">
      <!-- Recent Bidders -->
      <div class="col-md-6">
        <div class="section-title">
          <div>
            <i class="ti-user"></i> Recent Bidders
          </div>
          <a href="${pageContext.request.contextPath}/listUser" class="view-all-link">View All <i class="ti-arrow-right"></i></a>
        </div>
        
        <div class="table-container">
          <table class="table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Auction</th>
                <th>Bid Amount</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <div class="d-flex align-items-center">
                    <img src="https://ui-avatars.com/api/?name=John+Doe&background=28a745&color=fff&size=35" class="product-thumb" style="border-radius:50%;">
                    <strong>John Doe</strong>
                  </div>
                </td>
                <td>Vintage Rolex</td>
                <td><strong class="text-primary">$2,450</strong></td>
                <td><span class="badge badge-success">Winning</span></td>
              </tr>
              <tr>
                <td>
                  <div class="d-flex align-items-center">
                    <img src="https://ui-avatars.com/api/?name=Jane+Smith&background=667eea&color=fff&size=35" class="product-thumb" style="border-radius:50%;">
                    <strong>Jane Smith</strong>
                  </div>
                </td>
                <td>Ferrari 488</td>
                <td><strong class="text-primary">$245,000</strong></td>
                <td><span class="badge badge-warning">Outbid</span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      
      <!-- Recent Activity -->
      <div class="col-md-6">
        <div class="section-title">
          <div>
            <i class="ti-timer"></i> Recent Activity
          </div>
        </div>
        
        <div class="table-container">
          <ul class="activity-list">
            <li class="activity-item">
              <div class="activity-icon blue">
                <i class="ti-gavel"></i>
              </div>
              <div class="activity-content">
                <div class="activity-title">New bid of $2,500 on Rolex Watch</div>
                <div class="activity-time"><i class="ti-timer"></i> 5 minutes ago</div>
              </div>
            </li>
            <li class="activity-item">
              <div class="activity-icon green">
                <i class="ti-user"></i>
              </div>
              <div class="activity-content">
                <div class="activity-title">New user registered: Sarah Wilson</div>
                <div class="activity-time"><i class="ti-timer"></i> 15 minutes ago</div>
              </div>
            </li>
            <li class="activity-item">
              <div class="activity-icon orange">
                <i class="ti-layout"></i>
              </div>
              <div class="activity-content">
                <div class="activity-title">New category added: Art & Antiques</div>
                <div class="activity-time"><i class="ti-timer"></i> 1 hour ago</div>
              </div>
            </li>
            <li class="activity-item">
              <div class="activity-icon red">
                <i class="ti-alarm-clock"></i>
              </div>
              <div class="activity-content">
                <div class="activity-title">Auction ending: Ferrari 488 (1 hour left)</div>
                <div class="activity-time"><i class="ti-timer"></i> 2 hours ago</div>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    
    <!-- Footer -->
    <div class="footer">
      <div class="row">
        <div class="col-md-6 text-md-left">
          &copy; 2024 E-Auction. All rights reserved.
        </div>
        <div class="col-md-6 text-md-right">
          Powered by <i class="ti-heart text-danger"></i> Skydash
        </div>
      </div>
    </div>
    
  </div>

  <!-- Scripts -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/skydash/js/off-canvas.js"></script>
  <script src="${pageContext.request.contextPath}/assets/skydash/js/hoverable-collapse.js"></script>
  
  <script>
    // Sidebar Toggle Function
    function toggleSidebar() {
      const sidebar = document.getElementById('sidebar');
      const mainContent = document.getElementById('mainContent');
      const header = document.getElementById('header');
      const menuToggle = document.getElementById('menuToggle');
      
      sidebar.classList.toggle('collapsed');
      mainContent.classList.toggle('expanded');
      header.classList.toggle('expanded');
      menuToggle.classList.toggle('collapsed');
    }
    
    // Submenu Toggle (if needed