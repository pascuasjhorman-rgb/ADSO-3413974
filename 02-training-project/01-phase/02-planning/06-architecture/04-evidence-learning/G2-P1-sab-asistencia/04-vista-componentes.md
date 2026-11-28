# A5. Vista de Componentes del Software (SAB / BioSENA)

**Proyecto:** Sistema de Asistencia Biométrica (SAB / BioSENA) · **Referencia:** `SRS-SAB-001` (v2.3)  
**Autor:** `@pascuasjhorman-rgb` · Ficha 3413974  
**Entregable:** Guía 2 · Producto 1 · Artefacto A5 (RAP 593103)

---

## 1. Definición y Catálogo de Componentes de Software

La arquitectura interna del backend BioSENA se organiza en **6 componentes desacoplados de alta cohesión y bajo acoplamiento**, interactuando exclusivamente a través de interfaces formalmente definidas:

```
                  +-----------------------------------+
                  |      Capa de Presentación Web     |
                  |     (Controladores API / UI)      |
                  +-----------------+-----------------+
                                    │
                                    │ usa IAuthService, ISesionService, IAsistenciaService
                                    ▼
       ┌────────────────────────────┬────────────────────────────┐
       │                            │                            │
       ▼                            ▼                            ▼
+───────────────+            +───────────────+            +───────────────+
|   COMP-01     |            |   COMP-03     |            |   COMP-05     |
| Autenticación |            |  Sesiones QR  |            |   Registro    |
|   y Acceso    |            | y Temporizador|            |  Asistencia   |
+───────┬───────+            +───────┬───────+            +───────┬───────+
        │                            │                            │
        │ usa IUsuarioRepo           │ usa ISesionRepo            │ usa IIdentidadService
        │                            │                            ▼
        │                    +───────┴───────+            +───────────────+
        │                    |   COMP-02     |            |   COMP-04     |
        │                    |    Gestión    |            | Verificación  |
        │                    |  Académica    |            | de Identidad  |
        │                    +───────┬───────+            +───────┬───────+
        │                            │                            │
        │                            │                            │ usa IEstrategiaVerificacion
        ▼                            ▼                            ▼
+─────────────────────────────────────────────────────────────────────────+
|                                COMP-06                                  |
|                 Reportes, Auditoría y Persistencia de Datos             |
+─────────────────────────────────────────────────────────────────────────+
```

---

## 2. Especificación Detallada de los 6 Componentes

### Componente 1: `COMP-01 Autenticación y Control de Acceso`
- **Interfaces Provistas:**
  - `IAuthService`: Métodos `iniciarSesion(credenciales)`, `cerrarSesion(token)`, `recuperarClave(correo)`, `validarPermiso(token, rol, recurso)`.
- **Interfaces Requeridas:**
  - `IUsuarioRepository`: Consulta y actualización de estados de cuentas de usuarios.
- **Clases que agrupa:** `AuthService`, `TokenProvider` (JWT), `Argon2PasswordHasher`, `UsuarioRepository`.
- **Requisitos que atiende:** `RF-SAB-001` a `RF-SAB-005`, `RF-SAB-069` y `RNF-SAB-001`–`004`.

---

### Componente 2: `COMP-02 Gestión Académica e Institucional`
- **Interfaces Provistas:**
  - `IAcademicoService`: Métodos `crearFicha()`, `asignarLider()`, `crearAprendiz()`, `programarHorario()`, `consultarAmbientes()`.
- **Interfaces Requeridas:**
  - `IFichaRepository`, `IHorarioRepository`, `IAuditoriaService`.
- **Clases que agrupa:** `FichaService`, `HorarioService`, `AmbienteService`, `FichaRepository`, `HorarioRepository`.
- **Requisitos que atiende:** `RF-SAB-006` a `RF-SAB-016`, `RF-SAB-065` a `RF-SAB-068`, `RF-SAB-085` a `RF-SAB-088`.

---

### Componente 3: `COMP-03 Gestión de Sesiones y QR Dinámico`
- **Interfaces Provistas:**
  - `ISesionService`: Métodos `abrirSesion(ficha, ambiente)`, `cerrarSesion(id)`, `obtenerQRCodigo(id)`.
