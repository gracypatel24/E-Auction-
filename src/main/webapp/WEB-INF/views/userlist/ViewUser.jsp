<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="View User" scope="request"/>
<jsp:include page="../admin/AdminHeader.jsp">  <!-- Fixed path -->
    <jsp:param name="page" value="users"/>
</jsp:include>

<div class="container-fluid" style="padding: 20px;">
    <h1>View User</h1>
    <p>User details will be displayed here.</p>
    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary">Back to Users</a>
</div>

<jsp:include page="../admin/AdminFooter.jsp"/>  <!-- Fixed path -->