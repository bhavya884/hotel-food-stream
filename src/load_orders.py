import psycopg2
from generate_orders import make_order

conn = psycopg2.connect(
    host="localhost",
    port=5432,
    user="hotel",
    password="hotel123",
    dbname="hotel_food",
)

cur = conn.cursor()

for _ in range(100):
    o = make_order()

    cur.execute(
        """
        INSERT INTO bronze.raw_orders
            (guest_name, dish, quantity, price, order_type, ordered_at)
        VALUES (%s, %s, %s, %s, %s, %s)
        """,
        (
            o["guest_name"],
            o["dish"],
            o["quantity"],
            o["price"],
            o["order_type"],
            o["ordered_at"]
        ),
    )

conn.commit()

cur.close()
conn.close()

print("Saved 100 orders")