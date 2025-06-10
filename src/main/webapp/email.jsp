<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>email</title>
<link rel="stylesheet" href="email.css">
</head>
<body>
<div class="container">
<div class="heading1">
<h2>Enter the Email Address</h2>
</div>
<div class="heading2">

    <form action="UserDetailsServlet" method="post">
    
        <% 
            // Display the error message if available
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) { 
        %>
            <p class="error-message"><%= errorMessage %></p>
        <% 
            } 
        %>
        <label>Email</label><input type="email" name="email" required><br>
        <input type="hidden" name="step" value="3">
        <button type="submit">Next</button>
    </form>
    </div>
</div>
</body>
</html>
