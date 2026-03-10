<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Participant Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">E-Auction - Participant</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/participant/dashboard">Dashboard</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/participant/my-bids">My Bids</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/participant/won-auctions">Won Auctions</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/profile">Profile</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Welcome, ${sessionScope.user.firstName}!</h2>
        
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Total Bids</h5>
                        <h2>${totalBids}</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Winning Bids</h5>
                        <h2>${winningBids.size()}</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-info mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Active Auctions</h5>
                        <h2>${activeAuctions.size()}</h2>
                    </div>
                </div>
            </div>
        </div>

        <h3 class="mt-4">Active Auctions</h3>
        <div class="row">
            <c:forEach items="${activeAuctions}" var="auction">
                <div class="col-md-4 mb-3">
                    <div class="card">
                        <img src="${auction.imageUrl}" class="card-img-top" alt="${auction.title}" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <