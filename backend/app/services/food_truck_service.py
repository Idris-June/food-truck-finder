import requests
import os
from dotenv import load_dotenv
import logging

load_dotenv()

data_url = os.getenv("data_url")

logger = logging.getLogger(__name__)


def fetch_food_trucks(query: str = None):
    try:
        response = requests.get(data_url, timeout=5)
        response.raise_for_status()
        data = response.json()

        result = []

        for item in data:
            food_items = item.get("fooditems", "")

            if query and query.lower() not in food_items.lower():
                continue

            lat = item.get("latitude")
            lng = item.get("longitude")

            if not lat or not lng or lat == "0" or lng == "0":
                continue

            result.append({
                "name": item.get("applicant"),
                "food_items": food_items,
                "latitude": lat,
                "longitude": lng,
                "address": item.get("address") or item.get("locationdescription")
            })

        return result

    except Exception as e:
        logger.error(f"Error fetching food trucks: {e}")
        return []