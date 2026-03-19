<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Manage Products" scope="request"/>
<c:import url="${pageContext.request.contextPath}/WEB-INF/views/admin/AdminHeader.jsp">
    <c:param name="page" value="products"/>
</c:import>

<div class="manage-products-container">
    <!-- Header with Title and Add Button -->
    <div class="page-header">
        <div>
            <h1><i class="fas fa-box"></i> Manage Products</h1>
            <p class="subtitle">View and manage all your auction products</p>
        </div>
        <a href="${pageContext.request.contextPath}/newProduct" class="btn-add">
            <i class="fas fa-plus-circle"></i> Add New Product
        </a>
    </div>
    
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
    
    <!-- Search and Filter Bar -->
    <div class="filter-bar">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search products..." onkeyup="searchProducts()">
        </div>
        <div class="filter-options">
            <select id="statusFilter" class="filter-select" onchange="filterProducts()">
                <option value="all">All Status</option>
                <option value="ACTIVE">Active</option>
                <option value="INACTIVE">Inactive</option>
                <option value="SOLD">Sold</option>
                <option value="EXPIRED">Expired</option>
            </select>
            <select id="categoryFilter" class="filter-select" onchange="filterProducts()">
                <option value="all">All Categories</option>
                <c:forEach items="${categories}" var="cat">
                    <option value="${cat.categoryName}">${cat.categoryName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    
    <!-- Products Table -->
    <div class="table-card">
        <div class="table-responsive">
            <table class="table" id="productsTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Starting Price</th>
                        <th>Current Bid</th>
                        <th>Bids</th>
                        <th>Status</th>
                        <th>End Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr class="product-row" data-status="${product.status}" data-category="${product.category}">
                            <td>#${product.productId}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty product.mainImage}">
                                        <img src="${product.mainImage}" alt="${product.productName}" class="product-thumb">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-thumb-placeholder">
                                            <i class="fas fa-image"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <strong>${product.productName}</strong>
                                <c:if test="${not empty product.subcategory}">
                                    <br><small class="text-muted">${product.subcategory}</small>
                                </c:if>
                            </td>
                            <td>${product.category}</td>
                            <td><fmt:formatNumber value="${product.startingPrice}" type="currency" currencySymbol="$"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty product.currentBid}">
                                        <span class="current-bid"><fmt:formatNumber value="${product.currentBid}" type="currency" currencySymbol="$"/></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="no-bid">-</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><span class="bid-count">${product.bidCount}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.status == 'ACTIVE'}">
                                        <span class="status-badge status-active">Active</span>
                                    </c:when>
                                    <c:when test="${product.status == 'SOLD'}">
                                        <span class="status-badge status-sold">Sold</span>
                                    </c:when>
                                    <c:when test="${product.status == 'EXPIRED'}">
                                        <span class="status-badge status-expired">Expired</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-inactive">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${product.auctionEndDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <div class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/viewProduct?productId=${product.productId}" 
                                       class="btn-action btn-view" title="View">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/editProduct?productId=${product.productId}" 
                                       class="btn-action btn-edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <c:if test="${product.status == 'ACTIVE'}">
                                        <a href="${pageContext.request.contextPath}/deactivateProduct?productId=${product.productId}" 
                                           class="btn-action btn-deactivate" title="Deactivate">
                                            <i class="fas fa-ban"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${product.status != 'ACTIVE'}">
                                        <a href="${pageContext.request.contextPath}/activateProduct?productId=${product.productId}" 
                                           class="btn-action btn-activate" title="Activate">
                                            <i class="fas fa-check"></i>
                                        </a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/deleteProduct?productId=${product.productId}" 
                                       class="btn-action btn-delete" title="Delete"
                                       onclick="return confirm('Are you sure you want to delete this product?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty products}">
                        <tr>
                            <td colspan="10" class="empty-state">
                                <i class="fas fa-box-open"></i>
                                <h3>No Products Found</h3>
                                <p>Get started by adding your first product.</p>
                                <a href="${pageContext.request.contextPath}/newProduct" class="btn-empty-add">
                                    <i class="fas fa-plus"></i> Add New Product
                                </a>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
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
</div>

