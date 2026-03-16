<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Category - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
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
        h2 {
            color: #333;
            margin-bottom: 30px;
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
            border-radius: 8px;
        }
        .btn-save {
            background: #667eea;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
        }
        .btn-save:hover {
            background: #5a67d8;
        }
        .btn-cancel {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #6c757d;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-card">
            <h2><i class="fas fa-folder-plus"></i> Add New Category</h2>
            
            <form action="${pageContext.request.contextPath}/saveCategory" method="post">
                <div class="form-group">
                    <label class="form-label">Category Name</label>
                    <input type="text" class="form-control" name="categoryName" required>
                </div>
                <button type="submit" class="btn-save">Save Category</button>
            </form>
            
            <a href="${pageContext.request.contextPath}/listCategory" class="btn-cancel">
                ← Cancel
            </a>
        </div>
    </div>
</body>
</html>