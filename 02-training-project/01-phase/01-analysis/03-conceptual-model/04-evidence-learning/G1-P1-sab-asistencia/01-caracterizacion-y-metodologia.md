# Caracterización de la solución, comparación y selección de metodología

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001`  
**Autor:** `@pascuasjhorman-rgb`

---

## 1. Caracterización de la solución

Para determinar la metodología de desarrollo más adecuada para SAB, se caracterizó el proyecto a partir de las condiciones reales documentadas en el SRS (`SRS-SAB-001`, secciones 1.5, 1.6, 2.3 y Anexo A):

| Aspecto | Caracterización del proyecto SAB | Implicación metodológica |
|---|---|---|
| **1. Tipo de proyecto** | Aplicación web cliente-servidor de alcance institucional (SENA / sedes Comercio e Industria de Neiva, escalable a otras sedes) con **integración de hardware/SDK biométrico** externo y generación/validación de códigos QR dinámicos. | Requiere validar tempranamente riesgos técnicos (SDK de huella, tiempos reales de QR) mediante entregas incrementales y contratos claros entre módulos. |
| **2. Tamaño del equipo** | **Equipo pequeño de 3 aprendices** (desarrollo, análisis y pruebas compartidos en la ficha 3413974). | No soporta burocracia documental pesada ni roles excesivamente fragmentados; necesita ceremonias ágiles y coordinación directa. |
| **3. Estabilidad de requisitos** | **Media-baja (evolutiva):** el núcleo funcional está definido (54 RF y 18 CU), pero hay parámetros y restricciones técnicas pendientes de validación empírica (rotación QR 15 s, ventana 10 s, 3 intentos, SDK biométrico compatible, política institucional de retención biométrica). | Exige ciclos iterativos cortos que permitan ajustar parámetros y reglas tras pruebas piloto sin rehacer todo el análisis. |
| **4. Disponibilidad del cliente / usuarios** | **Alta y periódica:** el instructor académico, el instructor líder de ficha y la coordinación están disponibles semanalmente en el ambiente de formación para revisar avances, validar prototipos y aprobar criterios de aceptación. | Favorece revisiones frecuentes (sprint reviews) con retroalimentación temprana sobre pantallas y flujos reales de clase. |

---

## 2. Comparación de metodologías de desarrollo

Se compararon **4 metodologías** (Scrum, XP, RUP y RAD) evaluándolas frente a criterios derivados directamente de las 4 características del proyecto SAB:

| Criterio (derivado de la caracterización) | **Scrum** | **XP (Extreme Programming)** | **RUP (Rational Unified Process)** | **RAD (Rapid Application Development)** |
|---|---|---|---|---|
| **Adecuación a equipo pequeño (3 personas)** | **Alta.** Roles ligeros (Product Owner representado con el instructor, Scrum Master rotativo, Dev Team de 3). | **Alta.** Pensado para equipos pequeños (2–10), aunque exige disciplina estricta en programación en parejas continua. | **Baja-Media.** Diseñado para equipos medianos/grandes; genera alta sobrecarga de artefactos y roles formales. | **Media-Alta.** Funciona en equipos pequeños, pero orienta más a prototipado rápido de UI que a seguridad biométrica. |
| **Manejo de estabilidad media-baja de requisitos y parámetros pendientes** | **Alta.** Sprints de 1–2 semanas con Product Backlog priorizado; permite recalibrar parámetros (15 s / 10 s / 3 intentos) entre sprints. | **Alta.** Iteraciones muy cortas (1 semana) y refactorización continua; menos énfasis en documentación de trazabilidad institucional. | **Media.** Maneja riesgos en fase de Elaboración, pero los cambios frecuentes en requisitos requieren control formal costoso. | **Media.** Bueno para ajustar pantallas rápido, pero débil cuando cambian reglas de negocio de seguridad y auditoría. |
| **Aprovechamiento de la disponibilidad periódica del cliente (instructor/coordinación)** | **Alta.** *Sprint Review* al final de cada iteración permite validar flujos reales de toma de asistencia y reportes. | **Alta.** Supone cliente *in situ* casi permanente (difícil cubrir disponibilidad diaria continua del coordinador). | **Media.** Validación concentrada al cierre de hitos de fase (Inicio, Elaboración, Construcción). | **Alta.** Talleres intensivos JAD con usuarios para prototipos rápidos. |
| **Soporte para riesgo técnico (SDK biométrico, seguridad Ley 1581 y trazabilidad SENA)** | **Media-Alta.** Permite *spikes* técnicos en los primeros sprints para certificar lector/SDK y mantener trazabilidad ligera. | **Media.** Excelente calidad técnica (TDD, integración continua), pero débil en artefactos formales exigidos por SENA (SRS, bitácoras, políticas). | **Alta.** Fuerte en arquitectura, casos de uso y control de riesgos, aunque lento para el plazo académico. | **Baja.** Prioriza velocidad visual sobre arquitectura, seguridad biométrica y pruebas rigurosas. |

---

## 3. Metodología seleccionada y justificación

**Metodología seleccionada:** **Scrum** (complementada explícitamente en ingeniería con prácticas puntuales de XP: pruebas automatizadas de regresión y criterios de aceptación verificables por historia/requisito).

### Justificación frente a las 4 características de SAB
1. **Equipo pequeño (3 integrantes):** Scrum elimina la sobrecarga administrativa de RUP (múltiples comités y documentos redundantes) y organiza el trabajo semanal con transparencia mediante el *Product Backlog*, *Sprint Backlog* y tableros de seguimiento.
2. **Requisitos con parámetros por validar (estabilidad media-baja):** Al dividir el trabajo en *Sprints* cortos (por ejemplo, de 1 o 2 semanas), el equipo puede validar primero los módulos de mayor riesgo (*spike* del lector biométrico y flujo QR-huella) y ajustar los umbrales de 15 s, 10 s y 3 intentos sin afectar módulos ya estabilizados.
3. **Disponibilidad periódica del cliente:** El instructor líder y el coordinador no están dedicados tiempo completo como exige XP clásico (*on-site customer*), pero sí asisten periódicamente a las sesiones de formación; esto encaja exactamente con la ceremonia de **Sprint Review** para inspeccionar incrementos funcionales (toma de asistencia, contingencia, excusas y exportación PDF/XLSX).
4. **Tipo de proyecto (web + biometría + normatividad de datos):** A diferencia de RAD, Scrum permite planear historias técnicas de seguridad (`RNF-BIO-001` a `RNF-BIO-006`, cumplimiento Ley 1581 de 2012) con su *Definition of Done* (DoD), garantizando entregables verificables y trazables para el entorno SENA.
