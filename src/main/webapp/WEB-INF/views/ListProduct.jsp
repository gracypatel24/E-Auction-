<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | Products</title>
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  
  <style>
    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      gap: 25px;
      padding: 20px 0;
    }
    
    .product-card {
      background: white;
      border-radius: 15px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      transition: all 0.3s;
      position: relative;
    }
    
    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.2);
    }
    
    .product-badge {
      position: absolute;
      top: 15px;
      right: 15px;
      padding: 5px 15px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      z-index: 1;
    }
    
    .badge-active { background: #28a745; color: white; }
    .badge-pending { background: #ffc107; color: black; }
    .badge-ended { background: #dc3545; color: white; }
    
    .product-image {
      height: 200px;
      width: 100%;
      object-fit: cover;
    }
    
    .product-details {
      padding: 20px;
    }
    
    .product-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 10px;
      color: #333;
    }
    
    .product-meta {
      display: flex;
      justify-content: space-between;
      margin-bottom: 15px;
      font-size: 14px;
      color: #6c757d;
    }
    
    .bid-info {
      background: #f8f9fa;
      padding: 15px;
      border-radius: 10px;
      margin: 15px 0;
    }
    
    .current-bid {
      font-size: 20px;
      font-weight: 700;
      color: #667eea;
    }
    
    .btn-view {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      padding: 10px;
      border-radius: 8px;
      width: 100%;
      cursor: pointer;
      transition: all 0.3s;
    }
    
    .btn-view:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
    }
    
    .filter-bar {
      background: white;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 30px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
  </style>
</head>

<body>
  <div class="container-scroller">
    <!-- Same navbar as dashboard -->
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo mr-5" href="${pageContext.request.contextPath}/admin-dashboard">
          <img src="${pageContext.request.contextPath}/assets/skydash/images/logo.svg" class="mr-2" alt="logo"/>
          <span style="font-weight: 700; color: #667eea;">E-Auction</span>
        </a>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
        <ul class="navbar-nav navbar-nav-right">
          <li class="nav-item nav-profile dropdown">
            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">
              <img src="${pageContext.request.contextPath}/assets/skydash/images/faces/face28.jpg" alt="profile"/>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown">
              <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                <i class="ti-power-off text-primary"></i> Logout
              </a>
            </div>
          </li>
        </ul>
      </div>
    </nav>
    
    <div class="container-fluid page-body-wrapper">
      <!-- Same sidebar as dashboard -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">
              <i class="icon-grid menu-icon"></i>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/listProduct">
              <i class="ti-gavel menu-icon"></i>
              <span class="menu-title">Products</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/listCategory">
              <i class="ti-layout menu-icon"></i>
              <span class="menu-title">Categories</span>
            </a>
          </li>
        </ul>
      </nav>
      
      <div class="main-panel">
        <div class="content-wrapper">
          
          <!-- Page Header -->
          <div class="row mb-4">
            <div class="col-md-8">
              <h2 class="font-weight-bold">All Auctions</h2>
              <p class="text-muted">Browse and manage all auction items</p>
            </div>
            <div class="col-md-4 text-right">
              <a href="${pageContext.request.contextPath}/newProduct" class="btn btn-primary">
                <i class="ti-plus mr-2"></i>Create Auction
              </a>
            </div>
          </div>
          
          <!-- Filter Bar -->
          <div class="filter-bar">
            <div class="row align-items-center">
              <div class="col-md-3">
                <select class="form-control">
                  <option>All Categories</option>
                  <option>Electronics</option>
                  <option>Art</option>
                  <option>Vehicles</option>
                </select>
              </div>
              <div class="col-md-3">
                <select class="form-control">
                  <option>All Status</option>
                  <option>Active</option>
                  <option>Ending Soon</option>
                  <option>Completed</option>
                </select>
              </div>
              <div class="col-md-4">
                <input type="text" class="form-control" placeholder="Search auctions...">
              </div>
              <div class="col-md-2">
                <button class="btn btn-primary btn-block">Filter</button>
              </div>
            </div>
          </div>
          
          <!-- Products Grid -->
          <div class="product-grid">
            <c:forEach items="${allProduct}" var="p">
              <div class="product-card">
                <span class="product-badge badge-${p.status.toLowerCase()}">${p.status}</span>
                <img src="https://via.placeholder.com/300x200/667eea/ffffff?text=${p.title}" class="product-image" alt="${p.title}">
                <div class="product-details">
                  <h3 class="product-title">${p.title}</h3>
                  <div class="product-meta">
                    <span><i class="ti-location-pin mr-1"></i>${p.location}</span>
                    <span><i class="ti-user mr-1"></i>${p.eventType}</span>
                  </div>
                  <div class="bid-info">
                    <div class="d-flex justify-content-between">
                      <span>Current Bid</span>
                      <span class="current-bid">$2,450</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                      <span>Bids</span>
                      <span class="badge badge-primary">12 bids</span>
                    </div>
                  </div>
                  <button class="btn-view" onclick="location.href='${pageContext.request.contextPath}/viewProduct?productId=${p.productId}'">
                    View Auction
                  </button>
                </div>
              </div>
            </c:forEach>
          </div>
          
        </div>
      </div>
    </div>
  </div>
  
  <script src="${pageContext.request.contextPath}/assets/skydash/vendors/js/vendor.bundle.base.js"></script>
  <script src="${pageContext.request.contextPath}/assets/skydash/js/off-canvas.js"></script>
  <script src="${pageContext.request.contextPath}/assets/skydash/js/hoverable-collapse.js"></script>
  <script src="${pageContext.request.contextPath}/assets/skydash/js/template.js"></script>
</body>
</html