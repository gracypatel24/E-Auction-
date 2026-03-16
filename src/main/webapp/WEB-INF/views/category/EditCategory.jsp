<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 40px 0;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        .form-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .form-title {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-title span {
            color: #667eea;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            display: block;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5eb;
            border-radius: 10px;
            font-size: 15px;
        }
        .form-control:focus {
            border-color: #667eea;
            outline: none;
        }
        .form-check {
            margin: 20px 0;
        }
        .form-check-input {
            width: 18px;
            height: 18px;
            margin-right: 10px;
        }
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
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
    <div class="container">
        <div class="form-card">
            <h2 class="form-title"><span>Edit</span> Category</h2>
            
            <form action="${pageContext.request.contextPath}/updateCategory" method="post">
                <input type="hidden" name="categoryId" value="${category.categoryId}">
                
                <div class="form-group">
                    <label class="form-label">Category Name</label>
                    <input type="text" class="form-control" name="categoryName" 
                           value="${category.categoryName}" required>
                </div>
                
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" name="active" 
                           id="active" ${category.active ? 'checked' : ''}>
                    <label class="form-check-label" for="active">Active</label>
                </div>
                
                <button type="submit" class="btn-submit">
                    <i class="fas fa-save"></i> Update Category
                </button>
            </form>
            
            <a href="${pageContext.request.contextPath}/listCategory" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Categories
            </a>
        </div>
    </div>
</body>
</html>