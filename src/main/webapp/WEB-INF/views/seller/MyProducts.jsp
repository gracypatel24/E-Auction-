<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="My Products" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="SellerHeader.jsp">
    <jsp:param name="page" value="products"/>
</jsp:include>

<div class="products-container" style="padding: 20px; max-width: 1400px; margin: 0 auto;">
    <!-- Page Header with Add Product Button -->
    <div style="background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); border-radius: 15px; padding: 25px 30px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; color: white; box-shadow: 0 10px 30px rgba(251,191,36,0.3);">
        <div>
            <h1 style="font-size: 28px; margin: 0 0 5px 0;"><i class="fas fa-box"></i> My Products</h1>
            <p style="margin: 0; opacity: 0.9;">Manage all your product listings</p>
        </div>
        <!-- ADD PRODUCT BUTTON -->
        <a href="${ctx}/newProduct" style="background: white; color: #f59e0b; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; box-shadow: 0 5px 15px rgba(0,0,0,0.2); transition: all 0.3s;">
            <i class="fas fa-plus-circle"></i> Add New Product
        </a>
    </div>
    
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div style="background: #c6f6d5; color: #22543d; padding: 15px; border-radius: 10px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div style="background: #fed7d7; color: #742a2a; padding: 15px; border-radius: 10px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
    
    <!-- Search Bar -->
    <div style="background: white; border-radius: 10px; padding: 15px; margin-bottom: 20px; display: flex; gap: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
        <div style="flex: 1; position: relative;">
            <i class="fas fa-search" style="position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #a0aec0;"></i>
            <input type="text" id="searchInput" placeholder="Search products..." 
                   style="width: 100%; padding: 12px 15px 12px 45px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
        </div>
        <select id="statusFilter" style="padding: 12px 35px 12px 15px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px; background: white;">
            <option value="all">All Status</option>
            <option value="ACTIVE">Active</option>
            <option value="SOLD">Sold</option>
            <option value="INACTIVE">Inactive</option>
        </select>
    </div>
    
    <!-- Products Table -->
    <div style="background: white; border-radius: 15px; padding: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow-x: auto;">
        <table style="width: 100%; border-collapse: collapse;" id="productsTable">
            <thead>
                <tr style="background: #f7fafc; border-bottom: 2px solid #e2e8f0;">
                    <th style="padding: 15px 10px; text-align: left;">Product</th>
                    <th style="padding: 15px 10px; text-align: left;">Category</th>
                    <th style="padding: 15px 10px; text-align: left;">Price</th>
                    <th style="padding: 15px 10px; text-align: left;">Bids</th>
                    <th style="padding: 15px 10px; text-align: left;">Status</th>
                    <th style="padding: 15px 10px; text-align: left;">End Date</th>
                    <th style="padding: 15px 10px; text-align: left;">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach items="${products}" var="product">
                            <tr style="border-bottom: 1px solid #e2e8f0;" data-status="${product.status}">
                                <td style="padding: 15px 10px;">
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <div style="width: 40px; height: 40px; background: #f59e0b; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white;">
                                            <i class="fas fa-box"></i>
                                        </div>
                                        <strong>${product.productName}</strong>
                                    </div>
                                </td>
                                <td style="padding: 15px 10px;">${product.category}</td>
                                <td style="padding: 15px 10px; font-weight: bold; color: #f59e0b;">$${product.currentBid}</td>
                                <td style="padding: 15px 10px;">${product.bidCount}</td>
                                <td style="padding: 15px 10px;">
                                    <c:choose>
                                        <c:when test="${product.status == 'ACTIVE'}">
                                            <span style="background: #c6f6d5; color: #22543d; padding: 4px 12px; border-radius: 20px; font-size: 12px;">Active</span>
                                        </c:when>
                                        <c:when test="${product.status == 'SOLD'}">
                                            <span style="background: #feebc8; color: #744210; padding: 4px 12px; border-radius: 20px; font-size: 12px;">Sold</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="background: #fed7d7; color: #742a2a; padding: 4px 12px; border-radius: 20px; font-size: 12px;">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 15px 10px;"><fmt:formatDate value="${product.auctionEndDate}" pattern="MMM dd, yyyy"/></td>
                                <td style="padding: 15px 10px;">
                                    <div style="display: flex; gap: 5px;">
                                        <a href="${ctx}/viewProduct?productId=${product.productId}" style="width: 32px; height: 32px; border-radius: 6px; background: #e3f2fd; color: #1976d2; display: flex; align-items: center; justify-content: center; text-decoration: none;" title="View">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${ctx}/editProduct?productId=${product.productId}" style="width: 32px; height: 32px; border-radius: 6px; background: #fff3cd; color: #856404; display: flex; align-items: center; justify-content: center; text-decoration: none;" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${ctx}/deleteProduct?productId=${product.productId}" style="width: 32px; height: 32px; border-radius: 6px; background: #f8d7da; color: #721c24; display: flex; align-items: center; justify-content: center; text-decoration: none;" title="Delete" onclick="return confirm('Are you sure you want to delete this product?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                                <i class="fas fa-box-open" style="font-size: 60px; margin-bottom: 20px; color: #cbd5e0;"></i>
                                <h3 style="color: #2d3748; font-size: 20px; margin-bottom: 10px;">No Products Found</h3>
                                <p>You haven't listed any products yet.</p>
                                <a href="${ctx}/newProduct" style="display: inline-block; margin-top: 20px; background: #f59e0b; color: white; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 600;">
                                    <i class="fas fa-plus-circle"></i> Add Your First Product
                                </a>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<script>
document.getElementById('searchInput').addEventListener('keyup', function() {
    var input = this.value.toUpperCase();
    var rows = document.querySelectorAll('#productsTable tbody tr');
    
    rows.forEach(row => {
        var text = row.textContent.toUpperCase();
        row.style.display = text.includes(input) ? '' : 'none';
    });
});

document.getElementById('statusFilter').addEventListener('change', function() {
    var filter = this.value;
    var rows = document.querySelectorAll('#productsTable tbody tr');
    
    rows.forEach(row => {
        if (filter === 'all' || row.dataset.status === filter) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
});
</script>

<jsp:include page="SellerFooter.jsp"/>