<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - E-Auction</title>
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
        
        .search-box {
            width: 300px;
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            height: 45px;
            padding: 0 15px 0 45px;
            border: 2px solid #e1e5eb;
            border-radius: 10px;
        }
        
        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
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
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            object-fit: cover;
        }
        
        .role-badge {
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }
        
        .role-ADMIN { background: #dc3545; color: white; }
        .role-PARTICIPANT { background: #28a745; color: white; }
        
        .status-active { color: #28a745; font-weight: 600; }
        .status-inactive { color: #dc3545; font-weight: 600; }
        
        .badge {
            padding: 5px 10px;
            border-radius: 30px;
            font-size: 11px;
        }
        
        .badge-info { background: #17a2b8; color: white; }
        .badge-success { background: #28a745; color: white; }
        
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
        .btn-disable { background: #f8d7da; color: #721c24; }
        
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
    </style>
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="header-left">
        <div class="header-title">
            <span>User</span> Management
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
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listProduct">
                <i class="fas fa-gavel"></i> Auctions
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listCategory">
                <i class="fas fa-tags"></i> Categories
            </a>
        </div>
        <div class="nav-item active">
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
        <h2><span>Users</span> Management</h2>
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search users..." onkeyup="searchUsers()">
        </div>
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
    
    <!-- Statistics Row -->
    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-icon blue"><i class="fas fa-users"></i></div>
            <div>
                <div class="stat-value">${totalUsers}</div>
                <div class="stat-label">Total Users</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green"><i class="fas fa-user-check"></i></div>
            <div>
                <div class="stat-value">${activeUsers}</div>
                <div class="stat-label">Active Users</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon orange"><i class="fas fa-user-tag"></i></div>
            <div>
                <div class="stat-value">${participantCount}</div>
                <div class="stat-label">Participants</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon red"><i class="fas fa-user-shield"></i></div>
            <div>
                <div class="stat-value">${adminCount}</div>
                <div class="stat-label">Admins</div>
            </div>
        </div>
    </div>
    
    <!-- Users Table -->
    <div class="table-container">
        <h4 class="mb-4"><i class="fas fa-users mr-2 text-primary"></i> All Users</h4>
        
        <div class="table-responsive">
            <table class="table" id="usersTable">
                <thead>
                    <tr>
                        <th>User</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Joined</th>
                        <th>Contact</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${userList}" var="user">
                        <tr>
                            <td>
                                <div style="display: flex; align-items: center;">
                                    <img src="${user.profilePicURL != null ? user.profilePicURL : 'https://via.placeholder.com/40x40/667eea/ffffff?text='.concat(user.firstName.charAt(0))}" 
                                         class="user-avatar" alt="avatar">
                                    <strong>${user.firstName} ${user.lastName}</strong>
                                </div>
                            </td>
                            <td>${user.email}</td>
                            <td>
                                <span class="role-badge role-${user.role}">${user.role}</span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.active}">
                                        <span class="status-active">● Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-inactive">● Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${user.createdAt}</td>
                            <td>${user.contactNum != null ? user.contactNum : '—'}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/viewUser?userId=${user.userId}" 
                                   class="btn-action btn-view" title="View">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/editUser?userId=${user.userId}" 
                                   class="btn-action btn-edit" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <c:choose>
                                    <c:when test="${user.active}">
                                        <a href="#" onclick="toggleUserStatus(${user.userId}, false)" 
                                           class="btn-action btn-disable" title="Disable">
                                            <i class="fas fa-ban"></i>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="#" onclick="toggleUserStatus(${user.userId}, true)" 
                                           class="btn-action btn-edit" title="Enable">
                                            <i class="fas fa-check"></i>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty userList}">
                        <tr>
                            <td colspan="7" class="text-center py-5">
                                <i class="fas fa-users" style="font-size: 50px; color: #ccc;"></i>
                                <h5 class="mt-3">No Users Found</h5>
                                <p class="text-muted">There are no users in the database yet.</p>
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
    </div>
    
    <!-- Footer -->
    <div class="footer">
        &copy; 2026 E-Auction. All rights reserved.
    </div>
</div>

<!-- Toggle Status Modal -->
<div class="modal fade" id="toggleModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="toggleModalTitle">Confirm Action</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="toggleModalBody">
                Are you sure you want to change this user's status?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmToggleBtn" class="btn btn-primary">Confirm</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function searchUsers() {
    var input = document.getElementById("searchInput");
    var filter = input.value.toUpperCase();
    var table = document.getElementById("usersTable");
    var tr = table.getElementsByTagName("tr");
    
    for (var i = 1; i < tr.length; i++) {
        var tdArray = tr[i].getElementsByTagName("td");
        var found = false;
        
        for (var j = 0; j < tdArray.length; j++) {
            if (tdArray[j]) {
                var textValue = tdArray[j].textContent || tdArray[j].innerText;
                if (textValue.toUpperCase().indexOf(filter) > -1) {
                    found = true;
                    break;
                }
            }
        }
        
        if (found) {
            tr[i].style.display = "";
        } else {
            tr[i].style.display = "none";
        }
    }
}

function toggleUserStatus(userId, activate) {
    var action = activate ? "activate" : "deactivate";
    document.getElementById('toggleModalTitle').textContent = activate ? 'Activate User' : 'Deactivate User';
    document.getElementById('toggleModalBody').textContent = 'Are you sure you want to ' + action + ' this user?';
    document.getElementById('confirmToggleBtn').href = '${pageContext.request.contextPath}/toggleUserStatus?userId=' + userId + '&activate=' + activate;
    
    var modal = new bootstrap.Modal(document.getElementById('toggleModal'));
    modal.show();
}
</script>
</body>
</html>