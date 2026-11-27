# README de entrega · Guía 1 · Producto 2: Modelo de análisis y verificación

Ruta de entrega en el fork:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sab-asistencia/`

Fecha límite: **sábado 28 de noviembre de 2026 a las 6:00 a. m.**  
Criterios y mínimos aplicados: `Rubricas_G1.md` (Competencia 220501093 · RAP 592373 y 592374 · Criterios C1, C2, C3, C4, C5, C6, C7, C8).

---

> Este repositorio es público. No contiene nombres completos, números de documento, teléfonos ni correos, ni datos reales de terceros. Autor identificado exclusivamente con el usuario de GitHub.

---

## 1. Datos de la entrega

- **Producto:** P2 modelo de análisis y verificación
- **Usuario de GitHub del autor:** `pascuasjhorman-rgb`
- **Caso de estudio:** Sistema de Asistencia Biométrica (SAB / BioSENA) · Ficha 3413974
- **Trabajo en equipo del año:** Sí. Equipo SAB ("Asistencia Biométrica SENA") en la ficha 3413974 para el diagnóstico de campo preliminar y la especificación de requisitos en equipo (`SRS-SAB-001` v2.3 con Juan Sebastián Medina y Jhon Stiven Alba). Los diagramas de actividades UML, plantillas extendidas de CU, modelo de dominio, MER, prototipo de pantallas, lista de chequeo, registro de ajustes, matriz de trazabilidad e informe de análisis de esta entrega son de **autoría individual**.

---

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Prototipos de pantallas en HTML/CSS y diseño visual de interfaz | `03-execute/17-week/02-optional-activity/sena_asistencia_.zip` y `mockupASistencia (1).pdf` | En equipo (Equipo SAB) |
| Historias de usuario HU-01 a HU-10 y flujos de usuario por rol (Aprendiz, Instructor, Coordinador) | `03-execute/21-week/02-optional-activity/historias_usuario_mejoras_mockup.md` | Solo |
| Flujos textuales de checkpoints (Mód. A), captura QR (Mód. B) y gestión manual (Mód. C) | `03-execute/23-week/02-optional-activity/Sistema_Asistencia_1.1 (1).txt` | En equipo (Equipo SAB) |
| Prototipo interactivo en línea oficial BioSENA | [https://biosena-asistencia-biom-trica.ai.studio/](https://biosena-asistencia-biom-trica.ai.studio/) | En equipo (Equipo SAB) |

---

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | `01-diagramas-actividades.*` | **Modelado formal de flujos de negocio con UML (Criterio C1 / RAP 592373):** Se adaptaron los flujos textuales informales a 2 diagramas de actividades UML completos para los casos de uso críticos CU-08 (marcación ordinaria) y CU-11/CU-12 (contingencia de sesión). Se estructuraron calles (*swimlanes*) por actor (`Instructor`, `Aprendiz`, `Servicio de verificación`, `Base de datos`), nodos de bifurcación (`fork`) y unión (`join`) para concurrencia en la validación QR/identidad, y guardas explícitas `[cumple]`/`[no cumple]` en todas las salidas de decisión, sincronizadas al 100 % con las plantillas extendidas. | Día 1: [`64b189a`](https://github.com/pascuasjhorman-rgb/ADSO-3413974/commit/64b189a03fc6e36d8126e0b7f8e87498c4d2beec) |
| 2 | `02-plantillas-extendidas-cu.md` | **Estructuración formal según Anexo A sin tecnología (Criterio C2 / RAP 592373 y arbitraje Sec. 7):** Se transformaron los requisitos narrativos dispersos en 4 plantillas extendidas completas (CU-08, CU-05, CU-11, CU-13), cada una con precondiciones previas al caso, flujo principal de 8 a 10 pasos en secuencia actor-sistema, mínimo 1 flujo alterno de éxito y 1 excepción de falla con su consecuencia, reglas de negocio asociadas y vínculo al prototipo, erradicando cualquier mención de tablas, SQL o endpoints. | Día 1: [`64b189a`](https://github.com/pascuasjhorman-rgb/ADSO-3413974/commit/64b189a03fc6e36d8126e0b7f8e87498c4d2beec) |
| 3 | `03-modelo-dominio.*` y `04-modelo-entidad-relacion.*` | **Separación metodológica entre Dominio y MER (Criterios C3 y C4 / RAP 592373 y arbitraje Sec. 7):** Se distinguió con precisión la abstracción del negocio de la estructura física relacional. El Modelo de Dominio contiene 12 clases conceptuales con atributos puros de negocio, multiplicidades, generalización `Persona` (`Aprendiz` / `Instructor`) y clase asociativa `VinculacionFicha`, sin métodos ni claves foráneas. El MER en notación pata de gallo define 11 entidades de almacenamiento, entidad asociativa `VINCULACION_FICHA` con atributos propios (`estado`, `fecha_matricula`) y entidades débiles por existencia (`TOKEN_QR` y `PLANTILLA_BIOMETRICA`). | Día 1: [`64b189a`](https://github.com/pascuasjhorman-rgb/ADSO-3413974/commit/64b189a03fc6e36d8126e0b7f8e87498c4d2beec) |
| 4 | `05-prototipo-pantallas.md`, `06-lista-chequeo-validacion.md` a `09-informe-analisis.md` | **Ajustes de cierre y verificación formal (Criterios C5, C6, C7, C8 / RAP 592373 y 592374):** Integración formal del prototipo web interactivo BioSENA (`https://biosena-asistencia-biom-trica.ai.studio/`), aplicación de la lista de chequeo de 16 criterios con citas de evidencia, registro de 5 hallazgos analizados y corregidos en segunda verificación, matriz de trazabilidad y formalización del informe de análisis. | Día 2: *(commit actual 27/11/2026)* |

