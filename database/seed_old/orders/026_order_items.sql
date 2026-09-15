INSERT INTO order_items (
    order_id,
    menu_item_id,
    quantity,
    unit_price
)
SELECT
    o.id,
    mi.id,
    v.quantity,
    mi.base_price
FROM (
    VALUES
        (1, 'PIZZA_MARGHERITA', 1),
        (1, 'DRINK_COLA', 2),

        (2, 'PIZZA_HAM', 1),
        (2, 'APP_GARLIC_BREAD', 1),

        (3, 'PIZZA_PEPPERONI', 2),
        (3, 'DRINK_ICED_TEA', 2),

        (4, 'PIZZA_VEGGIE', 1),
        (4, 'DESS_CHEESECAKE', 1),

        (5, 'PIZZA_JETSKI', 1),
        (5, 'DRINK_LEMONADE', 1),

        (6, 'PIZZA_HAWAIIAN', 1),
        (6, 'DRINK_COLA', 1),

        (7, 'PASTA_BOLOGNESE', 1),
        (7, 'APP_FRIES', 1),

        (8, 'PIZZA_CHICKEN', 1),
        (8, 'DRINK_WATER', 2),

        (9, 'LUNCH_CHICKEN', 1),

        (10, 'PIZZA_PEPPERONI', 1),
        (10, 'DRINK_ORANGE', 1),

        (11, 'PIZZA_BEEF', 1),
        (11, 'DRINK_COLA', 1),

        (12, 'PASTA_CARBONARA', 1),
        (12, 'APP_MOZZARELLA_STICKS', 1),

        (13, 'PIZZA_HAM', 1),
        (13, 'DRINK_LEMONADE', 2),

        (14, 'LUNCH_VEGGIE', 1),
        (14, 'DESS_BROWNIE', 1),

        (15, 'PIZZA_TUNA', 1),
        (15, 'DRINK_ICED_TEA', 1),

        (16, 'PIZZA_MARGHERITA', 2),
        (16, 'DRINK_COLA', 2),

        (17, 'DRINK_WATER', 2),

        (18, 'PIZZA_JETSKI', 1),
        (18, 'DESS_TIRAMISU', 1),

        (19, 'LUNCH_BEEF', 1),
        (19, 'DRINK_WATER', 1),

        (20, 'PIZZA_CHICKEN', 1),
        (20, 'DRINK_ORANGE', 1)
) AS v(order_number, menu_code, quantity)
JOIN (
    SELECT
        id,
        ROW_NUMBER() OVER (ORDER BY created_at, id) AS order_number
    FROM orders
) o
    ON o.order_number = v.order_number
JOIN menu_items mi
    ON mi.code = v.menu_code;
