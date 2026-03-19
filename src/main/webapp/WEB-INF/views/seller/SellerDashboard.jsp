<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Dashboard" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="SellerHeader.jsp">
    <jsp:param name="page" value="dashboard"/>
</jsp:include>

<div class="seller-dashboard" style="padding: 20px; max-width: 1400px; margin: 0 auto;">
    <!-- Welcome Card -->
    <div style="background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); border-radius: 15px; padding: 30px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; color: white; box-shadow: 0 10px 30px rgba(251,191,36,0.3);">
        <div>
            <h1 style="font-size: 28px; margin-bottom: 10px;">Welcome back, ${sessionScope.user.firstName}!</h1>
            <p style="opacity: 0.9; font-size: 16px;">Manage your products and track your sales.</p>
        </div>
        <a href="${ctx}/newProduct" style="background: white; color: #f59e0b; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.2); transition: all 0.3s;">
            <i class="fas fa-plus"></i> List New Product
        </a>
    </div>
    
    <!-- Stats Grid -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 20px; margin-bottom: 30px;">
        <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h3 style="font-size: 14px; color: #718096; margin-bottom: 5px; text-transform: uppercase; letter-spacing: 1px;">Total Products</h3>
                <div style="font-size: 32px; font-weight: bold; color: #2d3748;">${totalProducts}</div>
            </div>
            <div style="width: 60px; height: 60px; border-radius: 50%; background: #e3f2fd; display: flex; align-items: center; justify-content: center; color: #1976d2; font-size: 24px;">
                <i class="fas fa-box"></i>
            </div>
        </div>
        
        <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h3 style="font-size: 14px; color: #718096; margin-bottom: 5px; text-transform: uppercase; letter-spacing: 1px;">Active Auctions</h3>
                <div style="font-size: 32px; font-weight: bold; color: #2d3748;">${activeAuctions}</div>
            </div>
            <div style="width: 60px; height: 60px; border-radius: 50%; background: #e8f5e9; display: flex; align-items: center; justify-content: center; color: #2e7d32; font-size: 24px;">
                <i class="fas fa-fire"></i>
            </div>
        </div>
        
        <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h3 style="font-size: 14px; color: #718096; margin-bottom: 5px; text-transform: uppercase; letter-spacing: 1px;">Sold Items</h3>
                <div style="font-size: 32px; font-weight: bold; color: #2d3748;">${soldItems}</div>
            </div>
            <div style="width: 60px; height: 60px; border-radius: 50%; background: #fff3e0; display: flex; align-items: center; justify-content: center; color: #ef6c00; font-size: 24px;">
                <i class="fas fa-check-circle"></i>
            </div>
        </div>
        
        <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h3 style="font-size: 14px; color: #718096; margin-bottom: 5px; text-transform: uppercase; letter-spacing: 1px;">Total Earnings</h3>
                <div style="font-size: 32px; font-weight: bold; color: #2d3748;">$${totalEarnings}</div>
            </div>
            <div style="width: 60px; height: 60px; border-radius: 50%; background: #e8eaf6; display: flex; align-items: center; justify-content: center; color: #3949ab; font-size: 24px;">
                <i class="fas fa-dollar-sign"></i>
            </div>
        </div>
    </div>
    
    <!-- Recent Activity -->
    <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="color: #2d3748; font-size: 20px;">Recent Activity</h2>
            <a href="${ctx}/seller/bids-received" style="color: #f59e0b; text-decoration: none; display: flex; align-items: center; gap: 5px;">
                View All <i class="fas fa-arrow-right"></i>
            </a>
        </div>
        
        <c:choose>
            <c:when test="${not empty recentActivities}">
                <c:forEach items="${recentActivities}" var="activity">
                    <div style="display: flex; align-items: center; gap: 15px; padding: 15px 0; border-bottom: 1px solid #f0f0f0;">
                        <div style="width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; 
                            background: ${activity.type == 'bid' ? '#e8f5e9' : (activity.type == 'sold' ? '#fff3e0' : '#e3f2fd')}; 
                            color: ${activity.type == 'bid' ? '#2e7d32' : (activity.type == 'sold' ? '#ef6c00' : '#1976d2')};">
                            <i class="fas ${activity.icon}"></i>
                        </div>
                        <div style="flex: 1;">
                            <div style="font-weight: 600; color: #2d3748; margin-bottom: 3px;">${activity.title}</div>
                            <div style="font-size: 12px; color: #718096;">${activity.time}</div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 40px 20px; color: #a0aec0;">
                    <i class="fas fa-bell" style="font-size: 40px; margin-bottom: 10px; color: #cbd5e0;"></i>
                    <p>No recent activity</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="SellerFooter.jsp"/>