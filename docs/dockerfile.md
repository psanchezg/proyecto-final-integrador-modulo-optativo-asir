# Explicación del Dockerfile

A continuación se detalla el contenido del archivo `Dockerfile` y la explicación de cada una de sus líneas para facilitar su comprensión.

```dockerfile
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
```

### Detalle línea a línea:

1.  **`FROM python:3.11-slim`**: Define la imagen base de Python. Usamos la versión `slim` para minimizar el tamaño y la superficie de ataque del contenedor.
2.  **`COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/`**: Copia los binarios de `uv` directamente desde la imagen oficial a nuestra imagen, permitiendo gestionar paquetes de forma ultra rápida.
3.  **`RUN groupadd -r asiruser && useradd -r -g asiruser -d /app asiruser`**: Crea un grupo y un usuario de sistema (`asiruser`) sin privilegios de root para mejorar la seguridad del entorno.
4.  **`WORKDIR /app`**: Define el directorio de trabajo principal dentro del contenedor donde se alojará la aplicación.
5.  **`ENV UV_PROJECT_ENVIRONMENT=/usr/local`**: Configura una variable de entorno para que `uv` instale las dependencias en el path global del sistema, evitando la necesidad de gestionar entornos virtuales dentro del contenedor.
6.  **`COPY pyproject.toml uv.lock ./`**: Copia los archivos que definen las dependencias. Se hace antes que el código para aprovechar la caché de capas de Docker.
7.  **`RUN uv sync --frozen --no-cache --no-install-project`**: Ejecuta la instalación de todas las dependencias externas bloqueando las versiones exactas.
8.  **`COPY src/ ./src/`** y **`COPY data/ ./data/`**: Copia todo el código fuente y la base de conocimientos JSON al contenedor.
9.  **`RUN chown -R asiruser:asiruser /app`**: Cambia el propietario de todos los archivos copiados al usuario `asiruser` creado anteriormente.
10. **`USER asiruser`**: Cambia el contexto de ejecución del contenedor al usuario sin privilegios.
11. **`RUN uv sync --frozen --no-cache`**: Sincroniza el proyecto final para asegurar que la aplicación está instalada correctamente bajo el usuario final.
12. **`EXPOSE 8000`**: Documenta que el contenedor escuchará en el puerto 8000.
13. **`CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]`**: Comando definitivo que arranca el servidor FastAPI. Escucha en `0.0.0.0` para permitir conexiones externas al contenedor.
