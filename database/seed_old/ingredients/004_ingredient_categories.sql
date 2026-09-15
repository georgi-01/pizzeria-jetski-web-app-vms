INSERT INTO ingredient_categories (name)
VALUES
    ('Cheese'),
    ('Meat'),
    ('Vegetables'),
    ('Fruits'),
    ('Seafood'),
    ('Sauces'),
    ('Spices'),
    ('Herbs'),
    ('Dough Ingredients'),
    ('Other')
ON CONFLICT (name) DO NOTHING;
