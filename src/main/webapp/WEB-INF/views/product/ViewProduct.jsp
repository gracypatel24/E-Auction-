<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="View Product" scope="request"/>
<jsp:include page="../admin/AdminHeader.jsp">  <!-- Fixed path -->
    <jsp:param name="page" value="products"/>
</jsp:include>

<div class="container-fluid" style="padding: 20px;">
    <h1>View Product</h1>
    <p>Product details will be displayed here.</p>
    <a href="${pageContext.request.contextPath}/listProduct" class="btn btn-primary">Back to Products</a>
</div>

<jsp:include page="../admin/AdminFooter.jsp"/>  <!-- Fixed path -->