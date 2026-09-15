INSERT INTO dough_sizes (
    dough_id,
    size_inches,
    size_cm,
    piece_count,
    price_addition
)
SELECT
    d.id,
    v.size_inches,
    ROUND(v.size_inches * 2.54, 1),
    v.piece_count,
    v.price_addition
FROM doughs d
CROSS JOIN (
    VALUES
        (8.0,  4, 0.00),
        (10.0, 6, 1.50),
        (12.0, 8, 3.00),
        (15.0, 12, 5.00)
) AS v(size_inches, piece_count, price_addition)
ON CONFLICT DO NOTHING;
