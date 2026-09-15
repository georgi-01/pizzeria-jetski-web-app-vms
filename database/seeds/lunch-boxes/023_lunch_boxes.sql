WITH seed(menu_code, dough_code, size_inches, available_from, available_to) AS (
    VALUES
        ('LUNCH_CHICKEN', 'THIN', 8.0, TIME '11:00', TIME '14:30'),
        ('LUNCH_BEEF',    'THIN', 8.0, TIME '11:00', TIME '14:30'),
        ('LUNCH_VEGGIE',  'THIN', 8.0, TIME '11:00', TIME '14:30')
)
INSERT INTO lunch_boxes (
    menu_item_id,
    dough_size_id,
    available_from,
    available_to
)
SELECT
    mi.id,
    ds.id,
    s.available_from,
    s.available_to
FROM seed s
JOIN menu_items mi ON mi.code = s.menu_code
JOIN doughs d ON d.code = s.dough_code
JOIN dough_sizes ds
    ON ds.dough_id = d.id
   AND ds.size_inches = s.size_inches
WHERE NOT EXISTS (
    SELECT 1
    FROM lunch_boxes lb
    WHERE lb.menu_item_id = mi.id
);
