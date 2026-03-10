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
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .edit-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 800px;
            padding: 40px;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
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
            padding: 10px 15px;
            border: 2px solid #e1e5eb;
            border-radius: 10px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            outline: none;
        }
        textarea.form-control {
            height: 100px;
            resize: vertical;
        }
        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 0;
        }
        .col-md-6 {
            flex: 1;
            min-width: calc(50% - 10px);
        }
        .btn-save {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn-cancel {
            background: #6c757d;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            margin-top: 10px;
            text-decoration: none;
            display: block;
            text-align: center;
        }
        .btn-cancel:hover {
            background: #5a6268;
            color: white;
        }
        .current-image {
            margin-bottom: 15px;
            text-align: center;
        }
        .current-image img {
            max-width: 200px;
            max-height: 150px;
            border-radius: 10px;
            border: 2px solid #667eea;
        }
        .status-badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            margin-left: 10px;
        }
        .status-active { background: #d4edda; color: #155724; }
        .status-completed { background: #d1ecf1; color: #0c5460; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <div class="edit-card">
        <h2><span>Edit</span> Auction</h2>
        
        <c:if test="${not empty auction.imageUrl}">
            <div class="current-image">
                <img src="${auction.imageUrl}" alt="${auction.title}">
                <p class="text-muted small mt-2">Current Image</p>
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/updateProduct" method="post">
            <input type="hidden" name="productId" value="${auction.productId}">
            
            <div class="form-group">
                <label>Auction Title</label>
                <input type="text" class="form-control" name="title" value="${auction.title}" required>
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <textarea class="form-control" name="description" required maxlength="5000">${auction.description}</textarea>
                <small class="text-muted">Maximum 5000 characters</small>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Category</label>
                        <select class="form-select" name="category" required>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat}" ${auction.category == cat ? 'selected' : ''}>${cat}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Status</label>
                        <select class="form-select" name="status" required>
                            <option value="ACTIVE" ${auction.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                            <option value="COMPLETED" ${auction.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                            <option value="CANCELLED" ${auction.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                        </select>
                        <c:if test="${auction.status == 'ACTIVE'}">
                            <span class="status-badge status-active">Current: Active</span>
                        </c:if>
                        <c:if test="${auction.status == 'COMPLETED'}">
                            <span class="status-badge status-completed">Current: Completed</span>
                        </c:if>
                        <c:if test="${auction.status == 'CANCELLED'}">
                            <span class="status-badge status-cancelled">Current: Cancelled</span>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Starting Bid ($)</label>
                        <input type="number" class="form-control" name="startingBid" value="${auction.startingBid}" min="1" step="0.01" required>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Current Bid ($)</label>
                        <input type="number" class="form-control" value="${auction.currentBid}" readonly disabled>
                        <small class="text-muted">Current highest bid</small>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Start Date</label>
                        <input type="date" class="form-control" name="startDate" value="${auction.startDate}" required>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label>End Date</label>
                        <input type="date" class="form-control" name="endDate" value="${auction.endDate}" required>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label>Image URL</label>
                <input type="url" class="form-control" name="imageUrl" value="${auction.imageUrl}" placeholder="https://example.com/image.jpg">
                <small class="text-muted">Leave empty to keep current image</small>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Bid Count</label>
                        <input type="number" class="form-control" value="${auction.bidCount}" readonly disabled>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Created At</label>
                        <input type="text" class="form-control" value="${auction.createdAt}" readonly disabled>
                    </div>
                </div>
            </div>
            
            <button type="submit" class="btn-save">
                <i class="fas fa-save"></i> Update Auction
            </button>
        </form>
        
        <a href="${pageContext.request.contextPath}/listProduct" class="btn-cancel">
            <i class="fas fa-times"></i> Cancel
        </a>
    </div>
</body>
</html>