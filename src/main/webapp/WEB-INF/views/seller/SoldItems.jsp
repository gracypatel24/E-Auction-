<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Sold Items" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="SellerHeader.jsp">
    <jsp:param name="page" value="sold"/>
</jsp:include>

<div class="sold-items-container" style="padding: 20px; max-width: 1400px; margin: 0 auto;">
    <!-- Page Header -->
    <div style="background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); border-radius: 15px; padding: 25px 30px; margin-bottom: 30px; color: white; box-shadow: 0 10px 30px rgba(251,191,36,0.3);">
        <h1 style="font-size: 28px; margin: 0;"><i class="fas fa-check-circle"></i> Sold Items</h1>
        <p style="margin: 5px 0 0 0; opacity: 0.9;">Items that have been sold</p>
    </div>
    
    <!-- Sold Items Table -->
    <div style="background: white; border-radius: 15px; padding: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow-x: auto;">
        <table style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr style="background: #f7fafc; border-bottom: 2px solid #e2e8f0;">
                    <th style="padding: 15px; text-align: left;">Product</th>
                    <th style="padding: 15px; text-align: left;">Sold Price</th>
                    <th style="padding: 15px; text-align: left;">Buyer</th>
                    <th style="padding: 15px; text-align: left;">Sold Date</th>
                    <th style="padding: 15px; text-align: left;">Status</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty soldItems}">
                        <c:forEach items="${soldItems}" var="item">
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="padding: 15px;">
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <div style="width: 40px; height: 40px; background: #f59e0b; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white;">
                                            <i class="fas fa-box"></i>
                                        </div>
                                        <strong>${item.productName}</strong>
                                    </div>
                                </td>
                                <td style="padding: 15px; font-weight: bold; color: #48bb78;">$${item.soldPrice}</td>
                                <td style="padding: 15px;">${item.buyerName}</td>
                                <td style="padding: 15px;"><fmt:formatDate value="${item.soldDate}" pattern="MMM dd, yyyy"/></td>
                                <td style="padding: 15px;">
                                    <span style="background: #48bb78; color: white; padding: 4px 12px; border-radius: 20px; font-size: 12px;">Completed</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                                <i class="fas fa-check-circle" style="font-size: 60px; margin-bottom: 20px; color: #cbd5e0;"></i>
                                <h3 style="color: #2d3748; font-size: 20px; margin-bottom: 10px;">No Sold Items</h3>
                                <p>You haven't sold any items yet.</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="SellerFooter.jsp"/>