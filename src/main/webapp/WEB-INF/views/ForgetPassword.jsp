<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <title>Forgot Password</title>

    <style>
        body {
            background: #eef2f7;
        }

        .forgot-card {
            max-width: 420px;
            margin: 60px auto;
            padding: 25px;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body>

    <div class="container">
        <div class="forgot-card">

            <h3 class="text-center mb-4">Forgot Password</h3>

            <!-- Success Message -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="sendResetLink" method="post">

                <!-- Email Field -->
                <div class="mb-3">
                    <label class="form-label" for="email">Email Address</label>
                    <input type="email" name="email" id="email" class="form-control"
                           placeholder="Enter your registered email" required>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary w-100">Send Reset Link</button>

                <p class="text-center mt-3">
                    <a href="login">Back to Login</a>
                </p>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>