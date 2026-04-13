from fastapi import APIRouter
from app.services.food_truck_service import fetch_food_trucks

router = APIRouter()


@router.get("/food-trucks")
def get_food_trucks():
    try:
        return fetch_food_trucks()
    except Exception as e:
        return {"error": str(e)}