from typing import List
from fastapi import APIRouter, Query, HTTPException
from app.services.food_truck_service import fetch_food_trucks
from app.models.food_truck_model import FoodTruck

router = APIRouter()


@router.get("/food-trucks", response_model=List[FoodTruck])
def get_food_trucks(q: str = Query(None)):
    try:
        data = fetch_food_trucks(q)

        if not data:
            raise HTTPException(status_code=404, detail="No food trucks found")

        return data

    except Exception:
        raise HTTPException(
            status_code=500, detail="Failed to fetch food trucks"
        )