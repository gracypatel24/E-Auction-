<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Won Auctions - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
            padding: 30px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .page-header h2 {
            color: #333;
            margin: 0;
        }
        .page-header h2 i {
            color: #ffc107;
        }
        .btn-browse {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
        }
        .auction-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .auction-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            position: relative;
        }
        .winner-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #ffc107;
            color: #333;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 700;
            z-index: 1;
        }
        .auction-image {
            height: 180px;
            width: 100%;
            object-fit: cover;
        }
        .auction-details {
            padding: 20px;
        }
        .auction-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .winning-price {
            font-size: 24px;
            font-weight: 700;
            color: #ffc107;
            margin: 15px 0;
        }
        .btn-pay {
            background: #28a745;
            color: white;
            padding: 12px;
            border-radius: 8px;
            text-decoration: none;
            display: block;
            text-align: center;
            font-weight: 600;
        }
        .btn-pay:hover {
            background: #218838;
        }
        .btn-view {
            background: #e7f3ff;
            color: #004085;
            padding: 8px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 15px;
            grid-column: span 3;
        }
        .back-link {
            margin-top: 30px;
            text-align: center;
        }
        .back-link a {
            color: #6c757d;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="page-header">
            <h2><i class="fas fa-trophy"></i> Won Auctions</h2>
            <a href="${pageContext.request.contextPath}/listProduct" class="btn-browse">
                <i class="fas fa-gavel"></i> Browse More
            </a>
        </div>
        
        <!-- Won Auctions Grid -->
        <div class="auction-grid">
            <c:forEach items="${wonAuctions}" var="auction">
                <div class="auction-card">
                    <span class="winner-badge"><i class="fas fa-crown"></i> WINNER</span>
                    <img src="${auction.imageUrl}" class="auction-image" alt="${auction.title}">
                    <div class="auction-details">
                        <h3 class="auction-title">${auction.title}</h3>
                        <div class="winning-price">$${auction.winningBid}</div>
                        
                        <c:choose>
                            <c:when test="${auction.paymentStatus == 'PENDING'}">
                                <a href="${pageContext.request.contextPath}/payment/checkout?auctionId=${auction.id}" class="btn-pay">
                                    <i class="fas fa-credit-card"></i> Pay Now
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/payment/receipt?transactionId=${auction.transactionId}" class="btn-view">
                                    <i class="fas fa-receipt"></i> View Receipt
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty wonAuctions}">
                <div class="empty-state">
                    <i class="fas fa-trophy" style="font-size: 60px; color: #ccc;"></i>
                    <h4>No Won Auctions Yet</h4>
                    <p>Keep bidding! Your winning moment is just around the corner.</p>
                    <a href="${pageContext.request.contextPath}/listProduct" class="btn-browse" style="display: inline-block;">Start Bidding Now</a>
                </div>
            </c:if>
        </div>
        
        <!-- Back Link -->
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/user/dashboard">← Back to Dashboard</a>
        </div>
    </div>
</body>
</html>