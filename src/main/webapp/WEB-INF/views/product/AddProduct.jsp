<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Add Product" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<%
    // Determine which header to use based on user role
    String userRole = "";
    if (session.getAttribute("user") != null) {
        userRole = ((com.grownited.eauction.entity.UserEntity) session.getAttribute("user")).getUserType().getUserTypeName();
    }
    request.setAttribute("userRole", userRole);
%>

<c:choose>
    <c:when test="${userRole == 'SELLER'}">
        <jsp:include page="../seller/SellerHeader.jsp">
            <jsp:param name="page" value="add"/>
        </jsp:include>
    </c:when>
    <c:when test="${userRole == 'ADMIN'}">
        <jsp:include page="../admin/AdminHeader.jsp">
            <jsp:param name="page" value="products"/>
        </jsp:include>
    </c:when>
    <c:otherwise>
        <jsp:include page="../user/UserHeader.jsp">
            <jsp:param name="page" value="add"/>
        </jsp:include>
    </c:otherwise>
</c:choose>

<div class="add-product-container" style="padding: 20px; max-width: 1000px; margin: 0 auto;">
    <!-- Page Header -->
    <div style="background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); border-radius: 15px; padding: 25px 30px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; color: white; box-shadow: 0 10px 30px rgba(251,191,36,0.3);">
        <div>
            <h1 style="font-size: 28px; margin: 0;"><i class="fas fa-plus-circle"></i> Add New Product</h1>
            <p style="margin: 5px 0 0 0; opacity: 0.9;">Fill in the details to list your product</p>
        </div>
        <c:choose>
            <c:when test="${userRole == 'SELLER'}">
                <a href="${ctx}/seller/products" style="background: white; color: #f59e0b; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 8px;">
                    <i class="fas fa-arrow-left"></i> Back to Products
                </a>
            </c:when>
            <c:when test="${userRole == 'ADMIN'}">
                <a href="${ctx}/listProduct" style="background: white; color: #667eea; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 8px;">
                    <i class="fas fa-arrow-left"></i> Back to Products
                </a>
            </c:when>
            <c:otherwise>
                <a href="${ctx}/user/dashboard" style="background: white; color: #48bb78; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 8px;">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Product Form -->
    <div style="background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
        <form action="${ctx}/saveProduct" method="post" enctype="multipart/form-data">
            <!-- Basic Information -->
            <div style="margin-bottom: 30px;">
                <h2 style="color: #2d3748; font-size: 18px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                    <i class="fas fa-info-circle" style="color: #f59e0b; margin-right: 8px;"></i> Basic Information
                </h2>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Product Name <span style="color: #f56565;">*</span></label>
                        <input type="text" name="productName" required 
                               style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                    </div>
                    
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Category <span style="color: #f56565;">*</span></label>
                        <select name="category" required style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                            <option value="">Select Category</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.categoryName}">${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div style="margin-top: 20px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Description</label>
                    <textarea name="description" rows="4" style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px; resize: vertical;"></textarea>
                </div>
            </div>
            
            <!-- Pricing & Auction Details -->
            <div style="margin-bottom: 30px;">
                <h2 style="color: #2d3748; font-size: 18px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                    <i class="fas fa-tag" style="color: #f59e0b; margin-right: 8px;"></i> Pricing & Auction Details
                </h2>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Starting Price ($) <span style="color: #f56565;">*</span></label>
                        <input type="number" name="startingPrice" step="0.01" min="0" required 
                               style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                    </div>
                    
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Buy Now Price ($)</label>
                        <input type="number" name="buyNowPrice" step="0.01" min="0" 
                               style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                    </div>
                </div>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px;">
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Subcategory</label>
                        <input type="text" name="subcategory" 
                               style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                    </div>
                    
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Auction End Date <span style="color: #f56565;">*</span></label>
                        <input type="datetime-local" name="auctionEndDate" required 
                               style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                    </div>
                </div>
                
                <div style="margin-top: 20px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Status</label>
                    <select name="status" style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                        <option value="ACTIVE">Active</option>
                        <option value="INACTIVE">Inactive</option>
                        <option value="DRAFT">Draft</option>
                    </select>
                </div>
            </div>
            
            <!-- Product Images -->
            <div style="margin-bottom: 30px;">
                <h2 style="color: #2d3748; font-size: 18px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                    <i class="fas fa-image" style="color: #f59e0b; margin-right: 8px;"></i> Product Images
                </h2>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Main Image URL</label>
                    <input type="url" name="mainImage" placeholder="https://example.com/image.jpg"
                           style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                </div>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Additional Image 1</label>
                        <input type="url" name="image1" placeholder="https://example.com/image1.jpg"
                               style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                    </div>
                    
                    <div>
                        <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Additional Image 2</label>
                        <input type="url" name="image2" placeholder="https://example.com/image2.jpg"
                               style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                    </div>
                </div>
                
                <div style="margin-top: 15px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Additional Image 3</label>
                    <input type="url" name="image3" placeholder="https://example.com/image3.jpg"
                           style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                </div>
            </div>
            
            <!-- Submit Button -->
            <div style="display: flex; gap: 15px;">
                <button type="submit" style="flex: 1; background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); color: white; border: none; padding: 14px; border-radius: 8px; font-weight: 600; cursor: pointer; font-size: 16px;">
                    <i class="fas fa-save"></i> Save Product
                </button>
                <c:choose>
                    <c:when test="${userRole == 'SELLER'}">
                        <a href="${ctx}/seller/products" style="flex: 1; background: #e2e8f0; color: #4a5568; text-decoration: none; padding: 14px; border-radius: 8px; font-weight: 600; text-align: center;">
                            Cancel
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/listProduct" style="flex: 1; background: #e2e8f0; color: #4a5568; text-decoration: none; padding: 14px; border-radius: 8px; font-weight: 600; text-align: center;">
                            Cancel
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </form>
    </div>
</div>

<style>
    /* Form field focus effects */
    input:focus, select:focus, textarea:focus {
        outline: none;
        border-color: #f59e0b !important;
        box-shadow: 0 0 0 3px rgba(251,191,36,0.1);
    }
    
    /* Button hover effects */
    button:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(251,191,36,0.3);
    }
    
    a:hover {
        transform: translateY(-2px);
    }
    
    /* Responsive design */
    @media (max-width: 768px) {
        .add-product-container {
            padding: 10px;
        }
        
        .add-product-container > div:first-child {
            flex-direction: column;
            text-align: center;
            gap: 15px;
        }
        
        .add-product-container > div:first-child a {
            width: 100%;
            justify-content: center;
        }
        
        div[style*="grid-template-columns: 1fr 1fr"] {
            grid-template-columns: 1fr;
        }
        
        div[style*="display: flex; gap: 15px"] {
            flex-direction: column;
        }
    }
</style>

<c:choose>
    <c:when test="${userRole == 'SELLER'}">
        <jsp:include page="../seller/SellerFooter.jsp"/>
    </c:when>
    <c:when test="${userRole == 'ADMIN'}">
        <jsp:include page="../admin/AdminFooter.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="../user/UserFooter.jsp"/>
    </c:otherwise>
</c:choose>