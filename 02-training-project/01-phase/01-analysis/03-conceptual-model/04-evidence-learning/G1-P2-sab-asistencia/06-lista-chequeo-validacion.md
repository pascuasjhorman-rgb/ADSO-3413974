# Lista de Chequeo de Validación de Modelos de Análisis (Anexo B)

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Ficha:** 3413974  
**Evaluador individual:** `@pascuasjhorman-rgb`  
**Objetivo:** Verificar el cumplimiento, consistencia y trazabilidad de los modelos y artefactos construidos para la Guía 1 (Modelo Conceptual).

> Cada criterio es verificable de forma binaria (Sí / No) con cita a la evidencia concreta dentro de los artefactos de entrega. Se incluyen 16 criterios (mínimo 15 exigidos), de los cuales 4 son estrictamente de cobertura y trazabilidad.

| # | Criterio verificable (responde Sí o No) | Artefacto evaluado | ¿Cumple? | Evidencia (enlace o cita específica) | Hallazgo / Ajuste requerido |
|---|---|---|---|---|---|
| 1 | Cada requisito funcional del SRS aparece en al menos un caso de uso (cobertura ≥ 90 %). | Matriz RF → CU (`G1-P1`) | **Sí** | `G1-P1/04-matriz-rf-cu.md`: 54 de 54 RF mapeados a CU (100 % de cobertura). | Ninguno. Cobertura completa. |
| 2 | El diagrama de casos de uso incluye al menos 8 casos, frontera del sistema y actores fuera de ella. | Diagrama de Casos de Uso (`G1-P1`) | **Sí** | `G1-P1/03-diagrama-casos-de-uso.png`: 18 casos de uso, frontera delimitada y 4 actores primarios + 1 secundario. | Ninguno. |
| 3 | Cada relación `«include»` y `«extend»` está justificada y tiene la dirección de flecha correcta según el estándar UML. | Justificación de Casos de Uso (`G1-P1`) | **Sí** | `G1-P1/03-justificacion-casos-de-uso.md`: `CU-08` include `CU-06`/`CU-07`, flechas validadas en `.drawio` y `.png`. | Hallazgo H-01 corregido: se ajustó la dirección inicial de extend. |
| 4 | Los requisitos no funcionales están explícitamente diferenciados de los funcionales y no se modelan como casos de uso aislados. | Matriz RF/RNF (`G1-P1`) | **Sí** | `G1-P1/04-matriz-rf-cu.md` sección 1: tabla comparativa y separación de `RNF-BIO-001` a `024`. | Ninguno. |
| 5 | Cada caso de uso crítico cuenta con una plantilla extendida que incluye precondiciones, postcondiciones, flujo principal de ≥ 6 pasos, al menos 1 alterno y 1 excepción. | Plantillas Extendidas (`G1-P2`) | **Sí** | `G1-P2/02-plantillas-extendidas-cu.md`: 4 plantillas (`CU-08`, `CU-05`, `CU-11`, `CU-13`) con 7 pasos c/u. | Ninguno. Estructura Anexo A completa. |
| 6 | Las plantillas de casos de uso describen la intención del negocio sin incluir detalles técnicos de implementación (SQL, tablas, endpoints). | Plantillas Extendidas (`G1-P2`) | **Sí** | `G1-P2/02-plantillas-extendidas-cu.md`: lenguaje de intención de usuario y respuestas del sistema. | Hallazgo H-02 corregido: se eliminaron referencias a APIs REST en el análisis. |
| 7 | Los diagramas de actividades tienen inicio, fin, calles por actor y decisiones con guardas entre corchetes `[...]` en todas sus salidas. | Diagramas de Actividades (`G1-P2`) | **Sí** | `G1-P2/01-actividad-asistencia-ordinaria.png` y `contingencia-sesion.png`: guardas `[coincide]`, `[no]`, `[intentos < 3]`, etc. | Ninguno. Guardas exhaustivas. |
| 8 | Cada rama alterna o de excepción del diagrama de actividades tiene su contraparte textual en la plantilla del mismo caso de uso. | Actividades y Plantillas (`G1-P2`) | **Sí** | `CU-08`: rama `[intentos >= 3]` corresponde a la excepción 3b de la plantilla; `[ya existe]` a la excepción 2b. | Coherencia 100 % verificada. |
| 9 | Si hay concurrencia en los procesos, el diagrama de actividades utiliza barras de bifurcación y unión (`fork`/`join`). | Diagramas de Actividades (`G1-P2`) | **Sí** | `G1-P2/01-actividad-contingencia-sesion.png`: bifurcación paralela de reporte PDF/XLSX y notificación a ficha. | Ninguno. |
| 10 | El modelo de dominio cuenta con al menos 8 clases conceptuales con atributos de negocio y no incluye métodos ni claves foráneas técnicas. | Modelo de Dominio (`G1-P2`) | **Sí** | `G1-P2/03-modelo-dominio.png`: 12 clases conceptuales, atributos tipados conceptualmente, sin `id_*` ni métodos. | Hallazgo H-03 corregido: se eliminaron FK del modelo de dominio. |
| 11 | El modelo de dominio incluye al menos una generalización o clase de asociación justificada. | Modelo de Dominio (`G1-P2`) | **Sí** | `G1-P2/03-modelo-dominio.png`: herencia `Aprendiz`/`Instructor` de `Usuario` y clase de asociación `VinculacionFicha`. | Cumple ambas estructuras. |
| 12 | Todo concepto del negocio utilizado en las plantillas extendidas existe en el modelo de dominio. | Dominio vs. Plantillas (`G1-P2`) | **Sí** | Conceptos `SesionFormacion`, `TokenQR`, `RegistroAsistencia`, `Incidencia`, `Excusa` mapeados exactamente. | Coherencia semántica total. |
| 13 | El MER declara su notación, incluye al menos 6 entidades con identificadores, cardinalidades mín/máx y resuelve relaciones N:M con entidades asociativas con atributos propios. | Modelo Entidad-Relación (`G1-P2`) | **Sí** | `G1-P2/04-modelo-entidad-relacion.png`: Notación Pata de Gallo, 11 entidades, asociativa `VINCULACION_FICHA`. | Ninguno. |
| 14 | El MER identifica claramente las entidades débiles por existencia o identificación. | Modelo Entidad-Relación (`G1-P2`) | **Sí** | `G1-P2/04-modelo-entidad-relacion.png`: `TOKEN_QR` (débil por identificación de sesión) y `PLANTILLA_BIOMETRICA` (débil de usuario). | Resaltadas con línea discontinua y tag `[Débil]`. |
| 15 | Toda pantalla del prototipo inicial está explícitamente rotulada con el caso de uso crítico que atiende. | Prototipo inicial (`G1-P2`) | **Sí** | `G1-P2/05-prototipo-pantallas.md`: Pantallas rotuladas con `CU-05`, `CU-08` y `CU-10/11` con imágenes integradas. | Hallazgo H-04 corregido: pantallas vinculadas formalmente. |
| 16 | Al menos el 90 % de los requisitos funcionales están trazados hasta caso de uso, plantilla/diagrama, clase de dominio y entidad del MER. | Matriz de Trazabilidad (`G1-P2`) | **Sí** | `G1-P2/08-matriz-trazabilidad-analisis.md`: 100 % de los requisitos del núcleo trazados de extremo a extremo. | Trazabilidad completa hacia adelante y atrás. |

---

## Resumen de la evaluación
- **Total criterios evaluados:** 16
- **Criterios que cumplen:** 16 (100 %)
- **Criterios que no cumplen:** 0
- **Resultado:** Aprobado para línea base de análisis y transición a la fase de diseño.
