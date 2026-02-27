<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | Forgot Password</title>
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
  
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Segoe UI', sans-serif;
    }
    
    .forgot-card {
      background: white;
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0,0,0,0.2);
      width: 450px;
      padding: 40px;
      animation: slideUp 0.5s ease;
    }
    
    @keyframes slideUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
    
    .lock-icon {
      width: 80px;
      height: 80px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px;
      color: white;
      font-size: 40px;
    }
    
    h2 {
      color: #333;
      text-align: center;
      margin-bottom: 10px;
      font-weight: 700;
    }
    
    .subtitle {
      text-align: center;
      color: #6c757d;
      font-size: 14px;
      margin-bottom: 30px;
      line-height: 1.6;
    }
    
    .form-group {
      margin-bottom: 25px;
      position: relative;
    }
    
    .form-group i {
      position: absolute;
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #667eea;
      font-size: 18px;
    }
    
    .form-control {
      height: 50px;
      padding-left: 45px;
      border: 2px solid #e1e5eb;
      border-radius: 10px;
      font-size: 15px;
      width: 100%;
      transition: all 0.3s;
    }
    
    .form-control:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      outline: none;
    }
    
    .btn-reset {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      height: 50px;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      font-weight: 600;
      width: 100%;
      cursor: pointer;
      transition: all 0.3s;
    }
    
    .btn-reset:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
    }
    
    .message {
      background: #d4edda;
      color: #155724;
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 20px;
      text-align: center;
      font-size: 14px;
    }
    
    .back-to-login {
      text-align: center;
      margin-top: 25px;
    }
    
    .back-to-login a {
      color: #6c757d;
      text-decoration: none;
      font-size: 14px;
      transition: color 0.3s;
    }
    
    .back-to-login a:hover {
      color: #667eea;
    }
    
    .back-to-login i {
      margin-right: 5px;
    }
  </style>
</head>

<body>
  <div class="forgot-card">
    <div class="lock-icon">
      <i class="ti-lock"></i>
    </div>
    
    <h2>Forgot Password?</h2>
    <p class="subtitle">
      Don't worry! Enter your email address and we'll send you instructions to reset your password.
    </p>
    
    <% if(request.getAttribute("successMessage") != null) { %>
      <div class="message">
        <i class="ti-check mr-2"></i><%= request.getAttribute("successMessage") %>
      </div>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/forgetpassword" method="post">
      <div class="form-group">
        <i class="ti-email"></i>
        <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
      </div>
      
      <button type="submit" class="btn-reset">
        <i class="ti-email mr-2"></i>Send Reset Instructions
      </button>
    </form>
    
    <div class="back-to-login">
      <a href="${pageContext.request.contextPath}/login">
        <i class="ti-angle-left"></i>Back to Login
      </a>
    </div>
  </div>
</body>
</html>