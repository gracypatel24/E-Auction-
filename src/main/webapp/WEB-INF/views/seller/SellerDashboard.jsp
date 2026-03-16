<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
            padding: 30px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        
        .header h2 {
            font-size: 28px;
            font-weight: 700;
            color: #333;
        }
        
        .header h2 span {
            color: #667eea;
        }
        
        .btn-add {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 25px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
        }
        
        .stats-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }
        
        .stat-icon.blue {
            background: rgba(102,126,234,0.1);
            color: #667eea;
        }
        
        .stat-icon.green {
            background: rgba(40,167,69,0.1);
            color: #28a745;
        }
        
        .stat-icon.orange {
            background: rgba(255,193,7,0.1);
            color: #ffc107;
        }
        
        .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: #333;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 14px;
        }
        
        .section-title {
            font-size: 22px;
            font-weight: 700;
            color: #333;
            margin: 30px 0 20px;
        }
        
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table th {
            border-bottom: 2px solid #667eea;
            padding: 15px 10px;
            text-align: left;
            color: #495057;
            font-weight: 600;
        }
        
        .table td {
            padding: 15px 10px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
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
            padding: 5px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h2><span>Seller</span> Dashboard</h2>
            <a href="${pageContext.request.contextPath}/seller/product/new" class="btn-add">
                <i class="fas fa-plus"></i> List New Product
            </a>
        </div>
        
        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon blue">
                    <i class="fas fa-box"></i>
                </div>
                <div>
                    <div class="stat-value">${totalListings}</div>
                    <div class="stat-label">Total Listings</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon green">
                    <i class="fas fa-clock"></i>
                </div>
                <div>
                    <div class="stat-value">${totalActive}</div>
                    <div class="stat-label">Active</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon orange">
                    <i class="fas fa-gavel"></i>
                </div>
                <div>
                    <div class="stat-value">${totalBids}</div>
                    <div class="stat-label">Total Bids</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon" style="background: rgba(40,167,69,0.1); color: #28a745;">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div>
                    <div class="stat-value">$${totalRevenue}</div>
                    <div class="stat-label">Revenue</div>
                </div>
            </div>
        </div>
        
        <!-- Active Listings -->
        <h3 class="section-title">Active Listings</h3>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Current Bid</th>
                        <th>Bids</th>
                        <th>End Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${activeListings}" var="product">
                        <tr>
                            <td>${product.title}</td>
                            <td>$${product.currentBid}</td>
                            <td>${product.bidCount}</td>
                            <td>${product.endDate}</td>
                            <td><span class="badge badge-success">Active</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/seller/product/view?id=${product.productId}" 
                                   class="btn-view">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Sold Items -->
        <h3 class="section-title">Sold Items (${totalSold})</h3>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Final Price</th>
                        <th>Bids</th>
                        <th>Sold Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${soldItems}" var="product">
                        <tr>
                            <td>${product.title}</td>
                            <td>$${product.currentBid}</td>
                            <td>${product.bidCount}</td>
                            <td>${product.endDate}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/seller/product/view?id=${product.productId}" 
                                   class="btn-view">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>