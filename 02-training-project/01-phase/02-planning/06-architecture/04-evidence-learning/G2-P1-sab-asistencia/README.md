# README de entrega · Guía 2: Diseño de la solución · Producto 1: Artefactos de diseño

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P1 (artefactos de diseño OO y arquitectura) |
| Usuario de GitHub del autor | `@pascuasjhorman-rgb` |
| Ficha | 3413974 · CIES Neiva |
| Caso elegido (nombre del proyecto) | Sistema de Asistencia Biométrica (SAB / BioSENA) · `SRS-SAB-001` (v2.3) |
| Enlace al informe de análisis o SRS del caso (ruta en el fork) | [`../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md) |
| Cuenta de GitHub con la que haces los commits | `pascuasjhorman-rgb` |

---

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el documento `SRS-SAB-001` (v2.3) fue elaborado en equipo de 3 aprendices (`Equipo SAB`: Juan Sebastián Medina, Jhon Stiven Alba y Jhorman Pascuas). |
| ¿Qué parte del SRS es tuya? | Participación en levantamiento de requerimientos y módulos de asistencia/sesiones. Para esta entrega individual diseño los requisitos críticos cubriendo el flujo central de asistencia, contingencia, clases y arquitectura. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, todos los artefactos de diseño (clases OO, patrones GoF, arquitectura 3 capas, componentes, despliegue y matriz de trazabilidad) son de **elaboración individual**. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No; únicamente compartimos el insumo base del año (`SRS-SAB-001`). Los modelos de diseño son propios. |

---

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| A1. Ficha interpretación y plataforma | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) | `03-execute/17-week/.../Hoja_de_Ruta...` y `G1-P1/00-insumo-analisis-srs-sab.md` | Selección de 18 RF + 8 RNF y justificación formal de Python/FastAPI y MariaDB. |
| A2–A3. Diagrama de clases y patrones | [`02-diagrama-clases-y-patrones.md`](./02-diagrama-clases-y-patrones.md) | `G1-P2/03-modelo-dominio.md` (evolucionado a diseño OO) | Se añadieron tipos, visibilidad, métodos, composición, herencia, 2 interfaces y 3 patrones GoF (2× Strategy + Facade). |
| A4. Arquitectura del software | [`03-arquitectura-decisiones.md`](./03-arquitectura-decisiones.md) | Nuevo | Arquitectura en 3 capas, tabla de 6 RNF con decisiones técnicas, estilo REST/HTTPS y justificación de descarte de microservicios. |
| A5. Vista de componentes | [`04-vista-componentes.md`](./04-vista-componentes.md) | Nuevo | 6 componentes desacoplados con interfaces provistas/requeridas, dependencias y mapeo de clases y requisitos. |
| A6. Vista de despliegue | [`05-vista-despliegue.md`](./05-vista-despliegue.md) | Nuevo | 3 nodos (Cliente Web, Servidor API FastAPI, Servidor MariaDB), protocolos (HTTPS 443, TCP 3306) y decisiones frente a RNF. |
| A7. Matriz de trazabilidad | [`06-matriz-trazabilidad-diseno.md`](./06-matriz-trazabilidad-diseno.md) | Nuevo | Mapeo integral del 100 % de los requisitos funcionales a componentes y clases, verificando que ninguna clase quede sin requisito. |

- **Qué reutilicé:** El catálogo de requisitos, reglas de negocio y actores del proyecto SAB (`SRS-SAB-001` v2.3 y semanas 16–24 de `03-execute/`).  
- **Qué ajusté:** Transformé las clases conceptuales del análisis en clases de diseño OO con visibilidad, tipos, firmas de métodos, herencia y composición, aplicando patrones GoF reales para desacoplar biometría, contingencia y reportes.  
- **Qué hice completamente nuevo:** La ficha de plataforma tecnológica, las vistas de arquitectura 3 capas, los 6 componentes con sus contratos de interfaz, el diagrama de despliegue en 3 nodos y la matriz de trazabilidad análisis $\to$ diseño.

---

## 4. Autoverificación de mínimos (Rúbricas G2 · Sección 2.1)

- [x] **A1 Ficha de interpretación:** $\ge$ 8 RF y $\ge$ 3 RNF con ID; plataforma tecnológica justificada con 3 condiciones concretas ([01-ficha-interpretacion-plataforma.md](./01-ficha-interpretacion-plataforma.md))
- [x] **A2 Diagrama de clases:** $\ge$ 8 clases con atributos tipados, métodos con parámetros, multiplicidades, $\ge$ 1 composición, $\ge$ 1 herencia y 2 interfaces con 2 implementaciones cada una ([02-diagrama-clases-y-patrones.md](./02-diagrama-clases-y-patrones.md))
- [x] **A3 Patrones de diseño:** $\ge$ 2 patrones GoF distintos (2× Strategy + Facade, todos distintos de singleton) aplicados en el diagrama con justificación técnica ([02-diagrama-clases-y-patrones.md](./02-diagrama-clases-y-patrones.md))
- [x] **A4 Arquitectura del software:** Estilo de 3 capas definido con diagrama, tabla de decisiones frente a RNF, estilo de comunicación y alternativa descartada justificada ([03-arquitectura-decisiones.md](./03-arquitectura-decisiones.md))
- [x] **A5 Vista de componentes:** 6 componentes con interfaces provistas y requeridas, dependencias y clases agrupadas ([04-vista-componentes.md](./04-vista-componentes.md))
- [x] **A6 Vista de despliegue:** 3 nodos con artefactos alojados, protocolos/puertos y decisiones de RNF ([05-vista-despliegue.md](./05-vista-despliegue.md))
- [x] **A7 Matriz de trazabilidad:** 100 % de RF cubiertos y ninguna clase sin requisito asignado ([06-matriz-trazabilidad-diseno.md](./06-matriz-trazabilidad-diseno.md))
- [x] **Fuentes editables e imágenes exportadas:** Draw.io editable, PNG y SVG de alta resolución ([drawio](./02-diagrama-clases.drawio) · [PNG](./02-diagrama-clases.png) · [SVG](./02-diagrama-clases.svg))

---

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) | Enlace al commit |
|---|---|---|
| 2026-11-26 (Día 1) | `feat(g2-p1): ficha de plataforma A1 y diagrama de clases con patrones Strategy y Facade` | [`27a1e43`](https://github.com/pascuasjhorman-rgb/ADSO-3413974/commit/27a1e43) |
| 2026-11-27 (Día 2) | `feat(g2-p1): arquitectura 3 capas A4, componentes A5, despliegue A6 y trazabilidad A7` | *(commit de cierre Día 2)* |

---

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente de IA) | Estructuración de plantillas Markdown, generación de código XML base para Draw.io/SVG y validación cruzada frente a la rúbrica G2. | Verifiqué personalmente la correspondencia con los IDs reales de `SRS-SAB-001`, la separación de responsabilidades entre capas sin saltos, el cumplimiento estricto de los patrones GoF (Strategy y Facade) y que ninguna clase quedara sin requisito funcional asignado. |

---

## 7. Enlaces

- Informe de análisis / SRS del caso: [`00-insumo-analisis-srs-sab.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md)
- Prototipo web interactivo BioSENA: [https://biosena-asistencia-biom-trica.ai.studio/](https://biosena-asistencia-biom-trica.ai.studio/)
- Carpeta de esta entrega en GitHub: [G2-P1-sab-asistencia](https://github.com/pascuasjhorman-rgb/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-sab-asistencia)

---

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría individual, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral del sábado 28 de noviembre de 2026.

**Usuario de GitHub:** `pascuasjhorman-rgb` · **Fecha:** `2026-11-27`
