<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="sidebar sidebar-offcanvas" id="sidebar">
  <ul class="nav">
    <li class="nav-item ${currentPage == 'dashboard' ? 'active' : ''}">
      <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">
        <i class="icon-grid menu-icon"></i>
        <span class="menu-title">Dashboard</span>
      </a>
    </li>
    
    <li class="nav-item ${currentPage == 'auctions' ? 'active' : ''}">
      <a class="nav-link" data-toggle="collapse" href="#auctions-menu" aria-expanded="false" aria-controls="auctions-menu">
        <i class="icon-gavel menu-icon"></i>
        <span class="menu-title">Auctions</span>
        <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="auctions-menu">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/listProduct">All Auctions</a></li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/newProduct">Create Auction</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Live Auctions</a></li>
        </ul>
      </div>
    </li>
    
    <li class="nav-item ${currentPage == 'categories' ? 'active' : ''}">
      <a class="nav-link" data-toggle="collapse" href="#categories-menu" aria-expanded="false" aria-controls="categories-menu">
        <i class="icon-layout menu-icon"></i>
        <span class="menu-title">Categories</span>
        <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="categories-menu">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/listCategory">All Categories</a></li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/newCategory">Add Category</a></li>
        </ul>
      </div>
    </li>
    
    <li class="nav-item ${currentPage == 'users' ? 'active' : ''}">
      <a class="nav-link" data-toggle="collapse" href="#users-menu" aria-expanded="false" aria-controls="users-menu">
        <i class="icon-head menu-icon"></i>
        <span class="menu-title">Users</span>
        <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="users-menu">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/listUser">All Users</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Bidders</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Sellers</a></li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/newUserType">User Types</a></li>
        </ul>
      </div>
	  <div class="nav-item">
	      <a class="nav-link" href="${pageContext.request.contextPath}/listUser">
	          <i class="ti-user"></i>
	          <span>Users</span>
	      </a>
	  </div>
    </li>
    
    <li class="nav-item ${currentPage == 'reports' ? 'active' : ''}">
      <a class="nav-link" href="#">
        <i class="icon-bar-graph menu-icon"></i>
        <span class="menu-title">Reports</span>
      </a>
    </li>
    
    <li class="nav-item ${currentPage == 'settings' ? 'active' : ''}">
      <a class="nav-link" href="#">
        <i class="icon-settings menu-icon"></i>
        <span class="menu-title">Settings</span>
      </a>
    </li>
  </ul>
</nav>