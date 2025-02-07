<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="login.css">
</head>
<body>
    <div class="login-container">
    <div class="heading1">
    <h1>Login your Account</h1>
    </div>
    <div class="heading2">
        <form action="UserLoginServlet" method="post" class="login-form">
            <h2>Login</h2>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Login</button>
            <div class="form-footer">
                <p>Don't have an account? <a href="name.jsp">Create an account</a></p>
            </div>
        </form>
        </div>
    </div>
</body>
</html>
