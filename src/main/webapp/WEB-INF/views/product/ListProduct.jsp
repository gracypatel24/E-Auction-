<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Auctions - E-Auction</title>
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
        .header {
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .header h2 {
            margin: 0;
            color: #333;
        }
        .btn-add {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
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
        .product-thumb {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            object-fit: cover;
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
        .btn-view {
            background: #e7f3ff;
            color: #004085;
            padding: 5px 15px;
            border-radius: 5px;
            text-decoration: none;
        }
        .btn-edit {
            background: #fff3cd;
            color: #856404;
            padding: 5px 15px;
            border-radius: 5px;
            text-decoration: none;
        }
        .btn-delete {
            background: #f8d7da;
            color: #721c24;
            padding: 5px 15px;
            border-radius: 5px;
            text-decoration: none;
        }
        .back-link {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h2><i class="fas fa-gavel"></i> Auction Management</h2>
            <a href="${pageContext.request.contextPath}/newProduct" class="btn-add">
                <i class="fas fa-plus"></i> Create Auction
            </a>
        </div>
        
        <!-- Products Table -->
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Current Bid</th>
                        <th>Bids</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${allAuctions}" var="product">
                        <tr>
                            <td>
                                <img src="${product.imageUrl}" class="product-thumb">
                            </td>
                            <td>${product.title}</td>
                            <td>${product.category}</td>
                            <td><strong>$${product.currentBid}</strong></td>
                            <td>${product.bidCount}</td>
                            <td>
                                <c:if test="${product.status == 'ACTIVE'}">
                                    <span class="badge badge-success">Active</span>
                                </c:if>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/viewProduct?productId=${product.productId}" 
                                   class="btn-view">View</a>
                                <a href="${pageContext.request.contextPath}/editProduct?productId=${product.productId}" 
                                   class="btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/deleteProduct?productId=${product.productId}" 
                                   class="btn-delete" 
                                   onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Back Link -->
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/admin-dashboard">← Back to Dashboard</a>
        </div>
    </div>
</body>
</html>