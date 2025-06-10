<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register</title>
<link rel="stylesheet" href="name.css">
</head>
<body>

<div class = "container">
<div class="heading1">
<h2>Register to Your Account</h2>
<h5>Enter your name</h5>
</div>
<div class="heading2">
<form action="UserDetailsServlet" method="post">
    <label><b>Name</b></label>
    <input type="text" name="firstName" required><br>
    <label><b>Surname</b></label>
    <input type="text" name="lastName" required><br>
    <input type="hidden" name="step" value="1">
    <button type="submit">Next</button>
</form>
</div>
</div>

</body>
</html>