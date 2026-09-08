-- =========================================================
-- PIZZERIA JETSKI WEB APP
-- FINAL DATABASE SCHEMA
-- PostgreSQL
-- 29 TABLES
-- =========================================================

-- =========================================================
-- 0. EXTENSIONS
-- =========================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- =========================================================
-- 1. BASIC / REFERENCE
-- =========================================================

CREATE TABLE pizzeria (
    id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         TEXT NOT NULL,
    address      TEXT,
    phone        TEXT,
    opens_at     TIME,
    closes_at    TIME,
    opened_date  DATE,
    status       TEXT NOT NULL DEFAULT 'ACTIVE'
                 CHECK (
                     status IN (
                         'ACTIVE',
                         'TEMPORARILY_CLOSED',
                         'PERMANENTLY_CLOSED'
                     )
                 )
);

CREATE TABLE roles (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name  TEXT NOT NULL UNIQUE
);

CREATE TABLE admins (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username       TEXT NOT NULL UNIQUE,
    password_hash  TEXT NOT NULL,
    full_name      TEXT NOT NULL,
    is_active      BOOLEAN NOT NULL DEFAULT TRUE,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    last_login_at  TIMESTAMPTZ
);

CREATE TABLE users (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name   TEXT NOT NULL,
    phone       TEXT UNIQUE,
    email       TEXT UNIQUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE employees (
    id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_serial_number TEXT NOT NULL UNIQUE,
    pizzeria_id            INTEGER
                          REFERENCES pizzeria(id)
                          ON DELETE RESTRICT,
    role_id                INTEGER NOT NULL
                          REFERENCES roles(id)
                          ON DELETE RESTRICT,
    full_name              TEXT NOT NULL,
    phone                  TEXT,
    email                  TEXT,
    hire_date              DATE,
    termination_date       DATE,
    employment_status      TEXT NOT NULL DEFAULT 'ACTIVE'
                           CHECK (
                               employment_status IN (
                                   'ACTIVE',
                                   'ON_LEAVE',
                                   'TERMINATED'
                               )
                           ),
    is_deleted             BOOLEAN NOT NULL DEFAULT FALSE,
    deleted_at             TIMESTAMPTZ,

    CONSTRAINT employee_serial_number_format
        CHECK (employee_serial_number ~ '^[0-9]{5,}$')
);

CREATE TABLE categories (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name  TEXT NOT NULL UNIQUE
);


-- =========================================================
-- 2. INGREDIENTS
-- =========================================================

CREATE TABLE ingredient_categories (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name  TEXT NOT NULL UNIQUE
);

CREATE TABLE ingredients (
    id                      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ingredient_category_id  INTEGER
                            REFERENCES ingredient_categories(id)
                            ON DELETE RESTRICT,
    code                    TEXT NOT NULL UNIQUE,
    name                    TEXT NOT NULL,
    price                   NUMERIC(6,2) NOT NULL DEFAULT 0
                            CHECK (price >= 0)
);

CREATE TABLE usage_contexts (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name  TEXT NOT NULL UNIQUE
);

CREATE TABLE ingredient_usage_contexts (
    ingredient_id     INTEGER NOT NULL
                      REFERENCES ingredients(id)
                      ON DELETE CASCADE,
    usage_context_id  INTEGER NOT NULL
                      REFERENCES usage_contexts(id)
                      ON DELETE CASCADE,

    PRIMARY KEY (ingredient_id, usage_context_id)
);


-- =========================================================
-- 3. DOUGH
-- =========================================================

CREATE TABLE doughs (
    id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        TEXT NOT NULL UNIQUE,
    name        TEXT NOT NULL,
    base_price  NUMERIC(6,2) NOT NULL DEFAULT 0
                CHECK (base_price >= 0)
);

CREATE TABLE dough_sizes (
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dough_id        INTEGER NOT NULL
                    REFERENCES doughs(id)
                    ON DELETE RESTRICT,
    size_inches     NUMERIC(4,1),
    size_cm         NUMERIC(4,1),
    piece_count     SMALLINT,
    price_addition  NUMERIC(6,2) NOT NULL DEFAULT 0
                    CHECK (price_addition >= 0),

    CONSTRAINT dough_size_positive
        CHECK (
            (size_inches IS NULL OR size_inches > 0)
            AND
            (size_cm IS NULL OR size_cm > 0)
            AND
            (piece_count IS NULL OR piece_count > 0)
        )
);


-- =========================================================
-- 4. MENU
-- =========================================================

CREATE TABLE menu_items (
    id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_id  INTEGER NOT NULL
                 REFERENCES categories(id)
                 ON DELETE RESTRICT,
    code         TEXT NOT NULL UNIQUE,
    name         TEXT NOT NULL,
    base_price   NUMERIC(6,2)
                 CHECK (base_price IS NULL OR base_price >= 0),
    is_active    BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE recipe_items (
    menu_item_id   INTEGER NOT NULL
                   REFERENCES menu_items(id)
                   ON DELETE CASCADE,
    ingredient_id  INTEGER NOT NULL
                   REFERENCES ingredients(id)
                   ON DELETE RESTRICT,

    PRIMARY KEY (menu_item_id, ingredient_id)
);

CREATE TABLE lunch_boxes (
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    menu_item_id    INTEGER NOT NULL
                    REFERENCES menu_items(id)
                    ON DELETE RESTRICT,
    dough_size_id   INTEGER NOT NULL
                    REFERENCES dough_sizes(id)
                    ON DELETE RESTRICT,
    available_from  TIME NOT NULL DEFAULT '11:00',
    available_to    TIME NOT NULL DEFAULT '14:00',

    CONSTRAINT lunch_box_availability
        CHECK (available_to > available_from)
);

CREATE TABLE lunch_box_components (
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lunch_box_id    INTEGER NOT NULL
                    REFERENCES lunch_boxes(id)
                    ON DELETE CASCADE,
    category_id     INTEGER NOT NULL
                    REFERENCES categories(id)
                    ON DELETE RESTRICT,
    quantity_grams  NUMERIC(6,1) NOT NULL
                    CHECK (quantity_grams > 0)
);


-- =========================================================
-- 5. PROMOTIONS
-- =========================================================

CREATE TABLE promotions (
    id                INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code              TEXT NOT NULL UNIQUE,
    name              TEXT NOT NULL,
    percent_discount  NUMERIC(4,1) NOT NULL
                      CHECK (
                          percent_discount > 0
                          AND percent_discount <= 100
                      ),
    is_active         BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE promotion_items (
    promotion_id  INTEGER NOT NULL
                  REFERENCES promotions(id)
                  ON DELETE CASCADE,
    menu_item_id  INTEGER NOT NULL
                  REFERENCES menu_items(id)
                  ON DELETE RESTRICT,

    PRIMARY KEY (promotion_id, menu_item_id)
);


-- =========================================================
-- 6. ORDERS
-- =========================================================

CREATE TABLE orders (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id             UUID
                        REFERENCES users(id)
                        ON DELETE SET NULL,

    employee_id         UUID
                        REFERENCES employees(id)
                        ON DELETE SET NULL,

    pizzeria_id         INTEGER
                        REFERENCES pizzeria(id)
                        ON DELETE RESTRICT,

    promotion_id        INTEGER
                        REFERENCES promotions(id)
                        ON DELETE SET NULL,

    status              TEXT NOT NULL DEFAULT 'ACCEPTED'
                        CHECK (
                            status IN (
                                'ACCEPTED',
                                'IN_PROGRESS',
                                'COMPLETED',
                                'PAID',
                                'PICKED_UP',
                                'DELIVERED'
                            )
                        ),

    channel             TEXT NOT NULL
                        CHECK (
                            channel IN (
                                'PHONE',
                                'WEBSITE',
                                'APP',
                                'IN_STORE'
                            )
                        ),

    payment_method      TEXT NOT NULL
                        CHECK (
                            payment_method IN (
                                'CASH',
                                'CARD',
                                'PREPAID_ONLINE'
                            )
                        ),

    fulfillment_type    TEXT NOT NULL
                        CHECK (
                            fulfillment_type IN (
                                'PICKUP',
                                'DELIVERY'
                            )
                        ),

    delivery_address    TEXT,

    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),

    completed_at        TIMESTAMPTZ,

    execution_duration  INTERVAL
                        GENERATED ALWAYS AS
                        (completed_at - created_at)
                        STORED,

    CONSTRAINT order_fulfillment_address
        CHECK (
            (
                fulfillment_type = 'DELIVERY'
                AND delivery_address IS NOT NULL
            )
            OR
            (
                fulfillment_type = 'PICKUP'
                AND delivery_address IS NULL
            )
        )
);

CREATE TABLE order_items (
    id            INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_id      UUID NOT NULL
                  REFERENCES orders(id)
                  ON DELETE CASCADE,

    menu_item_id  INTEGER NOT NULL
                  REFERENCES menu_items(id)
                  ON DELETE RESTRICT,

    quantity      SMALLINT NOT NULL DEFAULT 1
                  CHECK (quantity > 0),

    unit_price    NUMERIC(6,2) NOT NULL
                  CHECK (unit_price >= 0)
);

CREATE TABLE order_pizzas (
    id                  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_id            UUID NOT NULL
                        REFERENCES orders(id)
                        ON DELETE CASCADE,

    half1_menu_item_id  INTEGER NOT NULL
                        REFERENCES menu_items(id)
                        ON DELETE RESTRICT,

    half2_menu_item_id  INTEGER
                        REFERENCES menu_items(id)
                        ON DELETE RESTRICT,

    dough_size_id       INTEGER NOT NULL
                        REFERENCES dough_sizes(id)
                        ON DELETE RESTRICT,

    quantity            SMALLINT NOT NULL DEFAULT 1
                        CHECK (quantity > 0),

    unit_price          NUMERIC(6,2) NOT NULL
                        CHECK (unit_price >= 0)
);

CREATE TABLE order_pizza_customizations (
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_pizza_id  INTEGER NOT NULL
                    REFERENCES order_pizzas(id)
                    ON DELETE CASCADE,

    half            SMALLINT NOT NULL
                    CHECK (half IN (1,2)),

    ingredient_id   INTEGER NOT NULL
                    REFERENCES ingredients(id)
                    ON DELETE RESTRICT,

    action          TEXT NOT NULL
                    CHECK (action IN ('ADD','REMOVE')),

    CONSTRAINT unique_pizza_customization
        UNIQUE (
            order_pizza_id,
            half,
            ingredient_id,
            action
        )
);

CREATE TABLE order_lunch_box_items (
    id                      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_item_id           INTEGER NOT NULL
                            REFERENCES order_items(id)
                            ON DELETE CASCADE,

    lunch_box_component_id  INTEGER NOT NULL
                            REFERENCES lunch_box_components(id)
                            ON DELETE RESTRICT,

    menu_item_id            INTEGER
                            REFERENCES menu_items(id)
                            ON DELETE RESTRICT,

    ingredient_id           INTEGER
                            REFERENCES ingredients(id)
                            ON DELETE RESTRICT
);


-- =========================================================
-- 7. INVENTORY
-- =========================================================

CREATE TABLE inventory_checks (
    id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    pizzeria_id  INTEGER NOT NULL
                 REFERENCES pizzeria(id)
                 ON DELETE RESTRICT,

    employee_id  UUID
                 REFERENCES employees(id)
                 ON DELETE SET NULL,

    checked_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE inventory_check_items (
    id                  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    inventory_check_id  INTEGER NOT NULL
                        REFERENCES inventory_checks(id)
                        ON DELETE CASCADE,

    ingredient_id       INTEGER NOT NULL
                        REFERENCES ingredients(id)
                        ON DELETE RESTRICT,

    expected_quantity   NUMERIC(8,2) NOT NULL
                        CHECK (expected_quantity >= 0),

    actual_quantity     NUMERIC(8,2) NOT NULL
                        CHECK (actual_quantity >= 0),

    discrepancy         NUMERIC(8,2)
                        GENERATED ALWAYS AS
                        (actual_quantity - expected_quantity)
                        STORED
);


-- =========================================================
-- 8. EMPLOYEES
-- =========================================================

CREATE TABLE employee_contracts (
    id                       UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    employee_id              UUID NOT NULL
                             REFERENCES employees(id)
                             ON DELETE RESTRICT,

    weekly_contracted_hours  NUMERIC(4,1) NOT NULL
                             CHECK (weekly_contracted_hours >= 0),

    hourly_wage_net          NUMERIC(6,2) NOT NULL
                             CHECK (hourly_wage_net >= 0),

    start_date               DATE NOT NULL,

    end_date                 DATE,

    set_by_admin_id          UUID
                             REFERENCES admins(id)
                             ON DELETE SET NULL,

    CONSTRAINT contract_dates
        CHECK (
            end_date IS NULL
            OR end_date >= start_date
        )
);

CREATE TABLE employee_schedules (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    employee_id  UUID NOT NULL
                 REFERENCES employees(id)
                 ON DELETE RESTRICT,

    pizzeria_id  INTEGER NOT NULL
                 REFERENCES pizzeria(id)
                 ON DELETE RESTRICT,

    shift_date   DATE NOT NULL,

    day_of_week  SMALLINT
                 GENERATED ALWAYS AS
                 (EXTRACT(DOW FROM shift_date)::SMALLINT)
                 STORED,

    start_time   TIME NOT NULL,

    end_time     TIME NOT NULL,

    CONSTRAINT schedule_time_range
        CHECK (end_time > start_time)
);

CREATE TABLE employee_attendance (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    schedule_id     UUID NOT NULL
                    REFERENCES employee_schedules(id)
                    ON DELETE RESTRICT,

    clock_in        TIMESTAMPTZ NOT NULL,

    clock_out       TIMESTAMPTZ,

    clocked_in_by   UUID
                    REFERENCES employees(id)
                    ON DELETE SET NULL,

    clocked_out_by  UUID
                    REFERENCES employees(id)
                    ON DELETE SET NULL,

    total_hours     NUMERIC
                    GENERATED ALWAYS AS
                    (
                        EXTRACT(
                            EPOCH FROM
                            (clock_out - clock_in)
                        ) / 3600.0
                    )
                    STORED,

    CONSTRAINT attendance_time_range
        CHECK (
            clock_out IS NULL
            OR clock_out >= clock_in
        )
);

CREATE TABLE employee_payroll (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    employee_id         UUID NOT NULL
                        REFERENCES employees(id)
                        ON DELETE RESTRICT,

    period_start        DATE NOT NULL,

    period_end          DATE NOT NULL,

    total_hours         NUMERIC(6,2) NOT NULL
                        CHECK (total_hours >= 0),

    hourly_wage_net     NUMERIC(6,2) NOT NULL
                        CHECK (hourly_wage_net >= 0),

    net_salary          NUMERIC(8,2)
                        GENERATED ALWAYS AS
                        (
                            total_hours * hourly_wage_net
                        )
                        STORED,

    edited_by_admin_id  UUID
                        REFERENCES admins(id)
                        ON DELETE SET NULL,

    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT payroll_period
        CHECK (period_end >= period_start)
);


-- =========================================================
-- 9. INDEXES
-- =========================================================

-- ---------------------------------------------------------
-- ORDERS
-- ---------------------------------------------------------

CREATE INDEX idx_orders_user_id
    ON orders(user_id);

CREATE INDEX idx_orders_employee_id
    ON orders(employee_id);

CREATE INDEX idx_orders_pizzeria_id
    ON orders(pizzeria_id);

CREATE INDEX idx_orders_promotion_id
    ON orders(promotion_id);

CREATE INDEX idx_orders_status
    ON orders(status);

CREATE INDEX idx_orders_created_at
    ON orders(created_at);


-- ---------------------------------------------------------
-- ORDER ITEMS / PIZZAS
-- ---------------------------------------------------------

CREATE INDEX idx_order_items_order_id
    ON order_items(order_id);

CREATE INDEX idx_order_items_menu_item_id
    ON order_items(menu_item_id);

CREATE INDEX idx_order_pizzas_order_id
    ON order_pizzas(order_id);

CREATE INDEX idx_order_pizzas_half1_menu_item_id
    ON order_pizzas(half1_menu_item_id);

CREATE INDEX idx_order_pizzas_half2_menu_item_id
    ON order_pizzas(half2_menu_item_id);

CREATE INDEX idx_order_pizzas_dough_size_id
    ON order_pizzas(dough_size_id);

CREATE INDEX idx_order_pizza_customizations_ingredient_id
    ON order_pizza_customizations(ingredient_id);

CREATE INDEX idx_order_lunch_box_items_order_item_id
    ON order_lunch_box_items(order_item_id);

CREATE INDEX idx_order_lunch_box_items_component_id
    ON order_lunch_box_items(lunch_box_component_id);


-- ---------------------------------------------------------
-- MENU / RECIPES
-- ---------------------------------------------------------

CREATE INDEX idx_menu_items_category_id
    ON menu_items(category_id);

CREATE INDEX idx_recipe_items_ingredient_id
    ON recipe_items(ingredient_id);

CREATE INDEX idx_lunch_boxes_menu_item_id
    ON lunch_boxes(menu_item_id);

CREATE INDEX idx_lunch_boxes_dough_size_id
    ON lunch_boxes(dough_size_id);

CREATE INDEX idx_lunch_box_components_lunch_box_id
    ON lunch_box_components(lunch_box_id);

CREATE INDEX idx_lunch_box_components_category_id
    ON lunch_box_components(category_id);


-- ---------------------------------------------------------
-- INGREDIENTS
-- ---------------------------------------------------------

CREATE INDEX idx_ingredients_category_id
    ON ingredients(ingredient_category_id);

CREATE INDEX idx_ingredient_usage_contexts_usage_context_id
    ON ingredient_usage_contexts(usage_context_id);


-- ---------------------------------------------------------
-- DOUGH
-- ---------------------------------------------------------

CREATE INDEX idx_dough_sizes_dough_id
    ON dough_sizes(dough_id);


-- ---------------------------------------------------------
-- PROMOTIONS
-- ---------------------------------------------------------

CREATE INDEX idx_promotion_items_menu_item_id
    ON promotion_items(menu_item_id);


-- ---------------------------------------------------------
-- INVENTORY
-- ---------------------------------------------------------

CREATE INDEX idx_inventory_checks_pizzeria_id
    ON inventory_checks(pizzeria_id);

CREATE INDEX idx_inventory_checks_employee_id
    ON inventory_checks(employee_id);

CREATE INDEX idx_inventory_checks_checked_at
    ON inventory_checks(checked_at);

CREATE INDEX idx_inventory_check_items_inventory_check_id
    ON inventory_check_items(inventory_check_id);

CREATE INDEX idx_inventory_check_items_ingredient_id
    ON inventory_check_items(ingredient_id);


-- ---------------------------------------------------------
-- EMPLOYEES
-- ---------------------------------------------------------

CREATE INDEX idx_employees_pizzeria_id
    ON employees(pizzeria_id);

CREATE INDEX idx_employees_role_id
    ON employees(role_id);

CREATE INDEX idx_employees_employment_status
    ON employees(employment_status);


-- ---------------------------------------------------------
-- EMPLOYEE CONTRACTS
-- ---------------------------------------------------------

CREATE INDEX idx_employee_contracts_employee_id
    ON employee_contracts(employee_id);

CREATE INDEX idx_employee_contracts_set_by_admin_id
    ON employee_contracts(set_by_admin_id);

CREATE INDEX idx_employee_contracts_start_date
    ON employee_contracts(start_date);


-- ---------------------------------------------------------
-- EMPLOYEE SCHEDULES
-- ---------------------------------------------------------

CREATE INDEX idx_employee_schedules_employee_id
    ON employee_schedules(employee_id);

CREATE INDEX idx_employee_schedules_pizzeria_id
    ON employee_schedules(pizzeria_id);

CREATE INDEX idx_employee_schedules_shift_date
    ON employee_schedules(shift_date);

CREATE INDEX idx_employee_schedules_pizzeria_date
    ON employee_schedules(pizzeria_id, shift_date);


-- ---------------------------------------------------------
-- EMPLOYEE ATTENDANCE
-- ---------------------------------------------------------

CREATE INDEX idx_employee_attendance_schedule_id
    ON employee_attendance(schedule_id);

CREATE INDEX idx_employee_attendance_clock_in
    ON employee_attendance(clock_in);


-- ---------------------------------------------------------
-- EMPLOYEE PAYROLL
-- ---------------------------------------------------------

CREATE INDEX idx_employee_payroll_employee_id
    ON employee_payroll(employee_id);

CREATE INDEX idx_employee_payroll_period
    ON employee_payroll(period_start, period_end);

CREATE INDEX idx_employee_payroll_edited_by_admin_id
    ON employee_payroll(edited_by_admin_id);


-- =========================================================
-- END OF SCHEMA
-- =========================================================
