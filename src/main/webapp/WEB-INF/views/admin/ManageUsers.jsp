<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Manage Users" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="AdminHeader.jsp">
    <jsp:param name="page" value="users"/>
</jsp:include>

<!-- MAIN CONTENT -->
<div style="padding: 25px; background: #f8fafc; min-height: calc(100vh - 70px); font-family: 'Segoe UI', Arial, sans-serif;">

    <!-- PAGE HEADER - Purple Gradient -->
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 12px; padding: 25px; margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; color: white; box-shadow: 0 10px 25px rgba(102,126,234,0.3);">
        <div>
            <h1 style="font-size: 26px; margin: 0 0 8px 0; font-weight: 600;"><i class="fas fa-users-cog" style="margin-right: 10px;"></i> Manage Users</h1>
            <p style="margin: 0; opacity: 0.9; font-size: 15px;">View and manage all registered users in the system</p>
        </div>
        <a href="${ctx}/admin/dashboard" style="background: white; color: #667eea; padding: 10px 22px; border-radius: 8px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); transition: all 0.3s;">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <!-- STATS CARDS -->
    <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 25px;">
        <!-- Total Users -->
        <div style="background: white; border-radius: 10px; padding: 20px; display: flex; align-items: center; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
            <div style="width: 50px; height: 50px; border-radius: 10px; background: #e3f2fd; display: flex; align-items: center; justify-content: center; color: #1976d2; font-size: 22px;">
                <i class="fas fa-users"></i>
            </div>
            <div>
                <div style="color: #718096; font-size: 13px; margin-bottom: 5px;">Total Users</div>
                <div style="font-size: 26px; font-weight: bold; color: #2d3748;">${totalUsers != null ? totalUsers : '0'}</div>
            </div>
        </div>
        
        <!-- Active Users -->
        <div style="background: white; border-radius: 10px; padding: 20px; display: flex; align-items: center; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
            <div style="width: 50px; height: 50px; border-radius: 10px; background: #e8f5e9; display: flex; align-items: center; justify-content: center; color: #2e7d32; font-size: 22px;">
                <i class="fas fa-user-check"></i>
            </div>
            <div>
                <div style="color: #718096; font-size: 13px; margin-bottom: 5px;">Active Users</div>
                <div style="font-size: 26px; font-weight: bold; color: #2d3748;">${activeUsers != null ? activeUsers : '0'}</div>
            </div>
        </div>
        
        <!-- New Users -->
        <div style="background: white; border-radius: 10px; padding: 20px; display: flex; align-items: center; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
            <div style="width: 50px; height: 50px; border-radius: 10px; background: #fff3e0; display: flex; align-items: center; justify-content: center; color: #ef6c00; font-size: 22px;">
                <i class="fas fa-user-plus"></i>
            </div>
            <div>
                <div style="color: #718096; font-size: 13px; margin-bottom: 5px;">New (30d)</div>
                <div style="font-size: 26px; font-weight: bold; color: #2d3748;">${newUsers != null ? newUsers : '0'}</div>
            </div>
        </div>
        
        <!-- Sellers -->
        <div style="background: white; border-radius: 10px; padding: 20px; display: flex; align-items: center; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
            <div style="width: 50px; height: 50px; border-radius: 10px; background: #f3e5f5; display: flex; align-items: center; justify-content: center; color: #7b1fa2; font-size: 22px;">
                <i class="fas fa-store"></i>
            </div>
            <div>
                <div style="color: #718096; font-size: 13px; margin-bottom: 5px;">Sellers</div>
                <div style="font-size: 26px; font-weight: bold; color: #2d3748;">${sellerCount != null ? sellerCount : '0'}</div>
            </div>
        </div>
    </div>

    <!-- SEARCH BAR -->
    <div style="background: white; border-radius: 10px; padding: 18px; margin-bottom: 20px; display: flex; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
        <div style="flex: 1; position: relative;">
            <i class="fas fa-search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #a0aec0;"></i>
            <input type="text" id="searchInput" placeholder="Search users..." 
                   style="width: 100%; padding: 12px 15px 12px 40px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
        </div>
        <select id="roleFilter" style="padding: 12px 30px 12px 15px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px; background: white;">
            <option value="all">All Roles</option>
            <option value="ADMIN">Admin</option>
            <option value="SELLER">Seller</option>
            <option value="USER">User</option>
        </select>
        <select id="statusFilter" style="padding: 12px 30px 12px 15px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px; background: white;">
            <option value="all">All Status</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
        </select>
    </div>

    <!-- USERS TABLE -->
    <div style="background: white; border-radius: 12px; padding: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); overflow-x: auto;">
        <table style="width: 100%; border-collapse: collapse;" id="usersTable">
            <thead>
                <tr style="background: #f7fafc; border-bottom: 2px solid #e2e8f0;">
                    <th style="padding: 15px 10px; text-align: left; color: #4a5568; font-weight: 600; font-size: 13px;">ID</th>
                    <th style="padding: 15px 10px; text-align: left; color: #4a5568; font-weight: 600; font-size: 13px;">User</th>
                    <th style="padding: 15px 10px; text-align: left; color: #4a5568; font-weight: 600; font-size: 13px;">Email</th>
                    <th style="padding: 15px 10px; text-align: left; color: #4a5568; font-weight: 600; font-size: 13px;">Role</th>
                    <th style="padding: 15px 10px; text-align: left; color: #4a5568; font-weight: 600; font-size: 13px;">Contact</th>
                    <th style="padding: 15px 10px; text-align: left; color: #4a5568; font-weight: 600; font-size: 13px;">Status</th>
                    <th style="padding: 15px 10px; text-align: left; color: #4a5568; font-weight: 600; font-size: 13px;">Joined</th>
                    <th style="padding: 15px 10px; text-align: left; color: #4a5568; font-weight: 600; font-size: 13px;">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach items="${users}" var="user">
                            <tr style="border-bottom: 1px solid #e2e8f0;" data-role="${user.userType.userTypeName}" data-status="${user.isActive ? 'active' : 'inactive'}">
                                <td style="padding: 15px 10px;">#${user.userId}</td>
                                <td style="padding: 15px 10px;">
                                    <div style="display: flex; align-items: center; gap: 10px;">
                                        <div style="width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 14px;">
                                            ${user.firstName.charAt(0)}${user.lastName.charAt(0)}
                                        </div>
                                        <strong>${user.firstName} ${user.lastName}</strong>
                                    </div>
                                </td>
                                <td style="padding: 15px 10px;">${user.email}</td>
                                <td style="padding: 15px 10px;">
                                    <c:choose>
                                        <c:when test="${user.userType.userTypeName == 'ADMIN'}">
                                            <span style="background: #fed7d7; color: #c53030; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 500;">ADMIN</span>
                                        </c:when>
                                        <c:when test="${user.userType.userTypeName == 'SELLER'}">
                                            <span style="background: #feebc8; color: #c05621; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 500;">SELLER</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="background: #c6f6d5; color: #276749; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 500;">USER</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 15px 10px;">${user.contactNum != null ? user.contactNum : '—'}</td>
                                <td style="padding: 15px 10px;">
                                    <c:choose>
                                        <c:when test="${user.isActive}">
                                            <span style="background: #c6f6d5; color: #22543d; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 500; display: inline-flex; align-items: center; gap: 5px;">
                                                <i class="fas fa-circle" style="font-size: 8px;"></i> Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="background: #fed7d7; color: #742a2a; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 500; display: inline-flex; align-items: center; gap: 5px;">
                                                <i class="fas fa-circle" style="font-size: 8px;"></i> Inactive
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 15px 10px;"><fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy"/></td>
                                <td style="padding: 15px 10px;">
                                    <div style="display: flex; gap: 5px;">
                                        <a href="${ctx}/admin/users/view/${user.userId}" style="width: 32px; height: 32px; border-radius: 6px; background: #e3f2fd; color: #1976d2; display: inline-flex; align-items: center; justify-content: center; text-decoration: none;" title="View">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${ctx}/admin/users/edit/${user.userId}" style="width: 32px; height: 32px; border-radius: 6px; background: #fff3cd; color: #856404; display: inline-flex; align-items: center; justify-content: center; text-decoration: none;" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <c:choose>
                                            <c:when test="${user.isActive}">
                                                <a href="#" onclick="confirmStatusChange(${user.userId}, 'deactivate')" style="width: 32px; height: 32px; border-radius: 6px; background: #fff3e0; color: #ef6c00; display: inline-flex; align-items: center; justify-content: center; text-decoration: none;" title="Deactivate">
                                                    <i class="fas fa-ban"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="#" onclick="confirmStatusChange(${user.userId}, 'activate')" style="width: 32px; height: 32px; border-radius: 6px; background: #d4edda; color: #155724; display: inline-flex; align-items: center; justify-content: center; text-decoration: none;" title="Activate">
                                                    <i class="fas fa-check"></i>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                                <i class="fas fa-users-slash" style="font-size: 60px; margin-bottom: 20px; color: #cbd5e0;"></i>
                                <h3 style="color: #2d3748; font-size: 20px; margin: 0 0 10px 0;">No Users Found</h3>
                                <p style="margin: 0;">There are no users in the system yet.</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <!-- BACK LINK -->
    <div style="text-align: center; margin-top: 25px;">
        <a href="${ctx}/admin/dashboard" style="display: inline-flex; align-items: center; gap: 8px; background: white; color: #667eea; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 600; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

