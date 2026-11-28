# B4. Diccionario de Datos Completo (SAB / BioSENA)

**Proyecto:** Sistema de Asistencia Biométrica (SAB / BioSENA) · **Referencia:** `SRS-SAB-001` (v2.3)  
**Autor:** `@pascuasjhorman-rgb` · Ficha 3413974  
**Motor de base de datos:** MariaDB 10.4+ / MySQL 8.0 (Motor InnoDB)  
**Estándar de nombrado declarado:** `snake_case` en minúsculas. Claves primarias con prefijo `id_`, claves foráneas con `id_<tabla_origen>`, fechas con sufijos `_en` o `_fecha`.

---

## 1. Tabla: `sede`
Descripción: Almacena las sedes físicas institucionales donde se imparten las sesiones de formación.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_sede` | INT | - | `PK, AUTO_INCREMENT` | Identificador único secuencial de la sede |
| `nombre_sede` | VARCHAR | 100 | `NOT NULL, UNIQUE` | Nombre de la sede (ej. 'Centro Industria y Servicios - Neiva') |
| `ciudad` | VARCHAR | 80 | `NOT NULL` | Ciudad de ubicación ('Neiva', etc.) |
| `estado` | ENUM | - | `NOT NULL, CHECK (estado IN ('ACTIVA','INACTIVA'))` | Estado operativo de la sede. Por defecto 'ACTIVA' |

---

## 2. Tabla: `usuario`
Descripción: Entidad única para cuentas de usuarios del sistema (Aprendices, Instructores, Coordinadores y Superadministradores).

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_usuario` | INT | - | `PK, AUTO_INCREMENT` | Identificador único de usuario |
| `documento` | VARCHAR | 20 | `NOT NULL, UNIQUE` | Número de documento de identidad del usuario |
| `correo` | VARCHAR | 120 | `NOT NULL, UNIQUE` | Correo electrónico institucional o personal |
| `nombre_completo` | VARCHAR | 150 | `NOT NULL` | Nombres y apellidos completos |
| `clave_hash` | VARCHAR | 255 | `NOT NULL` | Hash de contraseña generado con Argon2id o bcrypt + sal |
| `rol` | ENUM | - | `NOT NULL, CHECK (rol IN ('APRENDIZ','INSTRUCTOR','COORDINADOR','SUPERADMIN'))` | Rol en el sistema |
| `codigo_matricula` | VARCHAR | 30 | `NULL` | Código estudiantil/matrícula (aplica para aprendices) |
| `especialidad` | VARCHAR | 100 | `NULL` | Área técnica o formación (aplica para instructores) |
| `estado` | ENUM | - | `NOT NULL, CHECK (estado IN ('ACTIVO','INACTIVO','BLOQUEADO'))` | Estado de la cuenta. Por defecto 'ACTIVO' |
| `ultimo_acceso` | DATETIME | - | `NULL` | Fecha y hora del último inicio de sesión exitoso |

---

## 3. Tabla: `ficha`
Descripción: Grupos o cursos de formación académica matriculados en una sede y dirigidos por un instructor líder.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_ficha` | INT | - | `PK, AUTO_INCREMENT` | Identificador interno de la ficha |
| `id_sede` | INT | - | `NOT NULL, FK -> sede(id_sede)` | Sede física a la que pertenece la ficha |
| `id_lider` | INT | - | `NOT NULL, FK -> usuario(id_usuario)` | Instructor asignado como líder de ficha |
| `codigo_ficha` | VARCHAR | 20 | `NOT NULL, UNIQUE` | Código numérico oficial de la ficha (ej. '3413974') |
| `programa` | VARCHAR | 120 | `NOT NULL` | Nombre del programa ('ADSO', 'Sistemas', etc.) |
| `jornada` | ENUM | - | `NOT NULL, CHECK (jornada IN ('DIURNA','NOCTURNA','MIXTA'))` | Jornada de formación |
| `estado` | ENUM | - | `NOT NULL, CHECK (estado IN ('ACTIVA','FINALIZADA','CANCELADA'))` | Estado lectivo de la ficha |

---

## 4. Tabla: `vinculacion_ficha`
Descripción: Tabla asociativa que resuelve la relación N:M entre aprendices y fichas con trazabilidad histórica.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_vinculacion` | INT | - | `PK, AUTO_INCREMENT` | Identificador de la vinculación |
| `id_ficha` | INT | - | `NOT NULL, FK -> ficha(id_ficha) ON DELETE RESTRICT` | Ficha asignada |
| `id_usuario` | INT | - | `NOT NULL, FK -> usuario(id_usuario) ON DELETE CASCADE` | Aprendiz matriculado |
| `rol_en_ficha` | VARCHAR | 30 | `NOT NULL, DEFAULT 'APRENDIZ'` | Rol específico desempeñado en el grupo |
| `fecha_vinculacion` | DATE | - | `NOT NULL` | Fecha oficial de inicio de formación |
| `fecha_retiro` | DATE | - | `NULL` | Fecha de desvinculación o graduación si aplica |
| `estado` | ENUM | - | `NOT NULL, CHECK (estado IN ('MATRICULADO','TRASLADADO','DESVINCULADO','GRADUADO'))` | Estado del aprendiz en la ficha |

