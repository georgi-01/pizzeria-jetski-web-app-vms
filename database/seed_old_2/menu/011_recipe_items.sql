INSERT INTO recipe_items (menu_item_id, ingredient_id)
SELECT
    mi.id,
    i.id
FROM (
    VALUES
        -- Pizzas
        ('PIZZA_MARGHERITA', 'MOZ'),
        ('PIZZA_MARGHERITA', 'TOM'),
        ('PIZZA_MARGHERITA', 'ORE'),

        ('PIZZA_HAM', 'MOZ'),
        ('PIZZA_HAM', 'HAM'),
        ('PIZZA_HAM', 'TOM'),

        ('PIZZA_PEPPERONI', 'MOZ'),
        ('PIZZA_PEPPERONI', 'PEP'),
        ('PIZZA_PEPPERONI', 'TOM'),

        ('PIZZA_BACON', 'MOZ'),
        ('PIZZA_BACON', 'BAC'),
        ('PIZZA_BACON', 'TOM'),

        ('PIZZA_CHICKEN', 'MOZ'),
        ('PIZZA_CHICKEN', 'CHK'),
        ('PIZZA_CHICKEN', 'TOM'),

        ('PIZZA_BEEF', 'MOZ'),
        ('PIZZA_BEEF', 'BEEF'),
        ('PIZZA_BEEF', 'TOM'),

        ('PIZZA_VEGGIE', 'MOZ'),
        ('PIZZA_VEGGIE', 'TOM'),
        ('PIZZA_VEGGIE', 'ONI'),
        ('PIZZA_VEGGIE', 'BEP'),
        ('PIZZA_VEGGIE', 'MUS'),
        ('PIZZA_VEGGIE', 'OLV'),

        ('PIZZA_HAWAIIAN', 'MOZ'),
        ('PIZZA_HAWAIIAN', 'HAM'),
        ('PIZZA_HAWAIIAN', 'PIN'),

        ('PIZZA_TUNA', 'MOZ'),
        ('PIZZA_TUNA', 'TUN'),
        ('PIZZA_TUNA', 'ONI'),
        ('PIZZA_TUNA', 'TOM'),

        ('PIZZA_JETSKI', 'MOZ'),
        ('PIZZA_JETSKI', 'PEP'),
        ('PIZZA_JETSKI', 'BAC'),
        ('PIZZA_JETSKI', 'CHK'),
        ('PIZZA_JETSKI', 'BEP'),
        ('PIZZA_JETSKI', 'OLV'),

        -- Appetizers
        ('APP_GARLIC_BREAD', 'FLR'),
        ('APP_GARLIC_BREAD', 'YST'),
        ('APP_GARLIC_BREAD', 'OIL'),
        ('APP_GARLIC_BREAD', 'GAR'),
        ('APP_GARLIC_BREAD', 'BAS'),

        ('APP_MOZZARELLA_STICKS', 'MOZ'),
        ('APP_MOZZARELLA_STICKS', 'FLR'),
        ('APP_MOZZARELLA_STICKS', 'OIL'),

        ('APP_CHICKEN_WINGS', 'CHK'),
        ('APP_CHICKEN_WINGS', 'BBQ'),
        ('APP_CHICKEN_WINGS', 'PAP'),

        ('APP_FRIES', 'OIL'),
        ('APP_FRIES', 'SAL'),

        -- Salads
        ('SAL_SHOPSKA', 'TOM'),
        ('SAL_SHOPSKA', 'ONI'),
        ('SAL_SHOPSKA', 'BEP'),
        ('SAL_SHOPSKA', 'MOZ'),

        ('SAL_CAESAR', 'CHK'),
        ('SAL_CAESAR', 'TOM'),
        ('SAL_CAESAR', 'PAR'),

        ('SAL_TUNA', 'TUN'),
        ('SAL_TUNA', 'TOM'),
        ('SAL_TUNA', 'ONI'),
        ('SAL_TUNA', 'CORN'),

        -- Pasta
        ('PASTA_BOLOGNESE', 'BEEF'),
        ('PASTA_BOLOGNESE', 'TSA'),
        ('PASTA_BOLOGNESE', 'TOM'),
        ('PASTA_BOLOGNESE', 'PAR'),

        ('PASTA_CARBONARA', 'BAC'),
        ('PASTA_CARBONARA', 'CHED'),
        ('PASTA_CARBONARA', 'PAR'),

        ('PASTA_CHICKEN', 'CHK'),
        ('PASTA_CHICKEN', 'GSA'),
        ('PASTA_CHICKEN', 'PAR'),

        -- Desserts
        ('DESS_CHEESECAKE', 'MOZ'),
        ('DESS_CHEESECAKE', 'SUG'),

        ('DESS_BROWNIE', 'SUG'),

        ('DESS_TIRAMISU', 'MOZ'),
        ('DESS_TIRAMISU', 'SUG'),

        -- Sauces
        ('SAUCE_TOMATO', 'TSA'),
        ('SAUCE_GARLIC', 'GSA'),
        ('SAUCE_BBQ', 'BBQ')
) AS r(menu_code, ingredient_code)
JOIN menu_items mi
    ON mi.code = r.menu_code
JOIN ingredients i
    ON i.code = r.ingredient_code
ON CONFLICT DO NOTHING;
