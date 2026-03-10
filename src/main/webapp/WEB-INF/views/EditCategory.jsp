<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Edit Category - E-Auction</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
    
    <style>
        body { background: #f4f7fc; font-family: 'Segoe UI', sans-serif; }
        
        .main-panel { margin-left: 250px; margin-top: 70px; padding: 30px; }
        
        .header {
            background: white; height: 70px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 30px; position: fixed; top: 0; right: 0; left: 250px; z-index: 99;
        }
        
        .header-title span { color: #667eea; }
        
        .sidebar {
            width: 250px; background: white; box-shadow: 2px 0 10px rgba(0,0,0,0.05);
            position: fixed; left: 0; top: 0; bottom: 0; z-index: 100; overflow-y: auto;
        }
        
        .sidebar-menu { list-style: none; padding: 20px 0; }
        
        .profile-section {
            display: flex; align-items: center; padding: 20px;
            border-bottom: 1px solid #f0f0f0; margin-bottom: 10px;
        }
        
        .dummy-logo {
            width: 45px; height: 45px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            color: white; font-weight: 700; margin-right: 12px;
        }
        
        .nav-item { margin: 5px 15px; border-radius: 10px; }
        .nav-item:hover { background: #f0f3ff; }
        .nav-item.active { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .nav-item.active .nav-link { color: white; }
        
        .nav-link {
            display: flex; align-items: center; padding: 12px 15px;
            color: #495057; text-decoration: none; font-weight: 500;
        }
        
        .nav-link i { margin-right: 12px; }
        
        .form-container {
            background: white; border-radius: 15px; padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05); max-width: 600px; margin: 0 auto;
        }
        
        .form-title { font-size: 24px; font-weight: 700; color: #333; margin-bottom: 30px; text-align: center; }
        
        .form-group { margin-bottom: 25px; }
        
        .form-label { font-weight: 600; color: #495057; margin-bottom: 8px; display: block; }
        
        .form-control {
            height: 50px; border: 2px solid #e1e5eb; border-radius: 10px;
            padding: 0 15px; width: 100%;
        }
        
        .form-control:focus { border-color: #667eea; outline: none; }
        
        .form-check { margin-top: 10px; }
        .form-check-input { margin-right: 8px; }
        
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; height: 50px; border: none; border-radius: 10px;
            font-size: 16px; font-weight: 600; width: 100%; cursor: pointer;
        }
        
        .btn-cancel {
            width: 100%; height: 50px; background: #6c757d; color: white;
            border: none; border-radius: 10px; font-size: 16px; font-weight: 600;
            cursor: pointer; margin-top: 10px; text-align: center; display: block;
            line-height: 50px; text-decoration: none;
        }
        
        .btn-cancel:hover { background: #5a6268; color: white; text-decoration: none; }
        
        .footer {
            background: white; padding: 20px; border-radius: 15px; margin-top: 30px;
            text-align: center; color: #6c757d;
        }
    </style>
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="header-left">
        <div class="header-title"><span>Edit</span> Category</div>
    </div>
    <div class="header-right">
        <div class="user-profile">
            <span>${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
        </div>
    </div>
</header>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-menu">
        <div class="profile-section">
            <div class="dummy-logo">
                ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
            </div>
            <div>
                <div style="font-weight: 600;">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                <div style="font-size: 12px; color: #667eea;">${sessionScope.user.role}</div>
            </div>
        </div>

        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">
                <i class="ti-dashboard"></i> Dashboard
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listProduct">
                <i class="ti-gavel"></i> Auctions
            </a>
        </div>
        <div class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/listCategory">
                <i class="ti-layout"></i> Categories
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listUser">
                <i class="ti-user"></i> Users
            </a>
        </div>
        <div class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/newUserType">
                <i class="ti-user"></i> User Types
            </a>
        </div>
        <div class="nav-item" style="margin-top: 20px;">
            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                <i class="ti-power-off"></i> Logout
            </a>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="main-panel">
    <div class="content-wrapper">
        
        <div class="form-container">
            <h2 class="form-title">Edit Category</h2>
            
            <form action="${pageContext.request.contextPath}/updateCategory" method="post">
                <input type="hidden" name="categoryId" value="${category.categoryId}">
                
                <div class="form-group">
                    <label class="form-label">Category Name</label>
                    <input type="text" class="form-control" name="categoryName" 
                           value="${category.categoryName}" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Status</label>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" name="active" 
                               ${category.active ? 'checked' : ''}>
                        <label class="form-check-label">Active</label>
                    </div>
                </div>
                
                <button type="submit" class="btn-submit">
                    <i class="ti-save mr-2"></i>Update Category
                </button>
            </form>
            
            <a href="${pageContext.request.contextPath}/listCategory" class="btn-cancel">
                <i class="ti-close mr-2"></i> Cancel
            </a>
        </div>
        
        <!-- Footer -->
        <footer class="footer">
            <span>E-Auction Admin Panel &copy; 2026</span>
        </footer>
        
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>