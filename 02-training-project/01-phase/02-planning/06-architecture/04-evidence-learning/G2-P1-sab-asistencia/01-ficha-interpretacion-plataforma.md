# A1 · Ficha de Interpretación del Análisis y Plataforma Tecnológica (SAB)

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001`  
**Insumo en el fork:** [`00-insumo-analisis-srs-sab.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sab-asistencia/00-insumo-analisis-srs-sab.md)  
**Autor:** `@pascuasjhorman-rgb` *(diseño individual completo sobre el caso SAB del equipo de 3 integrantes)*

---

## 1. Subconjunto de requisitos funcionales priorizados para diseño (16 RF de 54 RF del SRS)

Aunque la trazabilidad integral cubre los procesos centrales del SRS (`SRS-SAB-001`), esta ficha destaca el subconjunto crítico seleccionado para el diseño orientado a objetos y de datos:

| ID | Módulo | Requisito funcional (texto corto) | Prioridad |
|---|---|---|---|
| `RF-BIO-001` | Autenticación | Iniciar sesión con credenciales válidas y registrar último acceso. | Alta |
| `RF-BIO-003` | Autenticación | Aplicar control de acceso por rol (RBAC) y alcance de ficha/sede. | Alta |
| `RF-BIO-007` | Administración | Crear y gestionar fichas vinculadas a una sede existente. | Alta |
| `RF-BIO-009` | Administración | Asignar o reasignar líderes de ficha con histórico en bitácora. | Alta |
| `RF-BIO-012` | Aprendices | Permitir solo al instructor líder registrar aprendices en fichas a cargo. | Alta |
| `RF-BIO-017` | Aprendices | Habilitar enrolamiento controlado de huella previo consentimiento. | Alta |
| `RF-BIO-018` | Sesiones | Abrir sesión de asistencia para ficha autorizada sin superposición indebida. | Alta |
| `RF-BIO-020` | Sesiones | Generar código QR único vinculado a una sesión activa. | Alta |
| `RF-BIO-021` | Sesiones | Renovar automáticamente el QR cada 15 segundos (configurable). | Alta |
| `RF-BIO-022` | Sesiones | Cerrar sesión con consolidación de resultados bloqueando nuevos registros ordinarios. | Alta |
| `RF-BIO-024` | Biometría y QR | Solicitar cotejo de huella al proveedor biométrico compatible. | Alta |
| `RF-BIO-025` | Biometría y QR | Habilitar lectura QR (ventana 10 s) únicamente tras verificación biométrica exitosa. | Alta |
| `RF-BIO-028` | Biometría y QR | Limitar a 3 intentos fallidos el proceso ordinario generando incidencia al límite. | Alta |
| `RF-BIO-029` | Biometría y QR | Garantizar una única asistencia válida por aprendiz y sesión. | Alta |
| `RF-BIO-036` | Contingencia | Habilitar registro manual digital con causa y responsable ante fallo técnico. | Alta |
| `RF-BIO-040` | Excusas | Permitir al aprendiz radicar excusa con soporte validado para una sesión. | Alta |
| `RF-BIO-045` | Reportes | Exportar reporte consolidado de cierre de sesión en PDF y XLSX (`RF-BIO-046`). | Alta |
| `RF-BIO-050` | Auditoría | Registrar altas, reasignaciones, correcciones y cierres en bitácora (`RF-BIO-051`/`052`). | Alta |

---

## 2. Requisitos no funcionales críticos seleccionados (8 RNF con métrica)

| ID | Categoría | Requisito y métrica verificable |
|---|---|---|
| `RNF-BIO-001` | Control de acceso | Validar permisos en servidor para toda operación; 0 accesos horizontales o no autorizados permitidos. |
| `RNF-BIO-002` | Cifrado de tránsito | Todo tráfico cliente-API y API-servicios en producción sobre **HTTPS / TLS**. |
| `RNF-BIO-003` | Contraseñas | Almacenar contraseñas con **derivación robusta y sal individual** (Argon2id/bcrypt, nunca SHA-256 simple). |
| `RNF-BIO-004` | Datos biométricos | Minimización, cifrado de referencia biométrica y supresión verificable al finalizar programa (`RN-11`). |
| `RNF-BIO-007` | Rendimiento | **95 % de consultas simples ≤ 3 segundos** con al menos **100 usuarios concurrentes** (`RNF-BIO-008`). |
| `RNF-BIO-009` | Disponibilidad | Meta **99 % mensual** y respaldo probado con restauración (`RNF-BIO-010`). |
| `RNF-BIO-011` | Reloj sincronizado | Fuente horaria única del servidor (NTP) para coherencia de expiración QR (15 s / 10 s). |
| `RNF-BIO-016` | Modularidad | Separar identidad, sesión, biometría, QR, reportes y auditoría con contratos versionados (`RNF-BIO-024`). |

