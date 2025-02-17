<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>password</title>
<link rel="stylesheet" href="password.css">
</head>
<body>
<div class="container">
<div class="heading1">
<h2>Enter Your Password</h2>
<h6> <i>password should include capital letters,small letters,<br>numbers and symbols</i></h6>
</div>
<div class="heading2">
    <form action="UserDetailsServlet" method="post">
        <label>Password</label>
        <input type="password" id="password" name="password" required>
        <label>Confirm Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br>

        <input type="checkbox" id="showPassword" onclick="togglePasswordVisibility()">
        <label for="showPassword">Show Passwords</label><br>

        <input type="hidden" name="step" value="4">
        <button type="submit">Submit</button>
    </form>
    </div>
</div>

<script>
    function togglePasswordVisibility() {
        let passwordField = document.getElementById("password");
        let confirmPasswordField = document.getElementById("confirmPassword");
        let passwordType = passwordField.type === "password" ? "text" : "password";
        passwordField.type = passwordType;
        confirmPasswordField.type = passwordType;
    }
</script>
</body>
</html>
