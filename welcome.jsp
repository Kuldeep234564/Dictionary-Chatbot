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
            const userMessage = document.getElementById("userMessage").value;

            // Clear the reply container before fetching a new response
            document.getElementById("botReply").innerText = "Thinking...";

            // Send the message to the Flask server using fetch
            fetch('http://localhost:5000/chat', { // Adjust the URL if needed to match your Flask server's endpoint
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ message: userMessage })
            })
            .then(response => response.json())
            .then(data => {
                // Display the bot's reply or an error message
                if (data.reply) {
                    document.getElementById("botReply").innerText = data.reply;
                } else {
                    document.getElementById("botReply").innerText = "Error: " + data.error;
                }
            })
            .catch(error => {
                // Handle errors in communication
                document.getElementById("botReply").innerText = "An error occurred while connecting to the server.";
                console.error('Error:', error);
            });

            // Clear the input field after sending the message
            document.getElementById("userMessage").value = "";
        }
    </script>
</body>
</html>
