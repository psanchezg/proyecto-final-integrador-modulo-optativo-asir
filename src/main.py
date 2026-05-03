from fastapi import FastAPI
from pydantic import BaseModel
from src.brain import obtener_respuesta

app = FastAPI(title="ASIR-Bot API")

class UserMessage(BaseModel):
    mensaje: str

@app.get("/")
async def root():
    return {"status": "ASIR-Bot está activo y funcionando"}

@app.post("/chat")
async def chat(user_msg: UserMessage):
    respuesta = obtener_respuesta(user_msg.mensaje)
    return {"respuesta": respuesta}
