# coachlm
A simple sport plannifier using LLM and RAG
 
## Dockerized App Stack

This repo includes a Docker ecosystem for a three-service app:

- **Backend**: FastAPI (Python) exposing `/api/v1` endpoints
- **Frontend**: Vue.js 3 + Vite development server
- **Database**: PostgreSQL 18 with `pgvector` extension enabled

### Stack Components

- Compose file: [docker-compose.yml](docker-compose.yml)
- Environment: [.env](.env)
- Backend (FastAPI): [backend/](backend)
- Frontend (Vue.js + Vite): [frontend/](frontend)
- Database init (pgvector): [db/init.sql](db/init.sql)

### Prerequisites

- Docker Desktop (Windows/macOS) or Docker Engine + Docker Compose

### Quick Start

```powershell
# Build and start all services
docker compose up -d --build

# View container status
docker compose ps

# Tail logs (Ctrl+C to stop following)
docker compose logs -f
```

Once up:

- **Frontend**: http://localhost:3000
- **Backend API docs**: http://localhost:8000/docs
- **Backend health**: http://localhost:8000/api/v1/healthcheck
- **Postgres**: localhost:5432 (user/db/password from `.env`)

### Backend API

Current endpoints:

- `GET /api/v1/healthcheck` – Health check with database status
- `GET /api/v1/` – API version 1 welcome message
- `GET /` – Root endpoint with API info

For full API documentation, visit http://localhost:8000/docs (Swagger UI) when the backend is running.

### Environment

Defaults are set in [.env](.env):

- `POSTGRES_USER=app`
- `POSTGRES_PASSWORD=app_password`
- `POSTGRES_DB=appdb`
- `DATABASE_URL=postgresql://app:app_password@db:5432/appdb`

Override by editing `.env` before starting, or by passing env vars at runtime.

### Common Commands

```powershell
# Stop services
docker compose down

# Stop and remove volumes (DB data reset)
docker compose down -v

# Rebuild images (after code changes)
docker compose build --no-cache

# Exec into backend container
docker compose exec backend sh

# Connect to Postgres shell
docker compose exec db psql -U app -d appdb
```

### Notes

- Compose defines a custom network `app-network` used by all services.
- The Postgres service uses `pgvector/pgvector:pg18` and enables the `vector` extension via [db/init.sql](db/init.sql).
- The frontend runs Vite's development server with hot module reloading (HMR).
- Backend and frontend run on separate ports: backend on 8000, frontend on 3000.

### Troubleshooting

- If the backend shows DB connection errors at boot, ensure the DB is healthy: `docker compose logs db`.
- If port `3000` or `5432` is in use, stop the conflicting app or change the published ports in [docker-compose.yml](docker-compose.yml).
