<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="Categories" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<c:import url="${ctx}/WEB-INF/views/admin/AdminHeader.jsp">
    <c:param name="page" value="categories"/>
</c:import>

<div class="categories-container">
    <!-- Page Header -->
    <div class="page-header">
        <div>
            <h1><i class="fas fa-tags"></i> Categories</h1>
            <p class="subtitle">Welcome to Category Management. Organize and manage all product categories.</p>
        </div>
        <div class="header-actions">
            <a href="${ctx}/newCategory" class="btn-add">
                <i class="fas fa-plus"></i> Add New Category
            </a>
            <a href="${ctx}/admin/dashboard" class="btn-back-header">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
    
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
    
    <!-- Search Bar -->
    <div class="search-bar">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search categories...">
        </div>
        <div class="filter-options">
            <select id="statusFilter" class="filter-select">
                <option value="all">All Status</option>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
            </select>
        </div>
    </div>
    
    <!-- Categories Table -->
    <div class="table-container">
        <table class="categories-table" id="categoriesTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Category Name</th>
                    <th>Description</th>
                    <th>Parent Category</th>
                    <th>Status</th>
                    <th>Created</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty categories}">
                        <c:forEach items="${categories}" var="category">
                            <tr data-status="${category.isActive ? 'active' : 'inactive'}">
                                <td>#${category.categoryId}</td>
                                <td>
                                    <strong>${category.categoryName}</strong>
                                </td>
                                <td>${category.description != null ? category.description : '—'}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty category.parentCategoryId}">
                                            <span class="badge badge-main">Main Category</span>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${categories}" var="parent">
                                                <c:if test="${parent.categoryId == category.parentCategoryId}">
                                                    ${parent.categoryName}
                                                </c:if>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${category.isActive}">
                                            <span class="status-badge status-active">
                                                <i class="fas fa-circle"></i> Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">
                                                <i class="fas fa-circle"></i> Inactive
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${category.createdAt}" pattern="MMM dd, yyyy"/></td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${ctx}/editCategory?id=${category.categoryId}" class="btn-action btn-edit" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <c:choose>
                                            <c:when test="${category.isActive}">
                                                <a href="#" onclick="confirmStatusChange(${category.categoryId}, 'deactivate')" class="btn-action btn-deactivate" title="Deactivate">
                                                    <i class="fas fa-ban"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="#" onclick="confirmStatusChange(${category.categoryId}, 'activate')" class="btn-action btn-activate" title="Activate">
                                                    <i class="fas fa-check"></i>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="${ctx}/deleteCategory?id=${category.categoryId}" class="btn-action btn-delete" title="Delete" onclick="return confirm('Are you sure you want to delete this category?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="empty-state">
                                <i class="fas fa-folder-open"></i>
                                <h3>No Categories Found</h3>
                                <p>Get started by adding your first category.</p>
                                <a href="${ctx}/newCategory" class="btn-empty-add">
                                    <i class="fas fa-plus"></i> Add New Category
                                </a>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<!-- Status Change Modal -->
<div id="statusModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="modalTitle">Confirm Action</h3>
            <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <p id="modalMessage">Are you sure you want to change this category's status?</p>
        </div>
        <div class="modal-footer">
            <button class="modal-btn modal-btn-secondary" onclick="closeModal()">Cancel</button>
            <a href="#" id="confirmActionBtn" class="modal-btn modal-btn-primary">Confirm</a>
        </div>
    </div>
</div>

