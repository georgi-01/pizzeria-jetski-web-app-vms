INSERT INTO roles (name)
VALUES
    ('General Manager'),
    ('Assistant Manager'),
    ('Manager'),
    ('Pizza Maker'),
    ('Delivery Driver')
ON CONFLICT (name) DO NOTHING;
