from flask import Flask, request, jsonify
from flask_cors import CORS
import re
import json

app = Flask(__name__)

# Enable CORS
CORS(app, resources={r"/*": {"origins": "http://localhost:8080"}})

# Load patterns and responses from the JSON file
with open("dataset.json", "r") as json_file:
    dataset = json.load(json_file)
patterns = dataset["patterns"]
responses = dataset["responses"]

@app.route('/chat', methods=['POST'])
def chat():
    try:
        # Parse the JSON body
        data = request.get_json()
        user_message = data.get('message') if data else None
        if user_message is None:
            return jsonify({'error': 'Message is missing in the request'}), 400

        # Match user message against patterns
        for key, pattern in patterns.items():
            if re.search(pattern, user_message, re.IGNORECASE):
                return jsonify({'reply': responses[key]})

        # If no valid pattern is found
        return jsonify({'error': 'Sorry, I do not understand your query.'}), 400

    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True, port=5000)
