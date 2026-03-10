<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | Create Auction</title>
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <!-- Skydash Theme CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
  
  <style>
    body {
      background: #f4f7fc;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    .form-container {
      max-width: 800px;
      margin: 50px auto;
      background: white;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      padding: 30px;
    }
    
    .form-title {
      text-align: center;
      margin-bottom: 30px;
      color: #333;
      font-weight: 700;
    }
    
    .form-title span {
      color: #667eea;
    }
    
    .form-group {
      margin-bottom: 20px;
    }
    
    .form-group label {
      font-weight: 600;
      color: #495057;
      margin-bottom: 8px;
      display: block;
    }
    
    .form-control {
      height: 45px;
      border: 2px solid #e1e5eb;
      border-radius: 10px;
      padding: 0 15px;
      transition: all 0.3s;
    }
    
    .form-control:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      outline: none;
    }
    
    textarea.form-control {
      height: 100px;
      padding: 10px 15px;
      resize: vertical;
    }
    
    .btn-submit {
      width: 100%;
      height: 50px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
      margin-top: 20px;
    }
    
    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
    }
    
    .btn-cancel {
      width: 100%;
      height: 50px;
      background: #6c757d;
      color: white;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
      margin-top: 10px;
      text-align: center;
      display: block;
      line-height: 50px;
      text-decoration: none;
    }
    
    .btn-cancel:hover {
      background: #5a6268;
      color: white;
      text-decoration: none;
    }
    
    .alert {
      border-radius: 10px;
      padding: 15px 20px;
      margin-bottom: 20px;
    }
    
    .alert-success {
      background: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }
    
    .alert-danger {
      background: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }
  </style>
</head>

<body>
  <div class="container">
    <div class="form-container">
      <h2 class="form-title"><span>Create</span> New Auction</h2>
      
      <!-- Success/Error Messages -->
      <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
      </c:if>
      
      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>
      
      <!-- Add Auction Form -->
      <form action="${pageContext.request.contextPath}/saveProduct" method="post">
        
        <div class="form-group">
          <label for="title">Auction Title *</label>
          <input type="text" class="form-control" id="title" name="title" required 
                 placeholder="e.g. Vintage Rolex Submariner">
        </div>
        
        <div class="form-group">
          <label for="description">Description *</label>
          <textarea class="form-control" id="description" name="description" required 
                    placeholder="Describe your item in detail..."></textarea>
        </div>
        
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label for="category">Category *</label>
              <select class="form-control" id="category" name="category" required>
                <option value="">Select Category</option>
                <c:forEach items="${categories}" var="cat">
                  <option value="${cat}">${cat}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          
          <div class="col-md-6">
            <div class="form-group">
              <label for="startingBid">Starting Bid ($) *</label>
              <input type="number" class="form-control" id="startingBid" name="startingBid" 
                     required min="1" step="0.01" placeholder="100.00">
            </div>
          </div>
        </div>
        
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label for="startDate">Start Date *</label>
              <input type="date" class="form-control" id="startDate" name="startDate" 
                     required value="${java.time.LocalDate.now()}">
            </div>
          </div>
          
          <div class="col-md-6">
            <div class="form-group">
              <label for="endDate">End Date *</label>
              <input type="date" class="form-control" id="endDate" name="endDate" 
                     required min="${java.time.LocalDate.now().plusDays(1)}">
            </div>
          </div>
        </div>
        
        <div class="form-group">
          <label for="imageUrl">Image URL (Optional)</label>
          <input type="url" class="form-control" id="imageUrl" name="imageUrl" 
                 placeholder="https://example.com/image.jpg">
          <small class="text-muted">Leave empty to use default image</small>
        </div>
		<div class="form-group">
		  <label for="description">Description *</label>
		  <textarea class="form-control" id="description" name="description" 
		            required maxlength="5000" rows="5"
		            placeholder="Describe your item in detail..."></textarea>
		  <small class="text-muted">Maximum 5000 characters</small>
		</div>
        
        <button type="submit" class="btn-submit">
          <i class="ti-save mr-2"></i> Create Auction
        </button>
        
        <a href="${pageContext.request.contextPath}/listProduct" class="btn-cancel">
          <i class="ti-close mr-2"></i> Cancel
        </a>
      </form>
    </div>
  </div>
  
  <!-- Scripts -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
  
  <script>
    // Set min date for end date based on start date
    document.getElementById('startDate').addEventListener('change', function() {
      document.getElementById('endDate').min = this.value;
    });
  </script>
</body>
</html>