from flask import Flask, request, jsonify
from flask_cors import CORS
import re
import json

app = Flask(__name__)

# Enable CORS
CORS(app, resources={r"/*": {"origins": "http://localhost:8080"}})

# Load dataset from the JSON file
with open("dataset.json", "r", encoding="utf-8") as json_file:
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
        user_message = data.get('message', "").strip().lower()

        if not user_message:
            return jsonify({'error': 'Message is missing in the request'}), 400

        # Check for idioms
        for key, details in idioms.items():
            if re.search(r'\b' + re.escape(key) + r'\b', user_message, re.IGNORECASE):
                return jsonify({
                    'reply': f'🔹 Idiom: "{key}"\n📖 Meaning: {details["meaning"]}\n📝 Example: {details["example"]}'
                })

        # Check for phrasal verbs
        for key, details in phrasal_verbs.items():
            if re.search(r'\b' + re.escape(key) + r'\b', user_message, re.IGNORECASE):
                return jsonify({
                    'reply': f'🔹 Phrasal Verb: "{key}"\n📖 Meaning: {details["meaning"]}\n📝 Example: {details["example"]}'
                })

        # Check for words
        for word, details in words.items():
            if re.search(r'\b' + re.escape(word) + r'\b', user_message, re.IGNORECASE):
                return jsonify({
                    'reply': f'🔠 Word: "{word}"\n📖 Meaning: {details["meaning"]}\n'
                             f'✅ Synonyms: {", ".join(details["synonyms"])}\n'
                             f'❌ Antonyms: {", ".join(details["antonyms"])}\n'
                             f'📝 Example: {details["example"]}'
                })
                

        return jsonify({'reply': "❌ Sorry, I do not understand your query."})

    except Exception as e:
        return jsonify({'error': str(e)}), 400
    

if __name__ == '__main__':
    app.run(debug=True, port=5000)
