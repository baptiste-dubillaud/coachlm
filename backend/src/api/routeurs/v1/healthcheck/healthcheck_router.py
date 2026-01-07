from fastapi import APIRouter, Depends, status
from src.api.models.healthcheck_models import HealthResponse
from src.api.services.healthcheck_service import health_check
from src.db.database import get_db

router = APIRouter()


@router.get(
    "/healthcheck", response_model=HealthResponse, status_code=status.HTTP_200_OK
)
def get_healthcheck(db_conn=Depends(get_db)):
    """Health check endpoint."""
    return health_check(db_conn)
