from flask import Flask, request, jsonify
from flask_cors import CORS
import re
import json

app = Flask(__name__)

# Enable CORS
CORS(app, resources={r"/*": {"origins": "http://localhost:8080"}})

# Load dataset from the JSON file
with open("dataset.json", "r",encoding="utf-8") as json_file:
    dataset = json.load(json_file)

# Extract idioms, phrasal verbs, and words
idioms = dataset["idioms"]
phrasal_verbs = dataset["phrasal_verbs"]
words = dataset["words"]

@app.route('/chat', methods=['POST'])
def chat():
    try:
        # Parse the JSON body
        data = request.get_json()
        user_message = data.get('message') if data else None
        if user_message is None:
            return jsonify({'error': 'Message is missing in the request'}), 400

        # Check for idioms and phrasal verbs
        for data_dict in [idioms, phrasal_verbs]:
            for key, definition in data_dict.items():
                if re.search(r'\b' + re.escape(key) + r'\b', user_message, re.IGNORECASE):
                    return jsonify({'reply': f'{key}: {definition}'})

        # Check for words
        for word, definition in words.items():
            if re.search(r'\b' + re.escape(word) + r'\b', user_message, re.IGNORECASE):
                return jsonify({'reply': f'{word}: {definition}'})

        # If no valid match is found
        return jsonify({'error': 'Sorry, I do not understand your query.'}), 400

    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True, port=5000)
