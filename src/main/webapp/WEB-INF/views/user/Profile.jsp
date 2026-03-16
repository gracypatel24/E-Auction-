<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
            padding: 30px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .profile-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #667eea;
            margin-bottom: 15px;
        }
        .profile-name {
            font-size: 24px;
            font-weight: 700;
            color: #333;
        }
        .profile-email {
            color: #6c757d;
        }
        .nav-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 10px;
        }
        .nav-tabs a {
            padding: 10px 20px;
            text-decoration: none;
            color: #495057;
            border-radius: 5px;
        }
        .nav-tabs a.active {
            background: #667eea;
            color: white;
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
            cursor: pointer;
            width: 100%;
        }
        .btn-save:hover {
            background: #5a67d8;
        }
        .nav-links {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .nav-links a {
            color: #667eea;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-card">
            <div class="profile-header">
                <img src="${user.profilePicURL != null ? user.profilePicURL : 'https://ui-avatars.com/api/?name='.concat(user.firstName).concat('+').concat(user.lastName).concat('&background=667eea&color=fff&size=120')}" 
                     class="profile-avatar">
                <h2 class="profile-name">${user.firstName} ${user.lastName}</h2>
                <p class="profile-email">${user.email}</p>
                <p class="profile-role">Role: ${user.role}</p>
            </div>
            
            <div class="nav-tabs">
                <a href="${pageContext.request.contextPath}/profile" class="active">Profile</a>
                <a href="${pageContext.request.contextPath}/user/my-bids">My Bids</a>
                <a href="${pageContext.request.contextPath}/user/won-auctions">Won Auctions</a>
            </div>
            
            <form action="${pageContext.request.contextPath}/profile/update" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control" name="firstName" value="${user.firstName}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" name="lastName" value="${user.lastName}">
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Contact Number</label>
                    <input type="text" class="form-control" name="contactNum" value="${user.contactNum}">
                </div>
                
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">City</label>
                            <input type="text" class="form-control" name="city" value="${userDetail.city}">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">State</label>
                            <input type="text" class="form-control" name="state" value="${userDetail.state}">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Country</label>
                            <input type="text" class="form-control" name="country" value="${userDetail.country}">
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Profile Picture</label>
                    <input type="file" class="form-control" name="profilePic" accept="image/*">
                </div>
                
                <button type="submit" class="btn-save">
                    <i class="fas fa-save"></i> Update Profile
                </button>
            </form>
            
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a> |
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </div>
</body>
</html>