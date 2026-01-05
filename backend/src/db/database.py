import os

import psycopg
from pgvector.psycopg import register_vector

POSTGRES_HOST = os.getenv("POSTGRES_HOST", "")
POSTGRES_PORT = os.getenv("POSTGRES_PORT", "5432")
DATABASE_NAME = os.getenv("DATABASE_NAME", "")
POSTGRES_USER = os.getenv("POSTGRES_USER", "")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD", "")


def get_db_connection():
    """Create a database connection with pgvector support."""
    if not DATABASE_NAME:
        raise ValueError("DATABASE_NAME environment variable is not set")

    conn = psycopg.connect(
        host=POSTGRES_HOST,
        port=POSTGRES_PORT,
        dbname=DATABASE_NAME,
        user=POSTGRES_USER,
        password=POSTGRES_PASSWORD,
    )
    register_vector(conn)
    return conn


def get_db():
    """Dependency for database connection."""
    conn = get_db_connection()
    try:
        yield conn
    finally:
        conn.close()
