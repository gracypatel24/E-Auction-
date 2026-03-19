<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="sidebar">
    <div class="sidebar-header">
        <h3>E-Auction</h3>
        <p>Seller Panel</p>
    </div>
    <div class="sidebar-menu">
        <!-- DASHBOARD -->
        <a href="${pageContext.request.contextPath}/seller/dashboard" class="${currentPage == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
        
        <!-- MY PRODUCTS -->
        <a href="${pageContext.request.contextPath}/seller/products" class="${currentPage == 'products' ? 'active' : ''}">
            <i class="fas fa-box"></i>
            <span>My Products</span>
        </a>
        
        
        <!-- ACTIVE AUCTIONS -->
        <a href="${pageContext.request.contextPath}/seller/active-auctions" class="${currentPage == 'active' ? 'active' : ''}">
            <i class="fas fa-fire"></i>
            <span>Active Auctions</span>
        </a>
        
        <!-- SOLD ITEMS -->
        <a href="${pageContext.request.contextPath}/seller/sold-items" class="${currentPage == 'sold' ? 'active' : ''}">
            <i class="fas fa-check-circle"></i>
            <span>Sold Items</span>
        </a>
        
        <!-- BIDS RECEIVED -->
        <a href="${pageContext.request.contextPath}/seller/bids-received" class="${currentPage == 'bids' ? 'active' : ''}">
            <i class="fas fa-gavel"></i>
            <span>Bids Received</span>
        </a>
        
        <!-- EARNINGS -->
        <a href="${pageContext.request.contextPath}/seller/earnings" class="${currentPage == 'earnings' ? 'active' : ''}">
            <i class="fas fa-dollar-sign"></i>
            <span>Earnings</span>
        </a>
    </div>
</div>

<style>
:root {
    --primary: #fbbf24;
    --secondary: #f59e0b;
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