<style>
    .categories-container {
        padding: 20px;
        max-width: 1200px;
        margin: 0 auto;
    }
    
    /* Page Header */
    .page-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 15px;
        padding: 25px 30px;
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: white;
        box-shadow: 0 10px 30px rgba(102,126,234,0.3);
    }
    
    .page-header h1 {
        font-size: 28px;
        font-weight: 600;
        margin: 0 0 5px 0;
    }
    
    .page-header h1 i {
        margin-right: 10px;
    }
    
    .subtitle {
        font-size: 14px;
        opacity: 0.9;
        margin: 0;
    }
    
    .header-actions {
        display: flex;
        gap: 10px;
    }
    
    .btn-add {
        background: white;
        color: #667eea;
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }
    
    .btn-back-header {
        background: rgba(255,255,255,0.2);
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s;
        border: 1px solid rgba(255,255,255,0.3);
    }
    
    .btn-add:hover, .btn-back-header:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
    }
    
    .btn-add:hover {
        background: #f8f9fa;
    }
    
    .btn-back-header:hover {
        background: rgba(255,255,255,0.3);
    }
    
    /* Alert Messages */
    .alert {
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .alert-success {
        background: #c6f6d5;
        color: #22543d;
        border-left: 4px solid #48bb78;
    }
    
    .alert-danger {
        background: #fed7d7;
        color: #742a2a;
        border-left: 4px solid #f56565;
    }
    
    /* Search Bar */
    .search-bar {
        background: white;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    
    .search-box {
        position: relative;
        flex: 1;
        min-width: 250px;
    }
    
    .search-box i {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: #a0aec0;
    }
    
    .search-box input {
        width: 100%;
        padding: 12px 15px 12px 45px;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 14px;
        transition: all 0.3s;
    }
    
    .search-box input:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
    }
    
    .filter-options {
        display: flex;
        gap: 10px;
    }
    
    .filter-select {
        padding: 12px 35px 12px 15px;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 14px;
        color: #4a5568;
        background: white;
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%234a5568' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 10px center;
    }
    
    .filter-select:focus {
        outline: none;
        border-color: #667eea;
    }
    
    /* Table */
    .table-container {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        overflow-x: auto;
    }
    
    .categories-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .categories-table th {
        text-align: left;
        padding: 15px 10px;
        background: #f7fafc;
        color: #4a5568;
        font-weight: 600;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid #e2e8f0;
    }
    
    .categories-table td {
        padding: 15px 10px;
        border-bottom: 1px solid #e2e8f0;
        vertical-align: middle;
    }
    
    .categories-table tr:hover {
        background: #f7fafc;
    }
    
    .badge-main {
        background: #e2e8f0;
        color: #4a5568;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .status-badge {
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }
    
    .status-active {
        background: #c6f6d5;
        color: #22543d;
    }
    
    .status-inactive {
        background: #fed7d7;
        color: #742a2a;
    }
    
    .status-badge i {
        font-size: 8px;
    }
    
    .action-buttons {
        display: flex;
        gap: 5px;
    }
    
    .btn-action {
        width: 32px;
        height: 32px;
        border-radius: 6px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        transition: all 0.3s;
    }
    
    .btn-edit {
        background: #fff3cd;
        color: #856404;
    }
    
    .btn-deactivate {
        background: #fff3e0;
        color: #ef6c00;
    }
    
    .btn-activate {
        background: #d4edda;
        color: #155724;
    }
    
    .btn-delete {
        background: #f8d7da;
        color: #721c24;
    }
    
    .btn-action:hover {
        transform: translateY(-2px);
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }
    
    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px !important;
        color: #a0aec0;
    }
    
    .empty-state i {
        font-size: 60px;
        margin-bottom: 20px;
        color: #cbd5e0;
    }
    
    .empty-state h3 {
        color: #2d3748;
        font-size: 20px;
        margin-bottom: 10px;
    }
    
    .empty-state p {
        margin-bottom: 20px;
    }
    
    .btn-empty-add {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-weight: 500;
        transition: all 0.3s;
    }
    
    .btn-empty-add:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102,126,234,0.4);
    }
    
    /* Modal */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        align-items: center;
        justify-content: center;
        z-index: 1000;
    }
    
    .modal-content {
        background: white;
        border-radius: 10px;
        width: 400px;
        max-width: 90%;
        animation: slideIn 0.3s ease;
    }
    
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
    
    .modal-header {
        padding: 20px;
        border-bottom: 1px solid #e2e8f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .modal-header h3 {
        color: #2d3748;
        margin: 0;
        font-size: 18px;
    }
    
    .modal-close {
        background: none;
        border: none;
        font-size: 24px;
        cursor: pointer;
        color: #a0aec0;
    }
    
    .modal-close:hover {
        color: #4a5568;
    }
    
    .modal-body {
        padding: 20px;
        color: #4a5568;
    }
    
    .modal-footer {
        padding: 20px;
        border-top: 1px solid #e2e8f0;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }
    
    .modal-btn {
        padding: 10px 20px;
        border-radius: 6px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s;
        border: none;
        text-decoration: none;
        display: inline-block;
    }
    
    .modal-btn-primary {
        background: #667eea;
        color: white;
    }
    
    .modal-btn-secondary {
        background: #e2e8f0;
        color: #4a5568;
    }
    
    .modal-btn-primary:hover, .modal-btn-secondary:hover {
        transform: translateY(-2px);
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .page-header {
            flex-direction: column;
            text-align: center;
            gap: 15px;
        }
        
        .header-actions {
            width: 100%;
            flex-direction: column;
        }
        
        .search-bar {
            flex-direction: column;
        }
        
        .filter-options {
            width: 100%;
        }
        
        .filter-select {
            width: 100%;
        }
    }
</style>

<script>
    // Search functionality
    function searchCategories() {
        var input = document.getElementById('searchInput');
        if (!input) return;
        
        var filter = input.value.toUpperCase();
        var table = document.getElementById('categoriesTable');
        if (!table) return;
        
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
            
            if (found) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    }

    // Filter by status
    function filterCategories() {
        var statusFilter = document.getElementById('statusFilter').value;
        var table = document.getElementById('categoriesTable');
        if (!table) return;
        
        var rows = table.getElementsByTagName('tr');
        
        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var status = row.getAttribute('data-status');
            
            var statusMatch = (statusFilter === 'all' || status === statusFilter);
            
            if (statusMatch) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    }

    // Modal functions
    function confirmStatusChange(categoryId, action) {
        var modal = document.getElementById('statusModal');
        var title = document.getElementById('modalTitle');
        var message = document.getElementById('modalMessage');
        var confirmBtn = document.getElementById('confirmActionBtn');
        
        if (action === 'activate') {
            title.textContent = 'Activate Category';
            message.textContent = 'Are you sure you want to activate this category?';
            confirmBtn.href = '${ctx}/activateCategory?id=' + categoryId;
        } else {
            title.textContent = 'Deactivate Category';
            message.textContent = 'Are you sure you want to deactivate this category?';
            confirmBtn.href = '${ctx}/deactivateCategory?id=' + categoryId;
        }
        
        modal.style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('statusModal').style.display = 'none';
    }

    // Event listeners
    document.addEventListener('DOMContentLoaded', function() {
        var searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('keyup', searchCategories);
        }
        
        var statusFilter = document.getElementById('statusFilter');
        if (statusFilter) {
            statusFilter.addEventListener('change', filterCategories);
        }
    });

    // Close modal when clicking outside
    window.onclick = function(event) {
        var modal = document.getElementById('statusModal');
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }
</script>

<c:import url="${ctx}/WEB-INF/views/admin/AdminFooter.jsp"/>