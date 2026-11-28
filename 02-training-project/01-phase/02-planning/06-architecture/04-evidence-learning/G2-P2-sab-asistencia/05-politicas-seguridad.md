# B6. Políticas de Seguridad de la Información y Matriz de Roles RBAC (SAB / BioSENA)

**Proyecto:** Sistema de Asistencia Biométrica (SAB / BioSENA) · **Referencia:** `SRS-SAB-001` (v2.3)  
**Autor:** `@pascuasjhorman-rgb` · Ficha 3413974  
**Entregable:** Guía 2 · Producto 2 · Artefacto B6 (RAP 593101)  
**Marco normativo:** Ley Estatutaria 1581 de 2012 y Decreto 1377 de 2013 (Protección de Datos Personales en Colombia).

---

## 1. Políticas de Seguridad de Datos por Principio CIA (Confidencialidad, Integridad, Disponibilidad)

Se definen **6 políticas de seguridad obligatorias** (2 por cada principio del triángulo CIA), con medidas técnicas concretas sobre las tablas de MariaDB:

### A. Confidencialidad (Acceso restringido y protección contra divulgación no autorizada)
1. **POL-SEC-01: Protección Criptográfica de Credenciales y Secretos (`RNF-SAB-003`):**
   - Las contraseñas de todos los usuarios en la tabla `usuario.clave_hash` se procesan obligatoriamente con el algoritmo **Argon2id** (parámetros recomendados OWASP: memoria 64 MB, 3 iteraciones, 4 hilos) o **bcrypt** con factor de trabajo $\ge 12$, incorporando una sal criptográfica individual aleatoria por usuario.
   - Jamás se almacenan contraseñas en texto plano ni con funciones vulnerables (MD5, SHA-1 o SHA-256 sin sal).
2. **POL-SEC-02: Minimización y Protección de Datos Sensibles e Identidad (`RNF-SAB-005` y `RN-022`):**
   - En la tabla `plantilla_biometrica.referencia_protegida` únicamente se almacena una clave pública WebAuthn o un descriptor numérico cifrado en reposo con AES-256-GCM.
   - Las exportaciones a PDF/XLSX y las bitácoras de auditoría tienen terminantemente prohibido incluir representaciones biométricas, imágenes de huellas o vectores faciales crudos.

---

### B. Integridad (Exactitud, no repudio y prevención de alteraciones no autorizadas)
3. **POL-SEC-03: Atomicidad Transaccional y Bloqueo de Asistencias Duplicadas (`RN-006` y `RNF-SAB-025`):**
   - Cada inserción en la tabla `asistencia` se ejecuta dentro de una transacción serializable con restricción estricta de unicidad `UNIQUE (id_sesion, id_aprendiz)`.
   - Se garantiza que dos peticiones simultáneas del mismo aprendiz no puedan asentar doble presencia. Cualquier modificación manual posterior conserva el valor anterior y nuevo en `bitacora_auditoria` (`RN-020`).
4. **POL-SEC-04: Bitácora Inmutable de Auditoría para Operaciones Sensibles (`RN-012` y `RNF-SAB-006`):**
   - La tabla `bitacora_auditoria` registra de manera obligatoria el 100 % de los eventos críticos (cambio de instructor líder, apertura/cierre de sesión, asistencias manuales, resoluciones de excusas y eliminaciones de datos).
   - Los registros de la bitácora son de solo inserción (*append-only*); ningún rol del sistema, ni siquiera el Superadmin, dispone de permisos `UPDATE` o `DELETE` sobre esta tabla.

---

### C. Disponibilidad (Continuidad operativa y resiliencia ante contingencias)
5. **POL-SEC-05: Mecanismos de Contingencia Operativa Supervisada (`RN-007` y `RNF-SAB-034`):**
   - Ante cortes de fluido eléctrico, fallas de conectividad en el aula o problemas con la cámara del dispositivo móvil, el sistema habilita el registro de asistencia manual digital por parte del instructor y el uso del código numérico temporal de 60 segundos (`RN-004`), evitando la parálisis de la sesión de formación.
