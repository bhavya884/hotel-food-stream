import random
from datetime import datetime, timedelta
from faker import Faker

fake = Faker("en_IN")  # makes Indian names; change to "en_US" if you like

MENU = {
    "Chicken Biryani": 280,
    "Paneer Butter Masala": 240,
    "Masala Dosa": 120,
    "Veg Fried Rice": 180,
    "Butter Naan": 50,
    "Club Sandwich": 200,
    "Filter Coffee": 60,
    "Gulab Jamun": 90,
}

ORDER_TYPES = ["Dine-in", "Room Service", "Takeaway"]


def make_order():
    """Make one fake food order and return it as a dictionary."""
    dish = random.choice(list(MENU))
    minutes_ago = random.randint(0, 600)
    return {
        "guest_name": fake.name(),
        "dish": dish,
        "quantity": random.randint(1, 4),
        "price": MENU[dish],
        "order_type": random.choice(ORDER_TYPES),
        "ordered_at": datetime.now() - timedelta(minutes=minutes_ago),
    }


if __name__ == "__main__":
    for i in range(10):
        print(i + 1, make_order())