- **Interfaces Requeridas:**
  - `ISesionRepository`: Persistencia de estados de sesión.
  - `ITokenQRGenerator`: Generador criptográfico de tokens rotativos y códigos manuales temporales.
- **Clases que agrupa:** `SesionService`, `TokenQRManager`, `SesionRepository`.
- **Requisitos que atiende:** `RF-SAB-018` a `RF-SAB-023`, `RF-SAB-055`, `RF-SAB-056`, `RF-SAB-071`.

---

### Componente 4: `COMP-04 Verificación de Identidad (Strategy Pattern)`
- **Interfaces Provistas:**
  - `IIdentidadService`: Método `verificar(desafio, respuesta, modalidad)`.
- **Interfaces Requeridas:**
  - `IEstrategiaVerificacion`: Interfaz de polimorfismo implementada por los adaptadores concretos.
- **Clases que agrupa:** `IdentidadService`, `VerificacionWebAuthnStrategy`, `VerificacionFacialStrategy`, `VerificacionManualStrategy`.
- **Requisitos que atiende:** `RF-SAB-024` a `RF-SAB-028`, `RF-SAB-057`, `RF-SAB-058`, `RF-SAB-062`, `RF-SAB-064`, `RF-SAB-070`.

---

### Componente 5: `COMP-05 Registro de Asistencia y Contingencias (Facade Pattern)`
- **Interfaces Provistas:**
  - `IAsistenciaService`: Métodos `registrarMarcacion(codigo, identidad)`, `registrarContingenciaManual(motivo)`, `cancelarSesion(soporte)`.
- **Interfaces Requeridas:**
  - `ISesionService`, `IIdentidadService`, `IAsistenciaRepository`, `IIncidenciaService`.
- **Clases que agrupa:** `AsistenciaFacade`, `AsistenciaService`, `IncidenciaService`, `AsistenciaRepository`, `IncidenciaRepository`.
- **Requisitos que atiende:** `RF-SAB-029` a `RF-SAB-039`, `RF-SAB-059` a `RF-SAB-063`, `RF-SAB-079`, `RF-SAB-080`.

---

### Componente 6: `COMP-06 Reportes, Auditoría y Exportación`
- **Interfaces Provistas:**
  - `IReporteService`: Métodos `generarReporteSesion(id)`, `exportarPDF(id)`, `exportarXLSX(id)`.
  - `IAuditoriaService`: Método `registrarEvento(actor, operacion, recurso, resultado)`.
- **Interfaces Requeridas:**
  - `IAsistenciaRepository`, `IBitacoraRepository`, bibliotecas generadoras `ReportLab` (PDF) y `OpenPyXL` (XLSX).
- **Clases que agrupa:** `ReporteService`, `AuditoriaService`, `PDFExporterAdapter`, `XLSXExporterAdapter`, `BitacoraRepository`.
- **Requisitos que atiende:** `RF-SAB-044` a `RF-SAB-054`, `RF-SAB-075`, `RF-SAB-089` a `RF-SAB-094`.

---

## 3. Matriz de Dependencias entre Componentes

| Componente Origen | Depende de (Componente Destino) | Interfaz que consume | Justificación |
|---|---|---|---|
| `COMP-05 Asistencia` | `COMP-03 Sesiones` | `ISesionService` | Revalidar que la sesión esté activa y que el código QR/manual sea válido antes de asentar la marca. |
| `COMP-05 Asistencia` | `COMP-04 Identidad` | `IIdentidadService` | Ejecutar la verificación de credencial WebAuthn o cotejo facial en el servidor. |
| `COMP-05 Asistencia` | `COMP-06 Auditoría` | `IAuditoriaService` | Dejar constancia inmutable en bitácora de cada marcación ordinaria o manual de contingencia. |
| `COMP-01 Autenticación` | `COMP-06 Auditoría` | `IAuditoriaService` | Auditar inicios de sesión fallidos, bloqueos y restablecimientos. |
| `COMP-02 Gestión Académica` | `COMP-06 Auditoría` | `IAuditoriaService` | Auditar altas de aprendices, reasignación de instructores líderes y cambios de horario. |
