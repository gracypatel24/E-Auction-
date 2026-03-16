<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <h2>User Dashboard</h2>
        <p>Welcome, ${pageContext.request.userPrincipal.name}!</p>
        
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">My Bids</h5>
                        <p class="card-text display-4">${myBids}</p>
                    </div>
                </div>
            </div>
        </div>
        
        <h3 class="mt-4">Recent Bids</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${recentBids}" var="bid">
                    <tr>
                        <td>${bid.product.title}</td>
                        <td>₹${bid.bidAmount}</td>
                        <td>${bid.bidTime}</td>
                        <td>
                            <c:if test="${bid.isWinning}">
                                <span class="badge bg-success">Winning</span>
                            </c:if>
                            <c:if test="${!bid.isWinning}">
                                <span class="badge bg-secondary">Outbid</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>