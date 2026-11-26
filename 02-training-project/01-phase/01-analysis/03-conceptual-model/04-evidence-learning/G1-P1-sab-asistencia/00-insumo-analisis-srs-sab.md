# Insumo de análisis · Sistema de Asistencia Biométrica (SAB)

**Código de referencia:** `SRS-SAB-001` (v1.1)  
**Autor de esta síntesis y entregas individuales:** `@pascuasjhorman-rgb`  
**Trabajo previo reutilizado del fork:**
- `03-execute/16-week/02-optional-activity/registro de asistencia.md` (levantamiento inicial por observación y primeros RF01–RF06 + casos de uso iniciales)
- `03-execute/17-week/02-optional-activity/Hoja_de_Ruta_Sistema_Toma_de_Asistencias.md` (planificación por fases)
- `03-execute/23-week/02-optional-activity/Sistema_Asistencia_1.1 (1).txt` (diagnóstico de necesidades, justificación cuantitativa y objetivos)
- `03-execute/23-week/02-optional-activity/asistencia_sena_mockup.png` (referencia previa de interfaz; rediseñada sin datos reales de terceros para SAB)

> **Nota de equipo y privacidad:** El documento completo `SRS-SAB-001` fue elaborado en equipo de 3 aprendices para el proyecto formativo SAB. En cumplimiento de las reglas del repositorio público, no se publican nombres completos, documentos ni datos personales de terceros.

---

## 1. Descripción general del caso SAB

**Propósito:** Sustituir el llamado a lista manual en papel o en plataformas lentas durante las sesiones de formación del SENA (y adaptable a instituciones educativas) mediante una aplicación web cliente-servidor con doble verificación operativa (**huella biométrica + código QR dinámico de sesión**), gestión de contingencias manuales, excusas con soporte, auditoría y exportación de reportes en PDF y XLSX.

**Actores del sistema:**
- **Aprendiz (Primario):** Inicia sesión, verifica huella biométrica, escanea código QR vigente para registrar su asistencia, consulta su historial y envía excusas con soporte.
- **Instructor líder de ficha (Primario):** Registra aprendices en sus fichas a cargo, abre/cierra sesiones, proyecta el QR dinámico, gestiona incidencias/contingencias, confirma recepción de excusas y exporta reportes de sesión.
- **Coordinador (Primario):** Consulta reportes consolidados e indicadores por sede, ficha, instructor y rango de fechas, supervisando novedades conforme a permisos.
- **Administrador (Primario):** Administra sedes, fichas, cuentas de instructores y coordinadores, asignación/reasignación de líderes con bitácora, parámetros operativos y eliminación biométrica al egreso.
- **Servicio biométrico (Secundario):** Componente/proveedor externo o local compatible que realiza captura, enrolamiento y cotejo de plantillas biométricas bajo contrato definido.

---

## 2. Reglas de negocio clave (`RN-01` a `RN-12`)

| Código | Regla |
|---|---|
| `RN-01` | Solo el instructor líder asignado registra aprendices en sus fichas. |
| `RN-02` | El administrador puede asignar o reasignar el liderazgo dejando constancia en bitácora. |
| `RN-03` | Una asistencia ordinaria requiere verificación biométrica válida y QR de la misma sesión. |
| `RN-04` | El QR rota cada 15 segundos; la ventana de escaneo asignada al aprendiz es de 10 segundos (parámetros configurables). |
| `RN-05` | Se permiten hasta 3 intentos de validación fallidos por proceso; al superar el límite se crea incidencia para el instructor. |
| `RN-06` | Un aprendiz no puede generar dos asistencias válidas para la misma sesión. |
| `RN-07` | El instructor puede registrar asistencia manual de emergencia indicando motivo y dejando auditoría. |
| `RN-08` | Ante cancelación de clase por contingencia se exige registrar motivo y adjuntar soporte. |
| `RN-09` | El aprendiz puede presentar excusa; el instructor confirma recepción sin implicar aprobación automática. |
| `RN-10` | Al cerrar una sesión quedan disponibles exportaciones PDF y XLSX de su reporte. |
| `RN-11` | La biometría se elimina al finalizar el programa conforme a política documentada; datos básicos pueden conservarse según reglas institucionales. |
| `RN-12` | Toda operación administrativa sensible deja usuario, fecha, recurso y resultado en auditoría. |

---

## 3. Catálogo de Requisitos Funcionales (`RF-BIO-001` a `RF-BIO-054`)

