<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="${pageContext.request.contextPath}/WEB-INF/views/admin/AdminHeader.jsp">
    <c:param name="page" value="users"/>
</c:import>

<div class="container-fluid" style="padding: 20px;">
    <h1>Manage Users</h1>
    <p>Welcome to User Management. This page will display all users.</p>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary">Back to Dashboard</a>
</div>

<c:import url="${pageContext.request.contextPath}/WEB-INF/views/admin/AdminFooter.jsp"/>