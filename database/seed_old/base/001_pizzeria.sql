INSERT INTO pizzeria (
    id,
    name,
    address,
    phone,
    opens_at,
    closes_at,
    opened_date,
    status
)
OVERRIDING SYSTEM VALUE
VALUES
(
    117,
    'Pizzeria Jetski - Vitosha',
    'ж.к. Витоша, гр. София',
    '0812378451',
    '11:00',
    '22:30',
    '2025-01-15',
    'ACTIVE'
),
(
    118,
    'Pizzeria Jetski - Studentski Grad',
    'ж.к. Студентски град, гр. София',
    '0812378456',
    '11:00',
    '22:30',
    '2025-04-01',
    'ACTIVE'
),
(
    119,
    'Pizzeria Jetski - Mladost 4',
    'ж.к. Младост 4, гр. София',
    '0812378422',
    '11:00',
    '22:30',
    '2025-05-15',
    'ACTIVE'
),
(
    120,
    'Pizzeria Jetski - Mladost',
    'ж.к. Младост, гр. Варна',
    '0812378430',
    '11:00',
    '22:30',
    '2026-04-18',
    'ACTIVE'
)
ON CONFLICT DO NOTHING;
