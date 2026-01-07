from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from src.api.routeurs.api_v1_router import router as v1_router
from src.api.services.lifespan_service import api_lifespan_end, api_lifespan_start


@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Lifespan context manager for FastAPI application.

    :param app: FastAPI application instance
    :type app: FastAPI
    """
    await api_lifespan_start(app)

    yield

    await api_lifespan_end(app)


# FastAPI application instance
app = FastAPI(title="App Backend", version="0.1.0", lifespan=lifespan)

# CORS middleware configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(v1_router, prefix="/api")


@app.get("/")
def root():
    """Root endpoint."""
    return {"message": "Welcome to the CoachLM API", "docs": "/docs"}
