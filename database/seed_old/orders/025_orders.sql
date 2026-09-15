INSERT INTO orders (
    user_id,
    employee_id,
    pizzeria_id,
    promotion_id,
    status,
    channel,
    payment_method,
    fulfillment_type,
    delivery_address,
    created_at,
    completed_at
)
SELECT
    u.id,
    CASE
        WHEN v.employee_serial IS NOT NULL THEN e.id
        ELSE NULL
    END,
    p.id,
    pr.id,
    v.status,
    v.channel,
    v.payment_method,
    v.fulfillment_type,
    v.delivery_address,
    v.created_at::timestamptz,
    v.completed_at::timestamptz
FROM (
    VALUES
        (
            'ivan.petrov@example.com',
            'EMP-0010',
            117,
            'PIZZA10',
            'COMPLETED',
            'WEB',
            'CARD',
            'DELIVERY',
            'ж.к. Витоша, гр. София',
            '2026-09-01 12:15:00+03',
            '2026-09-01 13:05:00+03'
        ),
        (
            'maria.georgieva@example.com',
            NULL,
            117,
            NULL,
            'COMPLETED',
            'WEB',
            'CASH',
            'PICKUP',
            NULL,
            '2026-09-02 18:20:00+03',
            '2026-09-02 18:55:00+03'
        ),
        (
            'nikolay.dimitrov@example.com',
            'EMP-0011',
            117,
            'APP15',
            'COMPLETED',
            'PHONE',
            'CASH',
            'DELIVERY',
            'бул. България, гр. София',
            '2026-09-04 19:10:00+03',
            '2026-09-04 20:00:00+03'
        ),
        (
            'elena.ivanova@example.com',
            NULL,
            117,
            'WEEKEND20',
            'COMPLETED',
            'WEB',
            'CARD',
            'PICKUP',
            NULL,
            '2026-09-06 13:30:00+03',
            '2026-09-06 14:10:00+03'
        ),
        (
            'georgi.stoyanov@example.com',
            'EMP-0012',
            117,
            NULL,
            'ACCEPTED',
            'WEB',
            'ONLINE',
            'DELIVERY',
            'ж.к. Витоша, гр. София',
            '2026-09-14 11:45:00+03',
            NULL
        ),

        (
            'alexandra.nikolova@example.com',
            'EMP-0025',
            118,
            'PIZZA10',
            'COMPLETED',
            'WEB',
            'CARD',
            'DELIVERY',
            'ж.к. Студентски град, гр. София',
            '2026-09-01 13:10:00+03',
            '2026-09-01 14:00:00+03'
        ),
        (
            'daniel.hristov@example.com',
            NULL,
            118,
            NULL,
            'COMPLETED',
            'PHONE',
            'CASH',
            'PICKUP',
            NULL,
            '2026-09-03 17:45:00+03',
            '2026-09-03 18:25:00+03'
        ),
        (
            'sofia.vasileva@example.com',
            'EMP-0026',
            118,
            'APP15',
            'COMPLETED',
            'WEB',
            'CARD',
            'DELIVERY',
            'ул. Академик Стефан Младенов, гр. София',
            '2026-09-05 19:30:00+03',
            '2026-09-05 20:20:00+03'
        ),
        (
            'martin.kostov@example.com',
            NULL,
            118,
            'WEEKEND20',
            'COMPLETED',
            'WEB',
            'ONLINE',
            'PICKUP',
            NULL,
            '2026-09-06 14:15:00+03',
            '2026-09-06 14:55:00+03'
        ),
        (
            'ralitsa.todorova@example.com',
            'EMP-0027',
            118,
            NULL,
            'ACCEPTED',
            'WEB',
            'CARD',
            'DELIVERY',
            'ж.к. Студентски град, гр. София',
            '2026-09-14 12:30:00+03',
            NULL
        ),

        (
            'borislav.angelov@example.com',
            'EMP-0040',
            119,
            'PIZZA10',
            'COMPLETED',
            'WEB',
            'CARD',
            'DELIVERY',
            'ж.к. Младост 4, гр. София',
            '2026-09-02 12:40:00+03',
            '2026-09-02 13:30:00+03'
        ),
        (
            'kristina.dimova@example.com',
            NULL,
            119,
            NULL,
            'COMPLETED',
            'PHONE',
            'CASH',
            'PICKUP',
            NULL,
            '2026-09-03 18:10:00+03',
            '2026-09-03 18:50:00+03'
        ),
        (
            'stefan.marinov@example.com',
            'EMP-0041',
            119,
            'APP15',
            'COMPLETED',
            'WEB',
            'ONLINE',
            'DELIVERY',
            'бул. Александър Малинов, гр. София',
            '2026-09-05 20:00:00+03',
            '2026-09-05 20:55:00+03'
        ),
        (
            'viktoria.petrova@example.com',
            NULL,
            119,
            'DESSERT15',
            'COMPLETED',
            'WEB',
            'CARD',
            'PICKUP',
            NULL,
            '2026-09-06 15:20:00+03',
            '2026-09-06 16:00:00+03'
        ),
        (
            'teodor.ivanov@example.com',
            'EMP-0042',
            119,
            NULL,
            'ACCEPTED',
            'WEB',
            'CARD',
            'DELIVERY',
            'ж.к. Младост 4, гр. София',
            '2026-09-14 13:15:00+03',
            NULL
        ),

        (
            'kaloyan.georgiev@example.com',
            'EMP-0055',
            120,
            'PIZZA10',
            'COMPLETED',
            'WEB',
            'CARD',
            'DELIVERY',
            'ж.к. Младост, гр. Варна',
            '2026-09-01 12:50:00+03',
            '2026-09-01 13:45:00+03'
        ),
        (
            'nadezhda.dimitrova@example.com',
            NULL,
            120,
            NULL,
            'COMPLETED',
            'PHONE',
            'CASH',
            'PICKUP',
            NULL,
            '2026-09-03 17:30:00+03',
            '2026-09-03 18:10:00+03'
        ),
        (
            'anton.stoyanov@example.com',
            'EMP-0056',
            120,
            'APP15',
            'COMPLETED',
            'WEB',
            'ONLINE',
            'DELIVERY',
            'ж.к. Младост, гр. Варна',
            '2026-09-05 19:15:00+03',
            '2026-09-05 20:05:00+03'
        ),
        (
            'gabriela.nikolova@example.com',
            NULL,
            120,
            'WEEKEND20',
            'COMPLETED',
            'WEB',
            'CARD',
            'PICKUP',
            NULL,
            '2026-09-06 14:40:00+03',
            '2026-09-06 15:20:00+03'
        ),
        (
            'radoslav.vasilev@example.com',
            'EMP-0057',
            120,
            NULL,
            'ACCEPTED',
            'WEB',
            'CARD',
            'DELIVERY',
            'ж.к. Младост, гр. Варна',
            '2026-09-14 14:00:00+03',
            NULL
        )
) AS v (
    id,
    user_email,
    employee_serial,
    pizzeria_id,
    promotion_code,
    status,
    channel,
    payment_method,
    fulfillment_type,
    delivery_address,
    created_at,
    completed_at
)
JOIN users u
    ON u.email = v.user_email
JOIN pizzeria p
    ON p.id = v.pizzeria_id
LEFT JOIN employees e
    ON e.employee_serial_number = v.employee_serial
LEFT JOIN promotions pr
    ON pr.code = v.promotion_code
ON CONFLICT DO NOTHING;