<style>
    .manage-products-container {
        padding: 20px;
        max-width: 1400px;
        margin: 0 auto;
    }
    
    /* Page Header */
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        background: white;
        padding: 25px 30px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .page-header h1 {
        color: #2d3748;
        font-size: 28px;
        font-weight: 600;
        margin-bottom: 5px;
    }
    
    .page-header h1 i {
        color: #667eea;
        margin-right: 10px;
    }
    
    .subtitle {
        color: #718096;
        font-size: 14px;
    }
    
    .btn-add {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 12px 25px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s;
        box-shadow: 0 5px 15px rgba(102,126,234,0.3);
    }
    
    .btn-add:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(102,126,234,0.4);
    }
    
    /* Alert Messages */
    .alert {
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .alert-success {
        background: #c6f6d5;
        color: #22543d;
        border-left: 4px solid #48bb78;
    }
    
    .alert-danger {
        background: #fed7d7;
        color: #742a2a;
        border-left: 4px solid #f56565;
    }
    
    /* Filter Bar */
    .filter-bar {
        background: white;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 20px;
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
        padding: 10px 35px 10px 15px;
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
    
    /* Table Card */
    .table-card {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        overflow: hidden;
    }
    
    .table-responsive {
        overflow-x: auto;
    }
    
    .table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .table th {
        text-align: left;
        padding: 15px 10px;
        background: #f7fafc;
        color: #4a5568;
        font-weight: 600;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid #e2e8f0;
    }
    
    .table td {
        padding: 15px 10px;
        border-bottom: 1px solid #e2e8f0;
        vertical-align: middle;
    }
    
    .table tr:hover {
        background: #f7fafc;
    }
    
    /* Product Thumbnail */
    .product-thumb {
        width: 50px;
        height: 50px;
        border-radius: 8px;
        object-fit: cover;
    }
    
    .product-thumb-placeholder {
        width: 50px;
        height: 50px;
        background: #e2e8f0;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #a0aec0;
        font-size: 20px;
    }
    
    .text-muted {
        color: #a0aec0;
        font-size: 12px;
    }
    
    /* Bid Styling */
    .current-bid {
        color: #48bb78;
        font-weight: 600;
    }
    
    .no-bid {
        color: #a0aec0;
    }
    
    .bid-count {
        background: #e2e8f0;
        padding: 3px 8px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
    }
    
    /* Status Badges */
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
    
    .status-sold {
        background: #feebc8;
        color: #744210;
    }
    
    .status-expired {
        background: #e2e8f0;
        color: #4a5568;
    }
    
    .status-inactive {
        background: #fed7d7;
        color: #742a2a;
    }
    
    /* Action Buttons */
    .action-buttons {
        display: flex;
        gap: 5px;
        flex-wrap: wrap;
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
    
    .btn-edit {
        background: #fff3cd;
        color: #856404;
    }
    
    .btn-deactivate {
        background: #fff3e0;
        color: #ef6c00;
    }
    
    .btn-activate {
        background: #d4edda;
        color: #155724;
    }
    
    .btn-delete {
        background: #f8d7da;
        color: #721c24;
    }
    
    .btn-action:hover {
        transform: translateY(-2px);
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }
    
    /* Empty State */
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
        margin-bottom: 20px;
    }
    
    .btn-empty-add {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-weight: 500;
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
    
    /* Responsive Design */
    @media (max-width: 768px) {
        .page-header {
            flex-direction: column;
            text-align: center;
            gap: 15px;
        }
        
        .filter-bar {
            flex-direction: column;
        }
        
        .search-box {
            width: 100%;
        }
        
        .filter-options {
            width: 100%;
            flex-direction: column;
        }
        
        .table td, .table th {
            min-width: 120px;
        }
        
        .action-buttons {
            flex-wrap: wrap;
        }
    }
</style>

<script>
    function searchProducts() {
        var input = document.getElementById("searchInput");
        var filter = input.value.toUpperCase();
        var table = document.getElementById("productsTable");
        var tr = table.getElementsByTagName("tr");
        
        for (var i = 1; i < tr.length; i++) {
            var tdArray = tr[i].getElementsByTagName("td");
            var found = false;
            
            for (var j = 0; j < tdArray.length; j++) {
                if (tdArray[j]) {
                    var textValue = tdArray[j].textContent || tdArray[j].innerText;
                    if (textValue.toUpperCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }
            }
            
            if (found) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
    
    function filterProducts() {
        var statusFilter = document.getElementById("statusFilter").value;
        var categoryFilter = document.getElementById("categoryFilter").value;
        var table = document.getElementById("productsTable");
        var tr = table.getElementsByTagName("tr");
        
        for (var i = 1; i < tr.length; i++) {
            var row = tr[i];
            var status = row.getAttribute("data-status");
            var category = row.getAttribute("data-category");
            
            var statusMatch = (statusFilter === "all" || status === statusFilter);
            var categoryMatch = (categoryFilter === "all" || category === categoryFilter);
            
            if (statusMatch && categoryMatch) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        }
    }
</script>

<c:import url="${pageContext.request.contextPath}/WEB-INF/views/admin/AdminFooter.jsp"/>