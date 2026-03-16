<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .edit-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 600px;
            padding: 40px;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        h2 span {
            color: #667eea;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
            display: block;
        }
        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid #e1e5eb;
            border-radius: 10px;
        }
        .form-control:focus {
            border-color: #667eea;
            outline: none;
        }
        .form-check {
            margin-top: 10px;
        }
        .btn-save {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn-cancel {
            background: #6c757d;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            margin-top: 10px;
            text-decoration: none;
            display: block;
            text-align: center;
        }
        .btn-cancel:hover {
            background: #5a6268;
            color: white;
        }
    </style>
</head>
<body>
    <div class="edit-card">
        <h2><span>Edit</span> User</h2>
        
        <form action="${pageContext.request.contextPath}/updateUser" method="post">
            <input type="hidden" name="userId" value="${user.userId}">
            
            <div class="form-group">
                <label>First Name</label>
                <input type="text" class="form-control" name="firstName" value="${user.firstName}" required>
            </div>
            
            <div class="form-group">
                <label>Last Name</label>
                <input type="text" class="form-control" name="lastName" value="${user.lastName}" required>
            </div>
            
            <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" name="email" value="${user.email}" required>
            </div>
            
            <div class="form-group">
                <label>Contact Number</label>
                <input type="text" class="form-control" name="contactNum" value="${user.contactNum}">
            </div>
            
            <div class="form-group">
                <label>Gender</label>
                <select class="form-control" name="gender">
                    <option value="">Select Gender</option>
                    <option value="MALE" ${user.gender == 'MALE' ? 'selected' : ''}>Male</option>
                    <option value="FEMALE" ${user.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
                    <option value="OTHER" ${user.gender == 'OTHER' ? 'selected' : ''}>Other</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Birth Year</label>
                <input type="number" class="form-control" name="birthYear" value="${user.birthYear}" min="1900" max="2026">
            </div>
            
            <div class="form-group">
                <label>Status</label>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" name="active" ${user.active ? 'checked' : ''}>
                    <label class="form-check-label">Active</label>
                </div>
            </div>
            
            <button type="submit" class="btn-save">
                <i class="fas fa-save"></i> Update User
            </button>
        </form>
        
        <a href="${pageContext.request.contextPath}/listUser" class="btn-cancel">
            <i class="fas fa-times"></i> Cancel
        </a>
    </div>
</body>
</html>