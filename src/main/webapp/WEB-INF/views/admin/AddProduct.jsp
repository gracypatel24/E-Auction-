<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<%-- Include the correct header based on role --%>
<c:choose>
    <c:when test="${userRole == 'SELLER'}">
        <jsp:include page="../seller/SellerHeader.jsp">
            <jsp:param name="page" value="products"/>
        </jsp:include>
    </c:when>
    <c:when test="${userRole == 'ADMIN'}">
        <jsp:include page="../admin/AdminHeader.jsp">
            <jsp:param name="page" value="products"/>
        </jsp:include>
    </c:when>
</c:choose>

<div class="add-product-container" style="padding: 20px; max-width: 1000px; margin: 0 auto;">
    <!-- Page Header - Color changes based on role -->
    <div style="background: linear-gradient(135deg, ${userRole == 'SELLER' ? '#fbbf24, #f59e0b' : '#667eea, #764ba2'}); border-radius: 15px; padding: 25px 30px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; color: white; box-shadow: 0 10px 30px rgba(0,0,0,0.3);">
        <div>
            <h1 style="font-size: 28px; margin: 0;"><i class="fas fa-plus-circle"></i> Add New Product</h1>
            <p style="margin: 5px 0 0 0; opacity: 0.9;">${userRole == 'SELLER' ? 'List your product for auction' : 'Add a new product to the system'}</p>
        </div>
        
        <%-- Back button based on role --%>
        <c:choose>
            <c:when test="${userRole == 'SELLER'}">
                <a href="${ctx}/seller/products" style="background: white; color: #f59e0b; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 600;">
                    <i class="fas fa-arrow-left"></i> Back to Products
                </a>
            </c:when>
            <c:when test="${userRole == 'ADMIN'}">
                <a href="${ctx}/admin/products" style="background: white; color: #667eea; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 600;">
                    <i class="fas fa-arrow-left"></i> Back to Products
                </a>
            </c:when>
        </c:choose>
    </div>
    
    <!-- Product Form -->
    <div style="background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
        <form action="${ctx}/saveProduct" method="post">
            
            <!-- Basic Information -->
            <div style="margin-bottom: 30px;">
                <h2 style="color: #2d3748; font-size: 18px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                    <i class="fas fa-info-circle" style="color: ${userRole == 'SELLER' ? '#f59e0b' : '#667eea'}; margin-right: 8px;"></i> Basic Information
                </h2>
                
                <div style="margin-bottom: 20px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Product Name <span style="color: #f56565;">*</span></label>
                    <input type="text" name="productName" required 
                           style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                </div>
                
                <div style="margin-bottom: 20px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Description</label>
                    <textarea name="description" rows="4" style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;"></textarea>
                </div>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Category <span style="color: #f56565;">*</span></label>
                        <select name="category" required style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                            <option value="">Select Category</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.categoryName}">${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Subcategory</label>
                        <input type="text" name="subcategory" style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                    </div>
                </div>
            </div>
            
            <!-- Pricing -->
            <div style="margin-bottom: 30px;">
                <h2 style="color: #2d3748; font-size: 18px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                    <i class="fas fa-tag" style="color: ${userRole == 'SELLER' ? '#f59e0b' : '#667eea'}; margin-right: 8px;"></i> Pricing & Auction
                </h2>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Starting Price ($) <span style="color: #f56565;">*</span></label>
                        <input type="number" name="startingPrice" step="0.01" min="0" required 
                               style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                    </div>
                    
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Buy Now Price ($)</label>
                        <input type="number" name="buyNowPrice" step="0.01" min="0" 
                               style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                    </div>
                </div>
                
                <div style="margin-top: 20px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Auction End Date <span style="color: #f56565;">*</span></label>
                    <input type="datetime-local" name="auctionEndDate" required 
                           style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                </div>
            </div>
            
            <%-- Admin-only: Seller selection --%>
            <c:if test="${userRole == 'ADMIN'}">
                <div style="margin-bottom: 30px;">
                    <h2 style="color: #2d3748; font-size: 18px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                        <i class="fas fa-user-tie" style="color: #667eea; margin-right: 8px;"></i> Seller Information
                    </h2>
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Seller Email</label>
                        <input type="email" name="sellerEmail" placeholder="seller@example.com"
                               style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                    </div>
                </div>
            </c:if>
            
            <!-- Images -->
            <div style="margin-bottom: 30px;">
                <h2 style="color: #2d3748; font-size: 18px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                    <i class="fas fa-image" style="color: ${userRole == 'SELLER' ? '#f59e0b' : '#667eea'}; margin-right: 8px;"></i> Product Images
                </h2>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Main Image URL</label>
                    <input type="url" name="mainImage" style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                </div>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Image 1</label>
                        <input type="url" name="image1" style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                    </div>
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Image 2</label>
                        <input type="url" name="image2" style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px;">
                    </div>
                </div>
            </div>
            
            <!-- Submit Button -->
            <div style="display: flex; gap: 15px;">
                <button type="submit" style="flex: 1; background: linear-gradient(135deg, ${userRole == 'SELLER' ? '#fbbf24, #f59e0b' : '#667eea, #764ba2'}); color: white; border: none; padding: 14px; border-radius: 8px; font-weight: 600; cursor: pointer; font-size: 16px;">
                    <i class="fas fa-save"></i> Save Product
                </button>
                <c:choose>
                    <c:when test="${userRole == 'SELLER'}">
                        <a href="${ctx}/seller/products" style="flex: 1; background: #e2e8f0; color: #4a5568; text-decoration: none; padding: 14px; border-radius: 8px; font-weight: 600; text-align: center;">Cancel</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/admin/products" style="flex: 1; background: #e2e8f0; color: #4a5568; text-decoration: none; padding: 14px; border-radius: 8px; font-weight: 600; text-align: center;">Cancel</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </form>
    </div>
</div>

<style>
    input:focus, select:focus, textarea:focus {
        outline: none;
        border-color: ${userRole == 'SELLER' ? '#f59e0b' : '#667eea'} !important;
        box-shadow: 0 0 0 3px ${userRole == 'SELLER' ? 'rgba(251,191,36,0.1)' : 'rgba(102,126,234,0.1)'};
    }
    
    button:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px ${userRole == 'SELLER' ? 'rgba(251,191,36,0.3)' : 'rgba(102,126,234,0.3)'};
    }
</style>

<c:choose>
    <c:when test="${userRole == 'SELLER'}">
        <jsp:include page="../seller/SellerFooter.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../admin/AdminFooter.jsp"/>
    </c:otherwise>
</c:choose>