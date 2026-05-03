import json
import os

DATA_PATH = os.path.join("data", "conocimientos.json")

def cargar_conocimientos():
    if not os.path.exists(DATA_PATH):
        return {"default": "No tengo conocimientos cargados."}
    with open(DATA_PATH, "r", encoding="utf-8") as f:
        return json.load(f)

def obtener_respuesta(mensaje: str):
    conocimientos = cargar_conocimientos()
    mensaje = mensaje.lower().strip()
    
    for clave, data in conocimientos.items():
        if clave == "default":
            continue
        # Buscamos si alguna de las preguntas/keywords está en el mensaje del usuario
        if any(pregunta in mensaje for pregunta in data["preguntas"]):
            return data["respuesta"]
            
    return conocimientos.get("default", "No entiendo la pregunta.")
