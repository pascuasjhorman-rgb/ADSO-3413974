# README de entrega · Guía 1 · Producto 1: Plan de análisis y casos de uso

Ruta de entrega en el fork:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/`

Fecha límite: **sábado 28 de noviembre de 2026 a las 6:00 a. m.**  
Criterios y mínimos aplicados: `Rubricas_G1.md` (Competencia 220501093 · RAP 592375 y 592373 · Criterios C1, C2, C3, C4, C5).

---

> Este repositorio es público. No contiene nombres completos, números de documento, teléfonos ni correos, ni datos reales de terceros. Autor identificado exclusivamente con el usuario de GitHub.

---

## 1. Datos de la entrega

- **Producto:** P1 plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `pascuasjhorman-rgb`
- **Caso de estudio:** Sistema de Asistencia Biométrica (SAB / BioSENA) · Ficha 3413974
- **Trabajo en equipo del año:** Sí. Equipo SAB ("Asistencia Biométrica SENA") en la ficha 3413974 para el levantamiento de requisitos del proyecto formativo (`SRS-SAB-001` v2.3 elaborado en equipo con Juan Sebastián Medina y Jhon Stiven Alba). La caracterización, selección metodológica, plan de análisis, modelado UML de casos de uso y matriz de cobertura de esta entrega son de **autoría individual**.

---

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Levantamiento de necesidades iniciales y casos de uso preliminares | `03-execute/16-week/02-optional-activity/registro de asistencia.md` | Solo |
| Hoja de ruta por fases (Fase 1 a 7) para el sistema de asistencias | `03-execute/17-week/02-optional-activity/Hoja_de_Ruta_Sistema_Toma_de_Asistencias.md` | Solo |
| Diagnóstico cuantitativo de tiempos en SOFIA Plus (8–15 min por checkpoint), objetivos e instrumentos | `03-execute/23-week/02-optional-activity/Sistema_Asistencia_1.1 (1).txt` | En equipo (Equipo SAB) |
| Propuesta técnica y casos de mejora de captura de asistencias | `03-execute/24-week/02-optional-activity/Proyecto_mejora_Kevin_Brenda_Castro_Jhorman.zip` | En equipo (Equipo SAB) |
| Especificación oficial de requisitos `SRS-SAB-001` v2.3 y mockup web BioSENA | [`https://biosena-asistencia-biom-trica.ai.studio/`](https://biosena-asistencia-biom-trica.ai.studio/) y [`00-insumo-analisis-srs-sab.md`](./00-insumo-analisis-srs-sab.md) | En equipo (Equipo SAB) |

