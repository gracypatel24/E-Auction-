<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="pageTitle" value="My Profile" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="SellerHeader.jsp">
    <jsp:param name="page" value="profile"/>
</jsp:include>

<div class="profile-container" style="padding: 20px; max-width: 1200px; margin: 0 auto;">
    <!-- Profile Header -->
    <div style="background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%); border-radius: 15px; padding: 30px; margin-bottom: 30px; color: white; display: flex; align-items: center; gap: 30px; box-shadow: 0 10px 30px rgba(251,191,36,0.3);">
        <div style="width: 100px; height: 100px; border-radius: 50%; background: white; display: flex; align-items: center; justify-content: center; font-size: 48px; font-weight: bold; color: #f59e0b;">
            ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
        </div>
        <div>
            <h1 style="font-size: 32px; margin: 0 0 5px 0;">${sessionScope.user.firstName} ${sessionScope.user.lastName}</h1>
            <p style="margin: 0 0 5px 0; opacity: 0.9;"><i class="fas fa-envelope"></i> ${sessionScope.user.email}</p>
            <p style="margin: 0; opacity: 0.9;"><i class="fas fa-tag"></i> Role: ${sessionScope.user.userType.userTypeName}</p>
        </div>
    </div>
    
    <!-- Profile Info -->
    <div style="background: white; border-radius: 15px; padding: 25px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
        <h2 style="color: #2d3748; margin-bottom: 20px;">Profile Information</h2>
        
        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
            <div>
                <label style="color: #718096; font-size: 14px;">First Name</label>
                <p style="font-weight: 600;">${user.firstName}</p>
            </div>
            <div>
                <label style="color: #718096; font-size: 14px;">Last Name</label>
                <p style="font-weight: 600;">${user.lastName}</p>
            </div>
            <div>
                <label style="color: #718096; font-size: 14px;">Email</label>
                <p style="font-weight: 600;">${user.email}</p>
            </div>
            <div>
                <label style="color: #718096; font-size: 14px;">Phone</label>
                <p style="font-weight: 600;">${user.phone != null ? user.phone : 'Not provided'}</p>
            </div>
            <div>
                <label style="color: #718096; font-size: 14px;">Member Since</label>
                <p style="font-weight: 600;">${user.createdAt.toString().substring(0,10)}</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="SellerFooter.jsp"/>