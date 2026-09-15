WITH employee_data AS (
    SELECT
        e.id AS employee_id,
        e.employee_serial_number,
        e.hire_date,
        r.name AS role_name,
        ROW_NUMBER() OVER (
            PARTITION BY e.pizzeria_id, r.name
            ORDER BY e.employee_serial_number
        ) - 1 AS local_index
    FROM employees e
    JOIN roles r
        ON r.id = e.role_id
    WHERE e.is_deleted = FALSE
)
INSERT INTO employee_contracts (
    employee_id,
    weekly_contracted_hours,
    hourly_wage_net,
    start_date,
    end_date,
    set_by_admin_id
)
SELECT
    ed.employee_id,
    CASE
        WHEN ed.role_name IN (
            'General Manager',
            'Assistant Manager',
            'Manager'
        ) THEN 40.0

        WHEN ed.role_name = 'Pizza Maker'
             AND ed.local_index IN (4, 5)
            THEN 20.0

        WHEN ed.role_name = 'Pizza Maker'
            THEN 40.0

        WHEN ed.role_name = 'Delivery Driver'
             AND ed.local_index IN (0, 1, 2)
            THEN 20.0

        WHEN ed.role_name = 'Delivery Driver'
            THEN 40.0
    END,
    CASE
        WHEN ed.role_name = 'General Manager'
            THEN 15.00 + (ed.local_index % 3) * 0.50

        WHEN ed.role_name = 'Assistant Manager'
            THEN 13.00 + (ed.local_index % 2) * 0.50

        WHEN ed.role_name = 'Manager'
            THEN 12.00 + (ed.local_index % 3) * 0.50

        WHEN ed.role_name = 'Pizza Maker'
            THEN 10.00 + (ed.local_index % 3) * 0.25

        WHEN ed.role_name = 'Delivery Driver'
            THEN 9.50 + (ed.local_index % 3) * 0.25
    END,
    ed.hire_date,
    NULL,
    a.id
FROM employee_data ed
CROSS JOIN (
    SELECT id
    FROM admins
    WHERE username = 'administrator'
) a
ON CONFLICT DO NOTHING;
