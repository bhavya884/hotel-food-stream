CREATE TABLE silver.guests (
    guest_id SERIAL PRIMARY KEY,
    guest_name TEXT NOT NULL,
    salesforce_contact_id TEXT
);

CREATE TABLE silver.menu_items (
    item_id SERIAL PRIMARY KEY,
    dish_name TEXT NOT NULL,
    category TEXT,
    price NUMERIC(8,2) NOT NULL
);

CREATE TABLE silver.orders (
    order_id INT PRIMARY KEY,
    guest_id INT NOT NULL REFERENCES silver.guests (guest_id),
    order_type TEXT NOT NULL,
    ordered_at TIMESTAMP NOT NULL
);

CREATE TABLE silver.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES silver.orders (order_id),
    item_id INT NOT NULL REFERENCES silver.menu_items (item_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(8,2) NOT NULL
);