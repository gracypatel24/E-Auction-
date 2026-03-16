<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password - E-Auction System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .reset-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            width: 400px;
            max-width: 90%;
        }
        .reset-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .reset-header h2 {
            margin: 0;
            font-weight: 600;
        }
        .reset-header p {
            margin: 10px 0 0;
            opacity: 0.9;
        }
        .reset-body {
            padding: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }
        .btn-reset {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            width: 100%;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-reset:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102,126,234,0.4);
        }
        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-danger {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }
        .password-strength {
            margin-top: 5px;
            font-size: 12px;
        }
        .input-group {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
        }
    </style>
</head>
<body>
    <div class="reset-card">
        <div class="reset-header">
            <h2><i class="fas fa-gavel me-2"></i>E-Auction</h2>
            <p>Create new password</p>
        </div>
        <div class="reset-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/auth/reset-password" method="post">
                <input type="hidden" name="email" value="${email}">
                
                <div class="form-group">
                    <label><i class="fas fa-lock me-2"></i>New Password</label>
                    <div class="input-group">
                        <input type="password" name="password" id="password" 
                               class="form-control" placeholder="Enter new password" 
                               required onkeyup="checkPasswordStrength()">
                        <span class="toggle-password" onclick="togglePassword('password', 'toggleIcon1')">
                            <i class="far fa-eye" id="toggleIcon1"></i>
                        </span>
                    </div>
                    <div class="password-strength" id="strengthText"></div>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-lock me-2"></i>Confirm Password</label>
                    <div class="input-group">
                        <input type="password" name="confirmPassword" id="confirmPassword" 
                               class="form-control" placeholder="Confirm new password" 
                               required onkeyup="checkPasswordMatch()">
                        <span class="toggle-password" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                            <i class="far fa-eye" id="toggleIcon2"></i>
                        </span>
                    </div>
                    <div class="password-strength" id="matchText"></div>
                </div>
                
                <button type="submit" class="btn-reset" id="submitBtn">
                    <i class="fas fa-sync-alt me-2"></i>Reset Password
                </button>
            </form>
        </div>
    </div>
    
    <script>
        function togglePassword(fieldId, iconId) {
            const password = document.getElementById(fieldId);
            const toggleIcon = document.getElementById(iconId);
            
            if (password.type === 'password') {
                password.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]+/)) strength++;
            if (password.match(/[A-Z]+/)) strength++;
            if (password.match(/[0-9]+/)) strength++;
            if (password.match(/[$@#&!]+/)) strength++;
            
            if (password.length === 0) {
                strengthText.innerHTML = '';
            } else if (strength < 3) {
                strengthText.innerHTML = 'Weak password';
                strengthText.style.color = '#dc3545';
            } else if (strength < 5) {
                strengthText.innerHTML = 'Medium password';
                strengthText.style.color = '#ffc107';
            } else {
                strengthText.innerHTML = 'Strong password';
                strengthText.style.color = '#28a745';
            }
        }
        
        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirm = document.getElementById('confirmPassword').value;
            const matchText = document.getElementById('matchText');
            const submitBtn = document.getElementById('submitBtn');
            
            if (confirm.length === 0) {
                matchText.innerHTML = '';
                submitBtn.disabled = false;
            } else if (password === confirm) {
                matchText.innerHTML = '✓ Passwords match';
                matchText.style.color = '#28a745';
                submitBtn.disabled = false;
            } else {
                matchText.innerHTML = '✗ Passwords do not match';
                matchText.style.color = '#dc3545';
                submitBtn.disabled = true;
            }
        }
    </script>
</body>
</html>