---

## 3. Actores y restricciones del caso

- **Actores:** Primarios: `Aprendiz`, `Instructor líder`, `Coordinador`, `Administrador`; Secundario: `Servicio biométrico`.
- **Restricciones (`SRS-SAB-001`, sec. 2.3):** Dependencia de SDK/controlador compatible para huella (navegador web no accede directo al lector sin integración); restricción estricta de datos por ficha y rol; prohibición de marcar asistencia ordinaria sobre sesión cerrada; tratamiento sensible Ley 1581 de 2012; operación piloto web en sedes Comercio e Industria de Neiva.

---

## 4. Selección y justificación de plataforma tecnológica

### Lenguaje Orientado a Objetos seleccionado: **Python 3.12 (FastAPI + Pydantic + SQLAlchemy)**
Justificación basada en **4 condiciones concretas del caso SAB**:
1. **Alineación con el SRS:** La sección 3.3 del `SRS-SAB-001` propone Python/FastAPI como arquitectura de referencia para exponer contratos REST JSON versionados (`RNF-BIO-024`) con validación automática de esquemas.
2. **Desacoplamiento del lector biométrico:** Python soporta interfaces abstractas (`abc.ABC` / `typing.Protocol`) para aplicar el patrón *Strategy* entre el SDK del lector físico y un adaptador simulado de pruebas (`RNF-BIO-022`), sin comprometer la lógica central.
3. **Seguridad y generación de reportes:** Cuenta con librerías maduras para hashing con sal (`passlib` / `argon2-cffi`, `RNF-BIO-003`), tokens firmados para QR dinámico (`RF-BIO-020`) y exportación nativa a PDF (`ReportLab`/`WeasyPrint`) y XLSX (`openpyxl`) (`RF-BIO-045`, `RF-BIO-046`).
4. **Curva de aprendizaje del equipo (3 personas):** Permite construir módulos limpios y pruebas automatizadas de regresión (`RNF-BIO-018`) en tiempos cortos de entrega.

### Tipo de Base de Datos seleccionado: **Base de datos Relacional (MariaDB / MySQL 10.4+ o PostgreSQL)**
Justificación basada en **4 condiciones concretas del caso SAB**:
1. **Integridad referencial estricta:** La jerarquía `sede → ficha → vinculacion_ficha ← usuario` y las dependencias de `sesion_formacion`, `asistencia`, `incidencia` y `excusa` requieren llaves foráneas verificadas (`RF-BIO-007`).
2. **Unicidad garantizada a nivel de motor:** La regla `RN-06` («un aprendiz no puede generar dos asistencias válidas en la misma sesión») se protege con restricción `UNIQUE(id_sesion, id_aprendiz)` incluso ante concurrencia de 100 usuarios (`RNF-BIO-008`).
3. **Transaccionalidad ACID:** El registro de asistencia ordinaria/manual y su registro simultáneo en `bitacora_auditoria` (`RN-12`, `RF-BIO-050`) requieren atomicidad transaccional.
4. **Disponibilidad en ambiente de formación:** El entorno local dispone de **MariaDB 10.4 (XAMPP)** para validar DDL, restricciones `CHECK`, llaves foráneas con `ON DELETE` y pruebas de ejecución real.

---

## 5. Lista de entregables de diseño (Guía 2 · Producto 1)

1. `A1` Ficha de interpretación del análisis y plataforma tecnológica ([`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md)).
2. `A2` Diagrama de clases de diseño orientado a objetos ([`02-diagrama-clases-y-patrones.md`](./02-diagrama-clases-y-patrones.md), `.drawio`, `.svg`, `.png`).
3. `A3` Aplicación y justificación de 3 patrones de diseño GoF ([`02-diagrama-clases-y-patrones.md`](./02-diagrama-clases-y-patrones.md)).
4. `A4` Arquitectura de software y tabla de decisiones RNF *(entrega Día 2)*.
5. `A5` Vista de componentes con interfaces provistas/requeridas *(entrega Día 2)*.
6. `A6` Vista de despliegue con nodos y protocolos *(entrega Día 2)*.
7. `A7` Matriz de trazabilidad análisis → diseño *(entrega Día 2)*.
