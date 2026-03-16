<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
            padding: 30px;
        }
        
        .receipt-container {
            max-width: 700px;
            margin: 0 auto;
        }
        
        .receipt-card {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            text-align: center;
        }
        
        .success-icon {
            width: 80px;
            height: 80px;
            background: #d4edda;
            color: #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin: 0 auto 20px;
        }
        
        .receipt-header h2 {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        
        .receipt-header p {
            color: #6c757d;
            margin-bottom: 30px;
        }
        
        .receipt-details {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
            margin: 30px 0;
            text-align: left;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px dashed #dee2e6;
        }
        
        .detail-row:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: #6c757d;
            font-weight: 500;
        }
        
        .detail-value {
            font-weight: 600;
            color: #333;
        }
        
        .product-info {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            border-radius: 10px;
            object-fit: cover;
        }
        
        .product-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .btn-download {
            padding: 12px 30px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-download:hover {
            background: #5a67d8;
            color: white;
        }
        
        .btn-back {
            display: inline-block;
            margin-top: 20px;
            color: #6c757d;
            text-decoration: none;
        }
        
        .btn-back:hover {
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="receipt-container">
        <div class="receipt-card">
            
            <!-- Success Icon -->
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            
            <!-- Header -->
            <div class="receipt-header">
                <h2>Payment Successful!</h2>
                <p>Thank you for your purchase</p>
            </div>
            
            <!-- Product Info -->
            <div class="product-info">
                <img src="${product.imageUrl}" class="product-image" alt="${product.title}">
                <div style="text-align: left;">
                    <div class="product-title">${product.title}</div>
                    <p class="text-muted">${product.category}</p>
                </div>
            </div>
            
            <!-- Receipt Details -->
            <div class="receipt-details">
                <div class="detail-row">
                    <span class="detail-label">Transaction ID</span>
                    <span class="detail-value">#${transaction.transactionId}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Date</span>
                    <span class="detail-value">
                        <fmt:formatDate value="${transaction.transactionDate}" pattern="dd MMM yyyy HH:mm"/>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Payment Method</span>
                    <span class="detail-value">${param.paymentMethod}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Amount Paid</span>
                    <span class="detail-value" style="color: #28a745; font-size: 18px;">
                        $${transaction.finalAmount * 1.1 + 10}
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Status</span>
                    <span class="badge-success" style="padding: 5px 10px; border-radius: 20px;">
                        ${transaction.paymentStatus}
                    </span>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <a href="#" class="btn-download" onclick="window.print()">
                <i class="fas fa-download"></i> Download Receipt
            </a>
            
            <a href="${pageContext.request.contextPath}/participant/dashboard" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>