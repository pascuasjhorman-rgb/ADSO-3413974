# Insumo de análisis · Sistema de Asistencia Biométrica (SAB / BioSENA)

**Código de referencia:** `SRS-SAB-001` (Versión oficial 2.3 · 27 de noviembre de 2026)  
**Proyecto:** Sistema de Asistencia Biométrica (SAB) / BioSENA  
**Autores del SRS base en equipo:** Juan Sebastián Medina Cardozo, Jhon Stiven Alba Quiroga, Jhorman Pascuas  
**Programa y Ficha:** Tecnología en Análisis y Desarrollo de Software · Ficha 3413974  
**Centro de formación:** Centro de la Industria, la Empresa y los Servicios (CIES) · Neiva, Huila  
**Autor de esta síntesis, modelado y entregas individuales:** `@pascuasjhorman-rgb`  
**Prototipo interactivo en línea oficial:** [BioSENA Mockup Web](https://biosena-asistencia-biom-trica.ai.studio/)  

**Trabajo previo y antecedentes reutilizados del fork:**
- `03-execute/16-week/02-optional-activity/registro de asistencia.md` (levantamiento inicial por observación, problemática de llamados a lista en la ficha 3413974 y primeros RF01–RF06)
- `03-execute/17-week/02-optional-activity/Hoja_de_Ruta_Sistema_Toma_de_Asistencias.md` (planificación del ciclo de vida en 7 fases)
- `03-execute/17-week/02-optional-activity/sena_asistencia_.zip` (mockups y prototipos base de interfaz)
- `03-execute/23-week/02-optional-activity/Sistema_Asistencia_1.1 (1).txt` (diagnóstico cuantitativo de tiempos en SOFIA Plus: 45 min diarios perdidos por jornada)
- `03-execute/24-week/02-optional-activity/Proyecto_mejora_Kevin_Brenda_Castro_Jhorman.zip` (arquitectura de mejora y módulos funcionales)

> **Nota de privacidad:** En cumplimiento de las directrices de repositorios públicos y la Ley 1581 de 2012, no se publican documentos de identidad reales, teléfonos ni correos personales de terceros. El autor individual se identifica con su cuenta de GitHub `@pascuasjhorman-rgb`.

---

## 1. Descripción general y alcance del sistema

**Propósito:** Digitalizar y agilizar el control de asistencia en el Servicio Nacional de Aprendizaje (SENA) y adaptable a instituciones educativas, eliminando el llamado a lista manual mediante una aplicación web con doble factor operativo de verificación:
1. **Código QR dinámico** de sesión (o código numérico manual de 4-6 dígitos para contingencia).
2. **Verificación de identidad** guiada (WebAuthn / reconocimiento facial o alternativa supervisada sin biometría).

**Roles del sistema (v2.3):**
- **Aprendiz:** Registra asistencia validando QR y su identidad, consulta su historial propio, porcentaje de horas, competencias, excusas con soporte y notificaciones.
- **Instructor:** Abre y cierra sesiones asignadas de su ficha, proyecta el QR/código temporal, supervisa asistencias e incidencias en tiempo real, gestiona contingencias manuales y exporta reportes en PDF y XLSX.
- **Superadmin:** Administra sedes, fichas, programas, ambientes, instructores, horarios académicos, novedades institucionales, reportes consolidados y auditoría del sistema.
- **Servicio de verificación de identidad (Secundario):** Servicio compatible para autenticación local o remota bajo contratos REST definidos.

---

## 2. Reglas de negocio clave (`RN-001` a `RN-029`)

| Código | Regla de negocio |
|---|---|
| `RN-001` | Solo el instructor líder asignado registra aprendices en sus fichas a cargo. |
| `RN-002` | El Superadmin puede reasignar el liderazgo dejando constancia auditable en bitácora. |
| `RN-003` | Primero se valida el QR o código y luego la identidad; ambos deben corresponder a la misma sesión activa. |
| `RN-004` | El QR rota periódicamente cada 15 s; el código numérico de contingencia dura 60 s. |
| `RN-005` | Tres fallos de identidad consecutivos generan una incidencia para el instructor. Los fallos técnicos de red no cuentan como fallos de identidad. |
| `RN-006` | Cada aprendiz puede registrar una única asistencia válida por sesión (clave única de base de datos). |
| `RN-007` | El registro manual de contingencia exige indicar motivo y nombre del instructor responsable. |
| `RN-008` | Ante cancelación de clase por fuerza mayor se exige registrar motivo y soporte. Una sesión cancelada no genera ausencias. |
| `RN-009` | El aprendiz puede enviar excusa con adjunto; recibir la excusa no implica aprobación automática. |
| `RN-010` | Al cerrar una sesión quedan disponibles las exportaciones en formatos estándar PDF y XLSX. |
| `RN-011` | Los datos biométricos se eliminan al finalizar el programa según la política aprobada (Ley 1581 de 2012). |
| `RN-012` | Toda operación administrativa sensible deja actor, fecha, recurso y resultado en la bitácora de auditoría. |
| `RN-013` | La hora del servidor define si la asistencia se clasifica como puntual o retardo. |
| `RN-014` | No se registra información biométrica sin autorización previa y constancia registrada. |
| `RN-015` | Quien tenga autorización de excepción cuenta con una ruta supervisada sin uso de biometría. |
| `RN-016` | Una sesión cerrada no acepta nuevos registros ordinarios de asistencia. |
| `RN-017` | Una sesión cancelada no genera registros de inasistencia ni ausencias. |
| `RN-018` | El código numérico manual no reemplaza la verificación de identidad. |
| `RN-019` | Ningún usuario puede consultar registros de otra ficha sin autorización explícita. |
| `RN-020` | Al corregir un registro de asistencia, el sistema conserva el valor anterior y el nuevo en auditoría. |
| `RN-021` | WebAuthn certifica el uso de una credencial segura del dispositivo. |
| `RN-022` | Las bitácoras y registros de logs jamás almacenan imágenes ni plantillas biométricas crudas. |
| `RN-023` | Las excusas y sus archivos adjuntos solo se consultan dentro del alcance autorizado del instructor y el aprendiz. |
| `RN-024` | El umbral de tolerancia para marcar retardo es configurable por sesión. |
| `RN-025` | No se emplean datos personales reales de terceros sin consentimiento previo. |
| `RN-026` | La hora de inicio de una sesión o clase debe ser estrictamente anterior a la hora de fin. |
| `RN-027` | El servidor bloquea solapamientos o cruces de horario para una misma ficha, instructor o ambiente. |
| `RN-028` | Solo el Superadmin puede publicar y fijar novedades institucionales generales. |
| `RN-029` | Las competencias y resultados de aprendizaje solo son consultables por aprendices e instructores vinculados a la ficha. |

---

## 3. Estructura de Requisitos Funcionales (`RF-SAB-001` a `RF-SAB-100`)

El catálogo oficial comprende 100 requisitos estructurados por áreas funcionales:

- **Autenticación, acceso y seguridad (RF-SAB-001 a 005, 069):** Inicio de sesión por roles, cierre de sesión e invalidación de tokens, control de acceso basado en roles (RBAC), recuperación segura de contraseña por enlace de un solo uso de 15 min, bloqueo tras 5 intentos fallidos en 15 min.
- **Administración institucional y académica (RF-SAB-006 a 011, 065 a 068, 085 a 088):** Gestión de sedes, fichas, ambientes, programas, asignación académica sin cruces de horario, reasignación de instructores líderes con bitácora, configuración de parámetros operativos.
- **Gestión de aprendices y cuentas (RF-SAB-012 a 017, 095 a 097):** Registro de cuentas según rol, validación de ficha activa para aprendices, unicidad de documento y correo, enrolamiento con autorización legal, desvinculación conservando historial.
- **Sesiones de clase y generación de códigos (RF-SAB-018 a 023, 055, 056, 071):** Apertura de sesión sin solapamiento, emisión de QR dinámico con rotación cada 15 s, emisión de código manual alternativo de 60 s, consulta de sesiones activas, cierre de sesión y bloqueo de marcas posteriores.
- **Verificación de identidad y marcación de asistencia (RF-SAB-024 a 030, 057 a 060, 079, 080, 098 a 100):** Orden estricto (código previo a identidad), verificación facial o WebAuthn, ventana de 60 s, límite de 3 fallos con pase a incidencia, registro transaccional único por sesión (idempotencia), clasificación horaria puntual vs. retardo, guía visual de cámara sin distorsión.
- **Incidencias, contingencias y control manual (RF-SAB-031 a 039, 062, 063, 076, 078):** Generación de incidencia automática tras fallos reiterados, alertas al instructor, resolución auditada, registro de contingencia manual con motivo y responsable, cancelación de clase con soporte sin ausencias.
- **Excusas y justificaciones (RF-SAB-040 a 043, 073, 074, 081):** Envío de excusas por el aprendiz con soporte en PDF/JPG/PNG (límite 10 MB), confirmación de recepción por el instructor, resolución formal y notificación.
- **Reportes, supervisión y auditoría (RF-SAB-044 a 054, 075, 082 a 084, 089 a 094):** Reporte de sesión con totales, exportación a PDF y XLSX, estadísticas filtrables por sede y fecha, bitácora de auditoría inmutable, supresión de datos al egreso conforme a ley, consulta de competencias y novedades.

---

## 4. Requisitos No Funcionales Clave (`RNF-SAB-001` a `RNF-SAB-040`)

- **Seguridad:** 100 % de rutas protegidas mediante RBAC (`RNF-SAB-001`), cifrado HTTPS/TLS 1.2+ (`RNF-SAB-002`), contraseñas hasheadas con Argon2id o bcrypt (`RNF-SAB-003`), expiración de sesión por inactividad de 30 min (`RNF-SAB-004`), cifrado en reposo y bitácora completa (`RNF-SAB-005` y `006`).
- **Rendimiento:** Latencia percentil 95 $\le$ 3 s (`RNF-SAB-007`), capacidad de 100 usuarios concurrentes en prueba piloto (`RNF-SAB-008`), disponibilidad 99 % mensual (`RNF-SAB-009`), RPO 24 h y RTO 4 h (`RNF-SAB-010`), reloj sincronizado $\le$ 2 s (`RNF-SAB-011`).
- **Usabilidad y accesibilidad:** Diseño responsive adaptado desde 320 px de ancho sin desplazamiento horizontal (`RNF-SAB-012`), mensajes claros de error con indicación del paso siguiente (`RNF-SAB-013`), WCAG 2.1 AA (`RNF-SAB-014`), marcación completable en $\le$ 30 s (`RNF-SAB-015`).
- **Arquitectura y calidad:** Separación modular en 3 capas (`RNF-SAB-016`), trazabilidad de errores sin exponer secretos (`RNF-SAB-017`), política de retención de datos documentada (`RNF-SAB-021`), contratos API OpenAPI/REST (`RNF-SAB-024`), y garantía de cero duplicados por concurrencia (`RNF-SAB-025`).

---

## 5. Casos de Uso del Sistema (`CU-01` a `CU-30`)

El modelo funcional formaliza 30 casos de uso:
1. `CU-01` Iniciar sesión
2. `CU-02` Administrar ficha y liderazgo
3. `CU-03` Registrar aprendiz
4. `CU-04` Enrolar identidad
5. `CU-05` Abrir sesión
6. `CU-06` Verificar identidad
7. `CU-07` Validar QR o código
8. `CU-08` Registrar asistencia
9. `CU-09` Escalar incidencia
10. `CU-10` Cerrar sesión y exportar
11. `CU-11` Registrar asistencia manual
12. `CU-12` Cancelar clase
13. `CU-13` Enviar excusa
14. `CU-14` Confirmar excusa
15. `CU-15` Consultar reportes
16. `CU-16` Reasignar líder
17. `CU-17` Suprimir datos
18. `CU-18` Consultar auditoría
19. `CU-19` Consultar historial
20. `CU-20` Contingencia de servicio
21. `CU-21` Consultar panel e indicadores propios
22. `CU-22` Consultar competencias y resultados
23. `CU-23` Consultar notificaciones y novedades
24. `CU-24` Gestionar instructores y ambientes
25. `CU-25` Asignar y consultar horarios
26. `CU-26` Gestionar novedades institucionales
27. `CU-27` Consultar estados de validación
28. `CU-28` Resolver excusa
29. `CU-29` Consultar panel administrativo
30. `CU-30` Crear cuenta por rol
