INSERT INTO inventory_check_items (
    inventory_check_id,
    ingredient_id,
    expected_quantity,
    actual_quantity
)
SELECT
    ic.id,
    i.id,
    10.00 + (i.id % 10),
    10.00 + (i.id % 10) - 0.50
FROM inventory_checks ic
CROSS JOIN ingredients i
WHERE ic.pizzeria_id IN (117, 118, 119, 120)
  AND ic.checked_at IN (
      '2026-09-01 08:30:00+03',
      '2026-09-02 08:30:00+03',
      '2026-09-03 08:30:00+03',
      '2026-09-04 08:30:00+03'
  );
