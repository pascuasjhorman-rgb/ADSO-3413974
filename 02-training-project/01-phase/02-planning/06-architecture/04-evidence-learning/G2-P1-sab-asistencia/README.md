# README de entrega · Guía 2: Diseño de la solución (avance Día 1)

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P1 (artefactos de diseño) |
| Usuario de GitHub del autor | `@pascuasjhorman-rgb` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | Sistema de Asistencia Biométrica (SAB) · `SRS-SAB-001` |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md) |
| Cuenta de GitHub con la que haces los commits | `pascuasjhorman-rgb` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el documento `SRS-SAB-001` fue elaborado en equipo de 3 aprendices (`Equipo SAB`). |
| ¿Qué parte del SRS es tuya? | Participación en levantamiento de necesidades y módulos de asistencia/sesiones (`RF-BIO-018` a `039`). Para esta entrega individual diseño los 16 RF críticos listados en `A1` cubriendo todo el flujo central de SAB. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, todos los artefactos de diseño (clases, patrones, arquitectura, componentes, despliegue y trazabilidad) son de elaboración individual. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No; únicamente compartimos el insumo base del año (`SRS-SAB-001`). |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| A1. Ficha interpretación y plataforma | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) | `03-execute/17-week/02-optional-activity/Hoja_de_Ruta_Sistema_Toma_de_Asistencias.md` y `G1-P1/00-insumo-analisis-srs-sab.md` | Selección de 16 RF + 8 RNF y justificación formal de Python/FastAPI y BD relacional. |
| A2–A3. Diagrama de clases y patrones | [`02-diagrama-clases-y-patrones.md`](./02-diagrama-clases-y-patrones.md) | `G1-P2/03-modelo-dominio.md` (evolucionado a diseño OO) | Se añadieron tipos, visibilidad, métodos, composición, herencia, 2 interfaces y 3 patrones GoF (2× Strategy + Facade). |
| A4. Arquitectura | *(Día 2)* | Nuevo | *(pendiente Día 2)* |
| A5. Vista de componentes | *(Día 2)* | Nuevo | *(pendiente Día 2)* |
| A6. Vista de despliegue | *(Día 2)* | Nuevo | *(pendiente Día 2)* |
| A7. Matriz de trazabilidad | *(Día 2)* | Nuevo | *(pendiente Día 2)* |

**Qué reutilicé:** El catálogo de requisitos, actores y modelo de dominio del proyecto SAB (`SRS-SAB-001` y semanas 16–23 de `03-execute/`).  
**Qué ajusté:** Transformé las clases conceptuales del análisis en clases de diseño OO con visibilidad, tipos, firmas de métodos, herencia y composición, aplicando patrones GoF reales para desacoplar biometría y reportes.  
**Qué hice completamente nuevo:** La ficha de plataforma tecnológica, el diseño de `ProveedorBiometrico`, `ExportadorReporte` y `FachadaAsistenciaSAB` *(y en Día 2 las vistas de arquitectura, componentes, despliegue y trazabilidad)*.

## 4. Autoverificación de mínimos *(avance Día 1)*

- [x] A1 Ficha de interpretación: ≥ 8 RF y ≥ 3 RNF con ID; plataforma justificada
- [x] A2 Diagrama de clases: ≥ 8 clases, tipos, métodos, multiplicidades, ≥ 1 composición y ≥ 1 herencia + 2 interfaces con 2 implementaciones c/u
- [x] A3 ≥ 2 patrones GoF distintos aplicados en el diagrama (3 patrones: 2× Strategy + Facade, todos distintos de singleton)
- [ ] A4 Arquitectura *(Día 2)*
- [ ] A5 Vista de componentes *(Día 2)*
- [ ] A6 Vista de despliegue *(Día 2)*
- [ ] A7 Matriz de trazabilidad análisis → diseño *(Día 2)*
- [x] Fuente editable e imagen exportada del diagrama de clases ([drawio](./02-diagrama-clases.drawio) · [PNG](./02-diagrama-clases.png) · [SVG](./02-diagrama-clases.svg))

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| 2026-11-26 (Día 1) | `feat(g2-p1): ficha de plataforma A1 y diagrama de clases con patrones Strategy y Facade (A2-A3)` |
| 2026-11-27 (Día 2) | *(pendiente: arquitectura A4, componentes A5, despliegue A6 y trazabilidad A7)* |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente de IA) | Apoyo en redacción estructurada de Markdown, sintaxis Mermaid y generación de diagramas `.drawio`/`.svg`. | Verifiqué correspondencia con los IDs reales de `SRS-SAB-001`, separación de responsabilidades entre clases y cumplimiento de los patrones GoF distintos de Singleton. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [`00-insumo-analisis-srs-sab.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md)
- Carpeta de esta entrega en GitHub: `https://github.com/pascuasjhorman-rgb/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-sab-asistencia`

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@pascuasjhorman-rgb`  Fecha: `2026-11-26`
