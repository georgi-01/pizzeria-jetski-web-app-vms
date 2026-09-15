/*
 * Pizzeria Jetski Web App
 * Employee Payroll Seed
 *
 * Period:
 * 2026-09-14 -> 2026-10-11
 *
 * Payroll is generated from:
 *   017_employee_contracts
 *   019_employee_attendance
 *
 * Four weekly payroll periods:
 *
 *   2026-09-14 -> 2026-09-20
 *   2026-09-21 -> 2026-09-27
 *   2026-09-28 -> 2026-10-04
 *   2026-10-05 -> 2026-10-11
 *
 * Rules:
 * - One payroll record per employee per week.
 * - total_hours comes from employee attendance.
 * - hourly_wage_net comes from the employee contract.
 * - net_salary is calculated automatically by PostgreSQL:
 *
 *       total_hours * hourly_wage_net
 *
 * - Administrator is recorded as the editor.
 * - The seed is safely re-runnable.
 */

WITH payroll_periods AS (
    SELECT
        DATE '2026-09-14' AS period_start,
        DATE '2026-09-20' AS period_end

    UNION ALL

    SELECT
        DATE '2026-09-21',
        DATE '2026-09-27'

    UNION ALL

    SELECT
        DATE '2026-09-28',
        DATE '2026-10-04'

    UNION ALL

    SELECT
        DATE '2026-10-05',
        DATE '2026-10-11'
),

employee_periods AS (
    SELECT
        e.id AS employee_id,
        pp.period_start,
        pp.period_end

    FROM employees e

    CROSS JOIN payroll_periods pp

    WHERE e.is_deleted = FALSE
),

attendance_totals AS (
    SELECT
        s.employee_id,
        pp.period_start,
        pp.period_end,

        /*
         * total_hours is calculated from actual clock-in
         * and clock-out records.
         */
        COALESCE(
            SUM(ea.total_hours),
            0.00
        ) AS total_hours

    FROM employee_schedules s

    INNER JOIN employee_attendance ea
        ON ea.schedule_id = s.id

    INNER JOIN payroll_periods pp
        ON s.shift_date BETWEEN
            pp.period_start
            AND pp.period_end

    GROUP BY
        s.employee_id,
        pp.period_start,
        pp.period_end
),

employee_contracts_for_period AS (
    SELECT
        ep.employee_id,
        ep.period_start,
        ep.period_end,

        ec.hourly_wage_net,

        ROW_NUMBER() OVER (
            PARTITION BY
                ep.employee_id,
                ep.period_start,
                ep.period_end

            ORDER BY
                ec.start_date DESC
        ) AS contract_rank

    FROM employee_periods ep

    INNER JOIN employee_contracts ec
        ON ec.employee_id = ep.employee_id

    WHERE ec.start_date <= ep.period_end
      AND (
          ec.end_date IS NULL
          OR ec.end_date >= ep.period_start
      )
),

final_payroll AS (
    SELECT
        ep.employee_id,
        ep.period_start,
        ep.period_end,

        COALESCE(
            at.total_hours,
            0.00
        ) AS total_hours,

        ec.hourly_wage_net

    FROM employee_periods ep

    LEFT JOIN attendance_totals at
        ON at.employee_id = ep.employee_id
       AND at.period_start = ep.period_start
       AND at.period_end = ep.period_end

    INNER JOIN employee_contracts_for_period ec
        ON ec.employee_id = ep.employee_id
       AND ec.period_start = ep.period_start
       AND ec.period_end = ep.period_end
       AND ec.contract_rank = 1
)

INSERT INTO employee_payroll (
    employee_id,
    period_start,
    period_end,
    total_hours,
    hourly_wage_net,
    edited_by_admin_id
)

SELECT
    fp.employee_id,
    fp.period_start,
    fp.period_end,
    ROUND(fp.total_hours, 2),
    fp.hourly_wage_net,
    a.id

FROM final_payroll fp

CROSS JOIN (
    SELECT id
    FROM admins
    WHERE username = 'administrator'
    LIMIT 1
) a

WHERE NOT EXISTS (
    SELECT 1
    FROM employee_payroll existing
    WHERE existing.employee_id = fp.employee_id
      AND existing.period_start = fp.period_start
      AND existing.period_end = fp.period_end
);