---

## 5. Tabla: `plantilla_biometrica`
Descripción: Registro protegido de credenciales de autenticación segura / WebAuthn por usuario con consentimiento Ley 1581.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_plantilla` | INT | - | `PK, AUTO_INCREMENT` | Identificador de la credencial de identidad |
| `id_usuario` | INT | - | `NOT NULL, UNIQUE, FK -> usuario(id_usuario) ON DELETE CASCADE` | Usuario propietario de la credencial |
| `referencia_protegida` | TEXT | - | `NOT NULL` | Hash/clave pública o descriptor protegido (sin datos crudos) |
| `acepta_tratamiento` | TINYINT(1) | - | `NOT NULL, CHECK (acepta_tratamiento = 1)` | Booleano: 1 si aceptó la política de datos personales |
| `fecha_aceptacion` | DATETIME | - | `NOT NULL` | Marca de tiempo del consentimiento informado |
| `estado_vigencia` | ENUM | - | `NOT NULL, CHECK (estado_vigencia IN ('VIGENTE','REVOCADA','EXPIRADA'))` | Estado operativo de la credencial |
| `fecha_baja` | DATETIME | - | `NULL` | Fecha de eliminación legal por egreso |

---

## 6. Tabla: `sesion_formacion`
Descripción: Período de clase abierto por un instructor para la toma y control de asistencias de una ficha.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_sesion` | INT | - | `PK, AUTO_INCREMENT` | Identificador único de sesión |
| `id_ficha` | INT | - | `NOT NULL, FK -> ficha(id_ficha) ON DELETE RESTRICT` | Ficha para la que se abre la sesión |
| `id_instructor` | INT | - | `NOT NULL, FK -> usuario(id_usuario) ON DELETE RESTRICT` | Instructor a cargo de la clase |
| `fecha_apertura` | DATETIME | - | `NOT NULL` | Momento exacto de apertura de la sesión |
| `fecha_cierre` | DATETIME | - | `NULL` | Momento de cierre y consolidación |
| `estado_sesion` | ENUM | - | `NOT NULL, CHECK (estado_sesion IN ('ABIERTA','CERRADA','CANCELADA'))` | Estado actual de la sesión |
| `motivo_contingencia` | VARCHAR | 255 | `NULL` | Justificación si hubo apertura forzada o manual |
| `soporte_contingencia` | VARCHAR | 255 | `NULL` | Ruta de archivo de soporte ante cancelación |

---

## 7. Tabla: `token_qr`
Descripción: Tokens criptográficos temporales y códigos numéricos generados durante la sesión activa.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_token` | INT | - | `PK, AUTO_INCREMENT` | Identificador único del token |
| `id_sesion` | INT | - | `NOT NULL, FK -> sesion_formacion(id_sesion) ON DELETE CASCADE` | Sesión activa a la que pertenece |
| `codigo_firma` | VARCHAR | 128 | `NOT NULL, UNIQUE` | Firma criptográfica o código numérico temporal |
| `emitido_en` | DATETIME | - | `NOT NULL` | Hora del servidor de emisión |
| `expira_en` | DATETIME | - | `NOT NULL` | Hora límite de validez (15 s para QR, 60 s para código) |
| `estado_token` | ENUM | - | `NOT NULL, CHECK (estado_token IN ('ACTIVO','EXPIRADO','INVALIDADO'))` | Estado de vigencia del código |

---

## 8. Tabla: `asistencia`
Descripción: Registro transaccional atómico e inmutable de la presencia o retardo del aprendiz en una sesión.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_asistencia` | INT | - | `PK, AUTO_INCREMENT` | Identificador único de la marcación |
| `id_sesion` | INT | - | `NOT NULL, FK -> sesion_formacion(id_sesion) ON DELETE RESTRICT` | Sesión de formación |
| `id_aprendiz` | INT | - | `NOT NULL, FK -> usuario(id_usuario) ON DELETE RESTRICT` | Aprendiz que asistió |
| `estado_asistencia` | ENUM | - | `NOT NULL, CHECK (estado_asistencia IN ('PRESENTE','RETARDO','EXCUSADO','AUSENTE'))` | Clasificación de puntualidad de la marca |
| `origen_registro` | ENUM | - | `NOT NULL, CHECK (origen_registro IN ('QR_IDENTIDAD','MANUAL_INSTRUCTOR','EXCUSA_APROBADA'))` | Mecanismo utilizado para registrar la marca |
| `marca_tiempo` | DATETIME | - | `NOT NULL` | Momento exacto de la confirmación |
| `motivo_manual` | VARCHAR | 255 | `NULL` | Causa justificada si el origen fue manual |
| `registrada_por` | INT | - | `NOT NULL, FK -> usuario(id_usuario)` | Usuario que validó o autorizó el registro |

*Restricción de unicidad de negocio obligatoria:* `UNIQUE KEY uk_sesion_aprendiz (id_sesion, id_aprendiz)` para impedir marcas duplicadas.

---

