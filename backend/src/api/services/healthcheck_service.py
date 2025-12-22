from fastapi import HTTPException
import psycopg

from src.api.models.healthcheck_models import HealthResponse, DatabaseStatus

def health_check(conn: psycopg.Connection):
    """Health check endpoint that verifies database and pgvector status."""
    try:
        with conn.cursor() as cur:
            # Check database connection
            cur.execute("SELECT 1")
            
            # Check pgvector extension
            cur.execute("SELECT extversion FROM pg_extension WHERE extname = 'vector'")
            result = cur.fetchone()
            pgvector_version = result[0] if result else "not installed"
            
        return HealthResponse(
            global_status="healthy",
            database=DatabaseStatus(
                status="connected",
                pgvector_version=pgvector_version
            )
        )
    except Exception as e:
        raise HTTPException(status_code=503, detail=f"Database error: {str(e)}")
