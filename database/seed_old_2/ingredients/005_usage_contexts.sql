INSERT INTO usage_contexts (name)
VALUES
    ('Pizza'),
    ('Appetizer'),
    ('Salad'),
    ('Pasta'),
    ('Dessert'),
    ('Sauce'),
    ('Drink'),
    ('Dough'),
    ('Lunch Box')
ON CONFLICT (name) DO NOTHING;
