<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Earnings" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="SellerHeader.jsp">
    <jsp:param name="page" value="earnings"/>
</jsp:include>

<div class="earnings-container" style="padding: 20px; max-width: 1400px; margin: 0 auto;">
    <!-- Page Header -->
    <div style="background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); border-radius: 15px; padding: 25px 30px; margin-bottom: 30px; color: white; box-shadow: 0 10px 30px rgba(251,191,36,0.3);">
        <h1 style="font-size: 28px; margin: 0;"><i class="fas fa-dollar-sign"></i> Earnings</h1>
        <p style="margin: 5px 0 0 0; opacity: 0.9;">Track your sales revenue</p>
    </div>
    
    <!-- Summary Cards -->
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 30px;">
        <div style="background: white; border-radius: 15px; padding: 25px; text-align: center; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
            <div style="font-size: 36px; font-weight: bold; color: #f59e0b;">$${totalEarnings}</div>
            <div style="color: #718096; margin-top: 5px;">Total Earnings</div>
        </div>
        <div style="background: white; border-radius: 15px; padding: 25px; text-align: center; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
            <div style="font-size: 36px; font-weight: bold; color: #f59e0b;">${soldItems}</div>
            <div style="color: #718096; margin-top: 5px;">Items Sold</div>
        </div>
        <div style="background: white; border-radius: 15px; padding: 25px; text-align: center; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
            <div style="font-size: 36px; font-weight: bold; color: #f59e0b;">$${avgPrice}</div>
            <div style="color: #718096; margin-top: 5px;">Average Price</div>
        </div>
    </div>
    
    <!-- Earnings Breakdown -->
    <div style="background: white; border-radius: 15px; padding: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow-x: auto;">
        <h3 style="color: #2d3748; margin-bottom: 20px;">Earnings Breakdown</h3>
        <table style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr style="background: #f7fafc; border-bottom: 2px solid #e2e8f0;">
                    <th style="padding: 15px; text-align: left;">Product</th>
                    <th style="padding: 15px; text-align: left;">Sold Date</th>
                    <th style="padding: 15px; text-align: left;">Buyer</th>
                    <th style="padding: 15px; text-align: right;">Amount</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty earnings}">
                        <c:forEach items="${earnings}" var="earning">
                            <tr style="border-bottom: 1px solid #e2e8f0;">
                                <td style="padding: 15px;">
                                    <strong>${earning.productName}</strong>
                                </td>
                                <td style="padding: 15px;"><fmt:formatDate value="${earning.soldDate}" pattern="MMM dd, yyyy"/></td>
                                <td style="padding: 15px;">${earning.buyerName}</td>
                                <td style="padding: 15px; text-align: right; font-weight: bold; color: #48bb78;">$${earning.amount}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                                <i class="fas fa-chart-line" style="font-size: 60px; margin-bottom: 20px; color: #cbd5e0;"></i>
                                <h3 style="color: #2d3748; font-size: 20px; margin-bottom: 10px;">No Earnings Data</h3>
                                <p>You haven't made any sales yet.</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="SellerFooter.jsp"/>