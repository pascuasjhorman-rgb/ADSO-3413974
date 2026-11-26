# Diagramas de Actividades UML · Casos de Uso Críticos (SAB)

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001`  
**Autor:** `@pascuasjhorman-rgb`  
**Base reutilizada:** Flujos textuales de la sección 7 de `SRS-SAB-001` y experiencia previa con flujos BPMN en `03-execute/22-week/02-optional-activity/diagram_1.bpmn`–`diagram_5.bpmn`, adaptados y rediseñados en notación **UML de Diagramas de Actividades** para los procesos críticos de SAB.

---

## 1. Diagrama de Actividades 1 · `CU-08 Registrar asistencia ordinaria` (Huella + QR)

- **Fuente editable:** [`01-actividad-asistencia-ordinaria.drawio`](./01-actividad-asistencia-ordinaria.drawio)
- **Imágenes:** [`01-actividad-asistencia-ordinaria.png`](./01-actividad-asistencia-ordinaria.png) · [`01-actividad-asistencia-ordinaria.svg`](./01-actividad-asistencia-ordinaria.svg)
- **Calles (swimlanes):** `Aprendiz` | `Sistema SAB` | `Servicio biométrico`
- **Decisiones y guardas (cubren todas las salidas):**
  1. `¿Coincide huella?`: `[huella coincide]` / `[huella no coincide]`
  2. `¿Límite de intentos alcanzado?`: `[intentos < 3]` / `[intentos >= 3]`
  3. `¿QR vigente y de la sesión?`: `[QR válido y en ventana <= 10 s]` / `[QR vencido o de otra sesión]`
  4. `¿Asistencia previa registrada?`: `[sin asistencia previa]` / `[ya existe asistencia]`
- **Nota de concurrencia:** Este flujo es secuencial por regla de negocio (`RN-03` y `RF-BIO-025`: la lectura QR solo se habilita tras verificar la huella), por lo que no requiere nodos de bifurcación/unión (*fork/join*) dentro de la marcación individual del aprendiz.

---

## 2. Diagrama de Actividades 2 · `CU-11 / CU-12 Contingencia y cierre de sesión`

- **Fuente editable:** [`01-actividad-contingencia-sesion.drawio`](./01-actividad-contingencia-sesion.drawio)
- **Imágenes:** [`01-actividad-contingencia-sesion.png`](./01-actividad-contingencia-sesion.png) · [`01-actividad-contingencia-sesion.svg`](./01-actividad-contingencia-sesion.svg)
- **Calles (swimlanes):** `Instructor líder` | `Sistema SAB`
- **Decisiones y guardas (cubren todas las salidas):**
  1. `¿Es viable asistencia manual digital?`: `[viable registro manual]` / `[no es viable; cancelar clase]`
  2. `¿Soporte y motivo válidos?`: `[datos completos]` / `[faltan motivo o soporte]`
- **Concurrencia (`fork` / `join`):** Cuando se cierra o consolida la sesión de contingencia, el sistema ejecuta en paralelo la generación de reportes (`PDF` y `XLSX`) y el envío de notificación de estado a los aprendices de la ficha, sincronizando ambos hilos antes de finalizar el flujo.

> Todas las ramas alternas y de excepción de ambos diagramas están reflejadas en [`02-plantillas-extendidas-cu.md`](./02-plantillas-extendidas-cu.md).
