WITH seed(lunch_menu_code, category_name, quantity_grams) AS (
    VALUES
        ('LUNCH_CHICKEN', 'Pizza',      250.0),
        ('LUNCH_CHICKEN', 'Appetizers', 150.0),
        ('LUNCH_CHICKEN', 'Salads',     250.0),
        ('LUNCH_BEEF',    'Pizza',      250.0),
        ('LUNCH_BEEF',    'Appetizers', 150.0),
        ('LUNCH_BEEF',    'Salads',     250.0),
        ('LUNCH_VEGGIE',  'Pizza',      250.0),
        ('LUNCH_VEGGIE',  'Appetizers', 150.0),
        ('LUNCH_VEGGIE',  'Pasta',      250.0)
)
INSERT INTO lunch_box_components (
    lunch_box_id,
    category_id,
    quantity_grams
)
SELECT
    lb.id,
    c.id,
    s.quantity_grams
FROM seed s
JOIN menu_items mi ON mi.code = s.lunch_menu_code
JOIN lunch_boxes lb ON lb.menu_item_id = mi.id
JOIN categories c ON c.name = s.category_name
WHERE NOT EXISTS (
    SELECT 1
    FROM lunch_box_components existing
    WHERE existing.lunch_box_id = lb.id
      AND existing.category_id = c.id
);
