/*
 * Pizzeria Jetski Web App
 * Employee Schedules Seed
 *
 * Period:
 * 2026-09-14 -> 2026-10-11
 *
 * Scheduling rules:
 *
 * MANAGERS
 * - 3 managers per pizzeria:
 *     1 General Manager
 *     1 Assistant Manager
 *     1 Manager
 * - Exactly 2 managers work each day.
 * - The third manager has a rest day.
 * - Rest days rotate between the three managers.
 * - Day/evening shifts rotate between managers.
 *
 * PIZZA MAKERS
 * - 4 full-time employees (40h)
 * - 2 part-time employees (20h)
 * - Exactly 4 Pizza Makers work each day.
 * - 40h employees work 5 x 8h per week.
 * - 20h employees work 4 x 5h per week.
 *
 * DELIVERY DRIVERS
 * - 4 full-time employees (40h)
 * - 2 part-time employees (20h)
 * - Exactly 4 Delivery Drivers work each day.
 * - 40h employees work 5 x 8h per week.
 * - 20h employees work 4 x 5h per week.
 *
 * The schedule is deterministic.
 * No random values are used.
 */

WITH employee_base AS (
    SELECT
        e.id AS employee_id,
        e.pizzeria_id,
        e.employee_serial_number,
        r.name AS role_name,
        ec.weekly_contracted_hours,

        /*
         * Local employee index inside each pizzeria and role:
         *
         * Managers:
         *   0 = General Manager
         *   1 = Assistant Manager
         *   2 = Manager
         *
         * Pizza Makers:
         *   0-3 = Full-time
         *   4-5 = Part-time
         *
         * Delivery Drivers:
         *   0-3 = Full-time
         *   4-5 = Part-time
         */
        ROW_NUMBER() OVER (
            PARTITION BY e.pizzeria_id, r.name
            ORDER BY e.employee_serial_number
        ) - 1 AS local_index,

        /*
         * Different pizzerias receive rotated rest-day patterns.
         */
        ((e.pizzeria_id - 117) % 4) AS pizzeria_offset

    FROM employees e

    INNER JOIN roles r
        ON r.id = e.role_id

    INNER JOIN employee_contracts ec
        ON ec.employee_id = e.id
       AND ec.end_date IS NULL

    WHERE e.is_deleted = FALSE
      AND r.name IN (
          'General Manager',
          'Assistant Manager',
          'Manager',
          'Pizza Maker',
          'Delivery Driver'
      )
),

schedule_dates AS (
    SELECT
        gs::date AS shift_date,

        /*
         * PostgreSQL DOW:
         * 0 = Sunday
         * 1 = Monday
         * 2 = Tuesday
         * 3 = Wednesday
         * 4 = Thursday
         * 5 = Friday
         * 6 = Saturday
         */
        EXTRACT(DOW FROM gs)::smallint AS day_of_week,

        /*
         * Four complete scheduling weeks:
         *
         * Week 0: 14.09 - 20.09
         * Week 1: 21.09 - 27.09
         * Week 2: 28.09 - 04.10
         * Week 3: 05.10 - 11.10
         */
        FLOOR(
            (gs::date - DATE '2026-09-14') / 7.0
        )::integer AS week_index

    FROM generate_series(
        DATE '2026-09-14',
        DATE '2026-10-11',
        INTERVAL '1 day'
    ) AS gs
),