| ID | Módulo | Descripción resumida | Prioridad |
|---|---|---|---|
| `RF-BIO-001` | Autenticación y acceso | Iniciar sesión con credenciales válidas y registrar último acceso. | Alta |
| `RF-BIO-002` | Autenticación y acceso | Finalizar sesión e invalidar token/identificador. | Alta |
| `RF-BIO-003` | Autenticación y acceso | Aplicar permisos por rol y alcance de ficha/sede (RBAC). | Alta |
| `RF-BIO-004` | Autenticación y acceso | Restablecimiento seguro de credenciales sin revelar existencia de cuentas. | Media |
| `RF-BIO-005` | Autenticación y acceso | Bloquear o limitar intentos fallidos de inicio de sesión de forma configurable. | Alta |
| `RF-BIO-006` | Administración institucional | Crear, consultar y actualizar sedes institucionales. | Alta |
| `RF-BIO-007` | Administración institucional | Crear y gestionar fichas vinculadas a una sede existente. | Alta |
| `RF-BIO-008` | Administración institucional | Crear o desactivar cuentas de instructor y coordinador. | Alta |
| `RF-BIO-009` | Administración institucional | Asignar o reasignar líderes de ficha con histórico de cambios en auditoría. | Alta |
| `RF-BIO-010` | Administración institucional | Configurar parámetros de intentos máximos y caducidad de QR. | Media |
| `RF-BIO-011` | Administración institucional | Consultar estado general de usuarios, grupos y sesiones mediante filtros. | Media |
| `RF-BIO-012` | Gestión de aprendices | Permitir solo al instructor líder crear cuentas de aprendiz en una ficha a cargo. | Alta |
| `RF-BIO-013` | Gestión de aprendices | Validar unicidad de documento e identificador de cuenta. | Alta |
| `RF-BIO-014` | Gestión de aprendices | Actualizar datos básicos del aprendiz con permisos sin alterar historiales previos. | Alta |
| `RF-BIO-015` | Gestión de aprendices | Consultar listado de aprendices y estado de vinculación por ficha asignada. | Alta |
| `RF-BIO-016` | Gestión de aprendices | Desactivar o desvincular aprendices preservando trazabilidad e historial. | Media |
| `RF-BIO-017` | Gestión de aprendices | Habilitar proceso controlado de enrolamiento de huella (previa autorización). | Alta |
| `RF-BIO-018` | Sesiones de formación | Abrir sesión de asistencia para una ficha autorizada. | Alta |
| `RF-BIO-019` | Sesiones de formación | Evitar sesiones superpuestas según política institucional de la ficha. | Alta |
| `RF-BIO-020` | Sesiones de formación | Generar QR único vinculado a una sesión activa. | Alta |
| `RF-BIO-021` | Sesiones de formación | Renovar QR automáticamente cada 15 segundos (parámetro configurable). | Alta |
| `RF-BIO-022` | Sesiones de formación | Cerrar sesión con consolidación de resultados bloqueando nuevos registros ordinarios. | Alta |
| `RF-BIO-023` | Sesiones de formación | Consultar sesiones propias por ficha, fecha y estado. | Alta |
| `RF-BIO-024` | Verificación biométrica y QR | Solicitar cotejo de huella al proveedor biométrico compatible. | Alta |
| `RF-BIO-025` | Verificación biométrica y QR | Habilitar etapa QR únicamente tras verificación biométrica exitosa. | Alta |
| `RF-BIO-026` | Verificación biométrica y QR | Validar identidad de sesión, vencimiento y firma/aleatoriedad del QR. | Alta |
| `RF-BIO-027` | Verificación biométrica y QR | Conceder ventana de 10 segundos para lectura QR tras habilitación biométrica. | Alta |
| `RF-BIO-028` | Verificación biométrica y QR | Limitar a 3 intentos el proceso ordinario; al límite bloquear flujo y generar incidencia. | Alta |
| `RF-BIO-029` | Verificación biométrica y QR | Registrar una única asistencia válida por aprendiz y sesión (evitar duplicados). | Alta |
| `RF-BIO-030` | Verificación biométrica y QR | Mostrar resultado de validación y razón genérica de rechazo sin exponer biometría. | Alta |
| `RF-BIO-031` | Incidencias y novedades | Crear incidencia ante fallas reiteradas o actividad sospechosa vinculada a sesión y aprendiz. | Alta |
| `RF-BIO-032` | Incidencias y novedades | Notificar al instructor sobre nuevas incidencias de su sesión en tablero/buzón. | Alta |
| `RF-BIO-033` | Incidencias y novedades | Permitir clasificación y resolución auditada de incidencias. | Alta |
| `RF-BIO-034` | Incidencias y novedades | Registrar novedades operativas de sesión, lector o conectividad. | Media |
| `RF-BIO-035` | Incidencias y novedades | Impedir que una incidencia rechazada se convierta automáticamente en asistencia válida. | Alta |
| `RF-BIO-036` | Contingencia y control manual | Habilitar registro manual digital cuando el método regular no esté disponible (causa y responsable). | Alta |
| `RF-BIO-037` | Contingencia y control manual | Distinguir en reportes los registros manuales de las verificaciones ordinarias. | Alta |
| `RF-BIO-038` | Contingencia y control manual | Permitir cancelar clase registrando motivo y soporte adjunto. | Alta |
| `RF-BIO-039` | Contingencia y control manual | Restringir modificaciones de asistencia a roles autorizados guardando valor anterior y nuevo en auditoría. | Alta |
| `RF-BIO-040` | Excusas y soportes | Permitir al aprendiz enviar excusa asociada a fecha/sesión con texto y soporte. | Alta |
| `RF-BIO-041` | Excusas y soportes | Validar formato, tamaño y acceso autorizado de archivos adjuntos. | Alta |
| `RF-BIO-042` | Excusas y soportes | Permitir al instructor confirmar recepción de excusa actualizando fecha y responsable. | Alta |
| `RF-BIO-043` | Excusas y soportes | Consultar estado e historial de excusas propias (sin acceso a terceros). | Media |
| `RF-BIO-044` | Reportes y supervisión | Generar lista de asistencias, ausencias e incidencias por sesión con estado y origen. | Alta |
| `RF-BIO-045` | Reportes y supervisión | Exportar reporte de cierre de sesión en formato PDF. | Alta |
| `RF-BIO-046` | Reportes y supervisión | Exportar reporte de cierre de sesión en formato XLSX. | Alta |
| `RF-BIO-047` | Reportes y supervisión | Filtrar estadísticas por sede, ficha, instructor y rango de fechas. | Media |
| `RF-BIO-048` | Reportes y supervisión | Permitir al coordinador consultar registros globales según alcance autorizado. | Alta |
| `RF-BIO-049` | Reportes y supervisión | Permitir al instructor consultar historial únicamente de sus fichas/sesiones. | Alta |
| `RF-BIO-050` | Auditoría y privacidad | Registrar altas, reasignaciones, correcciones y cierres de sesión en bitácora. | Alta |
| `RF-BIO-051` | Auditoría y privacidad | Registrar aceptación del aviso de tratamiento de datos antes del enrolamiento biométrico. | Alta |
| `RF-BIO-052` | Auditoría y privacidad | Eliminar plantilla biométrica al finalizar programa según política aprobada. | Alta |
| `RF-BIO-053` | Auditoría y privacidad | Evitar exposición de imágenes o plantillas de huella en reportes o logs. | Alta |
| `RF-BIO-054` | Auditoría y privacidad | Permitir consulta filtrable de actividad relevante en bitácora por personal autorizado (solo lectura ordinaria). | Media |

