<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Active Auctions" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="UserHeader.jsp">
    <jsp:param name="page" value="active"/>
</jsp:include>

<div class="active-auctions-container">
    <!-- Page Header -->
    <div class="page-header">
        <div>
            <h1><i class="fas fa-fire"></i> Active Auctions</h1>
            <p>Browse and bid on active auctions</p>
        </div>
        <a href="${ctx}/user/dashboard" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
    
    <!-- Search and Filter Bar -->
    <div class="filter-bar">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search auctions by name or category...">
        </div>
        <div class="filter-options">
            <select id="categoryFilter" class="filter-select">
                <option value="all">All Categories</option>
                <c:forEach items="${categories}" var="cat">
                    <option value="${cat.categoryName}">${cat.categoryName}</option>
                </c:forEach>
            </select>
            <select id="sortFilter" class="filter-select">
                <option value="endingSoon">Ending Soon</option>
                <option value="newest">Newest First</option>
                <option value="priceLow">Price: Low to High</option>
                <option value="priceHigh">Price: High to Low</option>
            </select>
        </div>
    </div>
    
    <!-- Auctions Grid -->
    <div class="auctions-grid" id="auctionsGrid">
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach items="${products}" var="product">
                    <div class="auction-card" 
                         data-category="${product.category}"
                         data-price="${product.currentBid}"
                         data-end="${product.auctionEndDate.time}"
                         data-created="${product.createdAt.time}">
                        <div class="auction-image">
                            <c:choose>
                                <c:when test="${not empty product.mainImage}">
                                    <img src="${product.mainImage}" alt="${product.productName}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-image"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="auction-details">
                            <h3 class="auction-title">${product.productName}</h3>
                            <p class="auction-description">${product.description}</p>
                            
                            <div class="auction-info">
                                <div class="info-item">
                                    <span class="info-label">Current Bid</span>
                                    <span class="info-value current-bid">
                                        <fmt:formatNumber value="${product.currentBid}" type="currency" currencySymbol="$"/>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Starting Price</span>
                                    <span class="info-value">
                                        <fmt:formatNumber value="${product.startingPrice}" type="currency" currencySymbol="$"/>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Bids</span>
                                    <span class="info-value">${product.bidCount}</span>
                                </div>
                            </div>
                            
                            <div class="auction-timer" id="timer-${product.productId}">
                                <i class="fas fa-clock"></i>
                                <span class="time-left">
                                    <fmt:formatDate value="${product.auctionEndDate}" pattern="MMM dd, yyyy HH:mm"/>
                                </span>
                            </div>
                            
                            <div class="auction-actions">
                                <a href="${ctx}/viewProduct?productId=${product.productId}" class="btn-view">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                                <a href="${ctx}/bid/place/${product.productId}" class="btn-bid">
                                    <i class="fas fa-gavel"></i> Place Bid
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-box-open"></i>
                    <h3>No Active Auctions</h3>
                    <p>There are no active auctions at the moment. Please check back later.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Pagination -->
    <c:if test="${not empty products}">
        <div class="pagination">
            <button class="page-btn"><i class="fas fa-chevron-left"></i></button>
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
            <button class="page-btn">4</button>
            <button class="page-btn">5</button>
            <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
        </div>
    </c:if>
</div>

<style>
.active-auctions-container {
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

.btn-back {
    background: white;
    color: #48bb78;
    padding: 10px 20px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s;
}

.btn-back:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.filter-bar {
    background: white;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 30px;
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.search-box {
    flex: 1;
    min-width: 250px;
    position: relative;
}

.search-box i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #a0aec0;
}

.search-box input {
    width: 100%;
    padding: 12px 15px 12px 45px;
    border: 2px solid #e2e8f0;
    border-radius: 8px;
    font-size: 14px;
    transition: all 0.3s;
}

.search-box input:focus {
    outline: none;
    border-color: #48bb78;
    box-shadow: 0 0 0 3px rgba(72,187,120,0.1);
}

.filter-options {
    display: flex;
    gap: 10px;
}

.filter-select {
    padding: 12px 35px 12px 15px;
    border: 2px solid #e2e8f0;
    border-radius: 8px;
    font-size: 14px;
    color: #4a5568;
    background: white;
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%234a5568' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
}

.filter-select:focus {
    outline: none;
    border-color: #48bb78;
}

.auctions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 25px;
    margin-bottom: 30px;
}

.auction-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    transition: all 0.3s;
    display: flex;
    flex-direction: column;
}

.auction-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

.auction-image {
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

.auction-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.auction-details {
    padding: 20px;
    flex: 1;
    display: flex;
    flex-direction: column;
}

.auction-title {
    font-size: 18px;
    font-weight: 600;
    color: #2d3748;
    margin-bottom: 10px;
}

.auction-description {
    color: #718096;
    font-size: 14px;
    margin-bottom: 15px;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.auction-info {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 10px;
    margin-bottom: 15px;
    padding: 10px;
    background: #f7fafc;
    border-radius: 8px;
}

.info-item {
    text-align: center;
}

.info-label {
    display: block;
    color: #718096;
    font-size: 11px;
    margin-bottom: 3px;
}

.info-value {
    font-weight: 600;
    color: #2d3748;
    font-size: 14px;
}

.current-bid {
    color: #48bb78;
    font-size: 16px;
}

.auction-timer {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #f56565;
    font-size: 14px;
    margin-bottom: 15px;
    padding: 8px 12px;
    background: #fff5f5;
    border-radius: 8px;
}

.auction-actions {
    display: flex;
    gap: 10px;
    margin-top: auto;
}

.btn-view, .btn-bid {
    flex: 1;
    padding: 10px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: 500;
    font-size: 14px;
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
    color: #a0aec0;
}

.empty-state i {
    font-size: 60px;
    margin-bottom: 20px;
    color: #cbd5e0;
}

.empty-state h3 {
    color: #2d3748;
    font-size: 20px;
    margin-bottom: 10px;
}

.empty-state p {
    margin: 0;
}

.pagination {
    display: flex;
    justify-content: center;
    gap: 8px;
    margin-top: 20px;
}

.page-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #e2e8f0;
    background: white;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s;
    display: flex;
    align-items: center;
    justify-content: center;
}

.page-btn:hover {
    background: #f7fafc;
    border-color: #48bb78;
}

.page-btn.active {
    background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
    color: white;
    border-color: transparent;
}

@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }
    
    .filter-bar {
        flex-direction: column;
    }
    
    .filter-options {
        width: 100%;
        flex-direction: column;
    }
    
    .auctions-grid {
        grid-template-columns: 1fr;
    }
    
    .auction-actions {
        flex-direction: column;
    }
}
</style>

<script>
// Search functionality
document.getElementById('searchInput').addEventListener('keyup', function() {
    const searchTerm = this.value.toLowerCase();
    const cards = document.querySelectorAll('.auction-card');
    
    cards.forEach(card => {
        const title = card.querySelector('.auction-title').textContent.toLowerCase();
        const desc = card.querySelector('.auction-description').textContent.toLowerCase();
        
        if (title.includes(searchTerm) || desc.includes(searchTerm)) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
});

// Category filter
document.getElementById('categoryFilter').addEventListener('change', function() {
    const category = this.value;
    const cards = document.querySelectorAll('.auction-card');
    
    cards.forEach(card => {
        if (category === 'all' || card.dataset.category === category) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
});

// Sort functionality
document.getElementById('sortFilter').addEventListener('change', function() {
    const sortBy = this.value;
    const grid = document.querySelector('.auctions-grid');
    const cards = Array.from(document.querySelectorAll('.auction-card'));
    
    // Remove all cards
    cards.forEach(card => card.remove());
    
    // Sort cards
    cards.sort((a, b) => {
        switch(sortBy) {
            case 'endingSoon':
                return new Date(a.dataset.end) - new Date(b.dataset.end);
            case 'newest':
                return new Date(b.dataset.created) - new Date(a.dataset.created);
            case 'priceLow':
                return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
            case 'priceHigh':
                return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
            default:
                return 0;
        }
    });
    
    // Re-add sorted cards
    cards.forEach(card => grid.appendChild(card));
});

// Countdown timers (optional)
function updateTimers() {
    document.querySelectorAll('.auction-timer').forEach(timer => {
        const endTimeStr = timer.querySelector('.time-left').textContent;
        // You can add countdown logic here if needed
    });
}

// Update timers every minute
setInterval(updateTimers, 60000);
</script>

<jsp:include page="UserFooter.jsp"/>