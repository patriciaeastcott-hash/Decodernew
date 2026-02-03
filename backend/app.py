import os
import json
import logging
import datetime
from flask import Flask, request, jsonify, redirect
from flask_cors import CORS
import google.generativeai as genai
from dotenv import load_dotenv

# --- CONFIGURATION ---
load_dotenv()
app = Flask(__name__)

# Full CORS for cross-platform app communication
CORS(app, resources={r"/*": {"origins": "*"}})

API_KEY = os.getenv("GEMINI_API_KEY")
if API_KEY:
    genai.configure(api_key=API_KEY)

# Transparency & Legal
AI_DISCLOSURE = "AI-Generated Content: This analysis is provided for educational purposes. Digital ABCs does not provide psychological or legal advice."
PRIVACY_URL = "https://www.digitalabcs.com.au/privacy.html"
TERMS_URL = "https://www.digitalabcs.com.au/terms.html"

# Restored System Instruction
SYSTEM_INSTRUCTION = """
You are an expert Linguistic Analyst providing multi-perspective communication analysis.
ANALYZE conversations for intents, styles, and interaction patterns.
DETECTION RULES: Use names if present, attribute every sentence, detect speaker changes via context.
ANALYTICAL FRAMEWORK: Emotional, Strategic, Relational, and Underlying Needs.
INTERACTION PATTERNS: Double Bind, DARVO, Reality-questioning, Dismissal, etc.
NO psychological diagnoses. Ground all observations in specific textual evidence.
"""

def generate_with_fallback(prompt, model_name='gemini-1.5-flash'):
    try:
        model = genai.GenerativeModel(model_name=model_name, system_instruction=SYSTEM_INSTRUCTION)
        response = model.generate_content(
            prompt, 
            generation_config={"temperature": 0.4, "response_mime_type": "application/json"}
        )
        data = json.loads(response.text)
        data["ai_disclosure"] = AI_DISCLOSURE
        return data
    except Exception as e:
        logging.error(f"Generation failed: {e}")
        return {"error": "SERVICE_BUSY", "message": str(e)}

# --- ENDPOINTS ---

@app.route('/analyze', methods=['POST'])
def analyze():
    text = request.json.get('text', '')
    prompt = f"Analyze the following conversation using objective linguistic analysis:\n{text}"
    return jsonify(generate_with_fallback(prompt))

@app.route('/analyze-profile', methods=['POST'])
def analyze_profile():
    data = request.json
    name = data.get('name', 'Speaker')
    logs = data.get('logs', [])
    history = "\\n".join([f"[{l.get('date')}] {l.get('text')}" for l in logs[-15:]])
    prompt = f"Analyze recurring linguistic patterns for {name} based on history:\n{history}"
    return jsonify(generate_with_fallback(prompt, model_name='gemini-1.5-pro'))

@app.route('/simulate', methods=['POST'])
def simulate():
    data = request.json
    context = data.get('context', '')
    draft = data.get('draft', '')
    profile = data.get('recipient_profile', '')
    prompt = f"Context: {context}\nRecipient Style: {profile}\nDraft: {draft}\nAnalyze likely interpretation."
    return jsonify(generate_with_fallback(prompt))

@app.route('/identify-speakers', methods=['POST'])
def identify_speakers():
    text = request.json.get('text', '')
    prompt = f"Analyze this conversation and identify distinct speakers and labels:\n{text}"
    return jsonify(generate_with_fallback(prompt))

@app.route('/privacy')
def privacy(): return redirect(PRIVACY_URL)

@app.route('/terms')
def terms(): return redirect(TERMS_URL)

@app.route('/health')
def health(): return jsonify({"status": "live", "compliance": "Australian Privacy Act 1988"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv("PORT", 8080)))