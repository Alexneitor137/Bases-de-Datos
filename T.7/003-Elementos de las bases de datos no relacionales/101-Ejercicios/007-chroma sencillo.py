import chromadb

# Create / load ChromaDB
client = chromadb.Client()

# Create or get a collection
collection = client.get_or_create_collection(
    name="frutas"
)

# Store the embedding of "fresa"
collection.add(
    ids=["fresa"],
    embeddings=[fresa],
    documents=["fresa"]
)

print("Embedding de 'fresa' almacenado en ChromaDB")