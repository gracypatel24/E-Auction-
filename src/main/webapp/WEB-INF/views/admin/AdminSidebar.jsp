<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <h3>E-Auction</h3>
        <p>Admin Panel</p>
    </div>
    <div class="sidebar-menu">
        <!-- DASHBOARD -->
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="${currentPage == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
        
        <!-- MANAGE USERS -->
        <a href="${pageContext.request.contextPath}/admin/users" class="${currentPage == 'users' ? 'active' : ''}">
            <i class="fas fa-users"></i>
            <span>Manage Users</span>
        </a>
        
		<!-- MANAGE PRODUCTS -->
		<a href="${pageContext.request.contextPath}/admin/products" class="${currentPage == 'products' ? 'active' : ''}">
		    <i class="fas fa-box"></i>
		    <span>Manage Products</span>
		</a>
        
        <!-- CATEGORIES -->
        <a href="${pageContext.request.contextPath}/listCategory" class="${currentPage == 'categories' ? 'active' : ''}">
            <i class="fas fa-tags"></i>
            <span>Categories</span>
        </a>
        
        
        <!-- USER TYPES -->
        <a href="${pageContext.request.contextPath}/newUserType" class="${currentPage == 'userTypes' ? 'active' : ''}">
            <i class="fas fa-user-tag"></i>
            <span>User Types</span>
        </a>
        
        <!-- ALL BIDS -->
        <a href="${pageContext.request.contextPath}/admin/bids" class="${currentPage == 'bids' ? 'active' : ''}">
            <i class="fas fa-gavel"></i>
            <span>All Bids</span>
        </a>
        
        <!-- PAYMENTS -->
        <a href="${pageContext.request.contextPath}/chargecreditcard" class="${currentPage == 'payments' ? 'active' : ''}">
            <i class="fas fa-credit-card"></i>
            <span>Payments</span>
        </a>
        
        
    </div>
</div>

<style>
:root {
    --primary: #667eea;
    --secondary: #764ba2;
}

.sidebar {
    width: 250px;
    background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
    color: white;
    position: fixed;
    height: 100vh;
    overflow-y: auto;
    transition: all 0.3s;
    box-shadow: 2px 0 10px rgba(0,0,0,0.1);
    z-index: 1000;
}

.sidebar-header {
    padding: 20px;
    text-align: center;
    border-bottom: 1px solid rgba(255,255,255,0.1);
}

.sidebar-header h3 {
    font-size: 24px;
    margin-bottom: 5px;
}

.sidebar-header p {
    font-size: 12px;
    opacity: 0.8;
}

.sidebar-menu {
    padding: 20px 0;
}

.sidebar-menu a {
    display: flex;
    align-items: center;
    padding: 12px 20px;
    color: rgba(255,255,255,0.8);
    text-decoration: none;
    transition: all 0.3s;
    gap: 10px;
    position: relative;
}

.sidebar-menu a i {
    width: 20px;
    font-size: 18px;
}

.sidebar-menu a:hover {
    background: rgba(255,255,255,0.1);
    color: white;
    padding-left: 25px;
}

.sidebar-menu a.active {
    background: rgba(255,255,255,0.2);
    color: white;
    border-left: 4px solid white;
}

.sidebar-menu .badge {
    background: #dc3545;
    color: white;
    padding: 2px 6px;
    border-radius: 10px;
    font-size: 11px;
    margin-left: auto;
}

@media (max-width: 768px) {
    .sidebar {
        transform: translateX(-100%);
    }
    
    .sidebar.active {
        transform: translateX(0);
    }
}
</style>

<script>
function toggleSidebar() {
    document.querySelector('.sidebar').classList.toggle('active');
}
</script>