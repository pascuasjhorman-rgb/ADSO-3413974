# Modelo de Dominio (Conceptual) · SAB

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001` (sección 7.7)  
**Autor:** `@pascuasjhorman-rgb`  
**Archivos del diagrama:**
- Fuente editable: [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio)
- Imágenes: [`03-modelo-dominio.png`](./03-modelo-dominio.png) · [`03-modelo-dominio.svg`](./03-modelo-dominio.svg)

---

## Convenciones aplicadas
- **Nivel conceptual puro:** representa conceptos del negocio del SENA y sus **atributos de negocio**; **no incluye métodos**, tipos de columnas SQL ni claves foráneas técnicas (`id_*`).
- **Generalización:** `Aprendiz` e `Instructor` son especializaciones de `Usuario` (heredan documento, nombre y estado de cuenta).
- **Multiplicidades:** todas las asociaciones indican multiplicidad en ambos extremos, coherentes con las reglas `RN-01`–`RN-12` y las plantillas extendidas de casos de uso.

## Catálogo de clases conceptuales (11 clases)

| Clase conceptual | Atributos de negocio | Regla / relación clave |
|---|---|---|
| `Sede` | `nombreSede`, `ciudad`, `estadoSede` | Agrupa de `1..*` fichas institucionales. |
| `Usuario` | `numeroDocumento`, `nombreCompleto`, `correoInstitucional`, `estadoCuenta` | Superclase de `Aprendiz` e `Instructor`. |
| `Aprendiz` | `codigoMatricula`, `estadoAcademico`, `fechaIngreso` | Especializa a `Usuario`; pertenece a `1..*` `Ficha` (vía `VinculacionFicha`). |
| `Instructor` | `especialidad`, `esLiderFicha`, `estadoVinculacion` | Especializa a `Usuario`; lidera `0..*` `Ficha` y abre `0..*` `SesionFormacion`. |
| `Ficha` | `codigoFicha`, `programaFormacion`, `jornada`, `estadoFicha` | Pertenece a `1` `Sede`; tiene `1..*` vinculaciones de aprendizaje. |
| `VinculacionFicha` | `fechaVinculacion`, `estadoVinculacion`, `fechaRetiro` | **Clase de asociación** entre `Aprendiz` y `Ficha` (conserva trazabilidad histórica `RF-BIO-016`). |
| `PlantillaBiometrica` | `referenciaProtegida`, `fechaConsentimiento`, `estadoVigencia` | `0..1` por `Aprendiz`; exige consentimiento previo (`RN-11`, `RF-BIO-051`) y se suprime al egreso (`RF-BIO-052`). |
| `SesionFormacion` | `fechaApertura`, `fechaCierre`, `estadoSesion`, `motivoContingencia` | Pertenece a `1` `Ficha` y es dirigida por `1` `Instructor`. |
| `TokenQR` | `codigoTemporal`, `fechaEmision`, `fechaExpiracion`, `estadoVigencia` | `1..*` emitidos por cada `SesionFormacion` (`RN-04`). |
| `RegistroAsistencia` | `estadoAsistencia`, `origenRegistro`, `marcaTiempo`, `justificacionManual` | Único por par `Aprendiz`–`SesionFormacion` (`RN-06`). |
| `Incidencia` | `tipoIncidencia`, `intentosFallidos`, `estadoResolucion`, `decisionInstructor` | Generada en `SesionFormacion` respecto a un `Aprendiz` (`RN-05`). |
| `Excusa` | `fechaAusencia`, `tipoExcusa`, `observacion`, `rutaSoporte`, `estadoRecepcion` | Radicada por `Aprendiz` para una `SesionFormacion` (`RN-09`). |
