from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
from src.brain import obtener_respuesta

app = FastAPI(title="ASIR-Bot API")

# Configuración de archivos estáticos y plantillas
app.mount("/static", StaticFiles(directory="src/static"), name="static")
templates = Jinja2Templates(directory="src/templates")

class UserMessage(BaseModel):
    mensaje: str

@app.get("/")
async def get_index(request: Request):
    return templates.TemplateResponse(
        request=request, name="index.html", context={}
    )

@app.post("/chat")
async def chat(user_msg: UserMessage):
    respuesta = obtener_respuesta(user_msg.mensaje)
    return {"respuesta": respuesta}