<!-- MODAL -->
<div id="statusModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); align-items: center; justify-content: center; z-index: 1000;">
    <div style="background: white; border-radius: 10px; width: 400px; max-width: 90%; animation: slideIn 0.3s ease;">
        <div style="padding: 20px; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center;">
            <h3 id="modalTitle" style="margin: 0; color: #2d3748;">Confirm Action</h3>
            <button onclick="closeModal()" style="background: none; border: none; font-size: 24px; cursor: pointer; color: #a0aec0;">&times;</button>
        </div>
        <div style="padding: 20px; color: #4a5568;">
            <p id="modalMessage">Are you sure you want to change this user's status?</p>
        </div>
        <div style="padding: 20px; border-top: 1px solid #e2e8f0; display: flex; justify-content: flex-end; gap: 10px;">
            <button onclick="closeModal()" style="padding: 10px 20px; border-radius: 6px; background: #e2e8f0; color: #4a5568; border: none; cursor: pointer; font-weight: 500;">Cancel</button>
            <a href="#" id="confirmActionBtn" style="padding: 10px 20px; border-radius: 6px; background: #667eea; color: white; text-decoration: none; font-weight: 500;">Confirm</a>
        </div>
    </div>
</div>

<style>
    @keyframes slideIn {
        from {
            transform: translateY(-50px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }
    
    .btn-back:hover, .btn-back-bottom:hover, [style*="Back to Dashboard"]:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(102,126,234,0.3) !important;
    }
    
    [style*="action-buttons"] a:hover {
        transform: translateY(-2px);
        box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    }
    
    #searchInput:focus, select:focus {
        outline: none;
        border-color: #667eea !important;
    }
