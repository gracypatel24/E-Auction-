<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Auction - ${auction.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>${auction.title}</h2>
        <div class="row">
            <div class="col-md-6">
                <img src="${auction.imageUrl}" class="img-fluid" alt="${auction.title}">
            </div>
            <div class="col-md-6">
                <p><strong>Description:</strong> ${auction.description}</p>
                <p><strong>Category:</strong> ${auction.category}</p>
                <p><strong>Current Bid:</strong> $${auction.currentBid}</p>
                <p><strong>Total Bids:</strong> ${auction.bidCount}</p>
                <p><strong>End Date:</strong> ${auction.endDate}</p>
                
                <form action="${pageContext.request.contextPath}/participant/place-bid" method="post">
                    <input type="hidden" name="productId" value="${auction.productId}">
                    <div class="mb-3">
                        <label for="bidAmount" class="form-label">Your Bid Amount</label>
                        <input type="number" class="form-control" id="bidAmount" name="bidAmount" 
                               min="${auction.currentBid + 1}" step="0.01" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Place Bid</button>
                </form>
            </div>
        </div>
        
        <h3 class="mt-5">Bid History</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Bidder</th>
                    <th>Amount</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${bids}" var="bid">
                    <tr>
                        <td>User #${bid.userId}</td>
                        <td>$${bid.bidAmount}</td>
                        <td>${bid.bidTime}</td>
                        <td>${bid.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>