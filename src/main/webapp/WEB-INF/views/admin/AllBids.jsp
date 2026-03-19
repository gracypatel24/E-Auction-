<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="All Bids" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="AdminHeader.jsp">
    <jsp:param name="page" value="bids"/>
</jsp:include>

<style>
    /* All Bids Page Specific Styles */
    .bids-container {
        padding: 25px;
        max-width: 1400px;
        margin: 0 auto;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    /* Page Header */
    .page-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 15px;
        padding: 30px;
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: white;
        box-shadow: 0 10px 30px rgba(102,126,234,0.3);
    }
    
    .page-header h1 {
        font-size: 28px;
        font-weight: 600;
        margin: 0 0 10px 0;
    }
    
    .page-header h1 i {
        margin-right: 10px;
        font-size: 32px;
    }
    
    .page-header p {
        font-size: 16px;
        opacity: 0.9;
        margin: 0;
    }
    
    .btn-back {
        background: white;
        color: #667eea;
        padding: 12px 25px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        border: none;
        cursor: pointer;
    }
    
    .btn-back:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
    }
    
    /* Stats Cards */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        transition: all 0.3s;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    }
    
    .stat-icon {
        width: 55px;
        height: 55px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }
    
    .stat-icon.blue {
        background: #e3f2fd;
        color: #1976d2;
    }
    
    .stat-icon.green {
        background: #e8f5e9;
        color: #2e7d32;
    }
    
    .stat-icon.orange {
        background: #fff3e0;
        color: #ef6c00;
    }
    
    .stat-icon.purple {
        background: #f3e5f5;
        color: #7b1fa2;
    }
    
    .stat-info {
        flex: 1;
    }
    
    .stat-label {
        color: #718096;
        font-size: 13px;
        margin-bottom: 5px;
    }
    
    .stat-value {
        font-size: 24px;
        font-weight: bold;
        color: #2d3748;
    }
    
    /* Filter Bar */
    .filter-bar {
        background: white;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    
    .search-box {
        position: relative;
        flex: 1;
        min-width: 250px;
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
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
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
        border-color: #667eea;
    }
    
    /* Table Container */
    .table-container {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        overflow-x: auto;
        margin-bottom: 25px;
    }
    
    .bids-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .bids-table th {
        text-align: left;
        padding: 15px 12px;
        background: #f7fafc;
        color: #4a5568;
        font-weight: 600;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid #e2e8f0;
    }
    
    .bids-table td {
        padding: 15px 12px;
        border-bottom: 1px solid #e2e8f0;
        vertical-align: middle;
    }
    
    .bids-table tr:hover {
        background: #f7fafc;
    }
    
    .product-info {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .product-thumb {
        width: 45px;
        height: 45px;
        border-radius: 8px;
        background: #e2e8f0;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #a0aec0;
        font-size: 18px;
    }
    
    .product-thumb img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 8px;
    }
    
    .product-name {
        font-weight: 600;
        color: #2d3748;
    }
    
    .bid-amount {
        font-weight: 600;
        color: #48bb78;
        font-size: 16px;
    }
    
    .status-badge {
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        display: inline-block;
    }
    
    .status-active {
        background: #c6f6d5;
        color: #22543d;
    }
    
    .status-won {
        background: #feebc8;
        color: #744210;
    }
    
    .status-outbid {
        background: #fed7d7;
        color: #742a2a;
    }
    
    .status-pending {
        background: #e2e8f0;
        color: #4a5568;
    }
    
    .user-avatar-sm {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 12px;
        margin-right: 8px;
    }
    
    .bidder-info {
        display: flex;
        align-items: center;
    }
    
    .action-buttons {
        display: flex;
        gap: 5px;
    }
    
    .btn-action {
        width: 32px;
        height: 32px;
        border-radius: 6px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        transition: all 0.3s;
    }
    
    .btn-view {
        background: #e3f2fd;
        color: #1976d2;
    }
    
    .btn-view:hover {
        transform: translateY(-2px);
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px !important;
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
    
    /* Pagination */
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
        border-color: #667eea;
    }
    
    .page-btn.active {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-color: transparent;
    }
    
    /* Back Link */
    .back-link {
        text-align: center;
        margin-top: 20px;
    }
    
    .btn-back-bottom {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: white;
        color: #667eea;
        padding: 12px 25px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        transition: all 0.3s;
    }
    
    .btn-back-bottom:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102,126,234,0.2);
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .page-header {
            flex-direction: column;
            text-align: center;
            gap: 15px;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
        
        .filter-bar {
            flex-direction: column;
        }
        
        .filter-options {
            width: 100%;
            flex-direction: column;
        }
        
        .filter-select {
            width: 100%;
        }
    }
</style>

