# coachlm
A simple sport plannifier using LLM and RAG
 
## Dockerized App Stack

This repo includes a Docker ecosystem for a three-service app:

- Backend: FastAPI (Python) exposing `/api` endpoints
- Frontend: Static site served by Nginx (proxies `/api` to backend)
- Database: PostgreSQL with `pgvector` extension enabled

### Stack Components

- Compose file: [docker-compose.yml](docker-compose.yml)
- Environment: [.env](.env)
- Backend (FastAPI): [backend/](backend)
- Frontend (Nginx + static): [frontend/](frontend)
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

- Frontend: http://localhost:3000
- Backend health (proxied via frontend): http://localhost:3000/api/health
- Postgres: localhost:5432 (user/db/password from `.env`)

### Backend API

- `GET /api/health` – health + DB status
- `POST /api/embed` – body: `{ "content": string, "embedding": [f1,f2,f3] }`
- `GET /api/search?embedding=v1,v2,v3&limit=5` – nearest neighbors by vector distance
- `POST /api/seed` – inserts a few demo rows

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
- The Postgres service uses `pgvector/pgvector:pg16` and enables the `vector` extension via [db/init.sql](db/init.sql).
- The frontend Nginx config proxies `/api/*` to `backend:8000` inside the compose network, so the browser talks to one origin at port 3000.

### Troubleshooting

- If the backend shows DB connection errors at boot, ensure the DB is healthy: `docker compose logs db`.
- If port `3000` or `5432` is in use, stop the conflicting app or change the published ports in [docker-compose.yml](docker-compose.yml).
