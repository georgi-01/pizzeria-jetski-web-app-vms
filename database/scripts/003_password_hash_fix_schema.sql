ALTER TABLE users
ADD COLUMN password_hash TEXT;

ALTER TABLE employees
ADD COLUMN password_hash TEXT;
