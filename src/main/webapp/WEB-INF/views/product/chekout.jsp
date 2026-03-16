<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
            padding: 30px;
        }
        
        .checkout-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .checkout-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        
        .checkout-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .checkout-header h2 {
            font-size: 28px;
            font-weight: 700;
            color: #333;
        }
        
        .checkout-header h2 span {
            color: #667eea;
        }
        
        .product-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            display: flex;
            gap: 20px;
        }
        
        .product-image {
            width: 100px;
            height: 100px;
            border-radius: 10px;
            object-fit: cover;
        }
        
        .product-details {
            flex: 1;
        }
        
        .product-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .product-price {
            font-size: 24px;
            font-weight: 700;
            color: #667eea;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .detail-label {
            color: #6c757d;
        }
        
        .detail-value {
            font-weight: 600;
            color: #333;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 20px 0;
            font-size: 20px;
            font-weight: 700;
            border-top: 2px solid #667eea;
            margin-top: 10px;
        }
        
        .total-amount {
            color: #667eea;
        }
        
        .payment-methods {
            margin: 30px 0;
        }
        
        .payment-method {
            border: 2px solid #e1e5eb;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .payment-method:hover {
            border-color: #667eea;
        }
        
        .payment-method.selected {
            border-color: #667eea;
            background: #f0f3ff;
        }
        
        .payment-method input[type="radio"] {
            margin-right: 15px;
        }
        
        .btn-pay {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(40, 167, 69, 0.3);
        }
        
        .btn-back {
            display: block;
            text-align: center;
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
    <div class="checkout-container">
        <div class="checkout-card">
            
            <!-- Header -->
            <div class="checkout-header">
                <h2><span>Checkout</span></h2>
                <p class="text-muted">Complete your payment to win the auction</p>
            </div>
            
            <!-- Product Summary -->
            <div class="product-summary">
                <img src="${product.imageUrl}" class="product-image" alt="${product.title}">
                <div class="product-details">
                    <div class="product-title">${product.title}</div>
                    <div class="product-price">$${product.currentBid}</div>
                </div>
            </div>
            
            <!-- Order Details -->
            <div class="detail-row">
                <span class="detail-label">Subtotal</span>
                <span class="detail-value">$${transaction.finalAmount}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Tax (10%)</span>
                <span class="detail-value">$${transaction.finalAmount * 0.1}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Shipping</span>
                <span class="detail-value">$10.00</span>
            </div>
            
            <div class="total-row">
                <span>Total Amount</span>
                <span class="total-amount">$${transaction.finalAmount * 1.1 + 10}</span>
            </div>
            
            <!-- Payment Form -->
            <form action="${pageContext.request.contextPath}/payment/process" method="post">
                <input type="hidden" name="transactionId" value="${transaction.transactionId}">
                
                <div class="payment-methods">
                    <h5 style="margin-bottom: 15px;">Select Payment Method</h5>
                    
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="credit_card" checked>
                        <i class="fab fa-cc-visa" style="color: #1a1f71;"></i>
                        <i class="fab fa-cc-mastercard" style="color: #eb001b;"></i>
                        Credit / Debit Card
                    </label>
                    
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="paypal">
                        <i class="fab fa-paypal" style="color: #003087;"></i>
                        PayPal
                    </label>
                    
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="bank_transfer">
                        <i class="fas fa-university"></i>
                        Bank Transfer
                    </label>
                </div>
                
                <button type="submit" class="btn-pay">
                    <i class="fas fa-lock"></i> Pay Now
                </button>
            </form>
            
            <a href="${pageContext.request.contextPath}/participant/won-auctions" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Won Auctions
            </a>
        </div>
    </div>
</body>
</html>