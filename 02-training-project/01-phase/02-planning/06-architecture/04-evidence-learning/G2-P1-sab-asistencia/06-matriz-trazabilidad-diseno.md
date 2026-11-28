# A7. Matriz de Trazabilidad: Requisitos Funcionales → Clases y Componentes de Diseño

**Proyecto:** Sistema de Asistencia Biométrica (SAB / BioSENA) · **Referencia:** `SRS-SAB-001` (v2.3)  
**Autor:** `@pascuasjhorman-rgb` · Ficha 3413974  
**Entregable:** Guía 2 · Producto 1 · Artefacto A7 (RAP 593103)

---

## 1. Cobertura de Requisitos Funcionales en el Diseño de Clases y Componentes

Esta matriz asegura la consistencia entre el informe de análisis (`SRS-SAB-001 v2.3`) y los modelos de diseño orientado a objetos y arquitectura (A2, A3, A4, A5, A6). El **100 % de los requisitos funcionales del caso de estudio** queda asignado a componentes de software e implementado en clases de diseño:

| Módulo del SRS | Requisitos Funcionales | Componente Responsable | Clases / Interfaces de Diseño que lo implementan |
|---|---|---|---|
| **1. Autenticación y Acceso** | `RF-SAB-001`, `RF-SAB-002`, `RF-SAB-003`, `RF-SAB-004`, `RF-SAB-005`, `RF-SAB-069` | `COMP-01 Autenticación` | `Usuario`, `Rol`, `AuthService`, `TokenProvider`, `IUsuarioRepository` |
| **2. Administración de Sedes y Fichas** | `RF-SAB-006`, `RF-SAB-007`, `RF-SAB-008`, `RF-SAB-009`, `RF-SAB-010`, `RF-SAB-011` | `COMP-02 Gestión Académica` | `Sede`, `Ficha`, `Instructor`, `FichaService`, `IFichaRepository` |
| **3. Gestión de Aprendices y Cuentas** | `RF-SAB-012`, `RF-SAB-013`, `RF-SAB-014`, `RF-SAB-015`, `RF-SAB-016`, `RF-SAB-095`, `RF-SAB-096`, `RF-SAB-097` | `COMP-02 Gestión Académica` | `Aprendiz`, `Persona`, `VinculacionFicha`, `FichaService` |
| **4. Enrolamiento y Consentimiento** | `RF-SAB-017`, `RF-SAB-051`, `RF-SAB-052`, `RF-SAB-077` | `COMP-04 Identidad` | `RegistroIdentidad`, `IdentidadService`, `IIdentidadService` |
| **5. Apertura y Control de Sesión** | `RF-SAB-018`, `RF-SAB-019`, `RF-SAB-020`, `RF-SAB-021`, `RF-SAB-022`, `RF-SAB-023`, `RF-SAB-071` | `COMP-03 Sesiones QR` | `Sesion`, `TokenQR`, `SesionService`, `ISesionRepository` |
| **6. Códigos de Contingencia** | `RF-SAB-055`, `RF-SAB-056` | `COMP-03 Sesiones QR` | `TokenQR`, `SesionService`, `TokenQRManager` |
| **7. Verificación de Identidad (Strategy)** | `RF-SAB-024`, `RF-SAB-025`, `RF-SAB-026`, `RF-SAB-027`, `RF-SAB-028`, `RF-SAB-057`, `RF-SAB-058`, `RF-SAB-098`, `RF-SAB-099`, `RF-SAB-100` | `COMP-04 Identidad` | `IEstrategiaVerificacion`, `VerificacionWebAuthnStrategy`, `VerificacionFacialStrategy`, `VerificacionManualStrategy`, `IdentidadService` |
| **8. Marcación de Asistencia (Facade)** | `RF-SAB-029`, `RF-SAB-030`, `RF-SAB-059`, `RF-SAB-060`, `RF-SAB-079`, `RF-SAB-080` | `COMP-05 Asistencia` | `AsistenciaFacade`, `Asistencia`, `AsistenciaService`, `IAsistenciaRepository` |
| **9. Incidencias y Novedades Operativas** | `RF-SAB-031`, `RF-SAB-032`, `RF-SAB-033`, `RF-SAB-034`, `RF-SAB-035`, `RF-SAB-062`, `RF-SAB-076` | `COMP-05 Asistencia` | `Incidencia`, `IncidenciaService`, `IIncidenciaRepository` |
| **10. Contingencia Manual y Cancelación** | `RF-SAB-036`, `RF-SAB-037`, `RF-SAB-038`, `RF-SAB-039`, `RF-SAB-063` | `COMP-05 Asistencia` | `AsistenciaFacade`, `Asistencia`, `Sesion`, `AsistenciaService` |
| **11. Excusas y Justificaciones** | `RF-SAB-040`, `RF-SAB-041`, `RF-SAB-042`, `RF-SAB-043`, `RF-SAB-073`, `RF-SAB-074`, `RF-SAB-081` | `COMP-05 Asistencia` | `Excusa`, `ExcusaService`, `IExcusaRepository` |
| **12. Reportes, Estadísticas y Exportación** | `RF-SAB-044`, `RF-SAB-045`, `RF-SAB-046`, `RF-SAB-047`, `RF-SAB-048`, `RF-SAB-049`, `RF-SAB-075` | `COMP-06 Reportes y Auditoría` | `ReporteService`, `PDFExporterAdapter`, `XLSXExporterAdapter` |
| **13. Auditoría y Trazabilidad** | `RF-SAB-050`, `RF-SAB-053`, `RF-SAB-054` | `COMP-06 Reportes y Auditoría` | `Auditoria`, `AuditoriaService`, `IBitacoraRepository` |
| **14. Ambientes y Horarios Académicos** | `RF-SAB-065`, `RF-SAB-066`, `RF-SAB-067`, `RF-SAB-068`, `RF-SAB-085`, `RF-SAB-086`, `RF-SAB-087`, `RF-SAB-088` | `COMP-02 Gestión Académica` | `Ambiente`, `Horario`, `HorarioService`, `IHorarioRepository` |
| **15. Indicadores, Competencias y Novedades** | `RF-SAB-082`, `RF-SAB-083`, `RF-SAB-084`, `RF-SAB-089`, `RF-SAB-090`, `RF-SAB-091`, `RF-SAB-092`, `RF-SAB-093`, `RF-SAB-094` | `COMP-02 / COMP-06` | `NovedadInstitucional`, `NovedadService`, `ReporteService` |

