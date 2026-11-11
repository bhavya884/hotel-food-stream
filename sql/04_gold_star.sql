DROP TABLE IF EXISTS gold.fact_order_items;
DROP TABLE IF EXISTS gold.dim_guest;
DROP TABLE IF EXISTS gold.dim_dish;
DROP TABLE IF EXISTS gold.dim_date;
CREATE TABLE gold.dim_guest AS
SELECT guest_id AS guest_key, guest_name
FROM silver.guests;

CREATE TABLE gold.dim_dish AS
SELECT item_id AS dish_key, dish_name, category, price AS current_price
FROM silver.menu_items;

CREATE TABLE gold.dim_date AS
SELECT DISTINCT
    ordered_at::date                       AS date_key,
    EXTRACT(YEAR FROM ordered_at)::int     AS year,
    EXTRACT(MONTH FROM ordered_at)::int    AS month,
    TRIM(TO_CHAR(ordered_at, 'Day'))       AS day_name,
    EXTRACT(ISODOW FROM ordered_at) IN (6, 7) AS is_weekend
FROM silver.orders;

CREATE TABLE gold.fact_order_items AS
SELECT
    oi.order_item_id,
    o.order_id,
    o.guest_id                              AS guest_key,
    oi.item_id                              AS dish_key,
    o.ordered_at::date                      AS date_key,
    EXTRACT(HOUR FROM o.ordered_at)::int    AS order_hour,
    o.order_type,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price             AS line_total
FROM silver.order_items oi
JOIN silver.orders o ON o.order_id = oi.order_id;

ALTER TABLE gold.dim_guest          ADD PRIMARY KEY (guest_key);
ALTER TABLE gold.dim_dish           ADD PRIMARY KEY (dish_key);
ALTER TABLE gold.dim_date           ADD PRIMARY KEY (date_key);
ALTER TABLE gold.fact_order_items   ADD PRIMARY KEY (order_item_id);