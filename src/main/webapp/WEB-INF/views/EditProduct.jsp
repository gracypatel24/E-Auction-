<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Auction - E-Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .edit-container {
            width: 100%;
            max-width: 900px;
        }
        
        .edit-card {
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
        
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
        }
        
        h2 span {
            color: #667eea;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
            display: block;
        }
        
        .form-control, .form-select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5eb;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            outline: none;
        }
        
        textarea.form-control {
            height: 120px;
            resize: vertical;
        }
        
        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 0;
        }
        
        .col-md-6 {
            flex: 1 1 calc(50% - 10px);
            min-width: 250px;
        }
        
        .readonly-field {
            background-color: #e9ecef;
            opacity: 0.8;
        }
        
        .current-image {
            text-align: center;
            margin-bottom: 25px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .current-image img {
            max-width: 200px;
            max-height: 150px;
            border-radius: 10px;
            border: 3px solid #667eea;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .current-image p {
            margin-top: 10px;
            color: #6c757d;
            font-size: 13px;
        }
        
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            margin-top: 5px;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-completed {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        
        .btn-update {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        .btn-cancel {
            background: #6c757d;
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            margin-top: 10px;
            text-decoration: none;
            display: block;
            text-align: center;
            transition: all 0.3s;
        }
        
        .btn-cancel:hover {
            background: #5a6268;
            color: white;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
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
        
        .info-text {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .required-field::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="edit-container">
        <div class="edit-card">
            <h2><span>Edit</span> Auction</h2>
            
            <!-- Display success/error messages -->
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
            
            <!-- Check if auction object exists -->
            <c:if test="${empty auction}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i> Auction not found!
                </div>
                <a href="${pageContext.request.contextPath}/listProduct" class="btn-cancel">
                    <i class="fas fa-arrow-left"></i> Back to Auctions
                </a>
            </c:if>
            
            <c:if test="${not empty auction}">
                <!-- Current Image Display -->
                <c:if test="${not empty auction.imageUrl}">
                    <div class="current-image">
                        <img src="${auction.imageUrl}" alt="${auction.title}">
                        <p><i class="fas fa-image"></i> Current Image</p>
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/updateProduct" method="post">
                    <input type="hidden" name="productId" value="${auction.productId}">
                    
                    <div class="form-group">
                        <label class="required-field">Auction Title</label>
                        <input type="text" class="form-control" name="title" value="${auction.title}" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="required-field">Description</label>
                        <textarea class="form-control" name="description" required maxlength="5000">${auction.description}</textarea>
                        <div class="info-text">Maximum 5000 characters</div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="required-field">Category</label>
                                <select class="form-select" name="category" required>
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat}" ${auction.category == cat ? 'selected' : ''}>${cat}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="required-field">Status</label>
                                <select class="form-select" name="status" required>
                                    <option value="ACTIVE" ${auction.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                    <option value="COMPLETED" ${auction.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                    <option value="CANCELLED" ${auction.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                </select>
                                <span class="status-badge status-${auction.status.toLowerCase()}">
                                    Current: ${auction.status}
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="required-field">Starting Bid ($)</label>
                                <input type="number" class="form-control" name="startingBid" 
                                       value="${auction.startingBid}" min="1" step="0.01" required>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Current Bid ($)</label>
                                <input type="number" class="form-control readonly-field" 
                                       value="${auction.currentBid}" readonly disabled>
                                <div class="info-text">Current highest bid (read-only)</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="required-field">Start Date</label>
                                <input type="date" class="form-control" name="startDate" 
                                       value="${auction.startDate}" required>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="required-field">End Date</label>
                                <input type="date" class="form-control" name="endDate" 
                                       value="${auction.endDate}" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Image URL</label>
                        <input type="url" class="form-control" name="imageUrl" 
                               value="${auction.imageUrl}" placeholder="https://example.com/image.jpg">
                        <div class="info-text">Leave empty to keep current image</div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Bid Count</label>
                                <input type="number" class="form-control readonly-field" 
                                       value="${auction.bidCount}" readonly disabled>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Created At</label>
                                <input type="text" class="form-control readonly-field" 
                                       value="${auction.createdAt}" readonly disabled>
                            </div>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-update">
                        <i class="fas fa-save"></i> Update Auction
                    </button>
                </form>
                
                <a href="${pageContext.request.contextPath}/listProduct" class="btn-cancel">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </c:if>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Client-side validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const startDate = new Date(document.querySelector('input[name="startDate"]').value);
            const endDate = new Date(document.querySelector('input[name="endDate"]').value);
            
            if (endDate < startDate) {
                e.preventDefault();
                alert('End date cannot be before start date!');
            }
        });
    </script>
</body>
</html>