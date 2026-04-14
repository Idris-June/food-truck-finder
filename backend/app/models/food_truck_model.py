from pydantic import BaseModel


class FoodTruck(BaseModel):
    name: str = None
    food_items: str = None
    latitude: str = None
    longitude: str = None
    address: str = None