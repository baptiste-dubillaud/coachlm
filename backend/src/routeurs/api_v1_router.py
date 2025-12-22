from fastapi import APIRouter, status

from src.routeurs.v1.healthcheck.healthcheck_router import router as healthcheck_router

# Versioning router 
router = APIRouter(prefix="/v1")

router.include_router(healthcheck_router)

# Welcome endpoint for API v1
@router.get("/", status_code=status.HTTP_200_OK)
def welcome_v1():
    """Welcome endpoint for API v1."""
    return {"message": "Welcome to API version 1"}
