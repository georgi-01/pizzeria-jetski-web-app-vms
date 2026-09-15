INSERT INTO menu_items (
    category_id,
    code,
    name,
    base_price,
    is_active
)
SELECT
    c.id,
    v.code,
    v.name,
    v.base_price,
    TRUE
FROM (
    VALUES
        -- Pizzas
        ('PIZZA_MARGHERITA', 'Margherita', 9.90, 'Pizza'),
        ('PIZZA_HAM', 'Ham & Cheese', 11.90, 'Pizza'),
        ('PIZZA_PEPPERONI', 'Pepperoni', 13.90, 'Pizza'),
        ('PIZZA_BACON', 'Bacon', 13.50, 'Pizza'),
        ('PIZZA_CHICKEN', 'Chicken', 13.50, 'Pizza'),
        ('PIZZA_BEEF', 'Beef', 14.50, 'Pizza'),
        ('PIZZA_VEGGIE', 'Veggie', 11.90, 'Pizza'),
        ('PIZZA_HAWAIIAN', 'Hawaiian', 12.90, 'Pizza'),
        ('PIZZA_TUNA', 'Tuna', 14.90, 'Pizza'),
        ('PIZZA_JETSKI', 'Jetski Special', 15.90, 'Pizza'),

        -- Appetizers
        ('APP_GARLIC_BREAD', 'Garlic Bread', 5.90, 'Appetizers'),
        ('APP_MOZZARELLA_STICKS', 'Mozzarella Sticks', 7.90, 'Appetizers'),
        ('APP_CHICKEN_WINGS', 'Chicken Wings', 9.90, 'Appetizers'),
        ('APP_FRIES', 'French Fries', 4.90, 'Appetizers'),

        -- Salads
        ('SAL_SHOPSKA', 'Shopska Salad', 7.90, 'Salads'),
        ('SAL_CAESAR', 'Caesar Salad', 9.90, 'Salads'),
        ('SAL_TUNA', 'Tuna Salad', 10.90, 'Salads'),

        -- Pasta
        ('PASTA_BOLOGNESE', 'Spaghetti Bolognese', 11.90, 'Pasta'),
        ('PASTA_CARBONARA', 'Spaghetti Carbonara', 11.90, 'Pasta'),
        ('PASTA_CHICKEN', 'Chicken Pasta', 12.90, 'Pasta'),

        -- Desserts
        ('DESS_CHEESECAKE', 'Cheesecake', 6.90, 'Desserts'),
        ('DESS_BROWNIE', 'Chocolate Brownie', 5.90, 'Desserts'),
        ('DESS_TIRAMISU', 'Tiramisu', 6.90, 'Desserts'),

        -- Drinks
        ('DRINK_COLA', 'Cola', 3.20, 'Drinks'),
        ('DRINK_ORANGE', 'Orange Soda', 3.20, 'Drinks'),
        ('DRINK_WATER', 'Mineral Water', 2.00, 'Drinks'),
        ('DRINK_ICED_TEA', 'Iced Tea', 3.20, 'Drinks'),
        ('DRINK_LEMONADE', 'Lemonade', 4.50, 'Drinks'),

        -- Lunch Boxes
        ('LUNCH_CHICKEN', 'Chicken Lunch Box', 12.90, 'Lunch Boxes'),
        ('LUNCH_BEEF', 'Beef Lunch Box', 13.90, 'Lunch Boxes'),
        ('LUNCH_VEGGIE', 'Veggie Lunch Box', 11.90, 'Lunch Boxes'),

        -- Sauces
        ('SAUCE_TOMATO', 'Tomato Sauce', 1.50, 'Sauces'),
        ('SAUCE_GARLIC', 'Garlic Sauce', 1.80, 'Sauces'),
        ('SAUCE_BBQ', 'BBQ Sauce', 1.80, 'Sauces')
) AS v(code, name, base_price, category_name)
JOIN categories c
    ON c.name = v.category_name
ON CONFLICT (code) DO NOTHING;
