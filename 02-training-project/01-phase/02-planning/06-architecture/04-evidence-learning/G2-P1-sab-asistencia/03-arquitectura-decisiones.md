# A4. Arquitectura del Software y Decisiones Técnicas (SAB / BioSENA)

**Proyecto:** Sistema de Asistencia Biométrica (SAB / BioSENA) · **Referencia:** `SRS-SAB-001` (v2.3)  
**Autor:** `@pascuasjhorman-rgb` · Ficha 3413974  
**Entregable:** Guía 2 · Producto 1 · Artefacto A4 (RAP 593103)

---

## 1. Definición del Estilo Arquitectural: 3 Capas Lógicas (Multicapa Limpia)

Para responder a las características del proyecto formativo (equipo de desarrollo pequeño, cliente institucional SENA, necesidad de bajo acoplamiento y facilidad de mantenimiento y pruebas), se adopta una **Arquitectura en 3 Capas Lógicas Desacopladas**:

1. **Capa de Presentación (Frontend Web / UI):**
   - Implementada como Single Page Application (SPA) responsiva (HTML5, CSS3, JavaScript moderno / Web Components).
   - Acceso multidispositivo (Smartphones, tablets, PCs de ambientes de formación y proyectores).
   - Consume exclusivamente servicios de la API REST mediante HTTPS. No contiene lógica de negocio ni acceso a datos.
2. **Capa de Lógica de Negocio y Servicios (Backend / API REST):**
   - Implementada en **Python 3.12 con FastAPI**.
   - Expone contratos REST JSON bajo `/api/v1/`.
   - Organizada en controladores de ruta, servicios de dominio (gestión de sesiones, validación de códigos, cotejo de identidad, cálculo de retardos e incidencias) y repositorios de datos.
   - Aplica el principio de inversión de dependencias: los servicios dependen de interfaces (`IIdentidadService`, `ITokenQRService`).
3. **Capa de Persistencia y Acceso a Datos (Database):**
   - Sistema gestor de bases de datos relacional **MariaDB 10.4**.
   - Garantiza consistencia transaccional (ACID), integridad referencial estricta, claves foráneas e índices de unicidad.

### Diagrama de la Arquitectura en 3 Capas
```
+-----------------------------------------------------------------------------------+
|                           CAPA DE PRESENTACIÓN (UI)                               |
|   BioSENA WebApp (Navegador Móvil / Escritorio / Proyector de Ambiente)          |
|   - Módulo Aprendiz (QR/Cámara/WebAuthn)  - Módulo Instructor (Sesiones/Reportes)  |
|   - Módulo Superadmin (Sedes/Fichas/Horarios)                                     |
+-----------------------------------------------------------------------------------+
                                         │  HTTPS (TLS 1.2+) · REST JSON
                                         ▼
+-----------------------------------------------------------------------------------+
|                        CAPA DE NEGOCIO Y SERVICIOS (API)                          |
|   FastAPI Backend (Python 3.12 + Pydantic + Uvicorn)                              |
|   ┌───────────────────────────────────────────────────────────────────────────┐   |
|   │ Controladores REST (/auth, /sessions, /attendance, /incidents, /reports)   │   |
|   └─────────────────────────────────────┬─────────────────────────────────────┘   |
|                                         ▼                                         |
|   ┌───────────────────────────────────────────────────────────────────────────┐   |
|   │ Servicios de Negocio (SessionService, AttendanceService, ReportService)   │   |
|   └─────────────────────────────────────┬─────────────────────────────────────┘   |
|                                         ▼                                         |
|   ┌───────────────────────────────────────────────────────────────────────────┐   |
|   │ Adaptadores y Patrones (Strategy: WebAuthn/Facial, Facade: Asistencia)   │   |
|   └─────────────────────────────────────┬─────────────────────────────────────┘   |
|                                         ▼                                         |
|   ┌───────────────────────────────────────────────────────────────────────────┐   |
|   │ Repositorios de Persistencia (SQLAlchemy / PyMySQL Data Access Objects)   │   |
|   └───────────────────────────────────────────────────────────────────────────┘   |
+-----------------------------------------------------------------------------------+
                                         │  Conexión TCP Pool (Puerto 3306)
                                         ▼
+-----------------------------------------------------------------------------------+
|                       CAPA DE PERSISTENCIA Y DATOS (SGBD)                         |
|   MariaDB Server 10.4 (Motor InnoDB · Transaccional ACID)                         |
|   - Tablas normalizadas en 3FN (12 tablas)  - Índices únicos y llaves foráneas    |
|   - Bitácora inmutable de auditoría         - Respaldo diario programado          |
+-----------------------------------------------------------------------------------+
```

---

## 2. Decisiones Arquitecturales frente a los Requisitos No Funcionales (RNF)

