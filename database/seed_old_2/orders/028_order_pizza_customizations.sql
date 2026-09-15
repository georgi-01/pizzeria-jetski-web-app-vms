INSERT INTO order_pizza_customizations (
    order_pizza_id,
    half,
    ingredient_id,
    action
)
SELECT
    op.id AS order_pizza_id,
    c.half,
    i.id AS ingredient_id,
    c.action
FROM order_pizzas op
JOIN ingredients i
    ON i.code = c.ingredient_code
CROSS JOIN LATERAL (
    VALUES
        (
            CASE
                WHEN op.id % 3 = 0 THEN 1
                ELSE 2
            END,
            CASE
                WHEN op.id % 3 = 0 THEN 'JAL'
                ELSE 'MUS'
            END,
            'ADD'
        ),
        (
            1,
            'OLV',
            'ADD'
        )
) AS c(half, ingredient_code, action)
WHERE (
    c.half = 1
    OR (c.half = 2 AND op.half2_menu_item_id IS NOT NULL)
)
ON CONFLICT (
    order_pizza_id,
    half,
    ingredient_id,
    action
) DO NOTHING;
