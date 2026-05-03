# Proyecto Final: ASIR-Bot - Chatbot Web con Persistencia JSON

Este proyecto consiste en el desarrollo de un chatbot inteligente y ligero utilizando Python, diseñado para ser fácilmente desplegable mediante contenedores.

## 📋 Aplicación

Aplicación en lenguage _python_ con una **interfaz web** en lugar de Tkinter para garantizar una mejor compatibilidad con entornos Docker y facilitar el acceso remoto y online.

### 1. Funcionalidades del Chatbot
- **Interacción en tiempo real:** Interfaz web minimalista donde el usuario envía mensajes y recibe respuestas.
- **Base de conocimientos (JSON):** Las respuestas se gestionan desde un archivo `conocimientos.json`. Si el bot no conoce una respuesta, puede aprenderla o dar una respuesta por defecto.
- **Historial de conversación:** Almacenamiento opcional de las sesiones en el servidor (ficheros json).
- **Administración básica:** Capacidad de actualizar el archivo JSON mediante la propia lógica de la aplicación.

### 2. Stack Tecnológico
- **Lenguaje:** Python 3.11.
- **Framework Web:** FastAPI (alternativa moderna y asíncrona que facilita la creación de APIs y la validación de datos).
- **Almacenamiento:** Archivo plano `.json` para persistencia (cumpliendo el requisito de volúmenes en Docker Compose).
- **Frontend:** HTML5 / CSS3 (Vanilla) y un mínimo de JavaScript para llamadas asíncronas (Fetch API).

### 3. Estructura del Proyecto (Planificación)
Para cumplir con los requisitos del módulo, el desarrollo se organizará de la siguiente manera:
1. `src/main.py`: Lógica principal del servidor (FastAPI) y procesamiento de mensajes.
2. `src/brain.py`: Módulo encargado de la lectura/escritura del archivo JSON.
3. `src/templates/index.html`: Interfaz de usuario (Jinja2).
4. `src/static/style.css`: Estilos visuales.
5. `data/conocimientos.json`: Nuestra "base de datos" persistente.

## 🛠️ Hoja de Ruta para el Desarrollo

1. **Fase de Código:**
   - Implementar la lógica de búsqueda en el JSON (coincidencia de palabras clave).
   - Crear las rutas en FastAPI para servir la web y recibir peticiones POST con las consultas.
   - Organizar todo el código fuente dentro de la carpeta `src/`.
2. **Fase de Git:**
   - Crear rama `feature/backend` para la lógica de respuesta.
   - Crear rama `feature/frontend` para la interfaz.
   - Realizar Pull Request a `main`.
3. **Fase de Contenerización:**
   - Definir `Dockerfile` basado en `python:3.11-slim` que copie el contenido de `src/`.
   - Configurar `docker-compose.yml` montando el volumen `./data:/app/data` para que el aprendizaje del bot no se pierda al reiniciar el contenedor.


## ⚙️ Requerimientos e instalaciones iniciales

Para el desarrollo de este proyecto, utilizaremos `uv`, un administrador de paquetes y entornos de Python extremadamente rápido escrito en Rust.

### 1. Instalación de `uv`
Si no tienes `uv` instalado, puedes hacerlo siguiendo las instrucciones oficiales de [Astral](https://github.com/astral-sh/uv):

**macOS/Linux:**
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### 2. Inicialización del proyecto (sólo para desarrollo)
Una vez instalado `uv`, inicializamos nuestro entorno de trabajo:

```bash
# Inicializar el proyecto (crea pyproject.toml)
uv init
```

### 3. Instalación de dependencias
Añadimos FastAPI y las herramientas necesarias para la interfaz web y el servidor:

```bash
uv add fastapi uvicorn jinja2
```

## 🚀 Ejecución

Para ejecutar la aplicación en modo desarrollo (con recarga automática):

```bash
uv run uvicorn src.main:app --reload
```

### 🌐 Acceso a la aplicación

Una vez en ejecución, puedes interactuar con el chatbot de dos formas:

1.  **Interfaz Web:** Abre tu navegador en `http://127.0.0.1:8000` para usar la interfaz gráfica.
2.  **Documentación API:** Accede a `http://127.0.0.1:8000/docs` para probar los endpoints manualmente.

### 💬 Mensajes de prueba

Puedes probar el chatbot con las siguientes frases:
- "Hola" o "Buenas"
- "¿Quién eres?"
- "¿Qué es ASIR?"
- "Frase aleatoria" (para ver la respuesta por defecto)
