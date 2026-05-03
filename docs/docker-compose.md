# Explicación del docker-compose.yml

El archivo `docker-compose.yml` permite orquestar el despliegue del chatbot de forma automatizada, gestionando la construcción de la imagen y la persistencia de datos.

```yaml
services:
  asir-bot:
    build: .
    container_name: asir-bot-app
    ports:
      - "8000:8000"
    volumes:
      - ./data:/app/data
    restart: unless-stopped
```

### Detalle de la configuración:

1.  **`services:`**: Bloque principal donde definimos los servicios (contenedores) que forman nuestra infraestructura.
2.  **`asir-bot:`**: Nombre del servicio. Es el identificador interno que usará Docker Compose.
3.  **`build: .`**: Indica a Docker Compose que debe construir la imagen utilizando el `Dockerfile` que se encuentra en el mismo directorio (`.`).
4.  **`container_name: asir-bot-app`**: Define un nombre específico para el contenedor al ser creado, facilitando su administración mediante comandos de Docker.
5.  **`ports: - "8000:8000"`**: Establece el mapeo de puertos. El tráfico que llegue al puerto 8000 de nuestra máquina se redirigirá al puerto 8000 del contenedor.
6.  **`volumes: - ./data:/app/data`**: **Punto clave para la persistencia.** Mapea la carpeta local `data` con la carpeta `/app/data` del contenedor. Esto asegura que si el bot aprende algo nuevo o modificamos el archivo JSON, los datos no se pierdan al reiniciar el contenedor.
7.  **`restart: unless-stopped`**: Configura la política de reinicio. El contenedor se levantará automáticamente si se produce un error o si el equipo se reinicia, a menos que lo detengamos explícitamente.
