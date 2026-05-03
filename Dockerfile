# Usar una imagen base ligera de Python
FROM python:3.11-slim

# Instalamos uv copiando el binario desde la imagen oficial
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Establecer el directorio de trabajo
WORKDIR /app

# Habilitamos la instalación de paquetes en el entorno del sistema del contenedor
# o usamos el entorno virtual de uv. Por simplicidad en Docker:
ENV UV_PROJECT_ENVIRONMENT=/usr/local

# Copiamos los archivos de definición de proyecto
COPY pyproject.toml uv.lock ./

# Instalamos las dependencias (usando --no-install-project para cachear capas)
RUN uv sync --frozen --no-cache --no-install-project

# Copiamos el resto del código y datos
COPY src/ ./src/
COPY data/ ./data/

# Instalamos el proyecto actual
RUN uv sync --frozen --no-cache

# Exponemos el puerto
EXPOSE 8000

# Comando para ejecutar la aplicación
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
