# Justificación del Diagrama de Casos de Uso UML (SAB)

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001`  
**Archivos del diagrama:**
- Fuente editable: [`03-diagrama-casos-de-uso.drawio`](./03-diagrama-casos-de-uso.drawio)
- Imagen vectorial: [`03-diagrama-casos-de-uso.svg`](./03-diagrama-casos-de-uso.svg)
- Imagen PNG: [`03-diagrama-casos-de-uso.png`](./03-diagrama-casos-de-uso.png)

---

## 1. Actores y frontera del sistema

- **Frontera del sistema:** `Sistema de Asistencia Biométrica (SAB)`.
- **Actores primarios (izquierda, fuera de la frontera):** `Aprendiz`, `Instructor líder`, `Coordinador`, `Administrador`.
- **Actor secundario (derecha, fuera de la frontera):** `Servicio biométrico` (proveedor/SDK externo o local que recibe solicitudes de enrolamiento, cotejo y supresión de plantillas).

---

## 2. Justificación de relaciones `«include»` y `«extend»`

| Tipo | Origen → Destino | Punto de extensión / condición | Justificación (1 línea por relación) |
|---|---|---|---|
| `«include»` | `CU-08 Registrar asistencia ordinaria` → `CU-06 Verificar huella biométrica` | Obligatorio en cada marcación | Según `RN-03` y `RF-BIO-025`, toda asistencia ordinaria exige primero una verificación biométrica exitosa. |
| `«include»` | `CU-08 Registrar asistencia ordinaria` → `CU-07 Escanear código QR` | Obligatorio tras validar huella | Según `RN-03` y `RF-BIO-026`, la marcación ordinaria solo concluye al validar el código QR vigente de la sesión. |
| `«extend»` | `CU-09 Escalar intento sospechoso` → `CU-06 Verificar huella biométrica` | `[intentos fallidos >= 3]` | Según `RN-05` y `RF-BIO-028`, solo se dispara si el aprendiz supera el límite de 3 intentos fallidos durante la verificación. |
| `«extend»` | `CU-11 Registrar asistencia manual` → `CU-08 Registrar asistencia ordinaria` | `[fallo de lector, energía o red]` | Según `RN-07` y `RF-BIO-036`, es un mecanismo excepcional que solo se activa cuando el flujo biométrico-QR regular no está disponible. |
| `«extend»` | `CU-12 Cancelar sesión por contingencia` → `CU-05 Abrir sesión de asistencia` | `[contingencia impide dictar clase]` | Según `RN-08` y `RF-BIO-038`, extiende el ciclo de la sesión abierta únicamente cuando ocurre una causa de fuerza mayor con soporte. |
| `«extend»` | `CU-16 Reasignar líder de ficha` → `CU-02 Administrar fichas y liderazgo` | `[cambio de responsable de ficha]` | Según `RN-02` y `RF-BIO-009`, ocurre de manera condicional sobre la gestión de fichas cuando se requiere transferir liderazgo con auditoría. |

> **Nota de notación:** En `«include»`, la flecha apunta del caso base al caso incluido; en `«extend»`, la flecha apunta del caso que extiende hacia el caso base.
