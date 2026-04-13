from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Food Truck Api is running"}

@app.get("/health")
def health():
    return {"status": "ok"}