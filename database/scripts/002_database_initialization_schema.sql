-- PIZZERIA JETSKI WEB APP
-- Database Initialization State
-- PostgreSQL

CREATE TABLE database_initialization (
    id BOOLEAN PRIMARY KEY DEFAULT TRUE
        CHECK (id = TRUE),
    seed_version INTEGER NOT NULL,
    initialized BOOLEAN NOT NULL DEFAULT FALSE,
    initialized_at TIMESTAMPTZ,
    environment TEXT NOT NULL
        CHECK (environment IN ('DEVELOPMENT', 'PRODUCTION'))
);
