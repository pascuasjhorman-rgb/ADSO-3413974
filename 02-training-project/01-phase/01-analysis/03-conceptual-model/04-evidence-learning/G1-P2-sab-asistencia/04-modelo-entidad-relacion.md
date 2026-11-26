# Modelo Entidad-Relación (MER) · SAB

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001` (sección 7.7)  
**Autor:** `@pascuasjhorman-rgb`  
**Notación declarada:** **Pata de gallo (Crow's Foot)** con representación explícita de identificadores (`PK`), cardinalidad mínima/máxima y participación (línea continua / doble barra = participación obligatoria `1`; círculo `O` = participación opcional `0`).  
**Archivos del diagrama:**
- Fuente editable: [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio)
- Imágenes: [`04-modelo-entidad-relacion.png`](./04-modelo-entidad-relacion.png) · [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg)

---

## Elementos obligatorios verificados
1. **Cantidad de entidades:** **10 entidades** (`SEDE`, `USUARIO`, `FICHA`, `VINCULACION_FICHA`, `PLANTILLA_BIOMETRICA`, `SESION_FORMACION`, `TOKEN_QR`, `ASISTENCIA`, `INCIDENCIA`, `EXCUSA` + `BITACORA_AUDITORIA` = 11 entidades en total).
2. **Relación N:M resuelta con entidad asociativa con atributos propios:** Un usuario/aprendiz puede estar vinculado históricamente a varias fichas y una ficha agrupa varios aprendices (`N:M`); se resuelve con la entidad asociativa **`VINCULACION_FICHA`** con atributos propios `fecha_vinculacion`, `rol_en_ficha`, `estado_vinculacion` y `fecha_retiro` (`RF-BIO-009`, `RF-BIO-016`).
3. **Entidades débiles:**
   - **`TOKEN_QR`** es una entidad débil dependiente de identificación de **`SESION_FORMACION`** (un token QR no tiene existencia ni sentido fuera de la sesión a la que pertenece; `RF-BIO-020`).
   - **`PLANTILLA_BIOMETRICA`** depende existencialmente de **`USUARIO`** (un aprendiz tiene `0..1` plantilla protegida que se elimina al egreso; `RF-BIO-052`).
4. **Reglas de unicidad del negocio:** `ASISTENCIA` garantiza unicidad compuesta por `(id_sesion, id_usuario)` (`RN-06`).
