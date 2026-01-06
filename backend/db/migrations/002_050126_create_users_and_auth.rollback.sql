-- Rollback for create users and auth tables
-- depends: 001_050126_create_documents_table

-- Drop triggers first
DROP TRIGGER IF EXISTS update_oauth_updated_at ON oauth_connections;

DROP TRIGGER IF EXISTS update_credentials_updated_at ON user_credentials;

DROP TRIGGER IF EXISTS update_users_updated_at ON users;

-- Drop indexes
DROP INDEX IF EXISTS oauth_connections_provider_idx;

DROP INDEX IF EXISTS oauth_connections_user_idx;

DROP INDEX IF EXISTS users_active_idx;

DROP INDEX IF EXISTS users_auth_method_idx;

DROP INDEX IF EXISTS users_username_idx;

DROP INDEX IF EXISTS users_email_idx;

-- Drop tables in reverse order (respecting foreign key constraints)
DROP TABLE IF EXISTS oauth_connections;

DROP TABLE IF EXISTS user_credentials;

DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS auth_methods;

-- Drop the trigger function
DROP FUNCTION IF EXISTS update_updated_at_column ();