INSERT INTO promotion_items (
    promotion_id,
    menu_item_id
)
SELECT
    p.id,
    mi.id
FROM (
    VALUES
        ('PIZZA10', 'Pizza'),
        ('APP15', 'Appetizers'),
        ('WEEKEND20', 'Pizza'),
        ('WEEKEND20', 'Drinks'),
        ('LUNCH12', 'Lunch Boxes'),
        ('DESSERT15', 'Desserts'),
        ('OLD25', 'Pizza'),
        ('OLD25', 'Salads')
) AS mapping(promotion_code, category_name)
INNER JOIN promotions p
    ON p.code = mapping.promotion_code
INNER JOIN categories c
    ON c.name = mapping.category_name
INNER JOIN menu_items mi
    ON mi.category_id = c.id
ON CONFLICT DO NOTHING;
