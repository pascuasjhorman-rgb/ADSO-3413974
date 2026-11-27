# Informe de Análisis del Sistema de Asistencia Biométrica (SAB) (Anexo E)

**Proyecto:** Sistema de Asistencia Biométrica (SAB)  
**Código del documento:** `INF-ANA-SAB-01` · **Versión:** 1.0  
**Autor:** `@pascuasjhorman-rgb` · **Ficha:** 3413974 · ADSO  
**Competencia:** 220501093 - Análisis de la especificación de requisitos del software  
**RAP evaluados:** 592375 (Planear actividades), 592373 (Modelar funciones), 592374 (Verificar modelos)

---

## 1. Introducción y Requisitos Interpretados

El Sistema de Asistencia Biométrica (SAB) responde a la necesidad de modernizar, agilizar y transparentar la toma de asistencia en el ambiente de formación del SENA (Centro de Industria, Empresa y Servicios - Neiva), sustituyendo planillas físicas y llamados a lista manuales que consumen tiempo formativo valioso.

A partir del levantamiento inicial y el informe de requisitos `SRS-SAB-001`, se estructuraron e interpretaron:
- **54 Requisitos Funcionales (`RF-BIO-001` a `RF-BIO-054`):** agrupados en 10 módulos funcionales (Autenticación RBAC, Administración institucional, Gestión de aprendices, Sesiones de formación, Verificación biométrica y QR dinámico, Incidencias, Contingencia manual, Excusas con soporte, Reportes consolidados y Auditoría/Privacidad).
- **24 Requisitos No Funcionales (`RNF-BIO-001` a `RNF-BIO-024`):** priorizando la seguridad en el servidor, contraseñas con hash+sal, protección y cifrado de plantillas biométricas (Ley 1581 de 2012), tiempo de respuesta ≤ 3 s para el 95 % de consultas y alta disponibilidad del servicio.

---

## 2. Enlaces a los Modelos de Análisis Construidos

Todos los modelos fueron elaborados bajo estándares actuales de ingeniería de software y notación UML/ER:

1. **Plan de Análisis y Metodología Scrum:** [`G1-P1/01-caracterizacion-y-metodologia.md`](../G1-P1-sab-asistencia/01-caracterizacion-y-metodologia.md) y [`G1-P1/02-plan-actividades-analisis.md`](../G1-P1-sab-asistencia/02-plan-actividades-analisis.md).
2. **Diagrama de Casos de Uso UML:** [`G1-P1/03-diagrama-casos-de-uso.drawio`](../G1-P1-sab-asistencia/03-diagrama-casos-de-uso.drawio) · [Imagen PNG](../G1-P1-sab-asistencia/03-diagrama-casos-de-uso.png) · [Justificación de relaciones](../G1-P1-sab-asistencia/03-justificacion-casos-de-uso.md).
3. **Diagramas de Actividades UML con Calles y Guardas:** [`01-actividad-asistencia-ordinaria.drawio`](./01-actividad-asistencia-ordinaria.drawio) · [PNG Asistencia](./01-actividad-asistencia-ordinaria.png) y [`01-actividad-contingencia-sesion.drawio`](./01-actividad-contingencia-sesion.drawio) · [PNG Contingencia](./01-actividad-contingencia-sesion.png).
4. **Plantillas Extendidas de Casos de Uso:** [`02-plantillas-extendidas-cu.md`](./02-plantillas-extendidas-cu.md) (`CU-08`, `CU-05`, `CU-11`, `CU-13`).
5. **Modelo de Dominio Conceptual:** [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio) · [Imagen PNG](./03-modelo-dominio.png) (12 clases conceptuales, atributos de negocio, generalización y clase de asociación).
6. **Modelo Entidad-Relación en Pata de Gallo:** [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio) · [Imagen PNG](./04-modelo-entidad-relacion.png) (11 entidades, asociativa `VINCULACION_FICHA` y entidades débiles).
7. **Prototipo Inicial de Pantallas:** [`05-prototipo-pantallas.md`](./05-prototipo-pantallas.md) (Pantallas rotuladas con `CU-05`, `CU-08` y `CU-10/11`).

---

## 3. Resultado de la Verificación y Calidad Documental

Se aplicó la **Lista de Chequeo de Validación** ([`06-lista-chequeo-validacion.md`](./06-lista-chequeo-validacion.md)) evaluando **16 criterios objetivos** sobre los artefactos:
- **16 criterios cumplidos (100 % de conformidad).**
- Cobertura funcional total: el 100 % de los requisitos funcionales están asociados a casos de uso y respaldados en el modelo de datos.
- Consistencia semántica: cada concepto del negocio presente en las plantillas extendidas existe como clase de dominio y entidad relacional.

---

## 4. Ajustes Realizados (Segunda Verificación)

Durante la evaluación de calidad se registraron y corrigieron **5 hallazgos principales** ([`07-registro-ajustes-analisis.md`](./07-registro-ajustes-analisis.md)):
1. Inversión de la dirección de flechas en las relaciones `«extend»` de casos de uso para cumplir el estándar UML.
2. Eliminación de tecnicismos de implementación (endpoints y SQL) en las descripciones de análisis.
3. Desacoplamiento de claves foráneas relacionales dentro del modelo de dominio.
4. Vinculación formal y rotulado de pantallas del prototipo inicial con sus casos de uso.
5. Inclusión de la entidad asociativa `VINCULACION_FICHA` para resolver la relación muchos a muchos con atributos propios.

La segunda verificación confirmó que todos los hallazgos quedaron solventados, dejando la línea base de análisis aprobada y lista para la fase de arquitectura y diseño.
