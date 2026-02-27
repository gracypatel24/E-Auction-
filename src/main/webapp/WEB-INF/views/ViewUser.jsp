<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | User Details</title>
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
  
  <style>
    .profile-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 15px;
      padding: 40px;
      color: white;
      margin-bottom: 30px;
    }
    
    .profile-avatar {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      border: 4px solid white;
      margin-bottom: 20px;
    }
    
    .info-card {
      background: white;
      border-radius: 15px;
      padding: 25px;
      margin-bottom: 30px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .info-title {
      font-size: 16px;
      font-weight: 600;
      color: #495057;
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 2px solid #f0f0f0;
    }
    
    .info-row {
      display: flex;
      margin-bottom: 15px;
      padding: 10px 0;
      border-bottom: 1px solid #f0f0f0;
    }
    
    .info-label {
      width: 150px;
      color: #6c757d;
      font-weight: 500;
    }
    
    .info-value {
      flex: 1;
      color: #212529;
      font-weight: 500;
    }
    
    .status-badge {
      padding: 5px 15px;
      border-radius: 30px;
      font-size: 12px;
      font-weight: 600;
    }
    
    .status-active {
      background: #d4edda;
      color: #155724;
    }
    
    .status-inactive {
      background: #f8d7da;
      color: #721c24;
    }
    
    .role-badge {
      padding: 5px 20px;
      border-radius: 30px;
      font-size: 14px;
      font-weight: 600;
    }
    
    .role-admin { background: #dc3545; color: white; }
    .role-bidder { background: #28a745; color: white; }
    .role-seller { background: #ffc107; color: black; }
  </style>
</head>

<body>
  <div class="container-scroller">
    <!-- Navbar and Sidebar -->
    
    <div class="main-panel">
      <div class="content-wrapper">
        
        <!-- Profile Header -->
        <div class="profile-header">
          <div class="row align-items-center">
            <div class="col-md-8">
              <img src="${user.profilePicURL != null ? user.profilePicURL : 'https://via.placeholder.com/120x120/ffffff/667eea?text='.concat(user.firstName.charAt(0))}" 
                   class="profile-avatar" alt="avatar">
              <h2 class="mb-2">${user.firstName} ${user.lastName}</h2>
              <p class="mb-0"><i class="ti-email mr-2"></i>${user.email}</p>
              <p><i class="ti-mobile mr-2"></i>${user.contactNum != null ? user.contactNum : 'Not provided'}</p>
            </div>
            <div class="col-md-4 text-md-right">
              <span class="role-badge role-${user.role.toLowerCase()} mr-2">${user.role}</span>
              <c:choose>
                <c:when test="${user.active}">
                  <span class="status-badge status-active">Active</span>
                </c:when>
                <c:otherwise>
                  <span class="status-badge status-inactive">Inactive</span>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
        
        <div class="row">
          <!-- Personal Information -->
          <div class="col-md-6">
            <div class="info-card">
              <div class="info-title">
                <i class="ti-user mr-2 text-primary"></i>Personal Information
              </div>
              
              <div class="info-row">
                <div class="info-label">Full Name</div>
                <div class="info-value">${user.firstName} ${user.lastName}</div>
              </div>
              
              <div class="info-row">
                <div class="info-label">Gender</div>
                <div class="info-value">${user.gender != null ? user.gender : 'Not specified'}</div>
              </div>
              
              <div class="info-row">
                <div class="info-label">Birth Year</div>
                <div class="info-value">${user.birthYear != null ? user.birthYear : 'Not specified'}</div>
              </div>
              
              <div class="info-row">
                <div class="info-label">Member Since</div>
                <div class="info-value">${user.createdAt}</div>
              </div>
            </div>
          </div>
          
          <!-- Contact Information -->
          <div class="col-md-6">
            <div class="info-card">
              <div class="info-title">
                <i class="ti-location-pin mr-2 text-success"></i>Contact & Location
              </div>
              
              <div class="info-row">
                <div class="info-label">Email</div>
                <div class="info-value">${user.email}</div>
              </div>
              
              <div class="info-row">
                <div class="info-label">Phone</div>
                <div class="info-value">${user.contactNum != null ? user.contactNum : 'Not provided'}</div>
              </div>
              
              <div class="info-row">
                <div class="info-label">City</div>
                <div class="info-value">${userDetail.city != null ? userDetail.city : 'Not specified'}</div>
              </div>
              
              <div class="info-row">
                <div class="info-label">State</div>
                <div class="info-value">${userDetail.state != null ? userDetail.state : 'Not specified'}</div>
              </div>
              
              <div class="info-row">
                <div class="info-label">Country</div>
                <div class="info-value">${userDetail.country != null ? userDetail.country : 'Not specified'}</div>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Activity Summary -->
        <div class="row">
          <div class="col-md-12">
            <div class="info-card">
              <div class="info-title">
                <i class="ti-stats-up mr-2 text-warning"></i>Activity Summary
              </div>
              
              <div class="row text-center">
                <div class="col-md-3">
                  <h3 class="text-primary font-weight-bold">0</h3>
                  <p class="text-muted">Auctions Created</p>
                </div>
                <div class="col-md-3">
                  <h3 class="text-success font-weight-bold">0</h3>
                  <p class="text-muted">Bids Placed</p>
                </div>
                <div class="col-md-3">
                  <h3 class="text-info font-weight-bold">0</h3>
                  <p class="text-muted">Won Auctions</p>
                </div>
                <div class="col-md-3">
                  <h3 class="text-warning font-weight-bold">0</h3>
                  <p class="text-muted">Total Spent</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div class="text-center mt-4">
          <a href="${pageContext.request.contextPath}/listUser" class="btn btn-secondary">Back to Users</a>
          <button class="btn btn-primary">Edit Profile</button>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>