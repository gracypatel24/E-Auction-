<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Watchlist" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="UserHeader.jsp">
    <jsp:param name="page" value="watchlist"/>
</jsp:include>

<div class="watchlist-container">
    <!-- Page Header -->
    <div class="page-header">
        <div>
            <h1><i class="fas fa-heart"></i> My Watchlist</h1>
            <p>Track auctions you're interested in</p>
        </div>
        <a href="${ctx}/user/active-auctions" class="btn-browse">
            <i class="fas fa-fire"></i> Browse Auctions
        </a>
    </div>

    <!-- Watchlist Grid -->
    <div class="watchlist-grid">
        <c:choose>
            <c:when test="${not empty watchlist}">
                <c:forEach items="${watchlist}" var="item">
                    <div class="watchlist-card">
                        <div class="watchlist-image">
                            <c:choose>
                                <c:when test="${not empty item.productImage}">
                                    <img src="${item.productImage}" alt="${item.productName}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-image"></i>
                                </c:otherwise>
                            </c:choose>
                            <button class="btn-remove" onclick="removeFromWatchlist(${item.productId})" title="Remove from watchlist">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        <div class="watchlist-details">
                            <h3 class="watchlist-title">${item.productName}</h3>
                            <div class="watchlist-price">
                                <span class="current-bid">$${item.currentBid}</span>
                                <span class="starting-price">Starting: $${item.startingPrice}</span>
                            </div>
                            
                            <div class="watchlist-info">
                                <span><i class="fas fa-gavel"></i> ${item.bidCount} bids</span>
                                <span class="time-left"><i class="fas fa-clock"></i> 
                                    <fmt:formatDate value="${item.auctionEndDate}" pattern="MMM dd, HH:mm"/>
                                </span>
                            </div>
                            
                            <div class="watchlist-actions">
                                <a href="${ctx}/viewProduct?productId=${item.productId}" class="btn-view">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                                <a href="${ctx}/bid/place/${item.productId}" class="btn-bid">
                                    <i class="fas fa-gavel"></i> Place Bid
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-heart-broken"></i>
                    <h3>Your Watchlist is Empty</h3>
                    <p>Start adding items to your watchlist by clicking the heart icon on auctions.</p>
                    <a href="${ctx}/user/active-auctions" class="btn-empty">
                        <i class="fas fa-fire"></i> Browse Auctions
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<style>
.watchlist-container {
    padding: 20px;
    max-width: 1400px;
    margin: 0 auto;
}

.page-header {
    background: linear-gradient(135deg, #f56565 0%, #c53030 100%);
    border-radius: 15px;
    padding: 25px 30px;
    margin-bottom: 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    box-shadow: 0 10px 30px rgba(229,62,62,0.3);
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

.btn-browse {
    background: white;
    color: #f56565;
    padding: 10px 20px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s;
}

.btn-browse:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.watchlist-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 25px;
}

.watchlist-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    transition: all 0.3s;
    position: relative;
}

.watchlist-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

.watchlist-image {
    height: 180px;
    background: #e2e8f0;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #a0aec0;
    font-size: 40px;
    overflow: hidden;
}

.watchlist-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.btn-remove {
    position: absolute;
    top: 10px;
    right: 10px;
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: rgba(255,255,255,0.9);
    border: none;
    color: #f56565;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.btn-remove:hover {
    background: #f56565;
    color: white;
    transform: scale(1.1);
}

.watchlist-details {
    padding: 20px;
}

.watchlist-title {
    font-size: 18px;
    font-weight: 600;
    color: #2d3748;
    margin-bottom: 10px;
}

.watchlist-price {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    margin-bottom: 10px;
}

.current-bid {
    font-size: 20px;
    font-weight: bold;
    color: #48bb78;
}

.starting-price {
    font-size: 13px;
    color: #718096;
    text-decoration: line-through;
}

.watchlist-info {
    display: flex;
    justify-content: space-between;
    color: #718096;
    font-size: 13px;
    margin-bottom: 15px;
}

.watchlist-info i {
    margin-right: 5px;
}

.time-left {
    color: #f56565;
}

.watchlist-actions {
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
    background: linear-gradient(135deg, #f56565 0%, #c53030 100%);
    color: white;
    padding: 12px 25px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s;
}

.btn-empty:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(229,62,62,0.3);
}

@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }
    
    .watchlist-grid {
        grid-template-columns: 1fr;
    }
    
    .watchlist-actions {
        flex-direction: column;
    }
}
</style>

<script>
function removeFromWatchlist(productId) {
    if(confirm('Remove this item from your watchlist?')) {
        window.location.href = '${ctx}/user/watchlist/remove/' + productId;
    }
}
</script>

<jsp:include page="UserFooter.jsp"/>