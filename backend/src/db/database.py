import os

import psycopg
from pgvector.psycopg import register_vector

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://app:app_password@db:5432/appdb")

def get_db_connection():
    """Create a database connection with pgvector support."""
    conn = psycopg.connect(DATABASE_URL)
    register_vector(conn)
    return conn


def get_db():
    """Dependency for database connection."""
    conn = get_db_connection()
    try:
        yield conn
    finally:
        conn.close()