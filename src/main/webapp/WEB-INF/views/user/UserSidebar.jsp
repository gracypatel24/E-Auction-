<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="sidebar">
    <div class="sidebar-header">
        <h3>E-Auction</h3>
        <p>User Panel</p>
    </div>
    <div class="sidebar-menu">
        <!-- DASHBOARD -->
        <a href="${pageContext.request.contextPath}/user/dashboard" class="${currentPage == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
        
        <!-- ACTIVE AUCTIONS - FIXED: Now points to user active auctions -->
        <a href="${pageContext.request.contextPath}/user/active-auctions" class="${currentPage == 'active' ? 'active' : ''}">
            <i class="fas fa-fire"></i>
            <span>Active Auctions</span>
        </a>
        
        <!-- MY BIDS -->
        <a href="${pageContext.request.contextPath}/user/my-bids" class="${currentPage == 'mybids' ? 'active' : ''}">
            <i class="fas fa-gavel"></i>
            <span>My Bids</span>
        </a>
        
        <!-- WON AUCTIONS -->
        <a href="${pageContext.request.contextPath}/user/won-auctions" class="${currentPage == 'won' ? 'active' : ''}">
            <i class="fas fa-trophy"></i>
            <span>Won Auctions</span>
        </a>
        
        <!-- WATCHLIST -->
        <a href="${pageContext.request.contextPath}/user/watchlist" class="${currentPage == 'watchlist' ? 'active' : ''}">
            <i class="fas fa-heart"></i>
            <span>Watchlist</span>
        </a>
       
    </div>
</div>

<style>
:root {
    --primary: #48bb78;
    --secondary: #38a169;
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