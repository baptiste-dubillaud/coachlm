-- Create documents table with pgvector support
-- depends:

/* Enable pgvector extension on database initialization */
CREATE EXTENSION IF NOT EXISTS vector;

/* Documents table with vector embeddings
-- Adjust the vector dimension (1536) based on your embedding model
-- OpenAI text-embedding-ada-002: 1536 dimensions
-- OpenAI text-embedding-3-small: 1536 dimensions
-- OpenAI text-embedding-3-large: 3072 dimensions*/
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    embedding vector (1536),
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

/* Create an index for fast similarity search using HNSW (recommended for most cases) */
CREATE INDEX documents_embedding_idx ON documents USING hnsw (embedding vector_cosine_ops);