---

## 4. Qué construí nuevo

- Diagramas de actividades UML en Draw.io editable, PNG y SVG de alta resolución ([`01-actividad-asistencia-ordinaria.*`](./01-actividad-asistencia-ordinaria.png) y [`01-actividad-contingencia-sesion.*`](./01-actividad-contingencia-sesion.png)).
- 4 plantillas extendidas de casos de uso bajo el estándar del Anexo A ([`02-plantillas-extendidas-cu.md`](./02-plantillas-extendidas-cu.md)).
- Modelo de dominio conceptual con 12 clases, jerarquía y clase asociativa ([`03-modelo-dominio.*`](./03-modelo-dominio.md)).
- Modelo entidad-relación en notación pata de gallo con entidades débiles y asociativas ([`04-modelo-entidad-relacion.*`](./04-modelo-entidad-relacion.md)).
- Prototipo inicial de pantallas rotuladas con casos de uso en `mockups/` y enlace al prototipo web interactivo BioSENA ([`05-prototipo-pantallas.md`](./05-prototipo-pantallas.md)).
- Lista de chequeo de validación con 16 criterios binarios verificables con evidencia ([`06-lista-chequeo-validacion.md`](./06-lista-chequeo-validacion.md)).
- Registro de ajustes con 5 hallazgos analizados (H-01 a H-05) y segunda verificación de cierre ([`07-registro-ajustes-analisis.md`](./07-registro-ajustes-analisis.md)).
- Matriz de trazabilidad integral requisito → artefactos (Anexo C) cubriendo los requisitos de SAB ([`08-matriz-trazabilidad-analisis.md`](./08-matriz-trazabilidad-analisis.md)).
- Informe formal de análisis de 2 páginas con requisitos interpretados y enlaces a los modelos ([`09-informe-analisis.md`](./09-informe-analisis.md)).

---

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (2 o más): [01-diagramas-actividades.md](./01-diagramas-actividades.md) · [PNG Ordinaria](./01-actividad-asistencia-ordinaria.png) · [PNG Contingencia](./01-actividad-contingencia-sesion.png)
- [x] Plantillas extendidas de casos de uso (3 o más): [02-plantillas-extendidas-cu.md](./02-plantillas-extendidas-cu.md)
- [x] Modelo de dominio: [03-modelo-dominio.md](./03-modelo-dominio.md) · [03-modelo-dominio.png](./03-modelo-dominio.png) · [03-modelo-dominio.drawio](./03-modelo-dominio.drawio)
- [x] Modelo entidad-relación: [04-modelo-entidad-relacion.md](./04-modelo-entidad-relacion.md) · [04-modelo-entidad-relacion.png](./04-modelo-entidad-relacion.png) · [04-modelo-entidad-relacion.drawio](./04-modelo-entidad-relacion.drawio)
- [x] Prototipo inicial (3 o más pantallas rotuladas + prototipo interactivo): [05-prototipo-pantallas.md](./05-prototipo-pantallas.md) · [Mockups](./mockups/) · [BioSENA WebApp](https://biosena-asistencia-biom-trica.ai.studio/)
- [x] Lista de chequeo diligenciada (15 o más criterios): [06-lista-chequeo-validacion.md](./06-lista-chequeo-validacion.md)
- [x] Registro de ajustes y segunda verificación (5 hallazgos): [07-registro-ajustes-analisis.md](./07-registro-ajustes-analisis.md)
- [x] Informe de análisis (Anexo E): [09-informe-analisis.md](./09-informe-analisis.md)
- [x] Matriz de trazabilidad (Anexo C): [08-matriz-trazabilidad-analisis.md](./08-matriz-trazabilidad-analisis.md)

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
| Antigravity (asistente de IA) | Estructuración de plantillas Markdown, generación de código XML base para Draw.io/SVG y validación de cobertura matricial. | Verifiqué la correspondencia entre las ramas de decisión de los diagramas de actividades y los flujos alternos/excepciones de las plantillas extendidas; aseguré la pureza conceptual del modelo de dominio sin métodos ni claves técnicas; validé que la matriz de trazabilidad cubriera los requisitos de SAB hasta el MER; y verifiqué la completa ausencia de datos reales de terceros en las pantallas del prototipo. |

---

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega (Día 1: commit `64b189a` [2026-11-26]; Día 2: [2026-11-27]).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada (`https://github.com/pascuasjhorman-rgb/ADSO-3413974`).
