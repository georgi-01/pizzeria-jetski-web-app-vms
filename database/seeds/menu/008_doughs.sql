INSERT INTO doughs (
    code,
    name,
    base_price
)
VALUES
    ('THIN',  'Thin Crust',        0.00),
    ('CLASS', 'Classic Crust',     1.00),
    ('PAN',   'Pan Crust',         2.50),
    ('RECT',  'Rectangular Crust', 3.00),
    ('CRIS',  'Crispy Crust',      2.00)
ON CONFLICT (code) DO NOTHING;