## 9. Tabla: `incidencia`
Descripción: Registro de alertas automáticas originadas por intentos fallidos de marcación o anomalías de red.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_incidencia` | INT | - | `PK, AUTO_INCREMENT` | Identificador único de incidencia |
| `id_sesion` | INT | - | `NOT NULL, FK -> sesion_formacion(id_sesion) ON DELETE CASCADE` | Sesión vinculada al incidente |
| `id_aprendiz` | INT | - | `NOT NULL, FK -> usuario(id_usuario) ON DELETE CASCADE` | Aprendiz involucrado |
| `tipo_incidencia` | VARCHAR | 60 | `NOT NULL` | 'FALLO_IDENTIDAD_REITERADO', 'QR_CADUCADO', 'RED' |
| `intentos_fallidos` | INT | - | `NOT NULL, CHECK (intentos_fallidos >= 1)` | Número de fallos contabilizados |
| `estado_resolucion` | ENUM | - | `NOT NULL, CHECK (estado_resolucion IN ('PENDIENTE','RESUELTA','RECHAZADA'))` | Estado del trámite |
| `decision_resolucion` | TEXT | - | `NULL` | Motivo de la decisión tomada por el instructor |
| `resuelta_por` | INT | - | `NULL, FK -> usuario(id_usuario)` | Instructor que atendió la alerta |
| `fecha_resolucion` | DATETIME | - | `NULL` | Marca de tiempo de la resolución |

---

## 10. Tabla: `excusa`
Descripción: Justificaciones y soportes documentales radicados por aprendices para inasistencias.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_excusa` | INT | - | `PK, AUTO_INCREMENT` | Identificador único de la excusa |
| `id_aprendiz` | INT | - | `NOT NULL, FK -> usuario(id_usuario) ON DELETE RESTRICT` | Aprendiz que radica |
| `id_sesion` | INT | - | `NOT NULL, FK -> sesion_formacion(id_sesion) ON DELETE RESTRICT` | Sesión asociada a la ausencia |
| `tipo_excusa` | ENUM | - | `NOT NULL, CHECK (tipo_excusa IN ('MEDICA','LABORAL','FUERZA_MAYOR','CALAMIDAD'))` | Naturaleza de la justificación |
| `observacion` | TEXT | - | `NOT NULL` | Explicación detallada del aprendiz |
| `ruta_soporte` | VARCHAR | 255 | `NULL` | Ubicación privada del archivo PDF/JPG (máx 10 MB) |
| `estado_recepcion` | ENUM | - | `NOT NULL, CHECK (estado_recepcion IN ('RADICADA','RECIBIDA','APROBADA','RECHAZADA'))` | Estado del trámite administrativo |
| `confirmada_por` | INT | - | `NULL, FK -> usuario(id_usuario)` | Instructor o directivo que revisó |
| `fecha_confirmacion` | DATETIME | - | `NULL` | Momento de la respuesta administrativa |

---

## 11. Tabla: `bitacora_auditoria`
Descripción: Registro inmutable para cumplimiento normativo de operaciones sensibles (Ley 1581 de 2012).

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `id_auditoria` | BIGINT | - | `PK, AUTO_INCREMENT` | Identificador secuencial de auditoría |
| `id_actor` | INT | - | `NULL, FK -> usuario(id_usuario) ON DELETE SET NULL` | Usuario que ejecutó la acción |
| `entidad_recurso` | VARCHAR | 60 | `NOT NULL` | Recurso modificado ('ASISTENCIA', 'SESION', 'USUARIO') |
| `id_registro_afectado`| INT | - | `NOT NULL` | ID del registro modificado |
| `operacion` | ENUM | - | `NOT NULL, CHECK (operacion IN ('INSERT','UPDATE','DELETE','LOGIN','LOGOUT'))` | Tipo de operación ejecutada |
| `valor_anterior` | TEXT | - | `NULL` | Snapshot JSON del valor previo (en correcciones) |
| `valor_nuevo` | TEXT | - | `NULL` | Snapshot JSON del nuevo valor asentado |
| `resultado` | VARCHAR | 20 | `NOT NULL` | 'EXITO', 'DENEGADO', 'ERROR' |
| `fecha_evento` | DATETIME | - | `NOT NULL` | Marca de tiempo inmutable del servidor |

---

## 12. Tabla: `parametro_sistema`
Descripción: Parámetros operativos ajustables sin necesidad de recompilación de código.

| Columna | Tipo de dato | Longitud | Restricciones | Dominio / Descripción |
|---|---|---|---|---|
| `clave_parametro` | VARCHAR | 50 | `PK` | Nombre clave ('ROTACION_QR_SEG', 'INTENTOS_MAXIMOS') |
| `valor_parametro` | VARCHAR | 100 | `NOT NULL` | Valor actual ('15', '3', '60') |
| `descripcion` | VARCHAR | 255 | `NOT NULL` | Explicación del impacto del parámetro |
| `actualizado_por` | INT | - | `NOT NULL, FK -> usuario(id_usuario)` | Superadmin que modificó el parámetro |
| `actualizado_en` | DATETIME | - | `NOT NULL` | Fecha de actualización del valor |