</style>

<script>
    function searchUsers() {
        var input = document.getElementById('searchInput');
        var filter = input.value.toUpperCase();
        var table = document.getElementById('usersTable');
        var rows = table.getElementsByTagName('tr');
        
        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var cells = row.getElementsByTagName('td');
            var found = false;
            
            for (var j = 0; j < cells.length; j++) {
                var cell = cells[j];
                if (cell) {
                    var textValue = cell.textContent || cell.innerText;
                    if (textValue.toUpperCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }
            }
            
            row.style.display = found ? '' : 'none';
        }
    }

    function filterUsers() {
        var roleFilter = document.getElementById('roleFilter').value;
        var statusFilter = document.getElementById('statusFilter').value;
        var table = document.getElementById('usersTable');
        var rows = table.getElementsByTagName('tr');
        
        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var role = row.getAttribute('data-role');
            var status = row.getAttribute('data-status');
            
            var roleMatch = (roleFilter === 'all' || role === roleFilter);
            var statusMatch = (statusFilter === 'all' || status === statusFilter);
            
            row.style.display = (roleMatch && statusMatch) ? '' : 'none';
        }
    }

    function confirmStatusChange(userId, action) {
        var modal = document.getElementById('statusModal');
        var title = document.getElementById('modalTitle');
        var message = document.getElementById('modalMessage');
        var confirmBtn = document.getElementById('confirmActionBtn');
        
        if (action === 'activate') {
            title.textContent = 'Activate User';
            message.textContent = 'Are you sure you want to activate this user?';
            confirmBtn.href = '${ctx}/admin/users/activate/' + userId;
        } else {
            title.textContent = 'Deactivate User';
            message.textContent = 'Are you sure you want to deactivate this user?';
            confirmBtn.href = '${ctx}/admin/users/deactivate/' + userId;
        }
        
        modal.style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('statusModal').style.display = 'none';
    }

    document.getElementById('searchInput').addEventListener('keyup', searchUsers);
    document.getElementById('roleFilter').addEventListener('change', filterUsers);
    document.getElementById('statusFilter').addEventListener('change', filterUsers);

    window.onclick = function(event) {
        var modal = document.getElementById('statusModal');
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }
</script>

<jsp:include page="AdminFooter.jsp"/>