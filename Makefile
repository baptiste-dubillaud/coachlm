# Declare all targets as phony (not associated with actual files)
.PHONY: help
.PHONY: migrate-upgrade migrate-downgrade migrate-status migrate-history migrate-new db-shell
.PHONY: docker-up docker-down docker-restart docker-logs docker-build docker-clean
.PHONY: docker-migrate-upgrade docker-migrate-downgrade

##### Variables
# Database configuration
# These can be overridden from the command line, e.g., make migrate-upgrade POSTGRES_USER=myuser
# Load environment variables from .env file
include .env
export

# Directory paths for backend code and database migrations
BACKEND_DIR = backend
MIGRATIONS_DIR = $(BACKEND_DIR)/migrations

##### Docker Compose Commands
# Start all services defined in docker-compose.yml in detached mode
docker-up:
	@echo "Starting Docker containers..."
	@docker compose up -d

# Stop all running Docker containers
docker-down:
	@echo "Stopping Docker containers..."
	@docker compose down

# Restart all Docker containers without rebuilding
docker-restart:
	@echo "Restarting Docker containers..."
	@docker compose restart

# Display and follow logs from all Docker containers
docker-logs:
	@echo "Showing Docker logs..."
	@docker compose logs -f

# Build or rebuild Docker images from docker-compose.yml
docker-build:
	@echo "Building Docker images..."
	@docker compose build

# Stop containers and remove containers, networks, and volumes
docker-clean:
	@echo "Stopping and removing containers, networks, and volumes..."
	@docker compose down -v

##### Local Migration Commands (run on host machine)
# Apply all pending database migrations using migrate.py
migrate-upgrade:
	@echo "Applying all pending migrations..."
	@cd $(BACKEND_DIR) && python db/migrate.py upgrade

# Rollback the most recent database migration
migrate-downgrade:
	@echo "Rolling back last migration..."
	@cd $(BACKEND_DIR) && python db/migrate.py downgrade --steps 1

# Show the current migration status (which migrations are pending)
migrate-status:
	@echo "Migration status:"
	@cd $(BACKEND_DIR) && yoyo list --database postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST):$(POSTGRES_PORT)/$(POSTGRES_DB) db/migrations

# Display a list of all applied migrations
migrate-history:
	@echo "Applied migrations:"
	@cd $(BACKEND_DIR) && yoyo list --database postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST):$(POSTGRES_PORT)/$(POSTGRES_DB) db/migrations

# Create a new migration file with the specified message
# Requires MSG variable to be set, e.g., make migrate-new MSG='add users table'
migrate-new:
ifndef MSG
	@echo "Error: MSG variable required"
	@echo "Usage: make migrate-new MSG='description of migration'"
	@exit 1
endif
	@cd $(BACKEND_DIR) && python db/migrate.py new "$(MSG)"

# Open a PostgreSQL shell connected to the database inside the Docker container
db-shell:
	@echo "Opening database shell..."
	@docker exec -it app-db psql -U app -d appdb

##### Docker Migration Commands (run inside containers)
# Apply all pending migrations inside the Docker container
# Uses the app-backend container to run the migrate.py upgrade command
docker-migrate-upgrade:
	@echo "Applying migrations in Docker container..."
	@docker exec -it app-backend python db/migrate.py upgrade

# Rollback the last migration inside the Docker container
# Uses the app-backend container to run the migrate.py downgrade command
docker-migrate-downgrade:
	@echo "Rolling back in Docker container..."
	@docker exec -it app-backend python db/migrate.py downgrade

# Display help information with available commands and usage examples
help:
	@echo "Database Migration Commands"
	@echo "---------------------------"
	@echo "make migrate-upgrade      - Apply all pending migrations"
	@echo "make migrate-downgrade    - Rollback the last migration"
	@echo "make migrate-status       - Show migration status"
	@echo "make migrate-history      - Show applied migrations"
	@echo "make migrate-new MSG='...'- Create new migration"
	@echo "make db-shell             - Open psql shell"
	@echo ""
	@echo "Docker Commands"
	@echo "---------------"
	@echo "make docker-up            - Start Docker containers"
	@echo "make docker-down          - Stop Docker containers"
	@echo "make docker-restart       - Restart Docker containers"
	@echo "make docker-logs          - Show Docker logs"
	@echo "make docker-build         - Build Docker images"
	@echo "make docker-clean         - Remove containers, networks, and volumes"
	@echo "make docker-migrate-upgrade   - Apply migrations in Docker"
	@echo "make docker-migrate-downgrade - Rollback in Docker"
	@echo ""
	@echo "Environment Variables:"
	@echo "  POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB"
	@echo "  POSTGRES_HOST, POSTGRES_PORT"
	@echo ""
	@echo "Examples:"
	@echo "  make migrate-upgrade"
	@echo "  make migrate-new MSG='add user profile'"
	@echo "  POSTGRES_USER=myuser make migrate-upgrade"
