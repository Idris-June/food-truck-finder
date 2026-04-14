Name: Food Truck Finder

This is a simple full stack web application to find food trucks on a map
User can search for food items like pizza or tacos and see available food trucks

---

About the project:

Frontend is built using Flutter web
Backend is built using FastAPI
The app shows food truck locations on a map and allows basic search

---

How it works:

Frontend sends request to backend API
Backend fetches data from DataSF open API
Data is filtered based on search query
Filtered data is sent back and displayed on map

---

Frontend structure:

The frontend is organized in a simple clean way

data folder has models and repository
domain folder has usecase
presentation folder has UI and providers

Since the app is small, the domain layer is minimal but structure is kept for future use

---

Backend structure:

Backend is also simple

routes handles the API endpoints
service handles the logic and external API call
model defines the response structure

---

Features:

User can view food trucks on map
User can search any food items
User can tap marker and see the food truck details
Basic loading and error handling added

---

Performance:

Debouncer is used to reduce API calls while typing
Map loads first and markers load after

---

Setup:

Backend:

cd backend
pip install -r requirements.txt
uvicorn main:app --reload

Frontend:

cd frontend
flutter pub get
flutter run -d chrome

---

Testing:

Basic manual testing was done for frontend and backend.

Frontend was tested by checking search, map loading, and marker interactions.

Simple backend tests were written using FastAPI TestClient.

Tested health endpoint and food trucks API for status and response format.

Due to time constraints, I've not added frontend testing code.

---

Deployment:

Backend is deployed on Render - https://food-truck-api-b126.onrender.com

Frontend is deployed on Firebase hosting - https://food-truck-finder-idris.web.app

---

Author:

Mohammed Idris

---
