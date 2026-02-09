#!/usr/bin/env python3
import json
import urllib.request
import chromadb
from chromadb.config import Settings

# -------- OLLAMA CONFIG --------
OLLAMA_URL = "http://localhost:11434/api/embeddings"
MODEL = "nomic-embed-text:v1.5"
TEXT = "fresa"

# -------- GET EMBEDDING FROM OLLAMA --------
payload = {
    "model": MODEL,
    "prompt": TEXT
}

req = urllib.request.Request(
    OLLAMA_URL,
    data=json.dumps(payload).encode("utf-8"),
    headers={"Content-Type": "application/json"},
    method="POST",
)

with urllib.request.urlopen(req) as resp:
    data = json.loads(resp.read().decode("utf-8"))

fresa = data["embedding"]

# -------- CHROMADB (PERSISTENT) --------
client = chromadb.Client(
    Settings(
        persist_directory="./chroma_db"
    )
)

collection = client.get_or_create_collection(
    name="frutas"
)

collection.add(
    ids=["fresa"],
    embeddings=[fresa],
    documents=["fresa"]
)

print("OK: embedding de 'fresa' guardado en ./chroma_db")