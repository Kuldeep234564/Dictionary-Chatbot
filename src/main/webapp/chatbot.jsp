<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DicChat</title>
<link rel="stylesheet" href="chatbot.css">
</head>
<body>
<header class="header">
    <div class="left-section">
        <img src="images/chat.png" alt="Chat" class="chat-pic">
    </div>
    <div class="right-section">
        <img src="images/profile.png" alt="Profile" class="profile-pic">
        <a href="logout.jsp"><button class="logout-btn">Logout</button></a>
    </div>
</header>

<!-- Background Overlay -->
<div id="overlay" class="overlay"></div>

<!-- Popup Box -->
<div id="popupBox" class="popup-container">
    <p>Please login or create an account</p>
    <button class="login-btn" onclick="redirectToLogin()">Login</button>
    <button class="register-btn" onclick="redirectToRegister()">Register</button>
</div>

<div class="chat-container">
    <h2>Dictionary Chatbot</h2>
    <div class="input-container">
        <input type="text" id="userMessage" placeholder="Type your message here..." />
        <button onclick="sendMessage()">Send</button>
    </div>
    <div id="botReply" class="bot-reply"></div>
</div>

<script>
    // Show popup when page loads
    window.onload = function() {
        document.getElementById("popupBox").style.display = "block";
        document.getElementById("overlay").style.display = "block";

        setTimeout(() => {
            document.getElementById("popupBox").style.opacity = "1";
            document.getElementById("popupBox").style.transform = "translate(-50%, -50%) scale(1)";
        }, 100);

        document.body.classList.add("modal-open"); // Disable scrolling
    };

    // Redirect to login page
    function redirectToLogin() {
        window.location.href = "login.jsp";
    }

    // Redirect to register page
    function redirectToRegister() {
        window.location.href = "name.jsp";
    }
</script>
</body>
</html>