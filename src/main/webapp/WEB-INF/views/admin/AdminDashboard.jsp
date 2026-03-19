<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Dashboard" scope="request"/>
<jsp:include page="AdminHeader.jsp">
    <jsp:param name="page" value="dashboard"/>
</jsp:include>

<div class="dashboard-container">
    <!-- Welcome Banner -->
    <div class="welcome-banner">
        <div class="welcome-text">
            <h1>Welcome back, <span>${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>!</h1>
            <p>Here's what's happening with your auction platform today.</p>
        </div>
        <div class="welcome-actions">
            <a href="${pageContext.request.contextPath}/newProduct" class="btn-primary">
                <i class="fas fa-plus-circle"></i> Add New Product
            </a>
        </div>
    </div>
    
    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon users">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-details">
                <div class="stat-value">${totalUsers}</div>
                <div class="stat-label">Total Users</div>
                <div class="stat-trend positive">
                    <i class="fas fa-arrow-up"></i> 12% this month
                </div>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon products">
                <i class="fas fa-box"></i>
            </div>
            <div class="stat-details">
                <div class="stat-value">${totalProducts}</div>
                <div class="stat-label">Total Products</div>
                <div class="stat-trend positive">
                    <i class="fas fa-arrow-up"></i> 8% this month
                </div>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon bids">
                <i class="fas fa-gavel"></i>
            </div>
            <div class="stat-details">
                <div class="stat-value">${totalBids}</div>
                <div class="stat-label">Total Bids</div>
                <div class="stat-trend positive">
                    <i class="fas fa-arrow-up"></i> 23% this month
                </div>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon revenue">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="stat-details">
                <div class="stat-value">$24.5k</div>
                <div class="stat-label">Total Revenue</div>
                <div class="stat-trend positive">
                    <i class="fas fa-arrow-up"></i> 15% this month
                </div>
            </div>
        </div>
    </div>
    
    <!-- Quick Links Section -->
    <div class="quick-links-section">
        <h2>Quick Management Links</h2>
        <div class="quick-links-grid">
            <a href="${pageContext.request.contextPath}/admin/users" class="quick-link-card">
                <div class="quick-link-icon users-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="quick-link-content">
                    <h3>Manage Users</h3>
                    <p>View, edit, and manage user accounts</p>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/listProduct" class="quick-link-card">
                <div class="quick-link-icon products-icon">
                    <i class="fas fa-box"></i>
                </div>
                <div class="quick-link-content">
                    <h3>Manage Products</h3>
                    <p>Add, edit, and monitor product listings</p>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/listCategory" class="quick-link-card">
                <div class="quick-link-icon categories-icon">
                    <i class="fas fa-tags"></i>
                </div>
                <div class="quick-link-content">
                    <h3>Categories</h3>
                    <p>Organize products by categories</p>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/newProduct" class="quick-link-card">
                <div class="quick-link-icon add-icon">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <div class="quick-link-content">
                    <h3>Add Product</h3>
                    <p>Create a new product listing</p>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/newUserType" class="quick-link-card">
                <div class="quick-link-icon usertype-icon">
                    <i class="fas fa-user-tag"></i>
                </div>
                <div class="quick-link-content">
                    <h3>User Types</h3>
                    <p>Manage user roles and types</p>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/bids" class="quick-link-card">
                <div class="quick-link-icon bids-icon">
                    <i class="fas fa-gavel"></i>
                </div>
                <div class="quick-link-content">
                    <h3>All Bids</h3>
                    <p>Monitor all bidding activity</p>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/payments" class="quick-link-card">
                <div class="quick-link-icon payments-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div class="quick-link-content">
                    <h3>Payments</h3>
                    <p>Track transactions and payments</p>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/mail" class="quick-link-card">
                <div class="quick-link-icon mail-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="quick-link-content">
                    <h3>Messages</h3>
                    <p>View and respond to messages</p>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/profile" class="quick-link-card">
                <div class="quick-link-icon profile-icon">
                    <i class="fas fa-user"></i>
                </div>
                <div class="quick-link-content">
                    <h3>My Profile</h3>
                    <p>View and edit your profile</p>
                </div>
            </a>
        </div>
    </div>
    
    <!-- Recent Activity Section -->
    <div class="recent-activity-section">
        <h2>Recent Activity</h2>
        <div class="activity-list">
            <div class="activity-item">
                <div class="activity-avatar" style="background: #e3f2fd; color: #1976d2;">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="activity-details">
                    <div class="activity-title">New user registered</div>
                    <div class="activity-time">5 minutes ago</div>
                </div>
                <span class="activity-badge">New</span>
            </div>
            
            <div class="activity-item">
                <div class="activity-avatar" style="background: #e8f5e9; color: #2e7d32;">
                    <i class="fas fa-gavel"></i>
                </div>
                <div class="activity-details">
                    <div class="activity-title">New bid placed on Vintage Watch</div>
                    <div class="activity-time">15 minutes ago</div>
                </div>
            </div>
            
            <div class="activity-item">
                <div class="activity-avatar" style="background: #fff3e0; color: #ef6c00;">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="activity-details">
                    <div class="activity-title">Auction ended: Ferrari 488</div>
                    <div class="activity-time">1 hour ago</div>
                </div>
            </div>
            
            <div class="activity-item">
                <div class="activity-avatar" style="background: #e8eaf6; color: #3949ab;">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div class="activity-details">
                    <div class="activity-title">Payment received: $2,500</div>
                    <div class="activity-time">2 hours ago</div>
                </div>
            </div>
        </div>
        <div class="view-all-link">
            <a href="${pageContext.request.contextPath}/admin/bids">View All Activity <i class="fas fa-arrow-right"></i></a>
        </div>
    </div>
</div>

<style>
.dashboard-container {
    padding: 20px;
    max-width: 1400px;
    margin: 0 auto;
}

.welcome-banner {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
}

.welcome-text h1 {
    font-size: 28px;
    margin-bottom: 10px;
}

.welcome-text h1 span {
    font-weight: 700;
    text-decoration: underline;
    text-underline-offset: 8px;
}

.welcome-text p {
    opacity: 0.9;
    font-size: 16px;
}

.btn-primary {
    background: white;
    color: #667eea;
    padding: 12px 25px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 10px;
    transition: all 0.3s;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.3);
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    border-radius: 15px;
    padding: 25px;
    display: flex;
    align-items: center;
    gap: 20px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    transition: all 0.3s;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

.stat-icon {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
}

.stat-icon.users { background: #e3f2fd; color: #1976d2; }
.stat-icon.products { background: #e8f5e9; color: #2e7d32; }
.stat-icon.bids { background: #fff3e0; color: #ef6c00; }
.stat-icon.revenue { background: #e8eaf6; color: #3949ab; }

.stat-details { flex: 1; }
.stat-value { font-size: 32px; font-weight: 700; color: #2d3748; }
.stat-label { color: #718096; font-size: 14px; margin-bottom: 5px; }
.stat-trend { font-size: 12px; display: flex; align-items: center; gap: 3px; }
.stat-trend.positive { color: #48bb78; }

.quick-links-section { margin-bottom: 30px; }
.quick-links-section h2 { color: #2d3748; font-size: 22px; margin-bottom: 20px; }

.quick-links-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
}

.quick-link-card {
    background: white;
    border-radius: 12px;
    padding: 20px;
    display: flex;
    align-items: center;
    gap: 15px;
    text-decoration: none;
    color: #2d3748;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    transition: all 0.3s;
    border: 1px solid transparent;
}

.quick-link-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.15);
    border-color: #667eea;
}

.quick-link-icon {
    width: 60px;
    height: 60px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
}

.quick-link-icon.users-icon { background: #e3f2fd; color: #1976d2; }
.quick-link-icon.products-icon { background: #e8f5e9; color: #2e7d32; }
.quick-link-icon.categories-icon { background: #fff3e0; color: #ef6c00; }
.quick-link-icon.add-icon { background: #e8eaf6; color: #3949ab; }
.quick-link-icon.usertype-icon { background: #f3e5f5; color: #7b1fa2; }
.quick-link-icon.bids-icon { background: #ffebee; color: #c62828; }
.quick-link-icon.payments-icon { background: #e0f2f1; color: #00695c; }
.quick-link-icon.mail-icon { background: #fff8e1; color: #ff8f00; }
.quick-link-icon.profile-icon { background: #e0f2f1; color: #00695c; }

.quick-link-content { flex: 1; }
.quick-link-content h3 { font-size: 16px; font-weight: 600; margin-bottom: 5px; }
.quick-link-content p { font-size: 13px; color: #718096; }

.recent-activity-section {
    background: white;
    border-radius: 15px;
    padding: 25px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
}

.recent-activity-section h2 { color: #2d3748; font-size: 22px; margin-bottom: 20px; }

.activity-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 15px 0;
    border-bottom: 1px solid #f0f0f0;
}

.activity-item:last-child { border-bottom: none; }

.activity-avatar {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
}

.activity-details { flex: 1; }
.activity-title { font-weight: 600; color: #2d3748; margin-bottom: 3px; }
.activity-time { font-size: 12px; color: #a0aec0; }
.activity-badge {
    background: #667eea;
    color: white;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 11px;
}

.view-all-link { text-align: center; margin-top: 15px; }
.view-all-link a {
    color: #667eea;
    text-decoration: none;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    gap: 5px;
    transition: all 0.3s;
}

.view-all-link a:hover { gap: 8px; }

@media (max-width: 768px) {
    .welcome-banner { flex-direction: column; text-align: center; gap: 20px; }
    .stats-grid { grid-template-columns: 1fr; }
    .quick-links-grid { grid-template-columns: 1fr; }
}
</style>

<jsp:include page="AdminFooter.jsp"/>