employee_days AS (
    SELECT
        eb.employee_id,
        eb.pizzeria_id,
        eb.employee_serial_number,
        eb.role_name,
        eb.weekly_contracted_hours,
        eb.local_index,
        eb.pizzeria_offset,

        sd.shift_date,
        sd.day_of_week,
        sd.week_index,

        /*
         * Rest-day patterns for Pizza Makers
         * and Delivery Drivers.
         *
         * Full-time employees:
         *   5 working days / 2 rest days
         *
         * Part-time employees:
         *   4 working days / 3 rest days
         *
         * The entire pattern is rotated by pizzeria.
         */
        CASE

            /*
             * Full-time employee #0:
             * base rest days = Monday, Tuesday
             *
             * #1:
             * Tuesday, Wednesday
             *
             * #2:
             * Wednesday, Thursday
             *
             * #3:
             * Thursday, Friday
             */
            WHEN eb.weekly_contracted_hours = 40.0 THEN
                ARRAY[
                    (
                        eb.local_index + 1 + eb.pizzeria_offset
                    ) % 7,

                    (
                        eb.local_index + 2 + eb.pizzeria_offset
                    ) % 7
                ]

            /*
             * Part-time employee #4:
             * Saturday, Sunday, Monday
             */
            WHEN eb.weekly_contracted_hours = 20.0
                 AND eb.local_index = 4 THEN
                ARRAY[
                    (6 + eb.pizzeria_offset) % 7,
                    (0 + eb.pizzeria_offset) % 7,
                    (1 + eb.pizzeria_offset) % 7
                ]

            /*
             * Part-time employee #5:
             * Saturday, Sunday, Friday
             */
            WHEN eb.weekly_contracted_hours = 20.0
                 AND eb.local_index = 5 THEN
                ARRAY[
                    (6 + eb.pizzeria_offset) % 7,
                    (0 + eb.pizzeria_offset) % 7,
                    (5 + eb.pizzeria_offset) % 7
                ]

            ELSE
                ARRAY[]::integer[]

        END AS rest_days

    FROM employee_base eb

    CROSS JOIN schedule_dates sd
),

working_days AS (
    SELECT
        ed.*

    FROM employee_days ed

    WHERE

        /*
         * =========================================================
         * MANAGERS
         * =========================================================
         *
         * Exactly one manager is off each day.
         *
         * The manager whose local_index matches the rotating
         * value is assigned a rest day.
         *
         * This produces a 4/5/5 distribution each week.
         */
        (
            ed.role_name IN (
                'General Manager',
                'Assistant Manager',
                'Manager'
            )

            AND
            (
                (
                    ed.day_of_week
                    + ed.week_index
                    + ed.pizzeria_offset
                ) % 3
            ) <> ed.local_index
        )

        OR

        /*
         * =========================================================
         * PIZZA MAKERS / DELIVERY DRIVERS
         * =========================================================
         *
         * Employees work on every day that is not a rest day.
         */
        (
            ed.role_name IN (
                'Pizza Maker',
                'Delivery Driver'
            )

            AND NOT (
                ed.day_of_week = ANY(ed.rest_days)
            )
        )
),

ranked_shifts AS (
    SELECT
        wd.*,

        /*
         * Rank employees working on the same day.
         *
         * Managers:
         *   2 employees -> ranks 1-2
         *
         * Pizza Makers / Drivers:
         *   4 employees -> ranks 1-4
         *
         * The ordering rotates according to the day,
         * week and pizzeria.
         */
        ROW_NUMBER() OVER (
            PARTITION BY
                wd.pizzeria_id,
                wd.role_name,
                wd.shift_date

            ORDER BY
                (
                    wd.local_index
                    + wd.day_of_week
                    + wd.week_index
                    + wd.pizzeria_offset
                ) % 6
        ) AS shift_rank

    FROM working_days wd
),

