<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Payments" scope="request"/>
<jsp:include page="AdminHeader.jsp">
    <jsp:param name="page" value="payments"/>
</jsp:include>

<div style="padding: 20px;">
    <h1>Payments</h1>
    <p>Payments will be displayed here.</p>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a>
</div>

<jsp:include page="AdminFooter.jsp"/>