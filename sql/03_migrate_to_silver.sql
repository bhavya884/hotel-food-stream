-- 1. Guests and menu: one row per unique value

INSERT INTO silver.guests (guest_name)
SELECT DISTINCT guest_name
FROM bronze.raw_orders;

INSERT INTO silver.menu_items (dish_name, price)
SELECT DISTINCT dish, price
FROM bronze.raw_orders;

-- 2. Give each dish a category

UPDATE silver.menu_items
SET category = 'Main'
WHERE dish_name IN (
    'Chicken Biryani',
    'Paneer Butter Masala',
    'Veg Fried Rice',
    'Masala Dosa'
);

UPDATE silver.menu_items
SET category = 'Bread'
WHERE dish_name = 'Butter Naan';

UPDATE silver.menu_items
SET category = 'Snack'
WHERE dish_name = 'Club Sandwich';

UPDATE silver.menu_items
SET category = 'Beverage'
WHERE dish_name = 'Filter Coffee';

UPDATE silver.menu_items
SET category = 'Dessert'
WHERE dish_name = 'Gulab Jamun';

-- 3. Orders and order lines

INSERT INTO silver.orders (
    order_id,
    guest_id,
    order_type,
    ordered_at
)
SELECT
    r.order_id,
    g.guest_id,
    r.order_type,
    r.ordered_at
FROM bronze.raw_orders r
JOIN silver.guests g
ON g.guest_name = r.guest_name;

INSERT INTO silver.order_items (
    order_id,
    item_id,
    quantity,
    unit_price
)
SELECT
    r.order_id,
    m.item_id,
    r.quantity,
    r.price
FROM bronze.raw_orders r
JOIN silver.menu_items m
ON m.dish_name = r.dish;