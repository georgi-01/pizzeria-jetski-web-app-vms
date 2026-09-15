INSERT INTO order_pizzas (
    order_id,
    half1_menu_item_id,
    half2_menu_item_id,
    dough_size_id,
    quantity,
    unit_price
)
WITH ranked_orders AS (
    SELECT
        id AS order_id,
        ROW_NUMBER() OVER (ORDER BY created_at, id) AS order_number
    FROM orders
),
ranked_menu_items AS (
    SELECT
        id,
        base_price,
        ROW_NUMBER() OVER (ORDER BY id) AS item_number
    FROM menu_items
    WHERE is_active = TRUE
),
menu_count AS (
    SELECT COUNT(*)::integer AS total
    FROM ranked_menu_items
),
ranked_dough_sizes AS (
    SELECT
        ds.id,
        ds.price_addition,
        ROW_NUMBER() OVER (ORDER BY ds.id) AS dough_number
    FROM dough_sizes ds
),
dough_count AS (
    SELECT COUNT(*)::integer AS total
    FROM ranked_dough_sizes
),
pizza_rows AS (
    SELECT
        ro.order_id,
        ro.order_number,
        gs.pizza_number
    FROM ranked_orders ro
    CROSS JOIN generate_series(1, 2) AS gs(pizza_number)
)
SELECT
    pr.order_id,
    m1.id AS half1_menu_item_id,
    CASE
        WHEN pr.order_number % 3 = 0 THEN m2.id
        ELSE NULL
    END AS half2_menu_item_id,
    ds.id AS dough_size_id,
    1 AS quantity,
    (
        CASE
            WHEN pr.order_number % 3 = 0
                THEN GREATEST(m1.base_price, m2.base_price)
            ELSE m1.base_price
        END
        + ds.price_addition
    )::numeric(6,2) AS unit_price
FROM pizza_rows pr
CROSS JOIN menu_count mc
CROSS JOIN dough_count dc
JOIN ranked_menu_items m1
    ON m1.item_number = ((pr.order_number + pr.pizza_number - 2) % mc.total) + 1
JOIN ranked_menu_items m2
    ON m2.item_number = ((pr.order_number + pr.pizza_number - 1) % mc.total) + 1
JOIN ranked_dough_sizes ds
    ON ds.dough_number = ((pr.order_number + pr.pizza_number - 2) % dc.total) + 1
WHERE mc.total > 0
  AND dc.total > 0;
