<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bids - E-Auction</title>
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
        .btn-browse {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
        }
        .btn-browse:hover {
            background: #5a67d8;
        }
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th {
            border-bottom: 2px solid #667eea;
            padding: 15px 10px;
            text-align: left;
        }
        .table td {
            padding: 15px 10px;
            border-bottom: 1px solid #f0f0f0;
        }
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
        }
        .badge-success {
            background: #d4edda;
            color: #155724;
        }
        .badge-warning {
            background: #fff3cd;
            color: #856404;
        }
        .btn-view {
            background: #e7f3ff;
            color: #004085;
            padding: 5px 15px;
            border-radius: 5px;
            text-decoration: none;
        }
        .back-link {
            margin-top: 20px;
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
            <h2><i class="fas fa-list"></i> My Bids</h2>
            <a href="${pageContext.request.contextPath}/listProduct" class="btn-browse">
                <i class="fas fa-gavel"></i> Browse More Auctions
            </a>
        </div>
        
        <!-- Bids Table -->
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Your Bid</th>
                        <th>Current Bid</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${bids}" var="bid">
                        <tr>
                            <td>${bid.productTitle}</td>
                            <td><strong>$${bid.bidAmount}</strong></td>
                            <td>$${bid.currentBid}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${bid.status == 'WINNING'}">
                                        <span class="badge badge-success">Winning</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-warning">Outbid</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/viewProduct?productId=${bid.productId}" class="btn-view">
                                    View Auction
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Back Link -->
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/user/dashboard">← Back to Dashboard</a>
        </div>
    </div>
</body>
</html>