6. **POL-SEC-06: Respaldo Periódico y Procedimiento de Restauración (`RNF-SAB-010` y `RNF-SAB-029`):**
   - Se ejecuta una copia de seguridad diaria programada (*backup*) a las 23:00 horas mediante `mysqldump` transaccional consistente (`--single-transaction --quick`), cifrada con GPG hacia un volumen de almacenamiento secundario.
   - Se establece un objetivo de punto de recuperación (**RPO**) de 24 horas y un objetivo de tiempo de recuperación (**RTO**) de 4 horas, con simulacros trimestrales documentados de restauración de datos en ambiente de prueba.

---

## 2. Matriz de Control de Acceso Basado en Roles (RBAC) frente a Tablas

Nivel de privilegios sobre la base de datos MariaDB para los **3 roles principales del sistema**:
- **S** = `SELECT` (Consultar)
- **I** = `INSERT` (Crear / Marcar)
- **U** = `UPDATE` (Actualizar / Modificar)
- **D** = `DELETE` (Eliminar)
- **-** = Sin acceso (Denegación por defecto)

| # | Tabla de Base de Datos | Rol: `APRENDIZ` | Rol: `INSTRUCTOR` | Rol: `SUPERADMIN` | Restricción / Alcance de Fila |
|---|---|---|---|---|---|
| 1 | `sede` | S | S | S, I, U | Solo lectura para aprendices e instructores. |
| 2 | `usuario` | S (solo propio), U (clave propia) | S (aprendices de su ficha), U | S, I, U, D | Superadmin gestiona altas/bajas de personal. |
| 3 | `ficha` | S (solo su ficha) | S (fichas asignadas) | S, I, U | Fichas administradas por Superadmin. |
| 4 | `vinculacion_ficha` | S (solo su estado) | S, I (inscribir en su ficha) | S, I, U, D | Instructor líder gestiona sus aprendices. |
| 5 | `plantilla_biometrica` | S, I, U (solo su credencial) | - | S, D (supresión legal) | Instructores no ven datos de identidad ajenos. |
| 6 | `sesion_formacion` | S (sesión activa de su ficha) | S, I, U (sus sesiones asignadas) | S, U (cancelación autorizada) | Instructor abre y cierra clases a cargo. |
| 7 | `token_qr` | S (validar código vigente) | S, I (generar y rotar QR) | S | Token generado por backend para el instructor. |
| 8 | `asistencia` | S (solo su propio historial) | S, I (marcar manual), U (corregir) | S (reportes consolidados) | Aprendiz solo lee sus asistencias; marca vía API. |
| 9 | `incidencia` | S (solo si está involucrado) | S, U (resolver incidencias de clase) | S | Instructor resuelve alertas de su sesión. |
| 10 | `excusa` | S (propias), I (radicar soporte) | S, U (confirmar recepción) | S | Aprendiz radica; instructor confirma recepción. |
| 11 | `bitacora_auditoria` | - | - | S (solo lectura auditable) | **Nadie tiene permisos UPDATE o DELETE.** |
| 12 | `parametro_sistema` | - | - | S, U (ajustar tolerancias) | Exclusivo del Superadmin. |

---

## 3. Tratamiento de Datos Personales y Datos Biométricos (Ley 1581 de 2012)

1. **Principio de Libertad y Consentimiento Informado (`RF-SAB-051` y `RN-014`):**
   - El registro de cualquier credencial de autenticación WebAuthn o cotejo facial exige la visualización previa de la *Autorización de Tratamiento de Datos Sensibles*.
   - El usuario debe marcar explícitamente su aceptación (`plantilla_biometrica.acepta_tratamiento = 1`), quedando registrada la fecha y hora en auditoría.
2. **Principio de Finalidad y No Discriminación (`RN-015`):**
   - La información capturada tiene como finalidad exclusiva el control de asistencia académica dentro de la ficha de formación del SENA.
   - Aquellos aprendices que no otorguen su autorización disponen de la ruta supervisada ordinaria (código numérico o validación por el instructor) sin sufrir ningún tipo de perjuicio o restricción académica.
3. **Supresión Definitiva al Cierre del Ciclo Formativo (`RF-SAB-052` y `RN-011`):**
   - Al graduarse o culminar la etapa lectiva el grupo de aprendices, el Superadmin ejecuta el procedimiento de baja biométrica, purgando permanentemente las referencias de `plantilla_biometrica` y conservando únicamente los registros académicos de asistencia requeridos por archivo institucional.
