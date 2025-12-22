from pydantic import BaseModel

class DatabaseStatus(BaseModel):
    """Database status model."""
    status: str
    pgvector_version: str

class HealthResponse(BaseModel):
    """Health check response model."""
    global_status: str
    database: DatabaseStatus
    
