<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Auction | Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .login-container {
            width: 100%;
            max-width: 450px;
        }
        
        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            padding: 40px;
            width: 100%;
        }
        
        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo-section h2 {
            color: #333;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
        }
        
        .logo-section h2 span {
            color: #667eea;
        }
        
        .logo-section p {
            color: #6c757d;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #495057;
            font-weight: 500;
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            height: 52px;
            padding: 0 15px;
            border: 2px solid #e1e5eb;
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            outline: none;
        }
        
        .btn-login {
            width: 100%;
            height: 52px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 25px;
            text-align: center;
            font-size: 14px;
            border: 1px solid #f5c6cb;
        }
        
        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 25px 0 20px;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e1e5eb;
        }
        
        .divider span {
            padding: 0 15px;
            color: #6c757d;
            font-size: 13px;
            text-transform: uppercase;
        }
        
        .links {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-top: 20px;
        }
        
        .links a {
            color: #6c757d;
            text-decoration: none;
            font-size: 14px;
        }
        
        .links a:hover {
            color: #667eea;
        }
        
        .credentials-box {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
            border: 1px dashed #667eea;
        }
        
        .credentials-box h4 {
            color: #333;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 15px;
            text-align: center;
        }
        
        .credential-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #e1e5eb;
        }
        
        .credential-row:last-child {
            border-bottom: none;
        }
        
        .credential-label {
            color: #6c757d;
            font-size: 13px;
            font-weight: 500;
        }
        
        .credential-value {
            background: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            color: #667eea;
            border: 1px solid #667eea;
        }
        
        .fill-btn {
            text-align: center;
            margin-top: 15px;
        }
        
        .fill-btn button {
            background: none;
            border: 2px solid #667eea;
            color: #667eea;
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            margin: 0 5px;
        }
        
        .fill-btn button:hover {
            background: #667eea;
            color: white;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="logo-section">
                <h2>E<span>-Auction</span></h2>
                <p>Welcome back! Please login to your account</p>
            </div>
            
            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/authenticate" method="post">
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" class="form-control" name="email" 
                           value="gracypatel2446@gmail.com" required>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" class="form-control" name="password" 
                           value="admin123" required>
                </div>
                
                <button type="submit" class="btn-login">
                    Login to Dashboard
                </button>
            </form>
            
            <div class="divider">
                <span>OR</span>
            </div>
            
            <div class="links">
                <a href="${pageContext.request.contextPath}/signup">Create Account</a>
                <a href="${pageContext.request.contextPath}/forgetpassword">Forgot Password?</a>
            </div>
            
        </div>
    </div>
</body>
</html>