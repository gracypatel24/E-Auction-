<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category List</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Category List</h3>
        <a href="newCategory" class="btn btn-primary">+ Add Category</a>
    </div>

    <!-- Table -->
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Category Name</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>

            <c:if test="${empty categoryList}">
                <tr>
                    <td colspan="4" class="text-center text-muted">
                        No categories found
                    </td>
                </tr>
            </c:if>

            <c:forEach var="cat" items="${categoryList}" varStatus="i">
                <tr>
                    <td>${i.index + 1}</td>
                    <td>${cat.categoryName}</td>

                    <td>
                        <c:choose>
                            <c:when test="${cat.active}">
                                <span class="badge bg-success">Active</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Inactive</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <a href="editCategory?id=${cat.categoryId}" class="btn btn-sm btn-warning">Edit</a>
                        <a href="deleteCategory?id=${cat.categoryId}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this category?')">
                           Delete
                        </a>
                    </td>
                </tr>
            </c:forEach>

        </tbody>
    </table>

</div>

</body>
</html>