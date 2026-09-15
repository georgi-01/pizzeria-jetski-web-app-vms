/*
 * Pizzeria Jetski Web App
 * Promotions Seed
 *
 * Contains both active and inactive promotions.
 */

INSERT INTO promotions (
    code,
    name,
    percent_discount,
    is_active
)
VALUES
    (
        'PIZZA10',
        '10% Off All Pizzas',
        10.0,
        TRUE
    ),
    (
        'APP15',
        '15% Off Appetizers',
        15.0,
        TRUE
    ),
    (
        'WEEKEND20',
        '20% Weekend Promotion',
        20.0,
        TRUE
    ),
    (
        'LUNCH12',
        '12% Off Lunch Boxes',
        12.0,
        TRUE
    ),
    (
        'DESSERT15',
        '15% Off Desserts',
        15.0,
        TRUE
    ),
    (
        'OLD25',
        '25% Previous Campaign',
        25.0,
        FALSE
    )
ON CONFLICT (code) DO NOTHING;
