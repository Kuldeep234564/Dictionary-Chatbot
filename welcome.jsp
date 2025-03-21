<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dictionary Chatbot</title>
    <link rel="stylesheet" href="welcome.css">
</head>
<body>
 <div class="top-right">
        <img src="profile.png" alt="Profile" class="profile-pic">
        <a href="login.jsp"><button class="logout-btn">Logout</button></a>
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
    // Function to send the message to the Flask backend
function sendMessage() {
    const userMessage = document.getElementById("userMessage").value.trim(); // Trim spaces

    if (userMessage === "") {
        alert("Please enter a message!"); // Prevent empty input
        return;
    }

    // Show "Thinking..." while waiting for a response
    document.getElementById("botReply").innerText = "Thinking...";

    // Send user input to Flask backend
    fetch('http://localhost:5000/chat', { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ message: userMessage.toLowerCase() }) // Convert to lowercase
    })
    .then(response => response.json())
    .then(data => {
        if (data.reply) {
            document.getElementById("botReply").innerText = data.reply;
        } else {
            document.getElementById("botReply").innerText = "❌ " + (data.error || "I don't understand your query.");
        }
    })
    .catch(error => {
        document.getElementById("botReply").innerText = "⚠️ Error connecting to the server.";
        console.error('Error:', error);
    });

    // Clear input field after sending message
    document.getElementById("userMessage").value = "";
}
//Detect "Enter" key press in the input field
document.getElementById("userMessage").addEventListener("keypress", function(event) {
    if (event.key === "Enter") { // Check if the key pressed is "Enter"
        event.preventDefault(); // Prevent default form submission
        sendMessage(); // Call sendMessage() function
    }
});
  </script>  
</body>
</html>
