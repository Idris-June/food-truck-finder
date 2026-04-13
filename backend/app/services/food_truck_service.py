import requests

data_url = "https://data.sfgov.org/resource/rqzj-sfat.json"


def fetch_food_trucks():
    response = requests.get(data_url)
    data = response.json()
    result = []

    for item in data[:20]:
        truck = {
            "name": item.get("applicant"),
            "food_items": item.get("fooditems"),
            "latitude": item.get("latitude"),
            "longitude": item.get("longitude"),
            "address": item.get("location")
        }
        result.append(truck)

    return result