<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Category List - E-Auction</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    
    <style>
        body { background: #f4f7fc; }
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
        .nav-item { margin: 5px 15px; border-radius: 10px; }
        .nav-item.active { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .nav-item.active .nav-link { color: white; }
        .nav-link { display: flex; align-items: center; padding: 12px 15px; color: #495057; text-decoration: none; }
        .nav-link i { margin-right: 12px; }
        .card { border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .btn-add { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; padding: 10px 20px; border-radius: 8px; }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-danger { background: #f8d7da; color: #721c24; }
        .footer { background: white; padding: 20px; border-radius: 15px; margin-top: 30px; text-align: center; }
    </style>
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="header-left">
        <div class="header-title"><span>Category</span> Management</div>
    </div>
    <div class="header-right">
        <div class="user-profile">
            <span>${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
        </div>
    </div>
</header>

<!-- Sidebar -->
<div class="sidebar">
    <ul class="sidebar-menu">
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard"><i class="ti-dashboard"></i> Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/listProduct"><i class="ti-gavel"></i> Auctions</a></li>
        <li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/listCategory"><i class="ti-layout"></i> Categories</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/listUser"><i class="ti-user"></i> Users</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/newUserType"><i class="ti-user"></i> User Types</a></li>
        <li class="nav-item" style="margin-top:20px;"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="ti-power-off"></i> Logout</a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-panel">
    <div class="content-wrapper">
        
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="font-weight-bold">Category List</h3>
                <p class="text-muted mb-0">All auction categories</p>
            </div>
            <a href="${pageContext.request.contextPath}/newCategory" class="btn-add">
                <i class="ti-plus me-1"></i> Add Category
            </a>
        </div>

        <!-- Categories Table -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Category Name</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty categoryList}">
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">
                                        <i class="ti-folder" style="font-size: 40px; color: #ccc;"></i>
                                        <p class="mt-2">No categories found</p>
                                    </td>
                                </tr>
                            </c:if>
                            
                            <c:forEach items="${categoryList}" var="cat" varStatus="i">
                                <tr>
                                    <td>${i.index + 1}</td>
                                    <td>${cat.categoryName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${cat.active}">
                                                <span class="badge badge-success">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/editCategory?id=${cat.categoryId}"
                                           class="btn btn-sm btn-warning me-1">Edit</a>
                                        <form action="${pageContext.request.contextPath}/deleteCategory" method="post" style="display:inline"
                                              onsubmit="return confirm('Delete this category?')">
                                            <input type="hidden" name="id" value="${cat.categoryId}">
                                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
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