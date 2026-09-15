INSERT INTO admins (
    username,
    password_hash,
    full_name,
    is_active,
    created_at,
    last_login_at
)
VALUES (
    'administrator',
    '$2b$12$GkmiKkw//9PkQAFeLEGoZumaBXfn8diG1HOixlGFRh3gAo4czs/Qu',
    'System Administrator',
    TRUE,
    '2026-01-01 09:00:00+03',
    NULL
)
ON CONFLICT DO NOTHING;
