INSERT INTO employee_attendance (
    schedule_id,
    clock_in,
    clock_out,
    clocked_in_by,
    clocked_out_by
)
SELECT
    s.id,
    s.shift_date + s.start_time,
    s.shift_date + s.end_time,
    e.id,
    e.id
FROM employee_schedules s
JOIN employees e
    ON e.id = s.employee_id
WHERE s.shift_date BETWEEN DATE '2026-09-14' AND DATE '2026-10-11'
  AND e.is_deleted = FALSE
  AND NOT EXISTS (
      SELECT 1
      FROM employee_attendance ea
      WHERE ea.schedule_id = s.id
  );
