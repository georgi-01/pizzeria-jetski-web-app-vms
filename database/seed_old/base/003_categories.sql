INSERT INTO categories (name)
VALUES
    ('Pizza'),
    ('Appetizers'),
    ('Salads'),
    ('Pasta'),
    ('Desserts'),
    ('Drinks'),
    ('Lunch Boxes'),
    ('Sauces')
ON CONFLICT (name) DO NOTHING;
