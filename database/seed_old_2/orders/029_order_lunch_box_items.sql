INSERT INTO order_lunch_box_items (
    order_item_id,
    lunch_box_component_id,
    menu_item_id,
    ingredient_id
)
SELECT
    oi.id AS order_item_id,
    lbc.id AS lunch_box_component_id,
    (
        SELECT mi.id
        FROM menu_items mi
        WHERE mi.category_id = lbc.category_id
          AND mi.is_active = TRUE
        ORDER BY mi.id
        LIMIT 1
    ) AS menu_item_id,
    NULL AS ingredient_id
FROM order_items oi
JOIN lunch_boxes lb
    ON lb.menu_item_id = oi.menu_item_id
JOIN lunch_box_components lbc
    ON lbc.lunch_box_id = lb.id
WHERE EXISTS (
    SELECT 1
    FROM menu_items mi
    WHERE mi.category_id = lbc.category_id
      AND mi.is_active = TRUE
);
