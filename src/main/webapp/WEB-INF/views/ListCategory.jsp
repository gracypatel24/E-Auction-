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

    <%-- BUG #13 FIX: Success / error flash messages --%>
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <c:out value="${successMsg}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <c:out value="${errorMsg}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

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

                    <%-- BUG #9 FIX: Use <c:out> to HTML-escape output and prevent XSS --%>
                    <td><c:out value="${cat.categoryName}"/></td>

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
                        <%-- Edit button — GET is acceptable for navigation --%>
                        <a href="editCategory?id=${cat.categoryId}" class="btn btn-sm btn-warning">Edit</a>

                        <%--
                          BUG #10 FIX: Delete action converted from a plain GET <a> link to a
                                       POST <form>. GET requests must not have side-effects.
                                       A POST form also benefits from CSRF protection.
                          BUG #3  FIX: CSRF token included on the delete form.
                        --%>
                        <form action="deleteCategory" method="post" style="display:inline"
                              onsubmit="return confirm('Are you sure you want to delete this category?')">
                            <input type="hidden" name="id" value="${cat.categoryId}"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>

        </tbody>
    </table>

</div>

<%-- BUG #11 FIX: Bootstrap JS bundle was missing; added before </body> --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