---

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | `04-matriz-rf-cu.md` | **Ampliación integral de requisitos (Criterio C3 / RAP 592373):** Se pasó del listado básico de 6 RF de la semana 16 a los requisitos estructurados del `SRS-SAB-001` (100 % cubiertos en el catálogo de casos de uso). Se diferenció taxativamente entre RF y los RNF transversales (`RNF-SAB-001` a `040`) para eliminar mezclas de implementación técnica en la fase de análisis conceptual. | Día 1: [`463388b`](https://github.com/pascuasjhorman-rgb/ADSO-3413974/commit/463388b48bbddc4974f7620ea9b4a44b5840b2ef) · Día 2: *(commit de actualización v2.3)* |
| 2 | `03-diagrama-casos-de-uso.*` y `03-justificacion-casos-de-uso.md` | **Modelado UML formal según estándar (Criterio C4 / RAP 592373 y arbitraje Sec. 7):** Se reemplazó el diagrama informal de semana 16 por un diagrama UML completo con frontera del sistema, actores primarios fuera del límite (`Instructor`, `Aprendiz`, `Coordinador Académico`, `Superadmin`), actor secundario (`Servicio de verificación de identidad`), 18 casos de uso principales con nomenclatura *verbo + objeto*, 2 relaciones `«include»` y 2 `«extend»` con sentido y dirección estrictos justificados línea a línea sin ciclos ni CRUD fragmentado. | Día 1: [`463388b`](https://github.com/pascuasjhorman-rgb/ADSO-3413974/commit/463388b48bbddc4974f7620ea9b4a44b5840b2ef) |
| 3 | `01-caracterizacion-y-metodologia.md` y `02-plan-actividades-analisis.md` | **Caracterización y selección metodológica fundamentada (Criterios C1 y C2 / RAP 592375):** Se sustituyó la planificación lineal genérica de semana 17 por una caracterización en 4 dimensiones de ingeniería (tipo de software web-asistencia, equipo de aprendices, variabilidad media en reglas institucionales, disponibilidad del cliente SENA). Se compararon Scrum, XP, RUP y RAD mediante matriz multicriterio, justificando Scrum como marco óptimo, y se definió un plan de análisis en 3 Sprints con 8 actividades priorizadas, responsables, fechas y entregables medibles. | Día 1: [`463388b`](https://github.com/pascuasjhorman-rgb/ADSO-3413974/commit/463388b48bbddc4974f7620ea9b4a44b5840b2ef) |

---

## 4. Qué construí nuevo

- Documento de síntesis estructurada del `SRS-SAB-001 v2.3` con trazabilidad a BioSENA sin datos sensibles ([`00-insumo-analisis-srs-sab.md`](./00-insumo-analisis-srs-sab.md)).
- Caracterización multidimensional del proyecto y matriz comparativa Scrum vs. XP vs. RUP vs. RAD ([`01-caracterizacion-y-metodologia.md`](./01-caracterizacion-y-metodologia.md)).
- Plan de actividades de análisis estructurado en 3 Sprints con matriz RACI y fechas ([`02-plan-actividades-analisis.md`](./02-plan-actividades-analisis.md)).
- Diagrama UML de casos de uso editable en Draw.io y renders vectoriales/ráster ([`03-diagrama-casos-de-uso.drawio`](./03-diagrama-casos-de-uso.drawio), [`03-diagrama-casos-de-uso.svg`](./03-diagrama-casos-de-uso.svg), [`03-diagrama-casos-de-uso.png`](./03-diagrama-casos-de-uso.png)).
- Justificación detallada de relaciones `«include»` y `«extend»` conforme a los criterios de arbitraje de la sección 7 ([`03-justificacion-casos-de-uso.md`](./03-justificacion-casos-de-uso.md)).
- Matriz completa de trazabilidad Requisito Funcional → Caso de Uso y separación de RNF ([`04-matriz-rf-cu.md`](./04-matriz-rf-cu.md)).

---

## 5. Artefactos entregados

**Producto 1**

- [x] Caracterización de la solución: [01-caracterizacion-y-metodologia.md](./01-caracterizacion-y-metodologia.md)
- [x] Comparación de metodologías y selección justificada: [01-caracterizacion-y-metodologia.md](./01-caracterizacion-y-metodologia.md)
- [x] Plan de actividades, cronograma y entregables: [02-plan-actividades-analisis.md](./02-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable): [03-diagrama-casos-de-uso.drawio](./03-diagrama-casos-de-uso.drawio)
- [x] Diagrama de casos de uso (imagen PNG): [03-diagrama-casos-de-uso.png](./03-diagrama-casos-de-uso.png)
- [x] Diagrama de casos de uso (vectorial SVG): [03-diagrama-casos-de-uso.svg](./03-diagrama-casos-de-uso.svg)
- [x] Justificación técnica de relaciones UML: [03-justificacion-casos-de-uso.md](./03-justificacion-casos-de-uso.md)
- [x] Matriz requisito → caso de uso: [04-matriz-rf-cu.md](./04-matriz-rf-cu.md)

---

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma:** `pascuasjhorman-rgb` · 2026-11-27

---

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente de IA) | Estructuración de plantillas Markdown, generación de código XML base para Draw.io/SVG y validación cruzada de cobertura frente a las rúbricas de evaluación. | Verifiqué personalmente la cobertura de requisitos del SRS-SAB-001, la orientación y semántica estricta de las flechas `«include»` y `«extend»` según la sección 7 de las rúbricas, que todos los casos de uso tuvieran actor iniciador humano fuera de la frontera, y la total ausencia de datos personales de terceros en el repositorio público. |

---

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega (Día 1: commit `463388b` [2026-11-26]; Día 2: [2026-11-27]).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada (`https://github.com/pascuasjhorman-rgb/ADSO-3413974`).
