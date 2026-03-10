<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${auction.title} - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', sans-serif;
        }
        
        .container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .back-link {
            margin-bottom: 20px;
            display: inline-block;
            color: #667eea;
            text-decoration: none;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .auction-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .auction-title {
            color: #333;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .auction-title span {
            color: #667eea;
        }
        
        .product-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .info-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
        }
        
        .info-value {
            color: #333;
            margin-bottom: 15px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .bid-amount {
            font-size: 32px;
            font-weight: 700;
            color: #28a745;
        }
        
        .status-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .status-active { background: #d4edda; color: #155724; }
        .status-completed { background: #d1ecf1; color: #0c5460; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        
        .bid-form {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-top: 20px;
        }
        
        .btn-bid {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
        }
        
        .btn-bid:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.4);
        }
        
        .btn-bid:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        
        .table thead th {
            border-bottom: 2px solid #667eea;
            color: #495057;
            font-weight: 600;
        }
        
        .badge-winning { background: #d4edda; color: #155724; }
        .badge-outbid { background: #f8d7da; color: #721c24; }
        
        .alert {
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .seller-info {
            background: #e7f3ff;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/listProduct" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Auctions
        </a>
        
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <!-- Main Auction Card -->
        <div class="auction-card">
            <h1 class="auction-title"><span>${auction.title}</span></h1>
            
            <div class="row">
                <div class="col-md-6">
                    <img src="${auction.imageUrl}" class="product-image" alt="${auction.title}">
                </div>
                
                <div class="col-md-6">
                    <div class="mb-4">
                        <span class="status-badge status-${auction.status.toLowerCase()}">
                            ${auction.status}
                        </span>
                    </div>
                    
                    <div class="info-label">Current Bid</div>
                    <div class="bid-amount">$${auction.currentBid}</div>
                    
                    <div class="info-label">Starting Bid</div>
                    <div class="info-value">$${auction.startingBid}</div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-label">Start Date</div>
                            <div class="info-value">${auction.startDate}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">End Date</div>
                            <div class="info-value">${auction.endDate}</div>
                        </div>
                    </div>
                    
                    <div class="info-label">Category</div>
                    <div class="info-value">
                        <span class="badge bg-info text-white">${auction.category}</span>
                    </div>
                    
                    <div class="info-label">Total Bids</div>
                    <div class="info-value">${bidCount}</div>
                    
                    <c:if test="${isActive && !isSeller}">
                        <!-- Bid Form for Participants -->
                        <div class="bid-form">
                            <h5>Place Your Bid</h5>
                            <form action="${pageContext.request.contextPath}/participant/place-bid" method="post">
                                <input type="hidden" name="productId" value="${auction.productId}">
                                <div class="mb-3">
                                    <label class="form-label">Your Bid Amount ($)</label>
                                    <input type="number" class="form-control" name="bidAmount" 
                                           min="${auction.currentBid + 1}" step="0.01" 
                                           placeholder="Minimum: $${auction.currentBid + 1}" required>
                                </div>
                                <button type="submit" class="btn-bid">
                                    <i class="fas fa-gavel"></i> Place Bid
                                </button>
                            </form>
                        </div>
                    </c:if>
                    
                    <c:if test="${isSeller}">
                        <div class="seller-info">
                            <i class="fas fa-info-circle text-primary"></i>
                            You are the seller of this auction.
                            <a href="${pageContext.request.contextPath}/editProduct?productId=${auction.productId}" 
                               class="btn btn-warning btn-sm ms-2">
                                <i class="fas fa-edit"></i> Edit Auction
                            </a>
                        </div>
                    </c:if>
                    
                    <c:if test="${!isActive}">
                        <div class="alert alert-warning mt-3">
                            <i class="fas fa-clock"></i> This auction is no longer active.
                        </div>
                    </c:if>
                </div>
            </div>
            
            <!-- Description -->
            <div class="mt-4">
                <h5>Description</h5>
                <p class="text-muted">${auction.description}</p>
            </div>
        </div>
        
        <!-- Bid History -->
        <div class="table-container">
            <h4 class="mb-4"><i class="fas fa-history"></i> Bid History</h4>
            
            <c:if test="${empty bids}">
                <p class="text-muted text-center py-4">No bids have been placed yet.</p>
            </c:if>
            
            <c:if test="${not empty bids}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Bidder</th>
                            <th>Amount</th>
                            <th>Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bids}" var="bid">
                            <tr>
                                <td>User #${bid.userId}</td>
                                <td><strong>$${bid.bidAmount}</strong></td>
                                <td>${bid.bidTime}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${bid.status == 'WINNING'}">
                                            <span class="badge badge-winning">Winning</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-outbid">Outbid</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</body>
</html>