---

## 4. Requisitos No Funcionales clave (`RNF-BIO-001` a `RNF-BIO-024`)

- **Seguridad:** `RNF-BIO-001` (control de acceso en servidor), `RNF-BIO-002` (HTTPS/TLS en tránsito), `RNF-BIO-003` (contraseñas con derivación robusta y sal individual, no SHA-256 simple), `RNF-BIO-004` (minimización, cifrado y supresión de datos biométricos), `RNF-BIO-005` (bitácora inalterable), `RNF-BIO-006` (validación y restricción de adjuntos).
- **Rendimiento y disponibilidad:** `RNF-BIO-007` (95 % de consultas simples ≤ 3 s), `RNF-BIO-008` (100 usuarios concurrentes en piloto), `RNF-BIO-009` (disponibilidad 99 % mensual), `RNF-BIO-010` (respaldos y restauración probada), `RNF-BIO-011` (reloj sincronizado en servidor para vigencia de QR).
- **Usabilidad y accesibilidad:** `RNF-BIO-012` (responsivo en escritorio y móvil), `RNF-BIO-013` (mensajes claros de error), `RNF-BIO-014` (accesibilidad y contraste), `RNF-BIO-015` (minimizar pasos manuales en marcación).
- **Mantenibilidad y escalabilidad:** `RNF-BIO-016` (modularidad: identidad, sesión, biometría, QR, reportes, auditoría), `RNF-BIO-017` (observabilidad con correlación sin datos sensibles), `RNF-BIO-018` (pruebas automatizadas de regresión), `RNF-BIO-019` (parámetros externos configurables).
- **Privacidad y compatibilidad:** `RNF-BIO-020` (minimización de datos), `RNF-BIO-021` (retención y supresión), `RNF-BIO-022` (certificación de lector/SDK), `RNF-BIO-023` (consentimiento explícito Ley 1581 de 2012), `RNF-BIO-024` (contratos API versionados).
