<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
        }
        
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
        
        .header-title span { color: #667eea; }
        
        .nav-links {
            display: flex;
            gap: 20px;
            margin-right: 20px;
        }
        
        .nav-link-item {
            color: #495057;
            text-decoration: none;
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 5px;
        }
        
        .nav-link-item:hover {
            background: #f0f3ff;
            color: #667eea;
        }
        
        .mail-icon {
            position: relative;
            cursor: pointer;
            font-size: 20px;
            color: #667eea;
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
        
        .user-dropdown { position: relative; display: inline-block; }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 8px;
        }
        
        .user-profile:hover { background: #f0f3ff; }
        
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
        
        .dropdown-menu.show { display: block; }
        
        .dropdown-item {
            padding: 12px 20px;
            color: #495057;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .dropdown-item:hover {
            background: #f0f3ff;
            color: #667eea;
        }
        
        .dropdown-item i { width: 20px; color: #667eea; }
        
        .dropdown-divider {
            height: 1px;
            background: #f0f0f0;
            margin: 5px 0;
        }
        
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
        
        .sidebar-menu { list-style: none; padding: 20px 0; }
        
        .profile-section {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .nav-item { margin: 5px 15px; border-radius: 10px; }
        .nav-item:hover { background: #f0f3ff; }
        .nav-item.active { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .nav-item.active .nav-link { color: white; }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #495057;
            text-decoration: none;
            font-weight: 500;
        }
        
        .nav-link i { margin-right: 12px; }
        
        .main-content {
            margin-left: 250px;
            margin-top: 70px;
            padding: 30px;
        }
        
        .mail-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        
        .mail-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .mail-header h2 span { color: #667eea; }
        
        .compose-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
        }
        
        .mail-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }
        
        .mail-tab {
            padding: 8px 20px;
            cursor: pointer;
            border-radius: 20px;
            color: #6c757d;
        }
        
        .mail-tab.active {
            background: #667eea;
            color: white;
        }
        
        .mail-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .mail-item:hover {
            background: #f8f9fa;
        }
        
        .mail-item.unread {
            background: #f0f3ff;
        }
        
        .mail-checkbox { margin-right: 15px; }
        
        .mail-star { margin-right: 15px; color: #ffc107; }
        
        .mail-sender {
            width: 150px;
            font-weight: 600;
        }
        
        .mail-subject {
            flex: 1;
            margin: 0 15px;
        }
        
        .mail-subject small {
            color: #6c757d;
            font-size: 12px;
        }
        
        .mail-date {
            width: 100px;
            text-align: right;
            color: #6c757d;
        }
        
        .badge {
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
            background: #dc3545;
            color: white;
            margin-left: 10px;
        }
    </style>
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="header-left">
        <div class="header-title"><span>Messages</span> Center</div>
    </div>
    
    <div class="header-right">
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin-dashboard" class="nav-link-item">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/listProduct" class="nav-link-item">
                <i class="fas fa-gavel"></i> Auctions
            </a>
            <a href="${pageContext.request.contextPath}/listUser" class="nav-link-item">
                <i class="fas fa-users"></i> Users
            </a>
        </div>
        
        <div class="mail-icon">
            <i class="fas fa-envelope"></i>
            <span class="mail-badge">3</span>
        </div>
        
        <div class="user-dropdown" id="userDropdown">
            <div class="user-profile" onclick="toggleDropdown()">
                <div class="user-info">
                    <div class="name">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                    <div class="role">${sessionScope.user.role}</div>
                </div>
                <div class="dummy-logo">
                    ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                </div>
            </div>
            
            <div class="dropdown-menu" id="dropdownMenu">
                <a href="${pageContext.request.contextPath}/admin/profile" class="dropdown-item">
                    <i class="fas fa-user"></i> My Profile
                </a>
                <a href="${pageContext.request.contextPath}/admin/mail" class="dropdown-item">
                    <i class="fas fa-envelope"></i> Messages
                    <span style="margin-left: auto; background: #dc3545; color: white; padding: 2px 6px; border-radius: 10px; font-size: 11px;">3</span>
                </a>
                <div class="dropdown-divider"></div>
                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </div>
</header>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-menu">
        <div class="profile-section">
            <div class="dummy-logo" style="width:45px; height:45px; margin-right:12px;">
                ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
            </div>
            <div>
                <div style="font-weight: 600;">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                <div style="font-size: 12px; color: #667eea;">${sessionScope.user.role}</div>
            </div>
        </div>

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
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listUser">
                <i class="fas fa-users"></i> Users
            </a>
        </div>
        <div class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/mail">
                <i class="fas fa-envelope"></i> Messages
                <span style="margin-left: auto; background: #dc3545; color: white; padding: 2px 8px; border-radius: 10px; font-size: 11px;">3</span>
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
    <div class="mail-container">
        <div class="mail-header">
            <h2><span>Message</span> Center</h2>
            <button class="compose-btn" onclick="composeMessage()">
                <i class="fas fa-pen"></i> Compose
            </button>
        </div>
        
        <div class="mail-tabs">
            <span class="mail-tab active" onclick="filterMails('inbox')">Inbox (3)</span>
            <span class="mail-tab" onclick="filterMails('sent')">Sent</span>
            <span class="mail-tab" onclick="filterMails('drafts')">Drafts</span>
            <span class="mail-tab" onclick="filterMails('trash')">Trash</span>
        </div>
        
        <div class="mail-list">
            <!-- Unread Mail -->
            <div class="mail-item unread" onclick="viewMessage(1)">
                <input type="checkbox" class="mail-checkbox" onclick="event.stopPropagation()">
                <span class="mail-star"><i class="far fa-star"></i></span>
                <span class="mail-sender">John Doe</span>
                <span class="mail-subject">
                    New Bid on Vintage Watch
                    <small>- Someone placed a bid of $2,500 on your auction</small>
                    <span class="badge">New</span>
                </span>
                <span class="mail-date">5 min ago</span>
            </div>
            
            <!-- Read Mail -->
            <div class="mail-item" onclick="viewMessage(2)">
                <input type="checkbox" class="mail-checkbox" onclick="event.stopPropagation()">
                <span class="mail-star"><i class="fas fa-star" style="color: #ffc107;"></i></span>
                <span class="mail-sender">System</span>
                <span class="mail-subject">
                    Auction Ending Soon
                    <small>- Your auction 'Ferrari 488' ends in 1 hour</small>
                </span>
                <span class="mail-date">2 hours ago</span>
            </div>
            
            <div class="mail-item" onclick="viewMessage(3)">
                <input type="checkbox" class="mail-checkbox" onclick="event.stopPropagation()">
                <span class="mail-star"><i class="far fa-star"></i></span>
                <span class="mail-sender">Jane Smith</span>
                <span class="mail-subject">
                    New User Registration
                    <small>- New user registered as a seller</small>
                </span>
                <span class="mail-date">Yesterday</span>
            </div>
            
            <div class="mail-item" onclick="viewMessage(4)">
                <input type="checkbox" class="mail-checkbox" onclick="event.stopPropagation()">
                <span class="mail-star"><i class="far fa-star"></i></span>
                <span class="mail-sender">Support Team</span>
                <span class="mail-subject">
                    Account Verification
                    <small>- Your account has been verified</small>
                </span>
                <span class="mail-date">2 days ago</span>
            </div>
            
            <div class="mail-item" onclick="viewMessage(5)">
                <input type="checkbox" class="mail-checkbox" onclick="event.stopPropagation()">
                <span class="mail-star"><i class="far fa-star"></i></span>
                <span class="mail-sender">Payment System</span>
                <span class="mail-subject">
                    Payment Received
                    <small>- Payment of $2,500 has been processed</small>
                </span>
                <span class="mail-date">3 days ago</span>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleDropdown() {
        document.getElementById('dropdownMenu').classList.toggle('show');
    }
    
    function filterMails(filter) {
        alert('Filtering mails: ' + filter);
        // Add your filtering logic here
    }
    
    function viewMessage(id) {
        window.location.href = '${pageContext.request.contextPath}/admin/message/' + id;
    }
    
    function composeMessage() {
        window.location.href = '${pageContext.request.contextPath}/admin/compose';
    }
    
    window.onclick = function(event) {
        if (!event.target.matches('.user-profile') && !event.target.matches('.user-profile *')) {
            var dropdowns = document.getElementsByClassName('dropdown-menu');
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }
</script>

</body>
</html>