# README de entrega · Guía 2: Modelo de datos y verificación (avance Día 1)

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P2 (modelo de datos y verificación) |
| Usuario de GitHub del autor | `@pascuasjhorman-rgb` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | Sistema de Asistencia Biométrica (SAB) · `SRS-SAB-001` |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md) |
| Cuenta de GitHub con la que haces los commits | `pascuasjhorman-rgb` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, `SRS-SAB-001` fue elaborado en equipo de 3 aprendices (`Equipo SAB`). |
| ¿Qué parte del SRS es tuya? | Levantamiento y módulos de sesiones/asistencia (`RF-BIO-018`–`039`). El modelo conceptual ajustado, lógico, normalización, diccionario, script SQL, políticas y lista de chequeo son individuales. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, elaboración 100 % individual. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. *(No se reutilizó `sdaa.mwb` de semana 22 ni `ejemplo/` de semana 20.)* |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| B1–B2. Modelo conceptual y lógico | [`01-modelo-conceptual-y-logico.md`](./01-modelo-conceptual-y-logico.md) | [`G1-P2/04-modelo-entidad-relacion.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sab-asistencia/04-modelo-entidad-relacion.md) | Transformación formal a 12 tablas normalizadas con PK/FK, tabla intermedia `vinculacion_ficha`, `parametro_sistema` y cuadro de reglas. |
| B3. Normalización | [`02-normalizacion.md`](./02-normalizacion.md) | Nuevo | Normalización paso a paso `0FN → 1FN → 2FN → 3FN` de 2 tablas propias con dependencias funcionales. |
| B4. Diccionario de datos | *(Día 2)* | Nuevo | *(pendiente Día 2)* |
| B5. Script SQL y ejecución real | *(Día 2)* | Nuevo | *(pendiente Día 2)* |
| B6. Políticas de seguridad | *(Día 2)* | Nuevo | *(pendiente Día 2)* |
| B7. Lista de chequeo P1 y P2 | *(Día 2)* | Nuevo | *(pendiente Día 2)* |

**Qué reutilicé:** El modelo conceptual de 11 entidades de SAB y las reglas de negocio del SRS (`RN-01`–`RN-12`).  
**Qué ajusté:** Convertí el modelo conceptual a modelo lógico relacional con discriminador de roles en `usuario`, unicidad `(id_sesion, id_aprendiz)` y tabla de parámetros configurables.  
**Qué hice completamente nuevo:** La normalización `0FN → 3FN` con dependencias funcionales *(y en Día 2: diccionario completo, script ejecutado en MariaDB, políticas de seguridad y lista de chequeo de 20 criterios)*.

## 4. Autoverificación de mínimos *(avance Día 1)*

- [x] B1 Modelo conceptual: ≥ 6 entidades, cardinalidades, ≥ 1 N:M y ≥ 1 1:N
- [x] B2 Modelo lógico: ≥ 8 tablas (12 tablas) con PK/FK y cuadro de reglas de transformación
- [x] B3 Normalización: ≥ 2 tablas de 0FN a 3FN con dependencias funcionales (llave compuesta + transitiva)
- [ ] B4 Diccionario de datos *(Día 2)*
- [ ] B5 Script SQL ejecutado sin errores *(Día 2)*
- [ ] B6 Políticas de seguridad y matriz de roles *(Día 2)*
- [ ] B7 Lista de chequeo de ≥ 20 criterios sobre P1 y P2 *(Día 2)*

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| 2026-11-26 (Día 1) | `feat(g2-p2): modelo conceptual/lógico relacional B1-B2 y normalización 0FN-3FN B3` |
| 2026-11-27 (Día 2) | *(pendiente: diccionario B4, SQL ejecutado B5, seguridad B6 y lista de chequeo B7)* |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente de IA) | Apoyo en redacción de reglas de transformación, diagramas Mermaid y pasos de normalización. | Verifiqué todas las dependencias funcionales, llaves primarias/foráneas y la exclusión de datos de ejemplo de semana 20/22. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [`00-insumo-analisis-srs-sab.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md)
- Carpeta de esta entrega en GitHub: `https://github.com/pascuasjhorman-rgb/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-sab-asistencia`

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@pascuasjhorman-rgb`  Fecha: `2026-11-26`
