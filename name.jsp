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
<header>
<nav>
<ul>
<li><a href="#"></a>
<a href="#">Home</a></li>
        <li><a href="#">About Us</a></li>
        <li><a href="#">Help</a></li>
</ul>
</nav>
</header>
<div class = "container">
<div class="heading1">
<h2>Register to Your Account</h2>
<h5>Enter your name</h5>
</div>
<div class="heading2">
<form action="UserDetailsServlet" method="post" onsubmit="return validateNames()">
    <label><b>Name</b></label>
    <input type="text" name="firstName" required><br>
    <label><b>Surname</b></label>
    <input type="text" name="lastName" required><br>
    <input type="hidden" name="step" value="1">
    <button type="submit">Next</button>
</form>
</div>
</div>
<footer>
    <p>Phone: +630-729-3236</p>
    <p>Email: vishwakaramkuldeep900@gmail.com.com</p>
    <p>Website: www.reallygreatsite.com</p>
    <p>Address: 123-Anywhere St, Any City</p>
  </footer>
</body>
</html>