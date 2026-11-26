# B3 · Evidencia de Normalización Paso a Paso (0FN → 3FN) · SAB

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001`  
**Autor:** `@pascuasjhorman-rgb`

Se presenta la normalización paso a paso (`0FN → 1FN → 2FN → 3FN`) de **2 tablas propias** del dominio SAB, escribiendo sus **dependencias funcionales (DF)** y verificando:
1. Una tabla con **llave compuesta** y **dependencia parcial (2FN)**.
2. Una tabla con **dependencia transitiva (3FN)**.

---

## Tabla 1 · Planilla consolidada de asistencia por sesión (con llave compuesta → 2FN y 3FN)

### Estado inicial `0FN` (no normalizada)
`planilla_asistencia_0fn(id_sesion, id_aprendiz, codigo_ficha, nombre_sede, ciudad_sede, fecha_apertura, documento_aprendiz, nombre_aprendiz, telefonos_aprendiz, estado_asistencia, origen_registro, marca_tiempo)`

- **Llave primaria compuesta:** `(id_sesion, id_aprendiz)`.
- **Problemas detectados:** `telefonos_aprendiz` puede contener múltiples valores en una misma celda (ej. `"3001112233, 3154445566"`); además hay atributos que dependen solo de `id_sesion` o solo de `id_aprendiz`, y atributos transitivos de sede.

### Paso `1FN` (eliminar grupos repetitivos y volver atómicos los campos)
- **Violación:** `telefonos_aprendiz` no es atómico.
- **Solución:** Se extrae `telefonos_aprendiz` de la planilla (o se maneja como dato mínimo fuera de la tabla de asistencia conforme a `RNF-BIO-020` minimización de datos, o en `contacto_usuario(id_contacto, id_usuario, telefono)` si la institución requiere teléfono).
- **Estado `1FN`:**
  `planilla_asistencia_1fn(id_sesion, id_aprendiz, codigo_ficha, nombre_sede, ciudad_sede, fecha_apertura, documento_aprendiz, nombre_aprendiz, estado_asistencia, origen_registro, marca_tiempo)`

### Paso `2FN` (eliminar dependencias parciales sobre la llave compuesta `(id_sesion, id_aprendiz)`)
- **Dependencias funcionales escritas:**
  - `id_sesion → codigo_ficha, nombre_sede, ciudad_sede, fecha_apertura` *(dependencia parcial: solo depende de `id_sesion`)*
  - `id_aprendiz → documento_aprendiz, nombre_aprendiz` *(dependencia parcial: solo depende de `id_aprendiz`)*
  - `(id_sesion, id_aprendiz) → estado_asistencia, origen_registro, marca_tiempo` *(dependencia funcional completa de toda la llave compuesta)*
- **Resultado en `2FN`:** Se separan 3 relaciones:
  1. `sesion_2fn(id_sesion PK, id_ficha, codigo_ficha, nombre_sede, ciudad_sede, fecha_apertura)`
  2. `usuario_aprendiz(id_usuario PK, documento, nombre_completo)`
  3. `asistencia(id_asistencia PK, id_sesion FK, id_aprendiz FK, estado_asistencia, origen_registro, marca_tiempo)` con `UNIQUE(id_sesion, id_aprendiz)`

### Paso `3FN` (eliminar dependencias transitivas en `sesion_2fn`)
- **Dependencias funcionales transitivas detectadas:**
  - `id_sesion → id_ficha`
  - `id_ficha → codigo_ficha, id_sede`
  - `id_sede → nombre_sede, ciudad_sede` *(transitiva respecto a `id_sesion` y `id_ficha`)*
- **Resultado final en `3FN`:**
  - `sede(id_sede PK, nombre_sede, ciudad)`
  - `ficha(id_ficha PK, id_sede FK, codigo_ficha, programa, jornada, estado)`
  - `sesion_formacion(id_sesion PK, id_ficha FK, id_instructor FK, fecha_apertura, fecha_cierre, estado_sesion)`
  - `usuario(id_usuario PK, documento, correo, nombre_completo, clave_hash, rol, estado)`
  - `asistencia(id_asistencia PK, id_sesion FK, id_aprendiz FK, estado_asistencia, origen_registro, marca_tiempo)`

---

## Tabla 2 · Gestión de excusas y responsables de ficha (dependencia transitiva → 3FN)

### Estado inicial `0FN`
`excusa_gestion_0fn(id_excusa, id_aprendiz, id_sesion, id_ficha, codigo_ficha, programa_ficha, id_instructor_lider, nombre_instructor_lider, correo_instructor, tipos_y_soportes, estado_recepcion, fecha_confirmacion)`

- **Llave primaria:** `id_excusa`.
- **Problema inicial:** `tipos_y_soportes` combina tipo de excusa y múltiples rutas en una sola cadena; y múltiples columnas de la ficha y del instructor dependen transitivamente de `id_sesion → id_ficha → id_instructor_lider`.

### Paso `1FN` (atomicidad de atributos)
- **Violación:** `tipos_y_soportes` contiene varios valores compuestos.
- **Solución:** Se separa en columnas atómicas `tipo_excusa` y `ruta_soporte` (un único archivo validado por excusa según `RF-BIO-041`).
- **Estado `1FN`:**
  `excusa_1fn(id_excusa PK, id_aprendiz, id_sesion, id_ficha, codigo_ficha, programa_ficha, id_instructor_lider, nombre_instructor_lider, correo_instructor, tipo_excusa, ruta_soporte, estado_recepcion, fecha_confirmacion)`

### Paso `2FN`
- Como la llave primaria es simple (`id_excusa`), no existen dependencias parciales sobre llave compuesta; la relación ya cumple `2FN`, pero mantiene fuertes dependencias transitivas.

### Paso `3FN` (eliminar dependencias transitivas)
- **Dependencias funcionales escritas:**
  - `id_excusa → id_aprendiz, id_sesion, tipo_excusa, ruta_soporte, estado_recepcion, fecha_confirmacion`
  - `id_sesion → id_ficha` *(transitiva desde `id_excusa`)*
  - `id_ficha → codigo_ficha, programa_ficha, id_instructor_lider` *(transitiva desde `id_sesion`)*
  - `id_instructor_lider → nombre_instructor_lider, correo_instructor` *(transitiva desde `id_ficha`)*
- **Resultado final en `3FN`:**
  - `excusa(id_excusa PK, id_aprendiz FK, id_sesion FK, tipo_excusa, observacion, ruta_soporte, estado_recepcion, confirmada_por FK, fecha_confirmacion)`
  - `sesion_formacion(id_sesion PK, id_ficha FK, id_instructor FK, fecha_apertura, fecha_cierre, estado_sesion)`
  - `ficha(id_ficha PK, id_sede FK, id_lider FK, codigo_ficha, programa, jornada, estado)`
  - `usuario(id_usuario PK, documento, correo, nombre_completo, clave_hash, rol, estado)`

---

## Verificación de cierre
Ninguna de las **12 tablas** del modelo lógico final conserva atributos no atómicos, dependencias parciales ni dependencias transitivas; todas están en **3FN** sin desnormalizaciones pendientes.
