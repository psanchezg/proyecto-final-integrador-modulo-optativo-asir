# Solución de Problemas (Troubleshooting)

A continuación se detallan algunos problemas comunes y cómo solucionarlos:

### 1. Error de conexión al descargar imágenes (ghcr.io)
**Síntoma:** `DeadlineExceeded` o `Connection refused` al hacer `docker build`.
**Solución:** Reiniciar el motor de Docker (Docker Desktop) y verificar la conexión a internet. A veces los registros de contenedores tienen caídas temporales.

### 2. Puerto 8000 ya ocupado
**Síntoma:** Error al levantar el contenedor indicando que el puerto ya está en uso.
**Solución:** 
- Detener otros servicios que usen ese puerto.
- Cambiar el mapeo en `docker-compose.yml` (ejemplo: `"8080:8000"`).

### 3. Problemas de permisos con el volumen `data/`
**Síntoma:** El bot no puede leer o escribir en `conocimientos.json` dentro del contenedor.
**Solución:** Asegurarse de que el usuario que ejecuta Docker tiene permisos de lectura/escritura en la carpeta local `./data`. En el Dockerfile ya realizamos un `chown`, pero el montaje de volúmenes a veces requiere revisar los permisos del host.

### 4. Cambios en el código no se reflejan en Docker
**Síntoma:** Modificas un archivo pero el contenedor sigue ejecutando la versión antigua.
**Solución:** Reconstruir la imagen con `docker compose up --build`.