final_schedule AS (
    SELECT
        employee_id,
        pizzeria_id,
        shift_date,
        day_of_week,
        role_name,
        weekly_contracted_hours,
        shift_rank,

        /*
         * =========================================================
         * START TIMES
         * =========================================================
         */
        CASE

            /*
             * Managers - day
             */
            WHEN role_name IN (
                'General Manager',
                'Assistant Manager',
                'Manager'
            )
            AND shift_rank = 1
                THEN TIME '10:30:00'

            /*
             * Managers - evening
             */
            WHEN role_name IN (
                'General Manager',
                'Assistant Manager',
                'Manager'
            )
            AND shift_rank = 2
                THEN TIME '14:30:00'


            /*
             * Full-time Pizza Makers - day
             */
            WHEN role_name = 'Pizza Maker'
             AND weekly_contracted_hours = 40.0
             AND shift_rank <= 2
                THEN TIME '10:30:00'

            /*
             * Full-time Pizza Makers - evening
             */
            WHEN role_name = 'Pizza Maker'
             AND weekly_contracted_hours = 40.0
             AND shift_rank > 2
                THEN TIME '14:30:00'


            /*
             * Part-time Pizza Makers - day
             */
            WHEN role_name = 'Pizza Maker'
             AND weekly_contracted_hours = 20.0
             AND shift_rank <= 2
                THEN TIME '11:00:00'

            /*
             * Part-time Pizza Makers - evening
             */
            WHEN role_name = 'Pizza Maker'
             AND weekly_contracted_hours = 20.0
             AND shift_rank > 2
                THEN TIME '17:30:00'


            /*
             * Full-time Delivery Drivers - day
             */
            WHEN role_name = 'Delivery Driver'
             AND weekly_contracted_hours = 40.0
             AND shift_rank <= 2
                THEN TIME '11:00:00'

            /*
             * Full-time Delivery Drivers - evening
             */
            WHEN role_name = 'Delivery Driver'
             AND weekly_contracted_hours = 40.0
             AND shift_rank > 2
                THEN TIME '14:30:00'


            /*
             * Part-time Delivery Drivers - day
             */
            WHEN role_name = 'Delivery Driver'
             AND weekly_contracted_hours = 20.0
             AND shift_rank <= 2
                THEN TIME '12:00:00'

            /*
             * Part-time Delivery Drivers - evening
             */
            WHEN role_name = 'Delivery Driver'
             AND weekly_contracted_hours = 20.0
             AND shift_rank > 2
                THEN TIME '17:30:00'

        END AS start_time,

        /*
         * =========================================================
         * END TIMES
         * =========================================================
         */
        CASE

            /*
             * Managers - day
             */
            WHEN role_name IN (
                'General Manager',
                'Assistant Manager',
                'Manager'
            )
            AND shift_rank = 1
                THEN TIME '18:30:00'

            /*
             * Managers - evening
             */
            WHEN role_name IN (
                'General Manager',
                'Assistant Manager',
                'Manager'
            )
            AND shift_rank = 2
                THEN TIME '22:30:00'


            /*
             * Full-time Pizza Makers - day
             */
            WHEN role_name = 'Pizza Maker'
             AND weekly_contracted_hours = 40.0
             AND shift_rank <= 2
                THEN TIME '18:30:00'

            /*
             * Full-time Pizza Makers - evening
             */
            WHEN role_name = 'Pizza Maker'
             AND weekly_contracted_hours = 40.0
             AND shift_rank > 2
                THEN TIME '22:30:00'


            /*
             * Part-time Pizza Makers - day
             */
            WHEN role_name = 'Pizza Maker'
             AND weekly_contracted_hours = 20.0
             AND shift_rank <= 2
                THEN TIME '16:00:00'

            /*
             * Part-time Pizza Makers - evening
             */
            WHEN role_name = 'Pizza Maker'
             AND weekly_contracted_hours = 20.0
             AND shift_rank > 2
                THEN TIME '22:30:00'


            /*
             * Full-time Delivery Drivers - day
             */
            WHEN role_name = 'Delivery Driver'
             AND weekly_contracted_hours = 40.0
             AND shift_rank <= 2
                THEN TIME '19:00:00'

            /*
             * Full-time Delivery Drivers - evening
             */
            WHEN role_name = 'Delivery Driver'
             AND weekly_contracted_hours = 40.0
             AND shift_rank > 2
                THEN TIME '22:30:00'


            /*
             * Part-time Delivery Drivers - day
             */
            WHEN role_name = 'Delivery Driver'
             AND weekly_contracted_hours = 20.0
             AND shift_rank <= 2
                THEN TIME '17:00:00'

            /*
             * Part-time Delivery Drivers - evening
             */
            WHEN role_name = 'Delivery Driver'
             AND weekly_contracted_hours = 20.0
             AND shift_rank > 2
                THEN TIME '22:30:00'

        END AS end_time

    FROM ranked_shifts
)

INSERT INTO employee_schedules (
    employee_id,
    pizzeria_id,
    shift_date,
    start_time,
    end_time
)

SELECT
    fs.employee_id,
    fs.pizzeria_id,
    fs.shift_date,
    fs.start_time,
    fs.end_time

FROM final_schedule fs

WHERE fs.start_time IS NOT NULL
  AND fs.end_time IS NOT NULL

  /*
   * employee_schedules currently has no unique constraint
   * on (employee_id, shift_date), therefore ON CONFLICT
   * cannot protect against duplicate schedules.
   *
   * This condition makes the seed safely re-runnable.
   */
  AND NOT EXISTS (
      SELECT 1
      FROM employee_schedules existing
      WHERE existing.employee_id = fs.employee_id
        AND existing.shift_date = fs.shift_date
  );
