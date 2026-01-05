-- Create authentication and users tables
-- depends: 001_050126_create_documents_table

CREATE TABLE auth_methods (
    id SERIAL PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
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
    full_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    auth_method_id INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_auth_method FOREIGN KEY (auth_method_id) REFERENCES auth_methods (id) ON DELETE RESTRICT
);

/* Indexes for faster lookups */
CREATE INDEX users_email_idx ON users (email);

CREATE INDEX users_username_idx ON users (username);

CREATE INDEX users_auth_method_idx ON users (auth_method_id);