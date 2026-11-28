# README de entrega · Guía 2: Diseño de la solución · Producto 2: Modelo de datos y verificación

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P2 (modelo de datos relacional y verificación) |
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
| ¿Qué parte del SRS es tuya? | Levantamiento de requerimientos y módulos de sesiones/asistencia. El modelo conceptual ajustado, lógico relacional, normalización 3FN, diccionario de datos, script DDL MariaDB, políticas de seguridad y lista de chequeo son de **autoría individual**. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, elaboración 100 % individual. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. *(No se reutilizó `sdaa.mwb` de semana 22 ni `ejemplo/` de semana 20; todo el diseño es original para SAB).* |

---

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| B1–B2. Modelo conceptual y lógico | [`01-modelo-conceptual-y-logico.md`](./01-modelo-conceptual-y-logico.md) | [`G1-P2/04-modelo-entidad-relacion.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sab-asistencia/04-modelo-entidad-relacion.md) | Transformación formal a 12 tablas normalizadas con PK/FK, tabla intermedia `vinculacion_ficha`, `parametro_sistema` y cuadro de reglas. |
| B3. Normalización | [`02-normalizacion.md`](./02-normalizacion.md) | Nuevo | Normalización paso a paso `0FN → 1FN → 2FN → 3FN` de 2 tablas propias con dependencias funcionales escritas (clave compuesta y transitiva). |
| B4. Diccionario de datos | [`03-diccionario-datos.md`](./03-diccionario-datos.md) | Nuevo | Diccionario técnico del 100 % de las 12 tablas y sus columnas con tipo, tamaño, restricciones y reglas de dominio. |
| B5. Script SQL y evidencia de ejecución | [`04-script-creacion-mariadb.sql`](./04-script-creacion-mariadb.sql) · [`04-evidencia-ejecucion.log`](./04-evidencia-ejecucion.log) | Nuevo | Script DDL MariaDB creando las 12 tablas con PK, FK con ON DELETE en $\ge$ 3, NOT NULL, UNIQUE y $\ge$ 3 CHECK, probado con log de ejecución. |
| B6. Políticas de seguridad y roles | [`05-politicas-seguridad.md`](./05-politicas-seguridad.md) | Nuevo | 6 políticas bajo principios CIA, matriz RBAC de 3 roles contra 12 tablas, tratamiento Ley 1581 y contraseñas Argon2id/bcrypt. |
| B7. Lista de chequeo P1 y P2 | [`06-lista-chequeo-diseno.md`](./06-lista-chequeo-diseno.md) | Nuevo | Lista de chequeo de 20 criterios medibles con severidad aplicada sobre P1 y P2, con citas de evidencia y 4 hallazgos corregidos. |

- **Qué reutilicé:** El modelo conceptual de 11 entidades de SAB y las reglas de negocio del SRS (`RN-001` a `RN-029`).  
- **Qué ajusté:** Convertí el modelo conceptual a modelo lógico relacional con discriminador de roles en `usuario`, clave única `(id_sesion, id_aprendiz)` y tabla de parámetros configurables.  
- **Qué hice completamente nuevo:** La normalización `0FN → 3FN` con dependencias funcionales, el diccionario de datos exhaustivo, el script SQL para MariaDB con acciones referenciales, la matriz RBAC de seguridad y la lista de chequeo de 20 criterios.

---

## 4. Autoverificación de mínimos (Rúbricas G2 · Sección 3.1)

- [x] **B1 Modelo conceptual:** $\ge$ 6 entidades con atributos, identificador y cardinalidades mín/máx ([01-modelo-conceptual-y-logico.md](./01-modelo-conceptual-y-logico.md))
- [x] **B2 Modelo lógico:** $\ge$ 8 tablas (12 tablas) con PK y FK, cuadro de reglas de transformación y diagrama relacional ([01-modelo-conceptual-y-logico.md](./01-modelo-conceptual-y-logico.md))
- [x] **B3 Evidencia de normalización:** $\ge$ 2 tablas llevadas de 0FN a 3FN con dependencias funcionales escritas (clave compuesta en `vinculacion_ficha` y dependencia transitiva en `sesion_formacion`) ([02-normalizacion.md](./02-normalizacion.md))
- [x] **B4 Diccionario de datos:** 100 % de las 12 tablas y columnas con nombre, tipo, tamaño, restricciones y dominio ([03-diccionario-datos.md](./03-diccionario-datos.md))
- [x] **B5 Script SQL de creación:** Crea el 100 % de las tablas con PK, FK con `ON DELETE` en $\ge$ 3, `NOT NULL`, `UNIQUE`, $\ge$ 3 `CHECK` y log de ejecución sin errores ([04-script-creacion-mariadb.sql](./04-script-creacion-mariadb.sql) · [04-evidencia-ejecucion.log](./04-evidencia-ejecucion.log))
- [x] **B6 Políticas de seguridad:** $\ge$ 6 políticas (2 por cada principio CIA), matriz RBAC de 3 roles, tratamiento Ley 1581, hash Argon2id/bcrypt con sal y respaldo diario ([05-politicas-seguridad.md](./05-politicas-seguridad.md))
- [x] **B7 Lista de chequeo diligenciada:** $\ge$ 20 criterios medibles con severidad aplicados a P1 y P2, con evidencia por criterio y registro de 4 hallazgos corregidos ([06-lista-chequeo-diseno.md](./06-lista-chequeo-diseno.md))

---

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) | Enlace al commit |
|---|---|---|
| 2026-11-26 (Día 1) | `feat(g2-p2): modelo conceptual/logico B1-B2 y normalizacion paso a paso 0FN-3FN B3` | [`71c2e17`](https://github.com/pascuasjhorman-rgb/ADSO-3413974/commit/71c2e17) |
| 2026-11-27 (Día 2) | `feat(g2-p2): diccionario de datos B4, script DDL MariaDB B5, seguridad B6 y lista de chequeo B7` | *(commit de cierre Día 2)* |

---

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente de IA) | Apoyo en estructuración de tablas Markdown, reglas de transformación DDL MariaDB y cálculo de dependencias funcionales. | Verifiqué personalmente la validez sintáctica del DDL en MariaDB, la consistencia entre los nombres del diccionario y del script SQL, la presencia de acciones referenciales `ON DELETE`, y la exclusión de cualquier dato de prueba ajeno. |

---

## 7. Enlaces

- Informe de análisis / SRS del caso: [`00-insumo-analisis-srs-sab.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md)
- Prototipo web interactivo BioSENA: [https://biosena-asistencia-biom-trica.ai.studio/](https://biosena-asistencia-biom-trica.ai.studio/)
- Carpeta de esta entrega en GitHub: [G2-P2-sab-asistencia](https://github.com/pascuasjhorman-rgb/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-sab-asistencia)

---

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría individual, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada decisión técnica en la verificación oral del sábado 28 de noviembre de 2026.

**Usuario de GitHub:** `pascuasjhorman-rgb` · **Fecha:** `2026-11-27`
