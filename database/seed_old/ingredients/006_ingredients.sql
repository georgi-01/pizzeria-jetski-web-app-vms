INSERT INTO ingredients (
    ingredient_category_id,
    code,
    name,
    price
)
SELECT
    ic.id,
    v.code,
    v.name,
    v.price
FROM (
    VALUES
        -- Cheese
        ('CHEESE', 'MOZ',  'Mozzarella',    12.50),
        ('CHEESE', 'CHED', 'Cheddar',       14.00),
        ('CHEESE', 'PAR',  'Parmesan',      24.00),

        -- Meat
        ('MEAT', 'HAM',  'Ham',             11.50),
        ('MEAT', 'PEP',  'Pepperoni',       16.00),
        ('MEAT', 'BAC',  'Bacon',           15.00),
        ('MEAT', 'CHK',  'Chicken Breast',  13.00),
        ('MEAT', 'BEEF', 'Ground Beef',     14.50),

        -- Vegetables
        ('VEGETABLES', 'TOM',  'Tomato',       4.50),
        ('VEGETABLES', 'ONI',  'Red Onion',    3.50),
        ('VEGETABLES', 'BEP',  'Bell Pepper',  5.00),
        ('VEGETABLES', 'MUS',  'Mushrooms',    6.50),
        ('VEGETABLES', 'OLV',  'Olives',       8.00),
        ('VEGETABLES', 'JAL',  'Jalapeño',     9.00),
        ('VEGETABLES', 'CORN', 'Corn',         5.50),
        ('VEGETABLES', 'GAR',  'Garlic',       8.00),

        -- Fruits
        ('FRUITS', 'PIN', 'Pineapple', 6.50),

        -- Seafood
        ('SEAFOOD', 'TUN', 'Tuna', 15.00),

        -- Sauces
        ('SAUCES', 'TSA', 'Tomato Sauce', 5.50),
        ('SAUCES', 'GSA', 'Garlic Sauce', 7.00),
        ('SAUCES', 'BBQ', 'BBQ Sauce',    6.50),

        -- Spices
        ('SPICES', 'SAL', 'Salt',        1.50),
        ('SPICES', 'BPEP', 'Black Pepper', 8.00),
        ('SPICES', 'PAP', 'Paprika',     6.00),

        -- Herbs
        ('HERBS', 'ORE', 'Oregano', 12.00),
        ('HERBS', 'BAS', 'Basil',   15.00),

        -- Dough Ingredients
        ('DOUGH INGREDIENTS', 'FLR', 'Wheat Flour', 1.80),
        ('DOUGH INGREDIENTS', 'YST', 'Yeast',       7.00),
        ('DOUGH INGREDIENTS', 'OIL', 'Olive Oil',   12.00),

        -- Other
        ('OTHER', 'SUG', 'Sugar', 2.00)
) AS v(category_name, code, name, price)
JOIN ingredient_categories ic
    ON ic.name = v.category_name
ON CONFLICT (code) DO NOTHING;