| # | RNF del SRS v2.3 | Atributo de Calidad | Decisión Arquitectural que lo atiende | Justificación Técnica |
|---|---|---|---|---|
| 1 | `RNF-SAB-001` y `RNF-SAB-003` | Seguridad y Control de Acceso | Autenticación basada en tokens JWT con expiración estricta de 30 minutos y derivación de contraseñas mediante **hash Argon2id / bcrypt con sal**. | La capa de presentación nunca almacena credenciales en plano. El middleware del backend intercepta cada petición y valida el rol y ficha en servidor antes de llegar al servicio. |
| 2 | `RNF-SAB-002` | Confidencialidad en Tránsito | Terminación TLS 1.2+ obligatoria en el proxy inverso y comunicación cliente-servidor 100 % cifrada por HTTPS. | Protege los desafíos de WebAuthn, tokens de sesión y solicitudes de marcado contra intercepción en redes WiFi públicas o del centro de formación. |
| 3 | `RNF-SAB-007` y `RNF-SAB-008` | Rendimiento y Escalabilidad | Procesamiento asíncrono en FastAPI (`async/await`) y *Connection Pooling* hacia MariaDB para soportar 100 usuarios concurrentes con p95 $\le$ 3 s. | Al abrirse una sesión de clase, múltiples aprendices validan su código simultáneamente. El I/O asíncrono evita bloqueos del hilo principal del servidor. |
| 4 | `RNF-SAB-011` | Integridad Temporal del QR | Generación y validación de tokens de vigencia basada exclusivamente en la hora interna del servidor NTP (`RN-013`). | Previene que desfases en la hora de los celulares de los aprendices causen rechazos falsos o permitan reutilizar códigos caducados. |
| 5 | `RNF-SAB-016` | Modularidad y Mantenibilidad | Desacoplamiento de componentes mediante interfaces provistas y requeridas (IoC) y patrones GoF (Strategy y Facade). | Permite intercambiar el proveedor de verificación (WebAuthn por reconocimiento facial o contingencia manual) sin tocar la lógica central de asistencias. |
| 6 | `RNF-SAB-025` | Integridad de Datos | Restricción de clave única compuesta `UNIQUE (id_sesion, id_aprendiz)` en la tabla `ASISTENCIA` de MariaDB a nivel de motor de almacenamiento. | Garantiza a nivel transaccional que, incluso bajo peticiones concurrentes dobles, sea imposible duplicar un registro de asistencia para la misma sesión. |

---

## 3. Estilo de Comunicación entre Componentes

- **Cliente Web $\leftrightarrow$ Backend API:** Protocolo **HTTPS** mediante peticiones asíncronas `fetch` / REST JSON.
  - Formato de carga útil: JSON tipado con esquemas Pydantic.
  - Códigos de respuesta HTTP semánticos: `200 OK`, `201 Created`, `400 Bad Request`, `401 Unauthorized`, `403 Forbidden`, `409 Conflict`, `422 Unprocessable Entity`, `503 Service Unavailable`.
- **Backend API $\leftrightarrow$ Base de Datos MariaDB:** Conexión nativa sobre TCP/IP (puerto 3306) con *Connection Pool* reutilizable para optimizar latencia.
- **Backend $\leftrightarrow$ Servicio de Identidad:** Contrato REST interno que retorna objeto binario o booleano de éxito/fallo sin exponer vectores ni plantillas biométricas crudas a clientes externos.

---

## 4. Alternativa Arquitectural Descartada y Justificación

### Alternativa Evaluada y Descartada: Arquitectura de Microservicios Distribuidos (Docker Swarm / Kubernetes)
- **Descripción:** Separar el sistema en 5 microservicios independientes (Servicio de Autenticación, Servicio de Fichas, Servicio de Sesiones QR, Servicio de Asistencias, Servicio de Reportes) con bases de datos independientes y un bus de mensajería (RabbitMQ/Kafka).
- **Razón del Descarte:**
  1. **Sobrecostos de infraestructura y complejidad operativa:** Para un entorno piloto educativo en el centro CIES de Neiva, desplegar y mantener un clúster de microservicios con orquestación, balanceadores y trazabilidad distribuida sobrepasa los recursos de hardware presupuestados (servidor de 4 vCPU y 8 GB RAM).
  2. **Riesgo de consistencia eventual:** La validación de que un aprendiz pertenezca a la ficha y registre asistencia única requiere transacciones atómicas consistentes. En microservicios esto exigiría transacciones distribuidas (patrón Saga), incrementando innecesariamente el riesgo de fallas.
  3. **Conclusión:** Se seleccionó el **Monolito Modular en 3 Capas**, que ofrece el mismo aislamiento de responsabilidades y modularidad limpia en el código, pero con un despliegue simple, alta velocidad y facilidad de mantenimiento para el equipo de aprendices de la ficha 3413974.
