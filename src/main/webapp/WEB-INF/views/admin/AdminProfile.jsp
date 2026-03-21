<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="My Profile" scope="request"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="AdminHeader.jsp">
    <jsp:param name="page" value="profile"/>
</jsp:include>

<div class="profile-container" style="padding: 20px; max-width: 1200px; margin: 0 auto; font-family: 'Segoe UI', Arial, sans-serif;">
    <!-- Profile Header with Gradient -->
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 15px; padding: 30px; margin-bottom: 30px; color: white; box-shadow: 0 10px 30px rgba(102,126,234,0.3);">
        <div style="display: flex; align-items: center; gap: 30px; flex-wrap: wrap;">
            <!-- Avatar - Using initials (no profilePicURL) -->
            <div style="width: 100px; height: 100px; border-radius: 50%; background: white; display: flex; align-items: center; justify-content: center; font-size: 48px; font-weight: bold; color: #667eea; border: 4px solid white; box-shadow: 0 5px 15px rgba(0,0,0,0.2);">
                ${user.firstName.charAt(0)}${user.lastName.charAt(0)}
            </div>
            
            <!-- User Info -->
            <div style="flex: 1;">
                <h1 style="font-size: 32px; margin: 0 0 5px 0;">${user.firstName} ${user.lastName}</h1>
                <p style="margin: 0 0 5px 0; opacity: 0.9;"><i class="fas fa-envelope"></i> ${user.email}</p>
                <p style="margin: 0; opacity: 0.9;"><i class="fas fa-tag"></i> Role: ${user.userType.userTypeName}</p>
            </div>
            
            <!-- Stats -->
            <div style="display: flex; gap: 20px;">
                <div style="text-align: center; background: rgba(255,255,255,0.2); padding: 15px; border-radius: 10px; min-width: 80px;">
                    <div style="font-size: 28px; font-weight: bold;">${totalProducts != null ? totalProducts : '0'}</div>
                    <div style="font-size: 12px;">Products</div>
                </div>
                <div style="text-align: center; background: rgba(255,255,255,0.2); padding: 15px; border-radius: 10px; min-width: 80px;">
                    <div style="font-size: 28px; font-weight: bold;">${totalUsers != null ? totalUsers : '0'}</div>
                    <div style="font-size: 12px;">Users</div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Success/Error Messages -->
    <c:if test="${not empty successMessage}">
        <div style="background: #c6f6d5; color: #22543d; padding: 15px; border-radius: 10px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-check-circle"></i> ${successMessage}
        </div>
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <div style="background: #fed7d7; color: #742a2a; padding: 15px; border-radius: 10px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
        </div>
    </c:if>
    
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 25px;">
        <!-- Personal Information Card -->
        <div style="background: white; border-radius: 15px; padding: 25px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
            <h2 style="color: #2d3748; font-size: 20px; margin: 0 0 20px 0; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                <i class="fas fa-user-circle" style="color: #667eea; margin-right: 8px;"></i> Personal Information
            </h2>
            
            <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #f0f0f0; display: flex;">
                <span style="width: 120px; color: #718096;">User ID</span>
                <span style="flex: 1; color: #2d3748; font-weight: 500;">${user.userId}</span>
            </div>
            
            <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #f0f0f0; display: flex;">
                <span style="width: 120px; color: #718096;">First Name</span>
                <span style="flex: 1; color: #2d3748; font-weight: 500;">${user.firstName}</span>
            </div>
            
            <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #f0f0f0; display: flex;">
                <span style="width: 120px; color: #718096;">Last Name</span>
                <span style="flex: 1; color: #2d3748; font-weight: 500;">${user.lastName}</span>
            </div>
            
            <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #f0f0f0; display: flex;">
                <span style="width: 120px; color: #718096;">Email</span>
                <span style="flex: 1; color: #2d3748; font-weight: 500;">${user.email}</span>
            </div>
            
            <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #f0f0f0; display: flex;">
                <span style="width: 120px; color: #718096;">Phone</span>
                <span style="flex: 1; color: #2d3748; font-weight: 500;">${user.phone != null ? user.phone : 'Not provided'}</span>
            </div>
            
            <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #f0f0f0; display: flex;">
                <span style="width: 120px; color: #718096;">Member Since</span>
                <span style="flex: 1; color: #2d3748; font-weight: 500;">
                    ${user.createdAt.toLocalDate().toString()}
                </span>
            </div>
            
            <div style="display: flex;">
                <span style="width: 120px; color: #718096;">Account Status</span>
                <span style="flex: 1;">
                    <c:choose>
                        <c:when test="${user.isActive}">
                            <span style="background: #c6f6d5; color: #22543d; padding: 3px 10px; border-radius: 20px; font-size: 12px; font-weight: 500;">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span style="background: #fed7d7; color: #742a2a; padding: 3px 10px; border-radius: 20px; font-size: 12px; font-weight: 500;">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
        
        <!-- Edit Profile Card -->
        <div style="background: white; border-radius: 15px; padding: 25px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
            <h2 style="color: #2d3748; font-size: 20px; margin: 0 0 20px 0; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0;">
                <i class="fas fa-edit" style="color: #667eea; margin-right: 8px;"></i> Edit Profile
            </h2>
            
            <form action="${ctx}/admin/profile/update" method="post">
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">First Name</label>
                    <input type="text" name="firstName" value="${user.firstName}" 
                           style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Last Name</label>
                    <input type="text" name="lastName" value="${user.lastName}" 
                           style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Phone Number</label>
                    <input type="text" name="phone" value="${user.phone}" 
                           style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; color: #4a5568; font-weight: 500;">Email (cannot be changed)</label>
                    <input type="email" value="${user.email}" disabled 
                           style="width: 100%; padding: 10px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px; background: #f7fafc;">
                </div>
                
                <button type="submit" style="width: 100%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; padding: 12px; border-radius: 8px; font-weight: 600; cursor: pointer; font-size: 16px; margin-top: 10px;">
                    <i class="fas fa-save"></i> Update Profile
                </button>
            </form>
        </div>
    </div>
    
    <!-- Back to Dashboard -->
    <div style="text-align: center; margin-top: 30px;">
        <a href="${ctx}/admin/dashboard" style="display: inline-flex; align-items: center; gap: 8px; background: white; color: #667eea; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 600; box-shadow: 0 2px 10px rgba(0,0,0,0.05); transition: all 0.3s;">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

<style>
    /* Hover effects */
    .profile-container a:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102,126,234,0.2) !important;
    }
    
    .profile-container button:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102,126,234,0.3);
    }
    
    input:focus {
        outline: none;
        border-color: #667eea !important;
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .profile-container > div:first-child > div {
            flex-direction: column;
            text-align: center;
        }
        
        .profile-container > div:nth-child(3) {
            grid-template-columns: 1fr;
        }
    }
</style>

<jsp:include page="AdminFooter.jsp"/>