<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>E-Auction | Users Management</title>
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/feather/feather.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/skydash/css/vertical-layout-light/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
  
  <style>
    body { background: #f4f7fc; font-family: 'Segoe UI', sans-serif; }
    
    .main-panel { margin-left: 250px; margin-top: 70px; padding: 30px; }
    
    .header {
      background: white; height: 70px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 30px; position: fixed; top: 0; right: 0; left: 250px; z-index: 99;
    }
    
    .header-title { font-size: 20px; font-weight: 600; }
    .header-title span { color: #667eea; }
    
    .sidebar {
      width: 250px; background: white; box-shadow: 2px 0 10px rgba(0,0,0,0.05);
      position: fixed; left: 0; top: 0; bottom: 0; z-index: 100; overflow-y: auto;
    }
    
    .sidebar-menu { list-style: none; padding: 20px 0; }
    
    .profile-section {
      display: flex; align-items: center; padding: 20px;
      border-bottom: 1px solid #f0f0f0; margin-bottom: 10px;
    }
    
    .dummy-logo {
      width: 45px; height: 45px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 50%; display: flex; align-items: center; justify-content: center;
      color: white; font-weight: 700; margin-right: 12px;
    }
    
    .nav-item { margin: 5px 15px; border-radius: 10px; }
    .nav-item:hover { background: #f0f3ff; }
    .nav-item.active { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    .nav-item.active .nav-link { color: white; }
    
    .nav-link {
      display: flex; align-items: center; padding: 12px 15px;
      color: #495057; text-decoration: none; font-weight: 500;
    }
    
    .nav-link i { margin-right: 12px; }
    
    .page-header {
      background: white; padding: 20px; border-radius: 15px; margin-bottom: 30px;
      display: flex; justify-content: space-between; align-items: center;
    }
    
    .page-header h2 span { color: #667eea; }
    
    .search-box {
      width: 300px; position: relative;
    }
    
    .search-box input {
      width: 100%; height: 45px; padding: 0 15px 0 45px;
      border: 2px solid #e1e5eb; border-radius: 10px;
    }
    
    .search-box i {
      position: absolute; left: 15px; top: 50%; transform: translateY(-50%);
      color: #667eea;
    }
    
    .table-container {
      background: white; border-radius: 15px; padding: 20px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .table thead th {
      border-bottom: 2px solid #667eea; color: #495057;
      font-weight: 600; font-size: 13px; text-transform: uppercase;
    }
    
    .table tbody td { vertical-align: middle; padding: 15px 10px; }
    
    .user-avatar {
      width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;
      object-fit: cover;
    }
    
    .role-badge {
      padding: 5px 12px; border-radius: 30px; font-size: 12px; font-weight: 500;
      display: inline-block;
    }
    
    .role-ADMIN { background: #dc3545; color: white; }
    .role-PARTICIPANT { background: #28a745; color: white; }
    .role-JUDGE { background: #ffc107; color: black; }
    
    .status-active { color: #28a745; font-weight: 600; }
    .status-inactive { color: #dc3545; font-weight: 600; }
    
    .badge { padding: 5px 10px; border-radius: 30px; font-size: 11px; }
    .badge-info { background: #17a2b8; color: white; }
    
    .btn-action {
      padding: 6px 12px; border-radius: 5px; font-size: 12px; margin: 0 3px;
      border: none; cursor: pointer; text-decoration: none; display: inline-block;
    }
    
    .btn-view { background: #e7f3ff; color: #004085; }
    .btn-edit { background: #fff3cd; color: #856404; }
    .btn-disable { background: #f8d7da; color: #721c24; }
    
    .stats-card {
      background: white; border-radius: 15px; padding: 20px; text-align: center;
      box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 30px;
    }
    
    .stats-card h3 { font-size: 32px; font-weight: 700; color: #667eea; margin: 10px 0 5px; }
    
    .footer {
      background: white; padding: 20px; border-radius: 15px; margin-top: 30px;
      text-align: center; color: #6c757d;
    }
  </style>
</head>
<body>

<!-- Header -->
<header class="header">
  <div class="header-left">
    <div class="header-title"><span>Users</span> Management</div>
  </div>
  <div class="header-right">
    <div class="user-profile">
      <span>${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
    </div>
  </div>
</header>

<!-- Sidebar -->
<div class="sidebar">
  <div class="sidebar-menu">
    <div class="profile-section">
      <div class="dummy-logo">
        ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
      </div>
      <div>
        <div style="font-weight: 600;">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
        <div style="font-size: 12px; color: #667eea;">${sessionScope.user.role}</div>
      </div>
    </div>

    <div class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">
        <i class="ti-dashboard"></i> Dashboard
      </a>
    </div>
    <div class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/listProduct">
        <i class="ti-gavel"></i> Auctions
      </a>
    </div>
    <div class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/listCategory">
        <i class="ti-layout"></i> Categories
      </a>
    </div>
    <div class="nav-item active">
      <a class="nav-link" href="${pageContext.request.contextPath}/listUser">
        <i class="ti-user"></i> Users
      </a>
    </div>
    <div class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/newUserType">
        <i class="ti-user"></i> User Types
      </a>
    </div>
    <div class="nav-item" style="margin-top: 20px;">
      <a class="nav-link" href="${pageContext.request.contextPath}/logout">
        <i class="ti-power-off"></i> Logout
      </a>
    </div>
  </div>
</div>

<!-- Main Content -->
<div class="main-panel">
  
  <!-- Page Header -->
  <div class="page-header">
    <h2><span>Users</span> Management</h2>
    <div class="search-box">
      <i class="ti-search"></i>
      <input type="text" id="searchInput" placeholder="Search users..." onkeyup="searchUsers()">
    </div>
  </div>
  
  <!-- Success/Error Messages -->
  <c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <i class="ti-check mr-2"></i> ${success}
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
  </c:if>
  
  <c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <i class="ti-alert mr-2"></i> ${error}
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
  </c:if>
  
  <!-- Statistics Row -->
  <div class="row">
    <div class="col-md-3">
      <div class="stats-card">
        <i class="ti-user" style="font-size: 40px; color: #667eea;"></i>
        <h3>${totalUsers}</h3>
        <p>Total Users</p>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stats-card">
        <i class="ti-user" style="font-size: 40px; color: #28a745;"></i>
        <h3>${activeUsers}</h3>
        <p>Active Users</p>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stats-card">
        <i class="ti-user" style="font-size: 40px; color: #ffc107;"></i>
        <h3>${participantCount}</h3>
        <p>Participants</p>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stats-card">
        <i class="ti-user" style="font-size: 40px; color: #dc3545;"></i>
        <h3>${adminCount}</h3>
        <p>Admins</p>
      </div>
    </div>
  </div>
  
  <!-- Users Table -->
  <div class="table-container">
    <h4 class="mb-4"><i class="ti-user mr-2 text-primary"></i> All Users</h4>
    
    <div class="table-responsive">
      <table class="table table-hover" id="usersTable">
        <thead>
          <tr>
            <th>User</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
            <th>Joined</th>
            <th>Contact</th>
            <th>Auctions</th>
            <th>Bids</th>
            <th>Actions</th>
          </tr>
        </thead>
		<tbody>
		  <c:forEach items="${userList}" var="user">
		    <tr>
		      <td>
		        <div style="display: flex; align-items: center;">
		          <img src="${user.profilePicURL != null ? user.profilePicURL : 'https://via.placeholder.com/40x40/667eea/ffffff?text='.concat(user.firstName.charAt(0))}" 
		               class="user-avatar" alt="avatar">
		          <div>
		            <strong>${user.firstName} ${user.lastName}</strong>
		          </div>
		        </div>
		      </td>
		      <td>${user.email}</td>
		      <td>
		        <span class="role-badge role-${user.role}">${user.role}</span>
		      </td>
		      <td>
		        <c:choose>
		          <c:when test="${user.active}">
		            <span class="status-active">● Active</span>
		          </c:when>
		          <c:otherwise>
		            <span class="status-inactive">● Inactive</span>
		          </c:otherwise>
		        </c:choose>
		      </td>
		      <td>${user.createdAt}</td>  <!-- FIXED: removed fmt:formatDate -->
		      <td>${user.contactNum != null ? user.contactNum : '—'}</td>
		      <td><span class="badge badge-info">${user.auctionCount != null ? user.auctionCount : 0}</span></td>
		      <td><span class="badge badge-success">${user.bidCount != null ? user.bidCount : 0}</span></td>
		      <td>
		        <a href="${pageContext.request.contextPath}/viewUser?userId=${user.userId}" 
		           class="btn-action btn-view" title="View">
		          <i class="ti-eye"></i>
		        </a>
		        <a href="${pageContext.request.contextPath}/editUser?userId=${user.userId}" 
		           class="btn-action btn-edit" title="Edit">
		          <i class="ti-pencil"></i>
		        </a>
		        <c:choose>
		          <c:when test="${user.active}">
		            <a href="#" onclick="toggleUserStatus(${user.userId}, false)" 
		               class="btn-action btn-disable" title="Disable">
		              <i class="ti-close"></i>
		            </a>
		          </c:when>
		          <c:otherwise>
		            <a href="#" onclick="toggleUserStatus(${user.userId}, true)" 
		               class="btn-action btn-edit" title="Enable">
		              <i class="ti-check"></i>
		            </a>
		          </c:otherwise>
		        </c:choose>
		      </td>
		    </tr>
		  </c:forEach>
		</tbody>
      </table>
    </div>
  </div>
  
  <!-- Back to Dashboard -->
  <div class="text-center mb-4">
    <a href="${pageContext.request.contextPath}/admin-dashboard" class="btn btn-secondary">
      <i class="ti-arrow-left mr-2"></i> Back to Dashboard
    </a>
  </div>
  
  <!-- Footer -->
  <div class="footer">
    &copy; 2026 E-Auction. All rights reserved.
  </div>
</div>

<!-- Toggle Status Modal -->
<div class="modal fade" id="toggleModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="toggleModalTitle">Confirm Action</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="toggleModalBody">
        Are you sure you want to change this user's status?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
        <a href="#" id="confirmToggleBtn" class="btn btn-primary">Confirm</a>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function searchUsers() {
    var input = document.getElementById("searchInput");
    var filter = input.value.toUpperCase();
    var table = document.getElementById("usersTable");
    var tr = table.getElementsByTagName("tr");
    
    for (var i = 1; i < tr.length; i++) {
        var tdArray = tr[i].getElementsByTagName("td");
        var found = false;
        
        for (var j = 0; j < tdArray.length; j++) {
            if (tdArray[j]) {
                var textValue = tdArray[j].textContent || tdArray[j].innerText;
                if (textValue.toUpperCase().indexOf(filter) > -1) {
                    found = true;
                    break;
                }
            }
        }
        
        if (found) {
            tr[i].style.display = "";
        } else {
            tr[i].style.display = "none";
        }
    }
}

function toggleUserStatus(userId, activate) {
    var action = activate ? "activate" : "deactivate";
    $('#toggleModalTitle').text(activate ? 'Activate User' : 'Deactivate User');
    $('#toggleModalBody').text('Are you sure you want to ' + action + ' this user?');
    $('#confirmToggleBtn').attr('href', '${pageContext.request.contextPath}/toggleUserStatus?userId=' + userId + '&activate=' + activate);
    $('#toggleModal').modal('show');
}
</script>

</body>
</html>