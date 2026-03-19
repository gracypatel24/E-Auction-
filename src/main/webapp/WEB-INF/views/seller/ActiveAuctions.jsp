<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Active Auctions" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="SellerHeader.jsp">
    <jsp:param name="page" value="active"/>
</jsp:include>

<div class="active-auctions-container" style="padding: 20px; max-width: 1400px; margin: 0 auto;">
    <!-- Page Header -->
    <div style="background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); border-radius: 15px; padding: 25px 30px; margin-bottom: 30px; color: white; box-shadow: 0 10px 30px rgba(251,191,36,0.3);">
        <h1 style="font-size: 28px; margin: 0;"><i class="fas fa-fire"></i> Active Auctions</h1>
        <p style="margin: 5px 0 0 0; opacity: 0.9;">Currently running auctions</p>
    </div>
    
    <!-- Active Auctions Grid -->
    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px;">
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach items="${products}" var="product">
                    <c:if test="${product.status == 'ACTIVE'}">
                        <div style="background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
                            <div style="height: 150px; background: #f59e0b; display: flex; align-items: center; justify-content: center; color: white; font-size: 48px;">
                                <i class="fas fa-box"></i>
                            </div>
                            <div style="padding: 20px;">
                                <h3 style="font-size: 18px; font-weight: 600; color: #2d3748; margin-bottom: 10px;">${product.productName}</h3>
                                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                    <span style="color: #718096;">Current Bid:</span>
                                    <span style="font-weight: bold; color: #f59e0b;">$${product.currentBid}</span>
                                </div>
                                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                    <span style="color: #718096;">Bids:</span>
                                    <span>${product.bidCount}</span>
                                </div>
                                <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                                    <span style="color: #718096;">Ends:</span>
                                    <span style="color: #f56565;"><i class="fas fa-clock"></i> <fmt:formatDate value="${product.auctionEndDate}" pattern="MMM dd, HH:mm"/></span>
                                </div>
                                <a href="${ctx}/viewProduct?productId=${product.productId}" style="display: block; text-align: center; background: #f59e0b; color: white; text-decoration: none; padding: 10px; border-radius: 8px; font-weight: 500;">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="grid-column: 1/-1; text-align: center; padding: 60px 20px; background: white; border-radius: 15px;">
                    <i class="fas fa-fire" style="font-size: 60px; color: #cbd5e0; margin-bottom: 20px;"></i>
                    <h3 style="color: #2d3748; font-size: 20px; margin-bottom: 10px;">No Active Auctions</h3>
                    <p style="color: #718096;">You don't have any active auctions right now.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="SellerFooter.jsp"/>