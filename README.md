# Proyecto Final: ASIR-Bot - Chatbot Web con Persistencia JSON

Este proyecto consiste en el desarrollo de un chatbot inteligente y ligero utilizando Python, diseñado para ser fácilmente desplegable mediante contenedores.

## 📁 Organización del Repositorio

A continuación se muestra la estructura del proyecto y el flujo de trabajo seguido:

### Estructura de archivos
```text
.
├── pyproject.toml       # Configuración de dependencias (uv)
├── Dockerfile           # Construir la imagen del contenedor
├── docker-compose.yml   # Orquestación de servicios y volúmenes
├── data/                # Carpeta de persistencia
│   └── conocimientos.json
├── src/                 # Código fuente de la aplicación
│   ├── main.py          # Servidor FastAPI
│   ├── brain.py         # Lógica del chatbot
│   ├── templates/       # Vistas HTML (Jinja2)
│   └── static/          # Estilos CSS y JS
└── docs/                # Documentación detallada
```

### Flujo de ramas (Git Workflow)
El proyecto se ha desarrollado siguiendo una metodología de ramas por funcionalidad:
- **`main`**: Versión estable y lista para producción.
- **`feature/initial-setup`**: Configuración de `uv`, estructura de carpetas y README inicial.
- **`feature/backend`**: Implementación de la lógica en Python y FastAPI.
- **`feature/frontend`**: Desarrollo de la interfaz web y estilos.
- **`feature/docker`**: Creación del Dockerfile y pruebas de imagen.
- **`feature/orchestration`**: Configuración de Docker Compose y persistencia.
- **`feature/enhanced-docs`**: (Actual) Mejora de la documentación detallada.

## 📖 Documentación Detallada

Para más información sobre el funcionamiento técnico, consulta los siguientes documentos:

- 🐳 [Explicación del Dockerfile](./docs/dockerfile.md)
- 🐙 [Explicación del Docker Compose](./docs/docker-compose.md)
- 🔧 [Solución de problemas comunes](./docs/troubleshooting.md)

---

## 📋 Aplicación
... (resto del contenido)

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

## 🚀 Ejecución (Local con uv)

Para ejecutar la aplicación en modo desarrollo (con recarga automática):

```bash
uv run uvicorn src.main:app --reload
```

### 🌐 Acceso a la aplicación

Una vez en ejecución, puedes interactuar con el chatbot de dos formas:

1.  **Interfaz Web:** Abre el navegador en `http://127.0.0.1:8000` para usar la interfaz gráfica.
2.  **Documentación API:** Accede a `http://127.0.0.1:8000/docs` para probar los endpoints manualmente.

### 💬 Mensajes de prueba

Puedes probar el chatbot con las siguientes frases:
- "Hola" o "Buenas"
- "¿Quién eres?"
- "¿Qué es ASIR?"
- "Frase aleatoria" (para ver la respuesta por defecto)

## 🐳 Docker

Este proyecto está preparado para ser ejecutado en contenedores.

### 1. Construir la imagen

Puedes etiquetar la imagen manualmente o usar este comando para extraer la versión automáticamente desde el `pyproject.toml`:

```bash
# Extrae la versión (ej. 0.1.0) y construye la imagen
VERSION=$(grep -m 1 version pyproject.toml | cut -d '"' -f 2)
docker build -t asir-bot:$VERSION .
```

### 2. Ejecutar el contenedor (Manual)

```bash
docker run -d -p 8000:8000 --name asir-bot-container asir-bot
```

## 🐙 Orquestación con Docker Compose

La forma recomendada de desplegar el chatbot es usando Docker Compose, ya que gestiona automáticamente los volúmenes para la persistencia de datos.

### 1. Levantar el servicio

```bash
docker compose up -d
```

Este comando construirá la imagen y levantará el contenedor mapeando el puerto `8000` y montando el volumen de datos.

### 2. Persistencia de datos

Gracias al archivo `docker-compose.yml`, los cambios que el bot aprenda o los ajustes en `data/conocimientos.json` se mantendrán aunque el contenedor se detenga o elimine, ya que están vinculados a la carpeta local `./data`.

### 3. Detener los servicios

```bash
docker compose down
```

La aplicación está disponible en `http://127.0.0.1:8000`.

