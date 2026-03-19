<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Won Auctions" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="UserHeader.jsp">
    <jsp:param name="page" value="won"/>
</jsp:include>

<div class="won-auctions-container">
    <!-- Page Header -->
    <div class="page-header">
        <div>
            <h1><i class="fas fa-trophy"></i> Won Auctions</h1>
            <p>Congratulations! Here are your winning auctions</p>
        </div>
        <div class="header-stats">
            <div class="stat-badge">
                <i class="fas fa-gift"></i>
                <span>Won: <strong>${wonCount}</strong></span>
            </div>
            <div class="stat-badge">
                <i class="fas fa-dollar-sign"></i>
                <span>Total: <strong>$${totalSpent}</strong></span>
            </div>
        </div>
    </div>

    <!-- Won Auctions Grid -->
    <div class="won-grid">
        <c:choose>
            <c:when test="${not empty wonAuctions}">
                <c:forEach items="${wonAuctions}" var="auction">
                    <div class="won-card">
                        <div class="won-image">
                            <c:choose>
                                <c:when test="${not empty auction.productImage}">
                                    <img src="${auction.productImage}" alt="${auction.productName}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-box"></i>
                                </c:otherwise>
                            </c:choose>
                            <div class="won-badge">
                                <i class="fas fa-crown"></i> Winner
                            </div>
                        </div>
                        <div class="won-details">
                            <h3 class="won-title">${auction.productName}</h3>
                            
                            <div class="won-info">
                                <div class="info-row">
                                    <i class="fas fa-tag"></i>
                                    <span>Winning Bid:</span>
                                    <strong>$${auction.winningBid}</strong>
                                </div>
                                <div class="info-row">
                                    <i class="fas fa-calendar"></i>
                                    <span>Won Date:</span>
                                    <strong><fmt:formatDate value="${auction.wonDate}" pattern="MMM dd, yyyy"/></strong>
                                </div>
                                <div class="info-row">
                                    <i class="fas fa-store"></i>
                                    <span>Seller:</span>
                                    <strong>${auction.sellerName}</strong>
                                </div>
                            </div>
                            
                            <div class="payment-status">
                                <c:choose>
                                    <c:when test="${auction.paymentStatus == 'PAID'}">
                                        <span class="status-badge status-paid">
                                            <i class="fas fa-check-circle"></i> Payment Completed
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-pending">
                                            <i class="fas fa-clock"></i> Payment Pending
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="won-actions">
                                <a href="${ctx}/viewProduct?productId=${auction.productId}" class="btn-view">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                                <c:if test="${auction.paymentStatus != 'PAID'}">
                                    <a href="${ctx}/payment/make/${auction.auctionId}" class="btn-pay">
                                        <i class="fas fa-credit-card"></i> Pay Now
                                    </a>
                                </c:if>
                                <a href="${ctx}/invoice/${auction.auctionId}" class="btn-invoice">
                                    <i class="fas fa-file-invoice"></i> Invoice
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-trophy"></i>
                    <h3>No Won Auctions Yet</h3>
                    <p>Keep bidding! Your winning items will appear here.</p>
                    <a href="${ctx}/user/active-auctions" class="btn-empty">
                        <i class="fas fa-fire"></i> Browse Auctions
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<style>
.won-auctions-container {
    padding: 20px;
    max-width: 1400px;
    margin: 0 auto;
}

.page-header {
    background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
    border-radius: 15px;
    padding: 25px 30px;
    margin-bottom: 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    box-shadow: 0 10px 30px rgba(72,187,120,0.3);
}

.page-header h1 {
    font-size: 28px;
    font-weight: 600;
    margin: 0 0 5px 0;
}

.page-header h1 i {
    margin-right: 10px;
}

.page-header p {
    font-size: 16px;
    opacity: 0.9;
    margin: 0;
}

.header-stats {
    display: flex;
    gap: 15px;
}

.stat-badge {
    background: rgba(255,255,255,0.2);
    padding: 8px 15px;
    border-radius: 20px;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
    border: 1px solid rgba(255,255,255,0.3);
}

.stat-badge i {
    font-size: 16px;
}

.stat-badge strong {
    font-size: 16px;
}

.won-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
    gap: 25px;
}

.won-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    transition: all 0.3s;
}

.won-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

.won-image {
    height: 200px;
    background: #e2e8f0;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #a0aec0;
    font-size: 48px;
    overflow: hidden;
}

.won-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.won-badge {
    position: absolute;
    top: 15px;
    right: 15px;
    background: #fbbf24;
    color: #744210;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 5px;
}

.won-details {
    padding: 20px;
}

.won-title {
    font-size: 20px;
    font-weight: 600;
    color: #2d3748;
    margin-bottom: 15px;
}

.won-info {
    background: #f7fafc;
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 15px;
}

.info-row {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 8px 0;
    border-bottom: 1px solid #e2e8f0;
}

.info-row:last-child {
    border-bottom: none;
}

.info-row i {
    width: 20px;
    color: #48bb78;
}

.info-row span {
    flex: 1;
    color: #718096;
}

.info-row strong {
    color: #2d3748;
    font-weight: 600;
}

.payment-status {
    margin-bottom: 15px;
}

.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 500;
}

.status-paid {
    background: #c6f6d5;
    color: #22543d;
}

.status-pending {
    background: #feebc8;
    color: #744210;
}

.won-actions {
    display: flex;
    gap: 10px;
}

.btn-view, .btn-pay, .btn-invoice {
    flex: 1;
    padding: 10px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: 500;
    font-size: 13px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 5px;
    transition: all 0.3s;
}

.btn-view {
    background: #e2e8f0;
    color: #4a5568;
}

.btn-pay {
    background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
    color: white;
}

.btn-invoice {
    background: #e3f2fd;
    color: #1976d2;
}

.btn-view:hover, .btn-pay:hover, .btn-invoice:hover {
    transform: translateY(-2px);
    box-shadow: 0 3px 10px rgba(0,0,0,0.1);
}

.empty-state {
    grid-column: 1 / -1;
    text-align: center;
    padding: 60px 20px;
    background: white;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
}

.empty-state i {
    font-size: 60px;
    color: #cbd5e0;
    margin-bottom: 20px;
}

.empty-state h3 {
    color: #2d3748;
    font-size: 20px;
    margin-bottom: 10px;
}

.empty-state p {
    color: #718096;
    margin-bottom: 20px;
}

.btn-empty {
    display: inline-block;
    background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
    color: white;
    padding: 12px 25px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s;
}

.btn-empty:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(72,187,120,0.3);
}

@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }
    
    .won-grid {
        grid-template-columns: 1fr;
    }
    
    .won-actions {
        flex-direction: column;
    }
}
</style>

<jsp:include page="UserFooter.jsp"/>