-- Rollback for create users and auth tables
-- depends: 001_050126_create_documents_table

DROP INDEX IF EXISTS users_auth_method_idx;

DROP INDEX IF EXISTS users_username_idx;

DROP INDEX IF EXISTS users_email_idx;

DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS auth_methods;