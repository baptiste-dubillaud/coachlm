-- Create authentication and users tables
-- depends: 001_050126_create_documents_table

CREATE TABLE auth_methods (
    method_name VARCHAR(50) PRIMARY KEY
);

/* Insert default authentication methods */
INSERT INTO
    auth_methods (method_name)
VALUES ('standard'),
    ('oauth2')
ON CONFLICT (method_name) DO NOTHING;

/* Users table with UUID as primary key */
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    username VARCHAR(255) NOT NULL UNIQUE,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    email_verified BOOLEAN DEFAULT FALSE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    auth_method VARCHAR(50) NOT NULL,
    last_login_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_auth_method FOREIGN KEY (auth_method) REFERENCES auth_methods (method_name) ON DELETE RESTRICT,
    CONSTRAINT chk_email_format CHECK (
        email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    )
);

/* Standard authentication credentials */
CREATE TABLE user_credentials (
    credential_id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    password_changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    requires_password_change BOOLEAN DEFAULT FALSE,
    failed_login_attempts INTEGER DEFAULT 0,
    locked_until TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

/* OAuth provider connections */
CREATE TABLE oauth_connections (
    connection_id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL,
    provider VARCHAR(50) NOT NULL,
    provider_user_id VARCHAR(255) NOT NULL,
    access_token TEXT,
    refresh_token TEXT,
    token_expires_at TIMESTAMP WITH TIME ZONE,
    scope TEXT,
    profile_data JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_oauth_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
    CONSTRAINT uq_provider_user UNIQUE (provider, provider_user_id)
);

/* Indexes for faster lookups */
CREATE INDEX users_email_idx ON users (email);

CREATE INDEX users_username_idx ON users (username);

CREATE INDEX users_auth_method_idx ON users (auth_method);

CREATE INDEX users_active_idx ON users (is_active)
WHERE
    is_active = TRUE;

CREATE INDEX oauth_connections_user_idx ON oauth_connections (user_id);

CREATE INDEX oauth_connections_provider_idx ON oauth_connections (provider);

/* Trigger to update updated_at timestamp */
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_credentials_updated_at
    BEFORE UPDATE ON user_credentials
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_oauth_updated_at
    BEFORE UPDATE ON oauth_connections
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();