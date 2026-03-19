<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="My Bids" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="UserHeader.jsp">
    <jsp:param name="page" value="mybids"/>
</jsp:include>

<div class="my-bids-container">
    <!-- Page Header -->
    <div class="page-header">
        <div>
            <h1><i class="fas fa-gavel"></i> My Bids</h1>
            <p>Track all your bidding activity</p>
        </div>
        <div class="header-stats">
            <div class="stat-badge">
                <i class="fas fa-chart-line"></i>
                <span>Total Bids: <strong>${totalBids}</strong></span>
            </div>
        </div>
    </div>

    <!-- Filter Tabs -->
    <div class="filter-tabs">
        <button class="tab-btn active" onclick="filterBids('all')">All Bids</button>
        <button class="tab-btn" onclick="filterBids('active')">Active</button>
        <button class="tab-btn" onclick="filterBids('winning')">Winning</button>
        <button class="tab-btn" onclick="filterBids('outbid')">Outbid</button>
        <button class="tab-btn" onclick="filterBids('won')">Won</button>
    </div>

    <!-- Bids Grid -->
    <div class="bids-grid" id="bidsGrid">
        <c:choose>
            <c:when test="${not empty myBids}">
                <c:forEach items="${myBids}" var="bid">
                    <div class="bid-card" data-status="${bid.status.toLowerCase()}">
                        <div class="bid-image">
                            <c:choose>
                                <c:when test="${not empty bid.productImage}">
                                    <img src="${bid.productImage}" alt="${bid.productName}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-box"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="bid-details">
                            <h3 class="bid-title">${bid.productName}</h3>
                            <div class="bid-meta">
                                <span><i class="far fa-clock"></i> <fmt:formatDate value="${bid.bidDate}" pattern="MMM dd, yyyy HH:mm"/></span>
                            </div>
                            
                            <div class="bid-amounts">
                                <div class="amount-item">
                                    <span class="amount-label">Your Bid</span>
                                    <span class="amount-value your-bid">$${bid.amount}</span>
                                </div>
                                <div class="amount-item">
                                    <span class="amount-label">Current Bid</span>
                                    <span class="amount-value current-bid">$${bid.currentBid}</span>
                                </div>
                            </div>
                            
                            <div class="bid-status">
                                <c:choose>
                                    <c:when test="${bid.status == 'WINNING'}">
                                        <span class="status-badge status-winning">
                                            <i class="fas fa-check-circle"></i> Winning
                                        </span>
                                    </c:when>
                                    <c:when test="${bid.status == 'OUTBID'}">
                                        <span class="status-badge status-outbid">
                                            <i class="fas fa-exclamation-circle"></i> Outbid
                                        </span>
                                    </c:when>
                                    <c:when test="${bid.status == 'WON'}">
                                        <span class="status-badge status-won">
                                            <i class="fas fa-trophy"></i> Won
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-active">
                                            <i class="fas fa-clock"></i> Active
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="bid-actions">
                                <a href="${ctx}/viewProduct?productId=${bid.productId}" class="btn-view">
                                    <i class="fas fa-eye"></i> View Product
                                </a>
                                <c:if test="${bid.status != 'WON' && bid.status != 'OUTBID'}">
                                    <a href="${ctx}/bid/place/${bid.productId}" class="btn-bid">
                                        <i class="fas fa-gavel"></i> Increase Bid
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-gavel"></i>
                    <h3>No Bids Found</h3>
                    <p>You haven't placed any bids yet. Start bidding on active auctions!</p>
                    <a href="${ctx}/user/active-auctions" class="btn-empty">
                        <i class="fas fa-fire"></i> Browse Auctions
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<style>
.my-bids-container {
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

.filter-tabs {
    display: flex;
    gap: 10px;
    margin-bottom: 25px;
    flex-wrap: wrap;
}

.tab-btn {
    padding: 10px 20px;
    border: none;
    background: white;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    color: #4a5568;
    cursor: pointer;
    transition: all 0.3s;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}

.tab-btn:hover {
    background: #f0f3ff;
    color: #48bb78;
}

.tab-btn.active {
    background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
    color: white;
}

.bids-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 20px;
}

.bid-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    transition: all 0.3s;
    display: flex;
    flex-direction: column;
}

.bid-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

.bid-image {
    height: 150px;
    background: #e2e8f0;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #a0aec0;
    font-size: 40px;
    overflow: hidden;
}

.bid-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.bid-details {
    padding: 20px;
    flex: 1;
}

.bid-title {
    font-size: 18px;
    font-weight: 600;
    color: #2d3748;
    margin-bottom: 10px;
}

.bid-meta {
    color: #718096;
    font-size: 13px;
    margin-bottom: 15px;
}

.bid-meta i {
    margin-right: 5px;
}

.bid-amounts {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    padding: 10px;
    background: #f7fafc;
    border-radius: 8px;
}

.amount-item {
    text-align: center;
}

.amount-label {
    display: block;
    color: #718096;
    font-size: 11px;
    margin-bottom: 3px;
}

.amount-value {
    font-weight: 600;
    font-size: 16px;
}

.your-bid {
    color: #48bb78;
}

.current-bid {
    color: #2d3748;
}

.bid-status {
    margin-bottom: 15px;
}

.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 500;
}

.status-winning {
    background: #c6f6d5;
    color: #22543d;
}

.status-outbid {
    background: #fed7d7;
    color: #742a2a;
}

.status-won {
    background: #feebc8;
    color: #744210;
}

.status-active {
    background: #e2e8f0;
    color: #4a5568;
}

.bid-actions {
    display: flex;
    gap: 10px;
}

.btn-view, .btn-bid {
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

.btn-bid {
    background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
    color: white;
}

.btn-view:hover, .btn-bid:hover {
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
    
    .bids-grid {
        grid-template-columns: 1fr;
    }
    
    .bid-actions {
        flex-direction: column;
    }
}
</style>

<script>
function filterBids(status) {
    const cards = document.querySelectorAll('.bid-card');
    const tabs = document.querySelectorAll('.tab-btn');
    
    tabs.forEach(tab => {
        tab.classList.remove('active');
        if(tab.textContent.toLowerCase().includes(status)) {
            tab.classList.add('active');
        }
    });
    
    cards.forEach(card => {
        if(status === 'all' || card.dataset.status === status) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
}
</script>

<jsp:include page="UserFooter.jsp"/>