---

## 2. Validación de Cohesión: Ninguna Clase sin Requisito

Cada una de las 15 clases e interfaces del diagrama de clases (`02-diagrama-clases-y-patrones.md`) tiene una responsabilidad asignada y responde a requisitos verificables:
1. `Usuario`: Atiende `RF-SAB-001`, `002`, `003` (Autenticación y RBAC).
2. `Aprendiz`: Atiende `RF-SAB-012`–`016` (Gestión de aprendices).
3. `Instructor`: Atiende `RF-SAB-008`, `009`, `018` (Líder de ficha y sesiones).
4. `Sede`: Atiende `RF-SAB-006` (Catálogo institucional de sedes).
5. `Ficha`: Atiende `RF-SAB-007`, `009` (Grupos de formación y liderazgo).
6. `VinculacionFicha`: Atiende `RF-SAB-012`, `016` (Relación N:M aprendiz-ficha con estado).
7. `Sesion`: Atiende `RF-SAB-018`–`023` (Apertura, estado y cierre de clases).
8. `TokenQR`: Atiende `RF-SAB-020`, `021`, `055` (Emisión y rotación de códigos QR y manuales).
9. `Asistencia`: Atiende `RF-SAB-029`, `030`, `059` (Registro atómico, estado y puntualidad).
10. `Incidencia`: Atiende `RF-SAB-031`–`035` (Escalamiento de fallos y alertas).
11. `Excusa`: Atiende `RF-SAB-040`–`043` (Justificaciones con soporte).
12. `Auditoria`: Atiende `RF-SAB-050`, `054` (Bitácora inmutable de operaciones sensibles).
13. `IEstrategiaVerificacion`: Atiende `RF-SAB-024`, `057`, `058` (Contrato polimórfico Strategy).
14. `VerificacionWebAuthnStrategy` / `VerificacionFacialStrategy`: Atiende `RF-SAB-024`, `057` (Implementaciones concretas).
15. `AsistenciaFacade`: Atiende `RF-SAB-025`, `029`, `036` (Punto único de orquestación de la marcación).
