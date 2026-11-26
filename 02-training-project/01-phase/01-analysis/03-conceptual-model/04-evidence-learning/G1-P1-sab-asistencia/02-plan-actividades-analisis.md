# Plan de actividades de análisis · Metodología Scrum (SAB)

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Metodología:** Scrum  
**Responsable individual de esta entrega:** `@pascuasjhorman-rgb`  
**Ventana de análisis:** Semanas de fase de análisis / consolidación de requisitos y modelado conceptual (octubre – noviembre de 2026)

> Las actividades están **priorizadas** de acuerdo con el *Product Backlog* de análisis (prioridad **Alta / Crítica** primero: núcleo biométrico-QR, seguridad y contingencia; luego **Media**: administración extendida, estadísticas y auditoría avanzada) y organizadas en iteraciones cortas (*Sprints* de análisis de 1 semana) con revisiones periódicas (*Sprint Review*) junto al instructor y usuarios expertos.

---

## Plan y cronograma de actividades de análisis

| ID | Prioridad | Sprint / Iteración | Actividad de análisis | Responsable | Fecha prevista | Entregable verificable |
|---|---|---|---|---|---|---|
| **ACT-01** | Alta (P1) | Sprint 0 (Alistamiento) | Caracterización del proyecto SAB, levantamiento de restricciones institucionales (Ley 1581, sedes Neiva) y selección de metodología Scrum. | `@pascuasjhorman-rgb` (con validación de Equipo SAB) | 2026-10-20 al 2026-10-23 | Documento de caracterización, reglas de negocio (`RN-01`–`RN-12`) y selección metodológica (`01-caracterizacion-y-metodologia.md`). |
| **ACT-02** | Alta (P1) | Sprint 1 (Requisitos Core) | Refinamiento de requisitos funcionales de autenticación, sesiones de formación y doble validación biométrica-QR (`RF-BIO-001`–`005`, `018`–`030`). | `@pascuasjhorman-rgb` | 2026-10-24 al 2026-10-28 | Catálogo priorizado de RF/RNF en el SRS y matriz de trazabilidad RF → CU (`04-matriz-rf-cu.md`). |
| **ACT-03** | Alta (P1) | Sprint 1 (Requisitos Core) | Identificación de actores primarios/secundarios y modelado del **Diagrama de Casos de Uso UML** con relaciones `«include»` y `«extend»`. | `@pascuasjhorman-rgb` | 2026-10-29 al 2026-11-03 | Diagrama UML editable (`.drawio`), imagen exportada (`.png`/`.svg`) y justificación de relaciones (`03-diagrama-casos-de-uso.*`). |
| **ACT-04** | Alta (P1) | Sprint 2 (Flujos Críticos) | Elaboración de **diagramas de actividades UML** y **plantillas extendidas** para los flujos críticos (verificación huella-QR, apertura/cierre de sesión y contingencia manual). | `@pascuasjhorman-rgb` | 2026-11-04 al 2026-11-10 | 2+ diagramas de actividades con guardas y calles por actor + 3+ plantillas extendidas de CU (Anexo A). |
| **ACT-05** | Alta (P2) | Sprint 2 (Dominio y Datos) | Abstracción de conceptos del negocio en el **Modelo de Dominio** y estructuración del **Modelo Entidad-Relación (MER)** con entidades asociativas y reglas de unicidad. | `@pascuasjhorman-rgb` | 2026-11-11 al 2026-11-16 | Diagramas de Modelo de Dominio (sin métodos/FK) y MER en notación pata de gallo (fuentes editables + PNG). |
| **ACT-06** | Media (P2) | Sprint 3 (Prototipo y Backlog secundario) | Especificación de módulos complementarios (incidencias, excusas, reportes PDF/XLSX, auditoría) y construcción de **prototipos de interfaz** rotulados por CU. | `@pascuasjhorman-rgb` | 2026-11-17 al 2026-11-21 | Prototipo inicial de 3+ pantallas críticas rotuladas con su CU (`CU-05`, `CU-06/07/08`, `CU-11/13`). |
| **ACT-07** | Alta (Cierre) | Sprint 3 (Validación QA) | Aplicación de **lista de chequeo de validación** (≥ 15 criterios) y ejecución de **registro de ajustes** con segunda verificación (Sprint Review de calidad). | `@pascuasjhorman-rgb` | 2026-11-22 al 2026-11-26 | Lista de chequeo diligenciada (Anexo B) y registro de hallazgos/ajustes verificados (Anexo D). |
| **ACT-08** | Alta (Cierre) | Sprint 3 (Entrega final) | Consolidación de **matriz de trazabilidad completa** (RF → CU → Actividad → Dominio → MER → Pantalla) e **informe de análisis** para aprobación del Sprint Review. | `@pascuasjhorman-rgb` | 2026-11-26 al 2026-11-27 | Informe de análisis (Anexo E) y matriz de trazabilidad integral (Anexo C) listos para revisión del instructor. |

---

## Ceremonias de control Scrum aplicadas al análisis
- **Sprint Planning:** Al inicio de cada sprint se seleccionan los requisitos (`RF-BIO`) y artefactos según prioridad del negocio (primero asistencia biométrica-QR y contingencias; luego reportes y administración).
- **Daily / Seguimiento corto:** Revisión rápida de bloqueos (por ejemplo, coherencia entre nombres de casos de uso y entidades conceptuales o validación de reglas de negocio `RN-01`–`RN-12`).
- **Sprint Review:** Validación de entregables con el instructor académico/líder al cierre de cada iteración antes de congelar la línea base para la fase de Diseño (Guía 2).
- **Sprint Retrospective:** Registro de hallazgos y mejoras documentales (alimenta directamente el registro de ajustes del Producto 2).
