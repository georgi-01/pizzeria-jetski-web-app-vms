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
	('Cheese', 'MOZ',  'Mozzarella',    12.50),
        ('Cheese', 'CHED', 'Cheddar',       14.00),
	('Cheese', 'PAR',  'Parmesan',      24.00),

	-- Meat
	('Meat', 'HAM',  'Ham',             11.50),
	('Meat', 'PEP',  'Pepperoni',       16.00),
	('Meat', 'BAC',  'Bacon',           15.00),
	('Meat', 'CHK',  'Chicken Breast',  13.00),
	('Meat', 'BEEF', 'Ground Beef',     14.50),

	-- Vegetables
	('Vegetables', 'TOM',  'Tomato',       4.50),
	('Vegetables', 'ONI',  'Red Onion',    3.50),
	('Vegetables', 'BEP',  'Bell Pepper',  5.00),
	('Vegetables', 'MUS',  'Mushrooms',    6.50),
	('Vegetables', 'OLV',  'Olives',       8.00),
	('Vegetables', 'JAL',  'Jalapeño',     9.00),
	('Vegetables', 'CORN', 'Corn',         5.50),
	('Vegetables', 'GAR',  'Garlic',       8.00),

	-- Fruits
	('Fruits', 'PIN', 'Pineapple', 6.50),

	-- Seafood
	('Seafood', 'TUN', 'Tuna', 15.00),

	-- Sauces
	('Sauces', 'TSA', 'Tomato Sauce', 5.50),
	('Sauces', 'GSA', 'Garlic Sauce', 7.00),
	('Sauces', 'BBQ', 'BBQ Sauce',    6.50),

	-- Spices
	('Spices', 'SAL',  'Salt',          1.50),
	('Spices', 'BPEP', 'Black Pepper',  8.00),
	('Spices', 'PAP',  'Paprika',       6.00),

	-- Herbs
	('Herbs', 'ORE', 'Oregano', 12.00),
	('Herbs', 'BAS', 'Basil',   15.00),

	-- Dough Ingredients
 	('Dough Ingredients', 'FLR', 'Wheat Flour', 1.80),
	('Dough Ingredients', 'YST', 'Yeast',       7.00),
	('Dough Ingredients', 'OIL', 'Olive Oil',   12.00),

	-- Other
	('Other', 'SUG', 'Sugar', 2.00)
) AS v(category_name, code, name, price)
JOIN ingredient_categories ic
    ON ic.name = v.category_name
ON CONFLICT (code) DO NOTHING;
