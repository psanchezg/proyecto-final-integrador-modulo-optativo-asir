# Proyecto Integrador: Desarrollo, Control de Versiones y Despliegue con Docker

## 🎯 Objetivo
Desarrollar una aplicación sencilla (por ejemplo, un chatbot en Python con base de datos JSON y Tkinter) o un servicio alternativo elegido por el alumno/a.

La aplicación deberá estar correctamente documentada, versionada en GitHub, contenerizada en Docker, y desplegada preferentemente con Docker Compose, de manera que pueda ejecutarse fácilmente en otro equipo.

## 📌 Requisitos del proyecto

### 1. Control de versiones con Git y GitHub
- Crear un repositorio en GitHub para el proyecto.
- Usar ramas de desarrollo para cada nueva funcionalidad y una rama principal para la versión estable. 
- Realizar commits frecuentes y descriptivos.
- Crear al menos un pull request para fusionar una rama secundaria en main.
- Documentar en el repositorio cómo se organiza el flujo de trabajo con ramas.

### 2. Desarrollo de la aplicación
- Aplicación base propuesta: chatbot en Python con Tkinter, con base de datos en un archivo JSON.
    - Permite preguntas y respuestas simples.
    - Se puede extender con URLs, ejemplos, etc.
- Alternativa: el alumnado puede elegir otro servicio (ejemplo: una API REST sencilla en Flask, un servidor web estático, etc.), siempre que cumpla los demás requisitos.

### 3. Contenerización con Docker
- Crear un Dockerfile que:
    - Use una imagen base adecuada (python:3.11-slim o similar).
    - Instale dependencias necesarias (ejemplo: tkinter, json, etc.).
    - Copie los archivos de la aplicación al contenedor.
    - Exponga los puertos necesarios para la comunicación.
    - Ejecute la aplicación al iniciar el contenedor.
- Probar que la aplicación se ejecuta correctamente dentro del contenedor.

### 4. Orquestación con Docker Compose
- Crear un archivo docker-compose.yml que:
    - Defina el servicio principal (chatbot u otro).
    - Configure volúmenes para persistencia de datos (ejemplo: base_datos.json).
    - Exponga los puertos necesarios para que la aplicación sea accesible desde el host.
    - (Opcional) Añada un servicio adicional, como una base de datos externa (ejemplo: mongo, mysql, postgres) para quienes quieran ir más allá.

### 5. Documentación en Markdown
El repositorio deberá incluir un archivo README.md con:
- 📖 Descripción del proyecto (qué es, qué hace, cómo funciona).
- 🚀 Instrucciones de instalación y despliegue paso a paso:
    - Clonar el repositorio.
    - Construir la imagen con docker build.
    - Levantar los servicios con docker compose up.
    - Acceder a la aplicación (indicar URL/puerto).
- 🐳 Explicación de los archivos Dockerfile y docker-compose.yml.
- 🔧 Posibles problemas y soluciones (ejemplo: conflictos de puertos, permisos).
- ✨ Contribuciones y organización del proyecto (cómo se usan las ramas de GitHub).
- (Opcional) Capturas de pantalla o diagramas de arquitectura (ejemplo en Markdown o con draw.io).

### 6. Exposición de puertos
- La aplicación debe ser accesible desde fuera del contenedor (ejemplo: navegador, cliente HTTP o GUI).
- Indicar claramente en el README.md cuál es el puerto expuesto.


## 📂 Entregables
- Repositorio público en GitHub con:
    - Código de la aplicación.
    - Archivo Dockerfile.
    - Archivo docker-compose.yml.
    - Documentación completa (README.md).
    - Historial de commits y ramas.

## ✅ Criterios de evaluación
1. **Uso de GitHub**: repositorio creado, ramas gestionadas, commits claros, pull requests realizados.
2. **Funcionalidad de la aplicación**: cumple con lo propuesto (chatbot u otra aplicación).
3. **Docker**: aplicación correctamente contenerizada y ejecutable en otro sistema.
4. **Docker Compose**: despliegue automatizado y configuración de servicios.
5. **Documentación**: README claro, completo y bien estructurado.
6. **Exposición de puertos**: aplicación accesible desde el exterior.
7. **Extras opcionales**: integración de servicios adicionales, CI/CD, buenas prácticas avanzadas.