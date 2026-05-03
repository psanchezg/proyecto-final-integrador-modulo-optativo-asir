# Usar una imagen base ligera de Python
FROM python:3.11-slim

# Instalamos uv copiando el binario desde la imagen oficial
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Crear un usuario no root por seguridad
RUN groupadd -r asiruser && useradd -r -g asiruser -d /app asiruser

# Establecer el directorio de trabajo
WORKDIR /app

# Habilitamos la instalación de paquetes en el entorno del sistema
ENV UV_PROJECT_ENVIRONMENT=/usr/local

# Copiamos los archivos de definición de proyecto
COPY pyproject.toml uv.lock ./

# Instalamos las dependencias
RUN uv sync --frozen --no-cache --no-install-project

# Copiamos el resto del código y datos
COPY src/ ./src/
COPY data/ ./data/

# Cambiar la propiedad de los archivos al usuario no root
RUN chown -R asiruser:asiruser /app

# Cambiar al usuario no root
USER asiruser

# Instalamos el proyecto actual
RUN uv sync --frozen --no-cache

# Exponemos el puerto
EXPOSE 8000

# Comando para ejecutar la aplicación
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
