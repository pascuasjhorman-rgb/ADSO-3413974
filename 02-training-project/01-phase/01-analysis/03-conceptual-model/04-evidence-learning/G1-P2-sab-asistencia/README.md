# Entrega · Guía 1 · Producto 2: Modelo de análisis y verificación (avance Día 1)

## 1. Datos de la entrega

- **Producto:** P2 modelo de análisis y verificación
- **Usuario de GitHub del autor:** `@pascuasjhorman-rgb`
- **Caso de estudio:** Sistema de Asistencia Biométrica (SAB) · `SRS-SAB-001` (sintetizado en [G1-P1](../G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md))
- **Trabajo en equipo del año:** Sí (`Equipo SAB`, 3 integrantes para el SRS base; los diagramas de actividades, plantillas extendidas, modelo de dominio, MER, prototipo, verificación y ajustes son de autoría individual).

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Flujos textuales y modelo conceptual preliminar (`SRS-SAB-001` sec. 6.3 y 7) | [`../G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md`](../G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md) | En equipo (3 integrantes) |
| Referencia de flujos en BPMN | `03-execute/22-week/02-optional-activity/diagram_1.bpmn`–`diagram_5.bpmn` | Solo |
| Referencia visual previa de interfaz de asistencia | `03-execute/23-week/02-optional-activity/asistencia_sena_mockup.png` | Solo |

## 3. Qué ajusté *(se completa tras el push del Día 2)*

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | `01-diagramas-actividades.md` | Conversión de flujos textuales y experiencia BPMN a diagramas de actividades UML con calles por actor, guardas en todas las ramas y nodos `fork`/`join`. | *(pendiente Día 2)* |
| 2 | `02-plantillas-extendidas-cu.md` | Ampliación de fichas breves de `CU-05`, `CU-08`, `CU-11` y `CU-13` al formato completo del Anexo A (≥ 6 pasos, alternos y excepciones sin detalles técnicos). | *(pendiente Día 2)* |
| 3 | `03-modelo-dominio.*` y `04-modelo-entidad-relacion.*` | Separación estricta entre modelo de dominio conceptual (generalización + clase de asociación) y MER pata de gallo (entidad asociativa + entidades débiles). | *(pendiente Día 2)* |

## 4. Qué construí nuevo

- Diagramas de actividades UML (`01-actividad-asistencia-ordinaria.*` y `01-actividad-contingencia-sesion.*`).
- Plantillas extendidas de casos de uso (`02-plantillas-extendidas-cu.md`).
- Modelo de dominio conceptual (`03-modelo-dominio.*`) y MER pata de gallo (`04-modelo-entidad-relacion.*`).
- *(Día 2 — pendiente:)* Prototipo de 3 pantallas SAB sin datos reales, lista de chequeo diligenciada, registro de ajustes, informe de análisis y matriz de trazabilidad.

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (2): [01-diagramas-actividades.md](./01-diagramas-actividades.md) · [PNG 1](./01-actividad-asistencia-ordinaria.png) · [PNG 2](./01-actividad-contingencia-sesion.png)
- [x] Plantillas extendidas de casos de uso (4): [02-plantillas-extendidas-cu.md](./02-plantillas-extendidas-cu.md)
- [x] Modelo de dominio: [03-modelo-dominio.md](./03-modelo-dominio.md) · [PNG](./03-modelo-dominio.png) · [drawio](./03-modelo-dominio.drawio)
- [x] Modelo entidad-relación: [04-modelo-entidad-relacion.md](./04-modelo-entidad-relacion.md) · [PNG](./04-modelo-entidad-relacion.png) · [drawio](./04-modelo-entidad-relacion.drawio)
- [ ] Prototipo inicial (3 o más pantallas) *(Día 2)*
- [ ] Lista de chequeo diligenciada (15 o más criterios) *(Día 2)*
- [ ] Registro de ajustes y segunda verificación *(Día 2)*
- [ ] Informe de análisis *(Día 2)*
- [ ] Matriz de trazabilidad (Anexo C) *(Día 2)*

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo la verificación oral del sábado 28 de noviembre de 2026.

Firma (usuario de GitHub y fecha): `@pascuasjhorman-rgb` · 2026-11-26

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente de IA) | Apoyo en estructuración de diagramas `.svg`/`.drawio` y plantillas Anexo A. | Verifiqué la coherencia entre ramas de los diagramas de actividades y las plantillas extendidas, ausencia de detalles SQL en análisis y enrutamiento visual de relaciones. |
