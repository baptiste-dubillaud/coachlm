from fastapi import FastAPI
from src.db.database import get_db_connection


async def api_lifespan_start(app: FastAPI):
    """Application lifespan manager - runs on startup and shutdown."""
    # Startup: verify database connection and pgvector extension
    try:
        conn = get_db_connection()
        with conn.cursor() as cur:
            cur.execute("SELECT extversion FROM pg_extension WHERE extname = 'vector'")
            result = cur.fetchone()
            if result:
                print(
                    f"[✓] - Connected to PostgreSQL with pgvector extension v{result[0]}"
                )
            else:
                print("[X] -pgvector extension not found")
        conn.close()
    except Exception as e:
        print(f"[X] - Database connection error: {e}")


async def api_lifespan_end(app: FastAPI):
    """Cleanup tasks on application shutdown."""
    print("Shutting down application...")
