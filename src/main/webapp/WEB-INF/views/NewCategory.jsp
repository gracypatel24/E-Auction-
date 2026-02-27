<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | New Category</title>
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
  
  <style>
    .form-container {
      background: white;
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.05);
      max-width: 600px;
      margin: 0 auto;
    }
    
    .form-title {
      font-size: 24px;
      font-weight: 700;
      color: #333;
      margin-bottom: 30px;
      text-align: center;
    }
    
    .form-group {
      margin-bottom: 25px;
    }
    
    .form-label {
      font-weight: 600;
      color: #495057;
      margin-bottom: 8px;
      display: block;
    }
    
    .form-control {
      height: 50px;
      border: 2px solid #e1e5eb;
      border-radius: 10px;
      padding: 0 15px;
      width: 100%;
    }
    
    .form-control:focus {
      border-color: #667eea;
      outline: none;
    }
    
    .btn-submit {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      height: 50px;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      font-weight: 600;
      width: 100%;
      cursor: pointer;
    }
    
    .form-check {
      margin-top: 10px;
    }
  </style>
</head>

<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper">
      <div class="main-panel">
        <div class="content-wrapper">
          
          <div class="form-container">
            <h2 class="form-title">Add New Category</h2>
            
            <form action="${pageContext.request.contextPath}/saveCategory" method="post">
              <div class="form-group">
                <label class="form-label">Category Name</label>
                <input type="text" class="form-control" name="categoryName" placeholder="Enter category name" required>
              </div>
              
              <div class="form-group">
                <label class="form-label">Status</label>
                <div class="form-check">
                  <input type="checkbox" class="form-check-input" name="active" checked>
                  <label class="form-check-label">Active</label>
                </div>
              </div>
              
              <button type="submit" class="btn-submit">
                <i class="ti-save mr-2"></i>Save Category
              </button>
            </form>
          </div>
          
        </div>
      </div>
    </div>
  </div>
</body>
</html>