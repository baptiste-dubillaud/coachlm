from fastapi import APIRouter, status, Depends

from src.db.database import get_db
from src.api.models.healthcheck_models import HealthResponse
from src.api.services.healthcheck_service import health_check

router = APIRouter()

@router.get("/healthcheck", response_model=HealthResponse, status_code=status.HTTP_200_OK)
def get_healthcheck(conn=Depends(get_db)):
    """Health check endpoint."""
    return health_check(conn)