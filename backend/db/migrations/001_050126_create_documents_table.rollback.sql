-- Rollback for create documents table
DROP INDEX IF EXISTS documents_embedding_idx;

DROP TABLE IF EXISTS documents;

DROP EXTENSION IF EXISTS vector;