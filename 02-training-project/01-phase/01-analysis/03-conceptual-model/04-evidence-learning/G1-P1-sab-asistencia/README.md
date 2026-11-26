# Entrega · Guía 1 · Producto 1: Plan de análisis y casos de uso

## 1. Datos de la entrega

- **Producto:** P1 plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `@pascuasjhorman-rgb`
- **Caso de estudio:** Sistema de Asistencia Biométrica (SAB) · `SRS-SAB-001`
- **Trabajo en equipo del año:** Sí (`Equipo SAB`, 3 integrantes en la ficha `3413974` para el SRS base; los artefactos de análisis, selección metodológica, diagramas y ajustes de esta entrega son de autoría individual).

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Levantamiento inicial y casos de uso base de asistencia | `03-execute/16-week/02-optional-activity/registro de asistencia.md` | Solo |
| Hoja de ruta por fases del sistema de asistencias | `03-execute/17-week/02-optional-activity/Hoja_de_Ruta_Sistema_Toma_de_Asistencias.md` | Solo |
| Diagnóstico de necesidades y justificación cuantitativa | `03-execute/23-week/02-optional-activity/Sistema_Asistencia_1.1 (1).txt` | En equipo |
| Especificación de requisitos consolidada `SRS-SAB-001` (sintetizada aquí) | Insumo del proyecto SAB integrado en [`00-insumo-analisis-srs-sab.md`](./00-insumo-analisis-srs-sab.md) | En equipo (3 integrantes) |

## 3. Qué ajusté

*(Los enlaces a los commits se completan tras el segundo día de publicación antes del cierre del sábado 28 de noviembre a las 6:00 a. m.)*

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | `04-matriz-rf-cu.md` | Ampliación de los 6 RF iniciales de la semana 16 a los 54 RF de `SRS-SAB-001` (100 % cubiertos) y separación explícita entre RF y RNF (`RNF-BIO-001`–`024`). | *(pendiente enlace tras push Día 1 / Día 2)* |
| 2 | `03-diagrama-casos-de-uso.drawio` | Reestructuración del diagrama de semana 16: se agregaron frontera del sistema, 4 actores primarios, actor secundario `Servicio biométrico`, 18 casos de uso y relaciones `«include»`/`«extend»` con dirección UML verificada. | *(pendiente enlace tras push Día 1 / Día 2)* |
| 3 | `01-caracterizacion-y-metodologia.md` | Incorporación de caracterización formal en 4 ejes, comparación matricial de 4 metodologías (Scrum, XP, RUP, RAD) y justificación de Scrum frente a los riesgos del lector biométrico. | *(pendiente enlace tras push Día 1 / Día 2)* |

## 4. Qué construí nuevo

- Síntesis estructurada del SRS en el fork ([`00-insumo-analisis-srs-sab.md`](./00-insumo-analisis-srs-sab.md)) sin datos personales de terceros.
- Caracterización de la solución y matriz comparativa de metodologías ([`01-caracterizacion-y-metodologia.md`](./01-caracterizacion-y-metodologia.md)).
- Plan de actividades de análisis en Scrum con 8 actividades priorizadas ([`02-plan-actividades-analisis.md`](./02-plan-actividades-analisis.md)).
- Justificación línea a línea de cada relación `«include»` y `«extend»` ([`03-justificacion-casos-de-uso.md`](./03-justificacion-casos-de-uso.md)).
- Matriz completa RF → CU y distinción RF/RNF ([`04-matriz-rf-cu.md`](./04-matriz-rf-cu.md)).

## 5. Artefactos entregados

**Producto 1**

- [x] Insumo de análisis (`SRS-SAB-001` sintetizado): [00-insumo-analisis-srs-sab.md](./00-insumo-analisis-srs-sab.md)
- [x] Caracterización de la solución: [01-caracterizacion-y-metodologia.md](./01-caracterizacion-y-metodologia.md)
- [x] Comparación de metodologías y selección justificada: [01-caracterizacion-y-metodologia.md](./01-caracterizacion-y-metodologia.md)
- [x] Plan de actividades, cronograma y entregables: [02-plan-actividades-analisis.md](./02-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable): [03-diagrama-casos-de-uso.drawio](./03-diagrama-casos-de-uso.drawio)
- [x] Diagrama de casos de uso (imágenes + justificación): [03-diagrama-casos-de-uso.png](./03-diagrama-casos-de-uso.png) · [03-diagrama-casos-de-uso.svg](./03-diagrama-casos-de-uso.svg) · [03-justificacion-casos-de-uso.md](./03-justificacion-casos-de-uso.md)
- [x] Matriz requisito → caso de uso: [04-matriz-rf-cu.md](./04-matriz-rf-cu.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `@pascuasjhorman-rgb` · 2026-11-26

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente de IA) | Apoyo en estructuración de tablas Markdown, verificación de mínimos de `Rubricas_G1.md` y generación de XML `.drawio`/`.svg` del diagrama de casos de uso. | Verifiqué la cobertura de los 54 RF de `SRS-SAB-001`, la dirección de flechas `«include»`/`«extend»`, que todos los casos tuvieran actor iniciador y la ausencia de datos personales. |

## 8. Autocontrol antes del push

- [ ] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega *(Día 1: 2026-11-26; Día 2 pendiente: 2026-11-27)*.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [ ] Hice `push` y comprobé en GitHub que la carpeta está publicada.
