# Matriz Requisito → Caso de Uso y distinción RF / RNF

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001`  
**Autor:** `@pascuasjhorman-rgb`

---

## 1. Distinción entre Requisitos Funcionales (RF) y Requisitos No Funcionales (RNF)

Para evitar confusiones al modelar los casos de uso del sistema, se separan explícitamente ambos tipos de requisitos del `SRS-SAB-001`:

| Aspecto | Requisitos Funcionales (`RF-BIO-001` a `RF-BIO-054`) | Requisitos No Funcionales (`RNF-BIO-001` a `RNF-BIO-024`) |
|---|---|---|
| **Qué describen** | **Qué debe hacer** el sistema: comportamientos observables, interacciones actor-sistema y reglas de negocio (ej. abrir sesión, cotejar huella, generar QR, exportar PDF/XLSX). | **Cómo debe comportarse / qué calidad debe cumplir** el sistema: restricciones de seguridad, rendimiento, disponibilidad, usabilidad, modularidad y privacidad. |
| **Cómo se modelan en análisis** | Se mapean directamente a **Casos de Uso** (`CU-01` a `CU-18`) y a pasos/flujos dentro de sus plantillas extendidas. | **No son casos de uso independientes**; actúan como restricciones transversales que condicionan varios casos de uso (ej. `RNF-BIO-002` HTTPS aplica a toda comunicación; `RNF-BIO-003` hash+sal aplica a `CU-01`; `RNF-BIO-007` ≤ 3 s aplica a las consultas). |
| **Ejemplos en SAB** | `RF-BIO-018` Abrir sesión de asistencia → `CU-05`; `RF-BIO-024/025` Cotejo huella y etapa QR → `CU-06`, `CU-07`, `CU-08`. | `RNF-BIO-001` Validar permisos en servidor; `RNF-BIO-007` 95 % de respuestas ≤ 3 s; `RNF-BIO-023` Consentimiento Ley 1581. |

---

## 2. Matriz de cobertura: Requisitos Funcionales → Casos de Uso (100 % cubiertos)

De los **54 requisitos funcionales** definidos en `SRS-SAB-001`, el **100 % (54/54)** queda cubierto por el catálogo de casos de uso (`CU-01` a `CU-18`):

| ID Requisito | Módulo | Resumen del requisito | Caso(s) de Uso | Estado |
|---|---|---|---|---|
| `RF-BIO-001` | 4.1 Autenticación | Iniciar sesión con credenciales válidas y registrar último acceso | `CU-01` Iniciar sesión | Cubierto |
| `RF-BIO-002` | 4.1 Autenticación | Finalizar sesión e invalidar token/identificador | `CU-01` Iniciar sesión *(cierre de sesión autenticado)* | Cubierto |
| `RF-BIO-003` | 4.1 Autenticación | Aplicar permisos por rol y alcance de ficha/sede (RBAC) | `CU-01` Iniciar sesión *(y todos los CU protegidos)* | Cubierto |
| `RF-BIO-004` | 4.1 Autenticación | Restablecimiento seguro de credenciales | `CU-01` Iniciar sesión *(flujo alterno recuperación)* | Cubierto |
| `RF-BIO-005` | 4.1 Autenticación | Bloquear o limitar intentos de inicio de sesión | `CU-01` Iniciar sesión *(excepción por límite)* | Cubierto |
| `RF-BIO-006` | 4.2 Administración | Crear, consultar y actualizar sedes institucionales | `CU-02` Administrar ficha, sede y liderazgo | Cubierto |
| `RF-BIO-007` | 4.2 Administración | Crear y gestionar fichas vinculadas a una sede | `CU-02` Administrar ficha, sede y liderazgo | Cubierto |
| `RF-BIO-008` | 4.2 Administración | Crear o desactivar cuentas de instructor y coordinador | `CU-02` Administrar ficha, sede y liderazgo | Cubierto |
| `RF-BIO-009` | 4.2 Administración | Asignar o reasignar líderes de ficha con histórico | `CU-16` Reasignar líder de ficha / `CU-02` | Cubierto |
| `RF-BIO-010` | 4.2 Administración | Configurar parámetros de intentos y caducidad del QR | `CU-02` Administrar ficha, sede y liderazgo | Cubierto |
| `RF-BIO-011` | 4.2 Administración | Consultar estado general de usuarios, grupos y sesiones | `CU-02` / `CU-15` Consultar reportes | Cubierto |
| `RF-BIO-012` | 4.3 Aprendices | El líder crea cuenta de aprendiz en ficha a cargo | `CU-03` Registrar aprendiz en ficha | Cubierto |
| `RF-BIO-013` | 4.3 Aprendices | Validar unicidad de documento e identificador | `CU-03` Registrar aprendiz en ficha | Cubierto |
| `RF-BIO-014` | 4.3 Aprendices | Actualizar datos básicos del aprendiz con permisos | `CU-03` Registrar aprendiz en ficha | Cubierto |
| `RF-BIO-015` | 4.3 Aprendices | Consultar listado de aprendices y vinculación por ficha | `CU-03` / `CU-17` Consultar historial | Cubierto |
| `RF-BIO-016` | 4.3 Aprendices | Desactivar o desvincular aprendices preservando trazabilidad | `CU-03` Registrar aprendiz en ficha | Cubierto |
| `RF-BIO-017` | 4.3 Aprendices | Habilitar proceso controlado de enrolamiento de huella | `CU-04` Enrolar huella biométrica | Cubierto |
| `RF-BIO-018` | 4.4 Sesiones | Abrir una sesión de asistencia para ficha autorizada | `CU-05` Abrir sesión de asistencia | Cubierto |
| `RF-BIO-019` | 4.4 Sesiones | Evitar abrir sesiones superpuestas si la política lo prohíbe | `CU-05` Abrir sesión de asistencia | Cubierto |
| `RF-BIO-020` | 4.4 Sesiones | Generar QR único vinculado a una sesión activa | `CU-05` Abrir sesión de asistencia | Cubierto |
| `RF-BIO-021` | 4.4 Sesiones | Renovar QR automáticamente cada 15 segundos | `CU-05` Abrir sesión de asistencia | Cubierto |
| `RF-BIO-022` | 4.4 Sesiones | Cerrar una sesión con consolidación de resultados | `CU-10` Cerrar sesión y exportar reporte | Cubierto |
| `RF-BIO-023` | 4.4 Sesiones | Consultar sesiones propias por ficha, fecha y estado | `CU-17` Consultar historial | Cubierto |
| `RF-BIO-024` | 4.5 Biometría y QR | Solicitar cotejo de huella al proveedor biométrico compatible | `CU-06` Verificar huella biométrica | Cubierto |
| `RF-BIO-025` | 4.5 Biometría y QR | Habilitar etapa QR únicamente tras verificación biométrica exitosa | `CU-08` Registrar asistencia (`«include»` `CU-06`, `CU-07`) | Cubierto |
| `RF-BIO-026` | 4.5 Biometría y QR | Validar identidad de sesión, vencimiento y firma/aleatoriedad del QR | `CU-07` Escanear código QR | Cubierto |
| `RF-BIO-027` | 4.5 Biometría y QR | Conceder 10 segundos para lectura QR tras habilitación | `CU-07` Escanear código QR | Cubierto |
| `RF-BIO-028` | 4.5 Biometría y QR | Limitar a 3 intentos el proceso ordinario | `CU-08` / `CU-09` Escalar intento sospechoso (`«extend»`) | Cubierto |
| `RF-BIO-029` | 4.5 Biometría y QR | Registrar una única asistencia válida por aprendiz y sesión | `CU-08` Registrar asistencia | Cubierto |
| `RF-BIO-030` | 4.5 Biometría y QR | Mostrar resultado de validación y razón genérica de rechazo | `CU-08` / `CU-06` / `CU-07` | Cubierto |
| `RF-BIO-031` | 4.6 Incidencias | Crear incidencia ante fallas reiteradas o actividad sospechosa | `CU-09` Escalar intento sospechoso | Cubierto |
| `RF-BIO-032` | 4.6 Incidencias | Notificar al instructor sobre nuevas incidencias de su sesión | `CU-09` Escalar intento sospechoso | Cubierto |
| `RF-BIO-033` | 4.6 Incidencias | Permitir clasificación y resolución auditada de incidencias | `CU-09` Escalar intento sospechoso *(gestión por instructor)* | Cubierto |
| `RF-BIO-034` | 4.6 Incidencias | Registrar novedades operativas de sesión, lector o conectividad | `CU-11` / `CU-12` (contingencia) y `CU-09` | Cubierto |
| `RF-BIO-035` | 4.6 Incidencias | Impedir conversión automática de incidencia rechazada a asistencia válida | `CU-09` / `CU-11` | Cubierto |
| `RF-BIO-036` | 4.7 Contingencia | Habilitar registro manual digital cuando falla el método regular | `CU-11` Registrar asistencia manual de contingencia | Cubierto |
| `RF-BIO-037` | 4.7 Contingencia | Distinguir en reportes registros manuales de verificaciones ordinarias | `CU-11` / `CU-10` Cerrar sesión y exportar | Cubierto |
| `RF-BIO-038` | 4.7 Contingencia | Permitir cancelar clase registrando motivo y soporte | `CU-12` Cancelar sesión por contingencia | Cubierto |
| `RF-BIO-039` | 4.7 Contingencia | Restringir modificaciones de asistencia a roles autorizados con auditoría | `CU-11` Registrar asistencia manual de contingencia | Cubierto |
| `RF-BIO-040` | 4.8 Excusas | Permitir al aprendiz enviar excusa asociada a fecha/sesión | `CU-13` Enviar excusa con soporte | Cubierto |
| `RF-BIO-041` | 4.8 Excusas | Validar formato, tamaño y acceso autorizado a adjuntos | `CU-13` Enviar excusa con soporte | Cubierto |
| `RF-BIO-042` | 4.8 Excusas | Permitir al instructor confirmar recepción de una excusa | `CU-14` Confirmar recepción de excusa | Cubierto |
| `RF-BIO-043` | 4.8 Excusas | Consultar estado e historial de excusas propias | `CU-17` Consultar historial / `CU-13` | Cubierto |
| `RF-BIO-044` | 4.9 Reportes | Generar lista de asistencias, ausencias e incidencias por sesión | `CU-10` Cerrar sesión y exportar reporte | Cubierto |
| `RF-BIO-045` | 4.9 Reportes | Exportar reporte de cierre en formato PDF | `CU-10` Cerrar sesión y exportar reporte | Cubierto |
| `RF-BIO-046` | 4.9 Reportes | Exportar reporte de cierre en formato XLSX | `CU-10` Cerrar sesión y exportar reporte | Cubierto |
| `RF-BIO-047` | 4.9 Reportes | Filtrar estadísticas por sede, ficha, instructor y fechas | `CU-15` Consultar reportes consolidados | Cubierto |
| `RF-BIO-048` | 4.9 Reportes | Permitir al coordinador consultar registros globales según alcance | `CU-15` Consultar reportes consolidados | Cubierto |
| `RF-BIO-049` | 4.9 Reportes | Permitir al instructor consultar historial solo de sus fichas/sesiones | `CU-17` Consultar historial | Cubierto |
| `RF-BIO-050` | 4.10 Auditoría | Registrar altas, reasignaciones, correcciones y cierres en bitácora | `CU-02`, `CU-10`, `CU-11`, `CU-16` *(transversal)* | Cubierto |
| `RF-BIO-051` | 4.10 Auditoría | Registrar aceptación del aviso de tratamiento antes del enrolamiento | `CU-04` Enrolar huella biométrica | Cubierto |
| `RF-BIO-052` | 4.10 Auditoría | Eliminar plantilla biométrica al finalizar programa según política | `CU-18` Eliminar biometría al egreso | Cubierto |
| `RF-BIO-053` | 4.10 Auditoría | Evitar exponer imágenes/plantillas de huella en reportes o logs | `CU-10`, `CU-15`, `CU-18` | Cubierto |
| `RF-BIO-054` | 4.10 Auditoría | Permitir consulta de actividad relevante por personal autorizado | `CU-15` Consultar reportes / `CU-02` | Cubierto |

**Resumen de cobertura:** **54 / 54 requisitos funcionales (100 %)** trazados a casos de uso del diagrama UML.
