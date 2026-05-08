<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
// This scriptlet ensures no hidden characters
response.setHeader("Content-Type", "text/html; charset=UTF-8");
%>
<c:set var="pageTitle" value="Dashboard" scope="request"/>

<%-- Include header with proper syntax --%>
<jsp:include page="UserHeader.jsp">
    <jsp:param name="page" value="dashboard"/>
</jsp:include>

<div class="user-dashboard" style="padding: 20px; max-width: 1400px; margin: 0 auto;">
    <!-- Welcome Card -->
    <div style="background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); color: white; padding: 30px; border-radius: 15px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(72,187,120,0.3);">
        <h1 style="font-size: 28px; margin-bottom: 10px;">Welcome back, ${sessionScope.user.firstName}!</h1>
        <p style="opacity: 0.9; font-size: 16px; margin: 0;">Browse active auctions, place bids, and track your winnings.</p>
    </div>
    
    <!-- Stats Grid -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px;">
        <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); text-align: center;">
            <i class="fas fa-gavel fa-2x" style="color: #48bb78;"></i>
            <div style="font-size: 36px; font-weight: 700; color: #2d3748; margin: 10px 0;">${totalBids}</div>
            <div style="color: #718096; font-size: 14px;">Total Bids Placed</div>
        </div>
        
        <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); text-align: center;">
            <i class="fas fa-trophy fa-2x" style="color: #fbbf24;"></i>
            <div style="font-size: 36px; font-weight: 700; color: #2d3748; margin: 10px 0;">${wonAuctions}</div>
            <div style="color: #718096; font-size: 14px;">Auctions Won</div>
        </div>
        
        <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); text-align: center;">
            <i class="fas fa-heart fa-2x" style="color: #f56565;"></i>
            <div style="font-size: 36px; font-weight: 700; color: #2d3748; margin: 10px 0;">${watchlistCount}</div>
            <div style="color: #718096; font-size: 14px;">Watchlist Items</div>
        </div>
        
        <div style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); text-align: center;">
            <i class="fas fa-clock fa-2x" style="color: #4299e1;"></i>
            <div style="font-size: 36px; font-weight: 700; color: #2d3748; margin: 10px 0;">${activeBids}</div>
            <div style="color: #718096; font-size: 14px;">Active Bids</div>
        </div>
    </div>
    
    <!-- Active Auctions -->
    <h2 style="font-size: 22px; color: #2d3748; margin: 30px 0 20px;">🔥 Active Auctions You Might Like</h2>
    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; margin-bottom: 30px;">
        <c:forEach items="${recommendedAuctions}" var="product" begin="0" end="3">
            <div style="background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
                <div style="height: 180px; background: #e2e8f0; display: flex; align-items: center; justify-content: center; color: #a0aec0; font-size: 48px;">
                    <i class="fas fa-image"></i>
                </div>
                <div style="padding: 20px;">
                    <h3 style="font-size: 18px; font-weight: 600; color: #2d3748; margin-bottom: 10px;">${product.productName}</h3>
                    <div style="font-size: 24px; font-weight: 700; color: #48bb78; margin-bottom: 10px;">$${product.currentBid}</div>
                    <div style="display: flex; justify-content: space-between; color: #718096; font-size: 14px; margin-bottom: 15px;">
                        <span><i class="fas fa-gavel"></i> ${product.bidCount} bids</span>
                        <span style="color: #f56565;"><i class="fas fa-clock"></i> 2h left</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/viewProduct?productId=${product.productId}" 
                       style="display: block; text-align: center; background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); color: white; text-decoration: none; padding: 12px; border-radius: 8px;">
                        <i class="fas fa-gavel"></i> Place Bid
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <!-- My Recent Bids -->
    <h2 style="font-size: 22px; color: #2d3748; margin: 30px 0 20px;">📊 My Recent Bids</h2>
    <div style="background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
        <table style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr style="background: #f7fafc;">
                    <th style="padding: 15px; text-align: left; color: #4a5568; font-weight: 600; border-bottom: 2px solid #e2e8f0;">Product</th>
                    <th style="padding: 15px; text-align: left; color: #4a5568; font-weight: 600; border-bottom: 2px solid #e2e8f0;">Your Bid</th>
                    <th style="padding: 15px; text-align: left; color: #4a5568; font-weight: 600; border-bottom: 2px solid #e2e8f0;">Current Bid</th>
                    <th style="padding: 15px; text-align: left; color: #4a5568; font-weight: 600; border-bottom: 2px solid #e2e8f0;">Status</th>
                    <th style="padding: 15px; text-align: left; color: #4a5568; font-weight: 600; border-bottom: 2px solid #e2e8f0;">Time Left</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${recentBids}" var="bid" begin="0" end="4">
    <tr style="border-bottom: 1px solid #e2e8f0;">
        <td style="padding: 15px;">${bid.product.productName}</td>
        <td style="padding: 15px; font-weight: 600;">$${bid.bidAmount}</td>
        <td style="padding: 15px;">$${bid.product.currentBid}</td>
                            <span style="padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 500; 
                                  background: ${bid.statusClass == 'active' ? '#e3f2fd' : 
                                                (bid.statusClass == 'winning' ? '#e8f5e9' : 
                                                (bid.statusClass == 'outbid' ? '#ffebee' : '#fff3e0'))};
                                  color: ${bid.statusClass == 'active' ? '#1976d2' : 
                                          (bid.statusClass == 'winning' ? '#2e7d32' : 
                                          (bid.statusClass == 'outbid' ? '#c62828' : '#ef6c00'))};">
                                ${bid.status}
                            </span>
                        </td>
                        <td style="padding: 15px; color: #f56565;">${bid.timeLeft}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="UserFooter.jsp"/>
