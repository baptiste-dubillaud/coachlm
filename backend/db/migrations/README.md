# Database Migrations

This directory contains SQL migration files managed by yoyo-migrations.

## Quick Start

### Using Makefile (Recommended)

```bash
# Apply all pending migrations
make migrate-upgrade

# Rollback last migration
make migrate-downgrade

# Create new migration
make migrate-new MSG="add user profile table"

# Check migration status
make migrate-status

# View migration history
make migrate-history
```

### Using Python Script Directly

```bash
# Apply all pending migrations
cd backend
python db/migrate.py upgrade

# Rollback last migration
python db/migrate.py downgrade

# Create new migration
python db/migrate.py new "add user profile table"
```

### In Docker Container

```bash
# Apply migrations
make docker-migrate-upgrade

# Or directly
docker exec -it app-backend python db/migrate.py upgrade
```

## Migration File Format

Yoyo-migrations uses separate files for upgrade and rollback operations.

### Naming Convention
- Upgrade: `INDEX_DDMMYY_description.sql`
- Rollback: `INDEX_DDMMYY_description.rollback.sql`

Example:
- `001_050126_create_documents_table.sql`
- `001_050126_create_documents_table.rollback.sql`

### File Structure

**Migration file (upgrade):**
```sql
-- Create documents table with pgvector support
-- depends:

CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    embedding vector(1536),
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX documents_embedding_idx ON documents USING hnsw (embedding vector_cosine_ops);
```

**Rollback file:**
```sql
-- Rollback for create documents table
-- depends:

DROP INDEX IF EXISTS documents_embedding_idx;
DROP TABLE IF EXISTS documents;
DROP EXTENSION IF EXISTS vector;
```

### Dependencies

Specify dependencies using the `-- depends:` directive:

```sql
-- depends: 001_050126_create_documents_table

CREATE TABLE users (...);
```

### Non-Transactional Migrations

For operations that cannot run in a transaction (e.g., `CREATE DATABASE`, `ALTER TYPE ... ADD VALUE`):

```sql
-- transactional: false

CREATE DATABASE mydb;
```

## Environment Variables

Configuration is loaded from the `.env` file in the project root:

```bash
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=coachlm
POSTGRES_PASSWORD=coachlm_password
POSTGRES_DB=coachlm
```

## Manual yoyo Commands

If needed, you can run yoyo commands directly:

```bash
# List migrations
yoyo list --database postgresql://user:pass@host:port/db db/migrations

# Apply migrations interactively
yoyo apply --database postgresql://user:pass@host:port/db db/migrations

# Mark migration as applied without running it
yoyo mark --database postgresql://user:pass@host:port/db db/migrations migration_id

# Unmark migration
yoyo unmark --database postgresql://user:pass@host:port/db db/migrations migration_id
```

## Troubleshooting

### Migrations marked as applied but not executed

If migrations show as "Applied" but tables weren't created:

1. Unmark the migrations:
```bash
cd backend
yoyo unmark --database postgresql://user:pass@localhost:5432/db db/migrations migration_name
```

2. Reapply:
```bash
make migrate-upgrade
```

### Reset all migrations

To start fresh:

```bash
# Rollback all
cd backend
yoyo rollback --database postgresql://user:pass@localhost:5432/db db/migrations --all

# Or drop yoyo tracking tables manually
psql -d yourdb -c "DROP TABLE IF EXISTS _yoyo_migration, _yoyo_log, _yoyo_version, yoyo_lock;"
```
