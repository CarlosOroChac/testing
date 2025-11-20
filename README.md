# testing

# Smart Device Tester

Un proyecto de simulación IoT construido con **Flutter**, diseñado para demostrar la implementación efectiva de pruebas de software y aseguramiento de calidad (QA).

## De qué trata el proyecto
Este repositorio explora patrones de testing avanzados simulando un controlador de hogar inteligente. El foco no está solo en que la app funcione, sino en garantizar que **no falle** bajo condiciones inesperadas.

### Tecnologías y Conceptos Clave
- **Unit Testing:** Lógica de termostato, validación de comandos y buffers de logs.
- **Mocking (Mocktail):** Simulación de hardware externo, latencia de red y excepciones.
- **Widget Testing:** Pruebas de renderizado y respuesta a gestos del usuario.
- **Patrón AAA:** (Arrange-Act-Assert) en todos los suites de prueba.

## Escenarios de Prueba Destacados
El proyecto cubre situaciones críticas como:
- Manejo de **Timeouts** en calibración de sensores.
- Respuesta ante niveles críticos de batería y COx.
- Validación de límites de temperatura (Safety limits).

---
*Desarrollado por Carlos Orozco para programación Avanzada.*