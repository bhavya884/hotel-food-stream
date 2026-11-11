CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    guest_name TEXT,
    dish TEXT,
    quantity INT,
    price NUMERIC(8,2),
    order_type TEXT,
    ordered_at TIMESTAMP
);