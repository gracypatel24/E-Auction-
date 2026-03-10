<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Auction Management - E-Auction</title>
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
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 8px;
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
        
        /* Page Header */
        .page-header {
            background: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-header h2 span {
            color: #667eea;
        }
        
        .btn-add {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-add:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.4);
        }
        
        /* Filter Bar */
        .filter-bar {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }
        
        .filter-group {
            flex: 1;
            min-width: 150px;
        }
        
        .filter-group label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
            display: block;
            font-size: 13px;
        }
        
        .filter-control {
            width: 100%;
            padding: 8px 12px;
            border: 2px solid #e1e5eb;
            border-radius: 8px;
        }
        
        .filter-control:focus {
            border-color: #667eea;
            outline: none;
        }
        
        .btn-filter {
            background: #667eea;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 22px;
        }
        
        .btn-reset {
            background: #6c757d;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 22px;
            text-decoration: none;
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
        
        /* Table */
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
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
            text-transform: uppercase;
        }
        
        .table tbody td {
            padding: 12px 10px;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: middle;
        }
        
        .product-thumb {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            object-fit: cover;
            margin-right: 10px;
        }
        
        .badge {
            padding: 5px 10px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .badge-active { background: #d4edda; color: #155724; }
        .badge-completed { background: #d1ecf1; color: #0c5460; }
        .badge-cancelled { background: #f8d7da; color: #721c24; }
        .badge-info { background: #17a2b8; color: white; }
        .badge-primary { background: #007bff; color: white; }
        
        .btn-action {
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 12px;
            margin: 0 3px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-view { background: #e7f3ff; color: #004085; }
        .btn-edit { background: #fff3cd; color: #856404; }
        .btn-delete { background: #f8d7da; color: #721c24; }
        
        .alert {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .footer {
            background: white;
            padding: 20px;
            border-radius: 15px;
            margin-top: 30px;
            text-align: center;
            color: #6c757d;
        }
        
        .empty-state {
            text-align: center;
            padding: 50px;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 60px;
            color: #ccc;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="header-left">
        <div class="header-title">
            <span>Auction</span> Management
        </div>
    </div>
    
    <div class="header-right">
        <div class="user-profile">
            <div class="user-info">
                <div class="name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                <div class="role">${sessionScope.user.role}</div>
            </div>
            <div class="dummy-logo">
                ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
            </div>
        </div>
    </div>
</header>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-menu">
        <!-- Profile Section -->
        <div class="profile-section">
            <div class="dummy-logo" style="width:45px; height:45px; font-size:18px; margin-right:12px;">
                ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
            </div>
            <div class="profile-text">
                <div class="name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                <div class="role">${sessionScope.user.role}</div>
            </div>
        </div>

        <!-- Navigation Items -->
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
        </div>
        <div class="nav-item active">
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
        <div class="nav-item" style="margin-top: 20px;">
            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    
    <!-- Page Header -->
    <div class="page-header">
        <h2><span>Auction</span> Management</h2>
        <a href="${pageContext.request.contextPath}/newProduct" class="btn-add">
            <i class="fas fa-plus"></i> Create New Auction
        </a>
    </div>
    
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
    
    <!-- Filter Bar -->
    <div class="filter-bar">
        <form action="${pageContext.request.contextPath}/listProduct" method="get" style="display: flex; width: 100%; flex-wrap: wrap; gap: 15px;">
            <div class="filter-group">
                <label>Status</label>
                <select name="status" class="filter-control">
                    <option value="">All Status</option>
                    <option value="ACTIVE" ${selectedStatus == 'ACTIVE' ? 'selected' : ''}>Active</option>
                    <option value="COMPLETED" ${selectedStatus == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                    <option value="CANCELLED" ${selectedStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                </select>
            </div>
            
            <div class="filter-group">
                <label>Category</label>
                <select name="category" class="filter-control">
                    <option value="">All Categories</option>
                    <c:forEach items="${allCategories}" var="cat">
                        <option value="${cat}" ${selectedCategory == cat ? 'selected' : ''}>${cat}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="filter-group">
                <label>Search</label>
                <input type="text" name="search" class="filter-control" placeholder="Search by title..." value="${searchKeyword}">
            </div>
            
            <div class="filter-group" style="flex: 0 0 auto;">
                <button type="submit" class="btn-filter">
                    <i class="fas fa-filter"></i> Apply Filters
                </button>
            </div>
            
            <div class="filter-group" style="flex: 0 0 auto;">
                <a href="${pageContext.request.contextPath}/listProduct" class="btn-reset">
                    <i class="fas fa-redo"></i> Reset
                </a>
            </div>
        </form>
    </div>
    
    <!-- Statistics Row -->
    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-icon blue"><i class="fas fa-gavel"></i></div>
            <div>
                <div class="stat-value">${totalAuctions}</div>
                <div class="stat-label">Total Auctions</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green"><i class="fas fa-clock"></i></div>
            <div>
                <div class="stat-value">${activeAuctions.size()}</div>
                <div class="stat-label">Active Auctions</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon orange"><i class="fas fa-check-circle"></i></div>
            <div>
                <div class="stat-value">${completedAuctions.size()}</div>
                <div class="stat-label">Completed</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon red"><i class="fas fa-hourglass-end"></i></div>
            <div>
                <div class="stat-value">${endingSoon.size()}</div>
                <div class="stat-label">Ending Soon</div>
            </div>
        </div>
    </div>
    
    <!-- Auctions Table -->
    <div class="table-container">
        <h4 class="mb-4"><i class="fas fa-gavel mr-2 text-primary"></i> All Auctions</h4>
        
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Current Bid</th>
                        <th>Bids</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${allAuctions}" var="auction">
                        <tr>
                            <td>
                                <img src="${auction.imageUrl}" class="product-thumb" alt="${auction.title}">
                            </td>
                            <td>
                                <strong>${auction.title}</strong>
                                <br>
                                <small class="text-muted">ID: #${auction.productId}</small>
                            </td>
                            <td><span class="badge badge-info">${auction.category}</span></td>
                            <td><strong>$${auction.currentBid}</strong></td>
                            <td><span class="badge badge-primary">${auction.bidCount}</span></td>
                            <td>${auction.startDate}</td>
                            <td>${auction.endDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${auction.status == 'ACTIVE'}">
                                        <span class="badge badge-active">Active</span>
                                    </c:when>
                                    <c:when test="${auction.status == 'COMPLETED'}">
                                        <span class="badge badge-completed">Completed</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-cancelled">Cancelled</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/viewProduct?productId=${auction.productId}" 
                                   class="btn-action btn-view" title="View">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/editProduct?productId=${auction.productId}" 
                                   class="btn-action btn-edit" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="#" onclick="confirmDelete(${auction.productId})" 
                                   class="btn-action btn-delete" title="Delete">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty allAuctions}">
                        <tr>
                            <td colspan="9" class="empty-state">
                                <i class="fas fa-gavel"></i>
                                <h5>No Auctions Found</h5>
                                <p class="text-muted">Try adjusting your filters or create a new auction.</p>
                                <a href="${pageContext.request.contextPath}/newProduct" class="btn btn-primary mt-3">
                                    <i class="fas fa-plus"></i> Create New Auction
                                </a>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Back to Dashboard -->
    <div class="text-center mb-4">
        <a href="${pageContext.request.contextPath}/admin-dashboard" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/myAuctions" class="btn btn-info">
            <i class="fas fa-user"></i> My Auctions
        </a>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        &copy; 2026 E-Auction. All rights reserved.
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-danger">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this auction? This action cannot be undone.</p>
                <p class="text-muted small">All bids associated with this auction will also be deleted.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Delete Auction</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function confirmDelete(productId) {
    document.getElementById('confirmDeleteBtn').href = '${pageContext.request.contextPath}/deleteProduct?productId=' + productId;
    var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
    modal.show();
}
</script>
</body>
</html>