<div class="bids-container">
    <!-- Page Header -->
    <div class="page-header">
        <div>
            <h1><i class="fas fa-gavel"></i> All Bids</h1>
            <p>Monitor and manage all bidding activity across the platform</p>
        </div>
        <a href="${ctx}/admin/dashboard" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
    
    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon blue">
                <i class="fas fa-gavel"></i>
            </div>
            <div class="stat-info">
                <div class="stat-label">Total Bids</div>
                <div class="stat-value">${totalBids != null ? totalBids : '0'}</div>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon green">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-info">
                <div class="stat-label">Winning Bids</div>
                <div class="stat-value">${winningBids != null ? winningBids : '0'}</div>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon orange">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-info">
                <div class="stat-label">Active Bids</div>
                <div class="stat-value">${activeBids != null ? activeBids : '0'}</div>
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon purple">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="stat-info">
                <div class="stat-label">Total Value</div>
                <div class="stat-value">$${totalValue != null ? totalValue : '0'}</div>
            </div>
        </div>
    </div>
    
    <!-- Filter Bar -->
    <div class="filter-bar">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search by product, bidder, or amount...">
        </div>
        <div class="filter-options">
            <select id="statusFilter" class="filter-select">
                <option value="all">All Status</option>
                <option value="active">Active</option>
                <option value="won">Won</option>
                <option value="outbid">Outbid</option>
            </select>
            <select id="sortFilter" class="filter-select">
                <option value="newest">Newest First</option>
                <option value="oldest">Oldest First</option>
                <option value="highest">Highest Amount</option>
                <option value="lowest">Lowest Amount</option>
            </select>
        </div>
    </div>
    
    <!-- Bids Table -->
    <div class="table-container">
        <table class="bids-table" id="bidsTable">
            <thead>
                <tr>
                    <th>Bid ID</th>
                    <th>Product</th>
                    <th>Bidder</th>
                    <th>Bid Amount</th>
                    <th>Date & Time</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty bids}">
                        <c:forEach items="${bids}" var="bid">
                            <tr>
                                <td>#${bid.bidId}</td>
                                <td>
                                    <div class="product-info">
                                        <div class="product-thumb">
                                            <c:choose>
                                                <c:when test="${not empty bid.product.mainImage}">
                                                    <img src="${bid.product.mainImage}" alt="${bid.product.productName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-box"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="product-name">${bid.product.productName}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="bidder-info">
                                        <div class="user-avatar-sm">
                                            ${bid.user.firstName.charAt(0)}${bid.user.lastName.charAt(0)}
                                        </div>
                                        ${bid.user.firstName} ${bid.user.lastName}
                                    </div>
                                </td>
                                <td class="bid-amount">$${bid.bidAmount}</td>
                                <td><fmt:formatDate value="${bid.bidDate}" pattern="MMM dd, yyyy HH:mm"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${bid.status == 'ACTIVE'}">
                                            <span class="status-badge status-active">Active</span>
                                        </c:when>
                                        <c:when test="${bid.status == 'WON'}">
                                            <span class="status-badge status-won">Won</span>
                                        </c:when>
                                        <c:when test="${bid.status == 'OUTBID'}">
                                            <span class="status-badge status-outbid">Outbid</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-pending">Pending</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${ctx}/viewProduct?productId=${bid.product.productId}" class="btn-action btn-view" title="View Product">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="empty-state">
                                <i class="fas fa-gavel"></i>
                                <h3>No Bids Found</h3>
                                <p>There are no bids in the system yet.</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        
        <!-- Pagination -->
        <c:if test="${not empty bids}">
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
    
    <!-- Back to Dashboard Link -->
    <div class="back-link">
        <a href="${ctx}/admin/dashboard" class="btn-back-bottom">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

<script>
    // Search functionality
    document.getElementById('searchInput').addEventListener('keyup', function() {
        var input = this.value.toUpperCase();
        var table = document.getElementById('bidsTable');
        var rows = table.getElementsByTagName('tr');
        
        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var cells = row.getElementsByTagName('td');
            var found = false;
            
            for (var j = 0; j < cells.length; j++) {
                var cell = cells[j];
                if (cell) {
                    var textValue = cell.textContent || cell.innerText;
                    if (textValue.toUpperCase().indexOf(input) > -1) {
                        found = true;
                        break;
                    }
                }
            }
            
            row.style.display = found ? '' : 'none';
        }
    });
    
    // Filter by status
    document.getElementById('statusFilter').addEventListener('change', function() {
        var filter = this.value;
        var table = document.getElementById('bidsTable');
        var rows = table.getElementsByTagName('tr');
        
        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var statusCell = row.getElementsByTagName('td')[5];
            if (statusCell) {
                var status = statusCell.textContent.trim();
                if (filter === 'all' || status.toLowerCase().includes(filter)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }
    });
</script>

<jsp:include page="AdminFooter.jsp"/>