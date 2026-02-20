<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>
<body>

    <!-- Header -->
    <jsp:include page="AdminHeader.jsp"></jsp:include>

    <!-- Sidebar -->
    <jsp:include page="AdminSidebar.jsp"></jsp:include>

    <!-- Main Content -->
    <div class="content">
        <h3>Dashboard</h3>
        <p class="text-muted">Welcome to the admin dashboard, <strong>${name}</strong>.</p>

        <div class="row mt-3">

            <!-- Total Users -->
            <div class="col-md-3 mb-3">
                <div class="card shadow-sm border-left-primary h-100">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Users</div>
                            <div class="h4 mb-0 font-weight-bold text-gray-800">${totalUsers}</div>
                        </div>
                        <i class="bi bi-people-fill fs-2 text-primary opacity-50"></i>
                    </div>
                </div>
            </div>

            <!-- Total Categories -->
            <div class="col-md-3 mb-3">
                <div class="card shadow-sm border-left-success h-100">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Total Categories</div>
                            <div class="h4 mb-0 font-weight-bold text-gray-800">${totalCategories}</div>
                        </div>
                        <i class="bi bi-tags-fill fs-2 text-success opacity-50"></i>
                    </div>
                </div>
            </div>

            <!-- Total User Types -->
            <div class="col-md-3 mb-3">
                <div class="card shadow-sm border-left-info h-100">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">User Types</div>
                            <div class="h4 mb-0 font-weight-bold text-gray-800">${totalUserTypes}</div>
                        </div>
                        <i class="bi bi-person-badge-fill fs-2 text-info opacity-50"></i>
                    </div>
                </div>
            </div>

            <!-- Placeholder for future data -->
            <div class="col-md-3 mb-3">
                <div class="card shadow-sm border-left-warning h-100">
                    <div class="card-body d-flex align-items-center justify-content-between">
                        <div>
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Active Auctions</div>
                            <div class="h4 mb-0 font-weight-bold text-gray-800">--</div>
                        </div>
                        <i class="bi bi-hammer fs-2 text-warning opacity-50"></i>
                    </div>
                </div>
            </div>

        </div>

        <!-- Footer -->
        <jsp:include page="AdminFooter.jsp"></jsp:include>
    </div>

</body>
</html>
