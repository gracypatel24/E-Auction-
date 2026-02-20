<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <title>Login</title>

    <style>
        body {
            background: #f5f6fa;
        }

        .login-card {
            max-width: 420px;
            margin: 60px auto;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            background: #fff;
        }
    </style>
</head>

<body>

    <div class="container">
        <div class="login-card">

            <h3 class="text-center mb-4">Login</h3>

            <!-- Display error message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="loginUser" method="post">

                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" name="email" id="email" class="form-control" 
                           placeholder="Enter your email" required>
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" name="password" id="password" class="form-control" 
                           placeholder="Enter your password" required>
                </div>

                <!-- Login Button -->
                <button type="submit" class="btn btn-primary w-100">Login</button>

                <!-- Register Link -->
                <p class="text-center mt-3">
                    Don't have an account? 
                    <a href="signup">Sign Up</a>
                </p>

                <p class="text-center mt-3">
                    Forget Password? 
                    <a href="forgetpassword">Click Here</a>
                </p>

            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>