from typing import List

from pydantic import BaseModel

class VectorSearchRequest(BaseModel):
    """Request model for vector similarity search."""
    embedding: List[float]
    limit: int = 10
