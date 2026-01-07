from fastapi import HTTPException
from psycopg import Connection
from src.api.models.healthcheck_models import DatabaseStatus, HealthResponse


def health_check(db_conn: Connection):
    """Health check endpoint that verifies database and pgvector status."""
    try:
        with db_conn.cursor() as cur:
            # Check database connection
            cur.execute("SELECT 1")

            # Check pgvector extension
            cur.execute("SELECT extversion FROM pg_extension WHERE extname = 'vector'")
            result = cur.fetchone()
            pgvector_version = result[0] if result else "not installed"

            print(f"[✓] - Database connected. pgvector version: {pgvector_version}")

        return HealthResponse(
            global_status="healthy",
            database=DatabaseStatus(
                status="connected", pgvector_version=pgvector_version
            ),
        )
    except Exception as e:
        print(f"[X] - Health check failed: {e}")
        raise HTTPException(status_code=503, detail=f"Database error: {str(e)}")
