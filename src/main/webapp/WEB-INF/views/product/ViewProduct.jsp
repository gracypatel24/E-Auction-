<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.title} - E-Auction</title>
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
        .back-link {
            margin-bottom: 20px;
        }
        .back-link a {
            color: #6c757d;
            text-decoration: none;
        }
        .product-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .product-image {
            width: 100%;
            max-height: 400px;
            object-fit: contain;
            border-radius: 10px;
            background: #f8f9fa;
            padding: 20px;
        }
        .product-title {
            font-size: 28px;
            font-weight: 700;
            color: #333;
        }
        .product-price {
            font-size: 36px;
            font-weight: 700;
            color: #667eea;
        }
        .bid-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            padding: 25px;
            color: white;
            margin-top: 20px;
        }
        .bid-form {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        .bid-input {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
        }
        .btn-bid {
            background: white;
            color: #667eea;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-bid:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .btn-edit {
            background: #fff3cd;
            color: #856404;
            padding: 8px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin-right: 10px;
        }
        .btn-delete {
            background: #f8d7da;
            color: #721c24;
            padding: 8px 20px;
            border-radius: 5px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Back Link -->
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/listProduct">← Back to Auctions</a>
        </div>
        
        <!-- Product Details -->
        <div class="product-card">
            <div class="row">
                <div class="col-md-6">
                    <img src="${product.imageUrl}" class="product-image">
                </div>
                <div class="col-md-6">
                    <h1 class="product-title">${product.title}</h1>
                    <p>${product.description}</p>
                    <p><strong>Category:</strong> ${product.category}</p>
                    <p><strong>Start Date:</strong> ${product.startDate}</p>
                    <p><strong>End Date:</strong> ${product.endDate}</p>
                    <p><strong>Total Bids:</strong> ${product.bidCount}</p>
                    
                    <div class="product-price">$${product.currentBid}</div>
                    
                    <!-- Admin/Seller Actions -->
                    <c:if test="${sessionScope.userRole == 'ADMIN' || sessionScope.userId == product.sellerId}">
                        <div style="margin-top: 20px;">
                            <a href="${pageContext.request.contextPath}/editProduct?productId=${product.productId}" 
                               class="btn-edit">Edit Auction</a>
                            <a href="${pageContext.request.contextPath}/deleteProduct?productId=${product.productId}" 
                               class="btn-delete" 
                               onclick="return confirm('Are you sure?')">Delete Auction</a>
                        </div>
                    </c:if>
                    
                    <!-- Bid Section -->
                    <c:if test="${sessionScope.userRole == 'BIDDER' && product.status == 'ACTIVE'}">
                        <div class="bid-section">
                            <h4>Place Your Bid</h4>
                            <form action="${pageContext.request.contextPath}/bid/place" method="post" class="bid-form">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <input type="number" class="bid-input" name="bidAmount" 
                                       placeholder="Enter bid amount" min="${product.currentBid + 1}" step="0.01" required>
                                <button type="submit" class="btn-bid">Place Bid</button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>