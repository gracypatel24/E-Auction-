<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | Sign Up</title>
  
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
    
    .signup-container {
      width: 100%;
      max-width: 800px;
    }
    
    .signup-card {
      background: white;
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0,0,0,0.2);
      padding: 40px;
      width: 100%;
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
    
    .form-row {
      display: flex;
      gap: 20px;
      margin-bottom: 20px;
    }
    
    .form-group {
      flex: 1;
      margin-bottom: 0;
    }
    
    .form-group.full-width {
      flex: 0 0 100%;
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
      height: 45px;
      padding: 0 15px;
      border: 2px solid #e1e5eb;
      border-radius: 10px;
      font-size: 14px;
      transition: all 0.3s;
    }
    
    .form-control:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
      outline: none;
    }
    
    select.form-control {
      appearance: none;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%236c757d' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
      background-repeat: no-repeat;
      background-position: right 15px center;
    }
    
    .btn-signup {
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
      margin-top: 20px;
    }
    
    .btn-signup:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
    }
    
    .login-link {
      text-align: center;
      margin-top: 25px;
      color: #6c757d;
      font-size: 14px;
    }
    
    .login-link a {
      color: #667eea;
      text-decoration: none;
      font-weight: 600;
    }
    
    .login-link a:hover {
      text-decoration: underline;
    }
    
    .password-strength {
      margin-top: 5px;
      font-size: 12px;
    }
    
    .strength-weak {
      color: #dc3545;
    }
    
    .strength-medium {
      color: #ffc107;
    }
    
    .strength-strong {
      color: #28a745;
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
    
    .success-message {
      background: #d4edda;
      color: #155724;
      padding: 15px;
      border-radius: 12px;
      margin-bottom: 25px;
      text-align: center;
      font-size: 14px;
      border: 1px solid #c3e6cb;
    }
    
    .info-box {
      background: #e7f3ff;
      color: #004085;
      padding: 15px;
      border-radius: 12px;
      margin-bottom: 25px;
      text-align: center;
      font-size: 14px;
      border: 1px solid #b8daff;
    }
    
    .role-badge {
      display: inline-block;
      padding: 5px 12px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      margin-left: 10px;
    }
    
    .role-admin {
      background: #dc3545;
      color: white;
    }
    
    .role-bidder {
      background: #28a745;
      color: white;
    }
    
    .role-seller {
      background: #ffc107;
      color: black;
    }
  </style>
</head>

<body>
  <div class="signup-container">
    <div class="signup-card">
      
      <!-- Logo Section -->
      <div class="logo-section">
        <h2>E<span>-Auction</span></h2>
        <p>Create your account and start bidding today!</p>
      </div>
      
      
      <!-- Error/Success Messages -->
      <% if(request.getAttribute("error") != null) { %>
        <div class="error-message">
          <%= request.getAttribute("error") %>
        </div>
      <% } %>
      
      <% if(request.getAttribute("success") != null) { %>
        <div class="success-message">
          <%= request.getAttribute("success") %>
        </div>
      <% } %>
      
      <!-- Registration Form -->
      <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
        
        <!-- Name Row -->
        <div class="form-row">
          <div class="form-group">
            <label for="firstName">First Name *</label>
            <input type="text" class="form-control" id="firstName" name="firstName" 
                   placeholder="Enter first name" required>
          </div>
          
          <div class="form-group">
            <label for="lastName">Last Name *</label>
            <input type="text" class="form-control" id="lastName" name="lastName" 
                   placeholder="Enter last name" required>
          </div>
        </div>
        
        <!-- Email -->
        <div class="form-row">
          <div class="form-group full-width">
            <label for="email">Email Address *</label>
            <input type="email" class="form-control" id="email" name="email" 
                   placeholder="Enter your email" required>
          </div>
        </div>
        
        <!-- Password Row -->
        <div class="form-row">
          <div class="form-group">
            <label for="password">Password *</label>
            <input type="password" class="form-control" id="password" name="password" 
                   placeholder="Create password" required minlength="6">
          </div>
          
          <div class="form-group">
            <label for="confirmPassword">Confirm Password *</label>
            <input type="password" class="form-control" id="confirmPassword" 
                   placeholder="Confirm password" required minlength="6">
          </div>
        </div>
        <div class="password-strength" id="strengthIndicator"></div>
        
        <!-- Contact and Birth Year -->
        <div class="form-row">
          <div class="form-group">
            <label for="contactNum">Contact Number</label>
            <input type="tel" class="form-control" id="contactNum" name="contactNum" 
                   placeholder="Enter contact number">
          </div>
          
          <div class="form-group">
            <label for="birthYear">Birth Year</label>
            <input type="number" class="form-control" id="birthYear" name="birthYear" 
                   placeholder="YYYY" min="1900" max="2026">
          </div>
        </div>
        
        <!-- Gender and User Type -->
        <div class="form-row">
          <div class="form-group">
            <label for="gender">Gender</label>
            <select class="form-control" id="gender" name="gender">
              <option value="">Select Gender</option>
              <option value="MALE">Male</option>
              <option value="FEMALE">Female</option>
              <option value="OTHER">Other</option>
            </select>
          </div>
          
          <div class="form-group">
            <label for="userTypeId">
              Role * 
              <span class="role-badge role-admin">Admin</span>
              <span class="role-badge role-bidder">Bidder</span>
              <span class="role-badge role-seller">Seller</span>
            </label>
            <select class="form-control" id="userTypeId" name="userTypeId" required>
              <option value="">Select Your Role</option>
              <c:forEach items="${allUserType}" var="type">
                <option value="${type.userTypeId}">${type.userType}</option>
              </c:forEach>
            </select>
          </div>
        </div>
        
        <!-- Location -->
        <div class="form-row">
          <div class="form-group">
            <label for="city">City</label>
            <input type="text" class="form-control" id="city" name="city" 
                   placeholder="Enter city">
          </div>
          
          <div class="form-group">
            <label for="state">State</label>
            <input type="text" class="form-control" id="state" name="state" 
                   placeholder="Enter state">
          </div>
        </div>
        
        <!-- Country -->
        <div class="form-row">
          <div class="form-group full-width">
            <label for="country">Country</label>
            <input type="text" class="form-control" id="country" name="country" 
                   placeholder="Enter country" value="India">
          </div>
        </div>
        
        <!-- Profile Picture -->
        <div class="form-row">
          <div class="form-group full-width">
            <label for="profilePic">Profile Picture (Optional)</label>
            <input type="file" class="form-control" id="profilePic" name="profilePic" 
                   accept="image/*" style="padding-top: 10px;">
          </div>
        </div>
        
        <!-- Terms and Conditions -->
        <p style="font-size: 12px; color: #6c757d; text-align: center; margin: 15px 0;">
          By creating an account, you agree to our 
          <a href="#" style="color: #667eea; text-decoration: none;">Terms of Service</a> and 
          <a href="#" style="color: #667eea; text-decoration: none;">Privacy Policy</a>
        </p>
        
        <!-- Submit Button -->
        <button type="submit" class="btn-signup" id="submitBtn">
          Create Account
        </button>
      </form>
      
      <!-- Login Link -->
      <div class="login-link">
        Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>
      </div>
      
  
  <script>
    // Password strength checker
    const password = document.getElementById('password');
    const confirm = document.getElementById('confirmPassword');
    const strengthIndicator = document.getElementById('strengthIndicator');
    const submitBtn = document.getElementById('submitBtn');
    
    password.addEventListener('input', checkPasswordStrength);
    confirm.addEventListener('input', checkPasswordMatch);
    
    function checkPasswordStrength() {
      const val = password.value;
      let strength = 'weak';
      let message = '';
      
      if (val.length >= 8 && /[A-Z]/.test(val) && /[0-9]/.test(val) && /[^A-Za-z0-9]/.test(val)) {
        strength = 'strong';
        message = 'Strong password';
      } else if (val.length >= 6 && (/[A-Z]/.test(val) || /[0-9]/.test(val))) {
        strength = 'medium';
        message = 'Medium password';
      } else if (val.length > 0) {
        strength = 'weak';
        message = 'Weak password';
      } else {
        strengthIndicator.innerHTML = '';
        return;
      }
      
      strengthIndicator.innerHTML = message;
      strengthIndicator.className = 'password-strength strength-' + strength;
    }
    
    function checkPasswordMatch() {
      if (confirm.value.length > 0) {
        if (password.value !== confirm.value) {
          confirm.style.borderColor = '#dc3545';
          submitBtn.disabled = true;
          submitBtn.style.opacity = '0.5';
          submitBtn.style.cursor = 'not-allowed';
        } else {
          confirm.style.borderColor = '#28a745';
          submitBtn.disabled = false;
          submitBtn.style.opacity = '1';
          submitBtn.style.cursor = 'pointer';
        }
      } else {
        confirm.style.borderColor = '#e1e5eb';
      }
    }
    
    // Form validation
    document.querySelector('form').addEventListener('submit', function(e) {
      if (password.value !== confirm.value) {
        e.preventDefault();
        alert('Passwords do not match!');
      }
    });
  </script>
</body>
</html>