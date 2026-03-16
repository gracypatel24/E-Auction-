<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        .signup-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            width: 450px;
            max-width: 100%;
            padding: 40px;
        }
        .signup-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .signup-header h2 {
            color: #333;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .signup-header p {
            color: #666;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            height: 45px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            padding: 0 15px;
            width: 100%;
            font-size: 14px;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }
        .btn-signup {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            height: 45px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102,126,234,0.4);
        }
        .alert {
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .alert-danger {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }
        .login-footer {
            text-align: center;
            margin-top: 20px;
        }
        .login-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .login-footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="signup-card">
        <div class="signup-header">
            <h2>📝 Create Account</h2>
            <p>Join E-Auction today and start bidding</p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/auth/register" method="post">
            <div class="form-group">
                <input type="email" name="email" class="form-control" 
                       placeholder="Email Address" required>
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" 
                       placeholder="Password" required>
            </div>
            <div class="form-group">
                <input type="password" name="confirmPassword" class="form-control" 
                       placeholder="Confirm Password" required>
            </div>
            <button type="submit" class="btn-signup">Create Account</button>
        </form>
        
        <div class="login-footer">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login">Login</a></p>
        </div>
    </div>
</body>
</html>