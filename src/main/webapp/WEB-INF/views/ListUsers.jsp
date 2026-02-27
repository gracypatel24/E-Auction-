<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | Users</title>
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
  
  <style>
    .page-header {
      background: white;
      padding: 20px;
      border-radius: 15px;
      margin-bottom: 30px;
    }
    
    .table-container {
      background: white;
      border-radius: 15px;
      padding: 20px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .user-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      margin-right: 10px;
    }
    
    .role-badge {
      padding: 5px 12px;
      border-radius: 30px;
      font-size: 12px;
      font-weight: 500;
    }
    
    .role-admin { background: #dc3545; color: white; }
    .role-bidder { background: #28a745; color: white; }
    .role-seller { background: #ffc107; color: black; }
    .role-judge { background: #17a2b8; color: white; }
    
    .status-active {
      color: #28a745;
      font-weight: 600;
    }
    
    .status-inactive {
      color: #dc3545;
      font-weight: 600;
    }
  </style>
</head>

<body>
  <div class="container-scroller">
    <!-- Navbar and Sidebar same as dashboard -->
    
    <div class="main-panel">
      <div class="content-wrapper">
        
        <!-- Page Header -->
        <div class="page-header d-flex justify-content-between align-items-center">
          <div>
            <h2 class="font-weight-bold">Users Management</h2>
            <p class="text-muted">View and manage all platform users</p>
          </div>
          <div>
            <input type="text" class="form-control" placeholder="Search users..." style="width: 300px;">
          </div>
        </div>
        
        <!-- Users Table -->
        <div class="table-container">
          <div class="table-responsive">
            <table class="table table-hover">
              <thead>
                <tr>
                  <th>User</th>
                  <th>Email</th>
                  <th>Role</th>
                  <th>Status</th>
                  <th>Joined</th>
                  <th>Auctions</th>
                  <th>Bids</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${userList}" var="u">
                  <tr>
                    <td>
                      <div class="d-flex align-items-center">
                        <img src="${u.profilePicURL != null ? u.profilePicURL : 'https://via.placeholder.com/40x40/667eea/ffffff?text='.concat(u.firstName.charAt(0))}" 
                             class="user-avatar" alt="avatar">
                        <div>
                          <strong>${u.firstName} ${u.lastName}</strong>
                        </div>
                      </div>
                    </td>
                    <td>${u.email}</td>
                    <td>
                      <span class="role-badge role-${u.role.toLowerCase()}">${u.role}</span>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${u.active}">
                          <span class="status-active">● Active</span>
                        </c:when>
                        <c:otherwise>
                          <span class="status-inactive">● Inactive</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>${u.createdAt}</td>
                    <td><span class="badge badge-info">0</span></td>
                    <td><span class="badge badge-success">0</span></td>
                    <td>
                      <a href="${pageContext.request.contextPath}/viewUser?userId=${u.userId}" 
                         class="btn btn-sm btn-primary">View</a>
                      <button class="btn btn-sm btn-warning">Edit</button>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>