# Matriz de Trazabilidad Integral del Análisis (Anexo C)

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Ficha:** 3413974  
**Autor:** `@pascuasjhorman-rgb`

> Esta matriz garantiza la trazabilidad bidireccional desde los **Requisitos Funcionales (`RF-BIO`)** del `SRS-SAB-001` hacia los casos de uso, especificaciones dinámicas (diagramas de actividades y plantillas), modelo conceptual de dominio, modelo entidad-relación y pantallas del prototipo.
> 
> **Cobertura alcanzada:** 100 % de los requisitos funcionales del sistema (54/54) trazados hacia casos de uso y modelos de análisis.

| Requisito Funcional | Caso de Uso | Diagrama de Actividades | Plantilla Extendida | Clase de Dominio | Entidad del MER | Pantalla del Prototipo |
|---|---|---|---|---|---|---|
| `RF-BIO-001` (Login con credenciales) | `CU-01 Iniciar sesión` | Flujo de autenticación base | Incluido en alcance CU-01 | `Usuario` | `USUARIO` | Pantalla de inicio de sesión |
| `RF-BIO-002` (Cierre e invalidación token) | `CU-01 Iniciar sesión` | Cierre de sesión seguro | Incluido en alcance CU-01 | `Usuario` | `USUARIO` | Menú de usuario / Salir |
| `RF-BIO-003` (Control de acceso RBAC) | `CU-01 Iniciar sesión` | Validación de permisos | Transversal a todos los CU | `Usuario` | `USUARIO` | Vistas filtradas por rol |
| `RF-BIO-004` (Restablecimiento credenciales)| `CU-01 Iniciar sesión` | Recuperación segura | Flujo alterno CU-01 | `Usuario` | `USUARIO` | Formulario recuperación |
| `RF-BIO-005` (Bloqueo por intentos fallidos)| `CU-01 Iniciar sesión` | Control de intentos de login | Excepción CU-01 | `Usuario` | `USUARIO` | Mensaje de bloqueo temporal |
| `RF-BIO-006` (Gestión de sedes) | `CU-02 Administrar fichas` | Mantenimiento institucional | Flujo administrativo | `Sede` | `SEDE` | Panel administración sedes |
| `RF-BIO-007` (Fichas vinculadas a sede) | `CU-02 Administrar fichas` | Asignación de sede-ficha | Flujo administrativo | `Ficha`, `Sede` | `FICHA`, `SEDE` | Formulario de ficha |
| `RF-BIO-008` (Cuentas instructor/coordinador)| `CU-02 Administrar fichas` | Alta de personal académico | Flujo administrativo | `Instructor`, `Usuario` | `USUARIO` | Panel gestión usuarios |
| `RF-BIO-009` (Asignación líder de ficha) | `CU-16 Reasignar líder` | Reasignación con auditoría | Flujo extendido de CU-02 | `Ficha`, `Instructor` | `FICHA`, `USUARIO` | Formulario de liderazgo |
| `RF-BIO-010` (Parámetros QR e intentos) | `CU-02 Administrar fichas` | Configuración de umbrales | Flujo administrativo | `SesionFormacion` | `PARAMETRO_SISTEMA` | Configuración operativa |
| `RF-BIO-011` (Tablero general grupos) | `CU-02 / CU-15 Reportes` | Visualización consolidada | Tablero directivo | `Ficha`, `Usuario` | `FICHA`, `USUARIO` | Tablero de control general |
| `RF-BIO-012` (Crear cuenta aprendiz en ficha)| `CU-03 Registrar aprendiz` | Vinculación por líder | Flujo de registro | `Aprendiz`, `Ficha` | `VINCULACION_FICHA` | Formulario nuevo aprendiz |
| `RF-BIO-013` (Unicidad documento de cuenta) | `CU-03 Registrar aprendiz` | Validación de duplicados | Excepción registro | `Usuario` | `USUARIO` | Alerta validación |
| `RF-BIO-014` (Actualizar datos de aprendiz) | `CU-03 Registrar aprendiz` | Edición autorizada | Flujo de edición | `Aprendiz` | `USUARIO` | Perfil de aprendiz |
| `RF-BIO-015` (Consultar listado por ficha) | `CU-03 / CU-17 Historial` | Listado por ficha autorizada | Vista de aprendices | `Ficha`, `Aprendiz` | `VINCULACION_FICHA` | Lista de ficha asignada |
| `RF-BIO-016` (Desvincular con trazabilidad) | `CU-03 Registrar aprendiz` | Baja académica auditada | Flujo de desvinculación | `VinculacionFicha` | `VINCULACION_FICHA` | Gestión de matrícula |
| `RF-BIO-017` (Enrolamiento de huella) | `CU-04 Enrolar huella` | Enrolamiento biométrico | Flujo de enrolamiento | `PlantillaBiometrica` | `PLANTILLA_BIOMETRICA` | Captura biométrica |
| `RF-BIO-018` (Apertura de sesión) | `CU-05 Abrir sesión` | Flujo de sesión activa | `CU-05` (Plantilla completa) | `SesionFormacion` | `SESION_FORMACION` | `PANT-01` (mock-cu05-sesion-qr) |
| `RF-BIO-019` (Evitar sesiones superpuestas) | `CU-05 Abrir sesión` | Control de solapamiento | `CU-05` (Excepción 2a) | `SesionFormacion` | `SESION_FORMACION` | `PANT-01` (Alerta superposición) |
| `RF-BIO-020` (Generar QR único de sesión) | `CU-05 Abrir sesión` | Generación de token firmado | `CU-05` (Flujo paso 4) | `TokenQR` | `TOKEN_QR` | `PANT-01` (Visor QR) |
| `RF-BIO-021` (Rotar QR cada 15 segundos) | `CU-05 Abrir sesión` | Temporizador de rotación | `CU-05` (Flujo paso 6) | `TokenQR` | `TOKEN_QR` | `PANT-01` (Temporizador 15s) |
| `RF-BIO-022` (Cierre y consolidación sesión) | `CU-10 Cerrar sesión` | Cierre ordinario y reporte | Flujo de consolidación | `SesionFormacion` | `SESION_FORMACION` | `PANT-03` (mock-cu10-cu11) |
| `RF-BIO-023` (Consultar sesiones propias) | `CU-17 Consultar historial`| Historial de jornadas | Vista de sesiones | `SesionFormacion` | `SESION_FORMACION` | Historial de asistencias |
| `RF-BIO-024` (Cotejo de huella con SDK) | `CU-06 Verificar huella` | `01-actividad-asistencia` | `CU-08` (Flujo paso 3-4) | `PlantillaBiometrica` | `PLANTILLA_BIOMETRICA` | `PANT-02` (mock-cu08-marcacion) |
| `RF-BIO-025` (Etapa QR tras huella exitosa) | `CU-08 Asistencia ordinaria`| `01-actividad-asistencia` | `CU-08` (Paso 4 a 5) | `RegistroAsistencia` | `ASISTENCIA` | `PANT-02` (Habilitación cámara) |
| `RF-BIO-026` (Validar firma y vigencia QR) | `CU-07 Escanear QR` | `01-actividad-asistencia` | `CU-08` (Paso 6) | `TokenQR` | `TOKEN_QR` | `PANT-02` (Escáner cámara) |
| `RF-BIO-027` (Ventana 10 s para lectura QR) | `CU-07 Escanear QR` | `01-actividad-asistencia` | `CU-08` (Regla RN-04) | `TokenQR` | `TOKEN_QR` | `PANT-02` (Contador regresivo 10s)|
| `RF-BIO-028` (Límite 3 intentos e incidencia)| `CU-09 Escalar intento` | `01-actividad-asistencia` | `CU-08` (Excepción 3b) | `Incidencia` | `INCIDENCIA` | `PANT-02` (Alerta bloqueo) |
| `RF-BIO-029` (Única asistencia por sesión) | `CU-08 Asistencia ordinaria`| `01-actividad-asistencia` | `CU-08` (Paso 7 y Excep 2b)| `RegistroAsistencia` | `ASISTENCIA` | `PANT-02` (Confirmación) |
| `RF-BIO-030` (Mensajes claros sin fuga bio)| `CU-08 Asistencia ordinaria`| `01-actividad-asistencia` | `CU-08` (Flujos alternos) | `RegistroAsistencia` | `ASISTENCIA` | `PANT-02` (Toast / Notificación) |
| `RF-BIO-031` (Crear incidencia automática) | `CU-09 Escalar intento` | `01-actividad-asistencia` | `CU-08` (Excepción 3b) | `Incidencia` | `INCIDENCIA` | `PANT-03` (Buzón incidencias) |
| `RF-BIO-032` (Notificar incidencia a líder) | `CU-09 Escalar intento` | `01-actividad-asistencia` | Flujo de notificación | `Incidencia` | `INCIDENCIA` | `PANT-03` (Badge de alerta) |
| `RF-BIO-033` (Resolución auditada incidencias)| `CU-09 Escalar intento` | Tramitación de novedades | Flujo de resolución | `Incidencia` | `INCIDENCIA` | `PANT-03` (Modal resolución) |
| `RF-BIO-034` (Registrar novedades operativas)| `CU-11 Asistencia manual` | `01-actividad-contingencia`| `CU-11` (Paso 1) | `SesionFormacion` | `SESION_FORMACION` | `PANT-03` (Selector novedad) |
| `RF-BIO-035` (No validar incidencia rechazada)| `CU-09 Escalar intento` | Control de integridad | Regla de resolución | `Incidencia`, `Asistencia`| `INCIDENCIA`, `ASISTENCIA`| Modal resolución |
| `RF-BIO-036` (Registro manual de contingencia)| `CU-11 Asistencia manual` | `01-actividad-contingencia`| `CU-11` (Plantilla completa) | `RegistroAsistencia` | `ASISTENCIA` | `PANT-03` (Planilla manual) |
| `RF-BIO-037` (Distinguir origen en reportes) | `CU-11 Asistencia manual` | `01-actividad-contingencia`| `CU-11` (Paso 6) | `RegistroAsistencia` | `ASISTENCIA` | `PANT-03` (Tag "Manual / Ordinaria")|
| `RF-BIO-038` (Cancelar sesión por contingencia)| `CU-12 Cancelar sesión` | `01-actividad-contingencia`| Flujo extendido CU-05 | `SesionFormacion` | `SESION_FORMACION` | Modal cancelación y soporte |
| `RF-BIO-039` (Modificación restringida auditada)| `CU-11 Asistencia manual` | `01-actividad-contingencia`| `CU-11` (Paso 7) | `RegistroAsistencia` | `BITACORA_AUDITORIA` | Trazabilidad de auditoría |
| `RF-BIO-040` (Envío de excusa con soporte) | `CU-13 Enviar excusa` | Radicación de justificación | `CU-13` (Plantilla completa) | `Excusa` | `EXCUSA` | Formulario radicar excusa |
| `RF-BIO-041` (Validar tipo y tamaño de archivo)| `CU-13 Enviar excusa` | Validación de adjuntos | `CU-13` (Paso 3 y Excep 3a) | `Excusa` | `EXCUSA` | Validador de archivos |
| `RF-BIO-042` (Confirmar recepción de excusa) | `CU-14 Confirmar excusa` | Confirmación por instructor | Flujo confirmación | `Excusa` | `EXCUSA` | Bandeja de excusas |
| `RF-BIO-043` (Consultar excusas propias) | `CU-17 / CU-13 Excusas` | Historial propio aprendiz | `CU-13` (Flujo alterno 6a) | `Excusa` | `EXCUSA` | Historial de excusas |
| `RF-BIO-044` (Lista asistencias/ausencias) | `CU-10 Cerrar sesión` | Consolidación de sesión | Flujo de consolidación | `RegistroAsistencia` | `ASISTENCIA` | `PANT-03` (Resumen de sesión) |
| `RF-BIO-045` (Exportar reporte PDF) | `CU-10 Cerrar sesión` | `01-actividad-contingencia`| Exportación documental | `SesionFormacion` | `SESION_FORMACION` | `PANT-03` (Botón Descargar PDF) |
| `RF-BIO-046` (Exportar reporte XLSX) | `CU-10 Cerrar sesión` | `01-actividad-contingencia`| Exportación tabular | `SesionFormacion` | `SESION_FORMACION` | `PANT-03` (Botón Descargar XLSX) |
| `RF-BIO-047` (Estadísticas por sede/ficha) | `CU-15 Consultar reportes` | Filtro de métricas | Vista de estadísticas | `SesionFormacion` | `SESION_FORMACION` | Tablero de analítica |
| `RF-BIO-048` (Consulta global coordinador) | `CU-15 Consultar reportes` | Supervisión transversal | Vista de coordinación | `Sede`, `Ficha` | `SEDE`, `FICHA` | Reportes institucionales |
| `RF-BIO-049` (Consulta restringida instructor)| `CU-17 Consultar historial`| Historial de sus fichas | Vista de instructor | `Ficha`, `SesionFormacion`| `FICHA`, `SESION_FORMACION`| Mis Fichas / Historial |
| `RF-BIO-050` (Registro en bitácora de auditoría)| Transversal a eventos | Registro transaccional | Constancia en auditoría | `Usuario`, `SesionFormacion`| `BITACORA_AUDITORIA` | Log de auditoría |
| `RF-BIO-051` (Aceptación Ley 1581 previo a huella)| `CU-04 Enrolar huella` | Verificación de consentimiento| Precondición enrolamiento | `PlantillaBiometrica` | `PLANTILLA_BIOMETRICA` | Modal consentimiento Ley 1581 |
| `RF-BIO-052` (Supresión biométrica al egreso)| `CU-18 Eliminar biometría` | Baja definitiva y auditada | Flujo de egreso | `PlantillaBiometrica` | `PLANTILLA_BIOMETRICA` | Panel gestión privacidad |
| `RF-BIO-053` (No exponer plantillas en reportes)| Transversal a exportación| Sanitización de datos | Criterio de privacidad | `PlantillaBiometrica` | `PLANTILLA_BIOMETRICA` | Reportes seguros |
| `RF-BIO-054` (Consulta bitácora por autorizados)| `CU-15 / CU-02 Auditoría` | Consulta inalterable | Vista de auditoría | `Usuario` | `BITACORA_AUDITORIA` | Visor de bitácora |
