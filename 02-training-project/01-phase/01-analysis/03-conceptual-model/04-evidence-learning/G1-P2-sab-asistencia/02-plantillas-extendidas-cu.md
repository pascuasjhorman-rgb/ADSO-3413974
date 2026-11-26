# Plantillas Extendidas de Casos de Uso (Anexo A) · SAB

**Proyecto:** Sistema de Asistencia Biométrica (SAB) · **Referencia:** `SRS-SAB-001`  
**Autor:** `@pascuasjhorman-rgb`  
**Base reutilizada:** Especificaciones textuales resumidas de la sección 6.3 de `SRS-SAB-001`, ampliadas al formato completo del Anexo A sin incluir detalles técnicos de implementación (sin nombres de tablas, SQL ni endpoints).

---

## 1. `CU-08` · Registrar asistencia ordinaria

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | `CU-08` · Registrar asistencia ordinaria |
| **Requisitos que atiende** | `RF-BIO-024`, `RF-BIO-025`, `RF-BIO-026`, `RF-BIO-027`, `RF-BIO-028`, `RF-BIO-029`, `RF-BIO-030` |
| **Actor primario / secundarios** | Primario: `Aprendiz` · Secundario: `Servicio biométrico` |
| **Objetivo del actor** | Registrar su asistencia válida a una sesión de formación activa mediante doble verificación (huella y QR). |
| **Precondiciones** | El aprendiz tiene sesión iniciada con cuenta activa, está vinculado a la ficha, aceptó el aviso de tratamiento de datos y cuenta con plantilla biométrica enrolada; existe al menos una sesión abierta en su ficha. |
| **Disparador** | El aprendiz selecciona la sesión activa y solicita iniciar la marcación de asistencia. |
| **Flujo principal** | 1. El aprendiz selecciona la sesión activa de su ficha para registrar asistencia.<br>2. El sistema verifica que el aprendiz no tenga ya una asistencia válida para esa sesión e inicia el conteo de intentos disponibles (máximo 3).<br>3. El sistema solicita al aprendiz capturar su huella y envía la muestra al servicio biométrico para cotejo.<br>4. El servicio biométrico confirma coincidencia de identidad y el sistema habilita la lectura del código QR con una ventana de tiempo vigente.<br>5. El aprendiz escanea el código QR proyectado por el instructor en el ambiente.<br>6. El sistema comprueba que el código QR pertenece a la sesión activa y se encuentra dentro de su intervalo de vigencia.<br>7. El sistema registra la asistencia con estado «Presente», origen «Ordinaria» y marca de tiempo, deja constancia en auditoría y muestra confirmación al aprendiz. |
| **Flujos alternos** | **3a.** *Si falla el cotejo de huella pero el aprendiz aún tiene intentos disponibles (menos de 3):* el sistema informa fallo genérico de verificación, incrementa el contador de intentos y permite reintentar desde el paso 3.<br>**6a.** *Si el código QR expiró por cambio de rotación mientras restan intentos:* el sistema informa que el código venció, incrementa el contador de intentos y permite escanear el nuevo QR proyectado en el paso 5.<br>**2a.** *Si el método biométrico o la red no están disponibles:* el instructor puede activar el flujo extendido de asistencia manual de contingencia (`CU-11`). |
| **Excepciones** | **3b.** *Si el aprendiz alcanza el límite de 3 intentos fallidos:* el sistema bloquea el proceso ordinario para esa sesión, crea automáticamente una incidencia sospechosa, notifica al instructor líder y finaliza sin registrar asistencia.<br>**2b.** *Si ya existe una asistencia válida previa del mismo aprendiz en esa sesión:* el sistema rechaza la operación informando registro previo y evita duplicados.<br>**3c.** *Si el servicio biométrico reporta error técnico del dispositivo:* el sistema informa indisponibilidad temporal sin exponer datos biométricos y termina el intento. |
| **Postcondiciones** | Queda registrada una única asistencia ordinaria válida para el aprendiz en la sesión, o se genera la incidencia correspondiente si se agotaron los intentos. |
| **Reglas de negocio** | `RN-03` (doble validación huella + QR), `RN-04` (rotación QR 15 s y ventana 10 s), `RN-05` (máximo 3 intentos), `RN-06` (sin asistencias duplicadas). |
| **Pantalla del prototipo** | [`PANT-02 · Marcación de Asistencia (Aprendiz)`](./05-prototipo-pantallas.md#pant-02) |

---

## 2. `CU-05` · Abrir sesión de asistencia

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | `CU-05` · Abrir sesión de asistencia |
| **Requisitos que atiende** | `RF-BIO-018`, `RF-BIO-019`, `RF-BIO-020`, `RF-BIO-021` |
| **Actor primario / secundarios** | Primario: `Instructor líder` · Secundarios: ninguno |
| **Objetivo del actor** | Habilitar una sesión de formación para una ficha autorizada y proyectar un código QR dinámico para la toma de asistencia. |
| **Precondiciones** | El instructor inició sesión con cuenta activa y tiene al menos una ficha asignada. |
| **Disparador** | El instructor ingresa al panel de sesiones y presiona la opción para abrir una nueva sesión. |
| **Flujo principal** | 1. El instructor selecciona una de sus fichas autorizadas y confirma la apertura de sesión.<br>2. El sistema valida que el instructor sea responsable de la ficha y verifica si existen sesiones abiertas incompatibles.<br>3. El sistema crea la sesión con identificador único, fecha/hora de apertura y estado «Activa».<br>4. El sistema genera el primer código QR único vinculado exclusivamente a la sesión activa.<br>5. El sistema proyecta el código QR en la vista del instructor con indicador visual de vigencia.<br>6. Cada vez que se cumple el intervalo de rotación configurado, el sistema invalida el código anterior y emite uno nuevo automáticamente.<br>7. El sistema deja disponible la sesión para que los aprendices inicien su marcación y registra la apertura en auditoría. |
| **Flujos alternos** | **1a.** *Si el instructor desea consultar sesiones anteriores antes de abrir una nueva:* el sistema muestra el listado filtrado por ficha, fecha y estado sin abrir sesión aún.<br>**5a.** *Si ocurre una contingencia que impide continuar la clase:* el instructor puede activar la cancelación de sesión con soporte (`CU-12`). |
| **Excepciones** | **2a.** *Si ya existe una sesión activa superpuesta y la política de la ficha la prohíbe:* el sistema impide la apertura, muestra el detalle de la sesión abierta y cancela la operación.<br>**2b.** *Si la ficha no pertenece al instructor o fue desactivada:* el sistema deniega la acción y registra el intento no autorizado. |
| **Postcondiciones** | La sesión queda en estado «Activa» con rotación automática de código QR vigente y lista para recibir asistencias. |
| **Reglas de negocio** | `RN-04` (rotación periódica del QR), `RN-12` (auditoría de eventos de sesión). |
| **Pantalla del prototipo** | [`PANT-01 · Panel de Sesión y QR Dinámico (Instructor)`](./05-prototipo-pantallas.md#pant-01) |

---

## 3. `CU-11` · Registrar asistencia manual de contingencia

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | `CU-11` · Registrar asistencia manual de contingencia |
| **Requisitos que atiende** | `RF-BIO-034`, `RF-BIO-036`, `RF-BIO-037`, `RF-BIO-039`, `RF-BIO-050` |
| **Actor primario / secundarios** | Primario: `Instructor líder` · Secundarios: ninguno |
| **Objetivo del actor** | Registrar digitalmente la asistencia de los aprendices cuando el lector biométrico, la red o la energía impiden el flujo ordinario. |
| **Precondiciones** | El instructor inició sesión con permisos sobre la ficha y existe una sesión activa (o autorizada para registro de contingencia). |
| **Disparador** | El instructor detecta indisponibilidad del método regular y selecciona «Activar registro manual de contingencia». |
| **Flujo principal** | 1. El instructor selecciona el tipo de novedad operativa (fallo de lector, conectividad o energía) y describe la causa de la contingencia.<br>2. El sistema valida los permisos del instructor sobre la ficha y muestra la lista completa de aprendices vinculados.<br>3. El instructor marca el estado de asistencia de cada aprendiz (Presente, Tarde o Ausente) en la pantalla.<br>4. El instructor confirma y guarda la planilla manual de contingencia.<br>5. El sistema valida que la causa y el responsable estén diligenciados y que no se generen duplicados por aprendiz.<br>6. El sistema almacena cada registro con marca explícita de origen «Manual de contingencia», fecha, hora y responsable.<br>7. El sistema registra la operación en la bitácora de auditoría (conservando valor anterior y nuevo si corrige un registro) y confirma al instructor. |
| **Flujos alternos** | **1a.** *Si la falla impide por completo continuar la jornada formativa:* el instructor elige cancelar la sesión por contingencia (`CU-12`) adjuntando motivo y soporte.<br>**3a.** *Si algunos aprendices ya habían marcado por biometría y QR antes de la falla:* el sistema muestra esos registros como «Ordinaria» bloqueados contra duplicado y permite marcar solo a los restantes. |
| **Excepciones** | **5a.** *Si el instructor intenta guardar sin indicar motivo de contingencia:* el sistema rechaza el guardado y resalta el campo obligatorio.<br>**2a.** *Si un usuario sin rol autorizado intenta modificar una asistencia previa:* el sistema deniega la modificación y registra alerta de seguridad. |
| **Postcondiciones** | Los registros manuales quedan guardados con origen distinguible «Manual» en reportes y completamente trazados en auditoría. |
| **Reglas de negocio** | `RN-06` (unicidad por sesión y aprendiz), `RN-07` (motivo y auditoría obligatorios), `RN-12` (bitácora de modificaciones). |
| **Pantalla del prototipo** | [`PANT-03 · Contingencia Manual y Gestión de Excusas`](./05-prototipo-pantallas.md#pant-03) |

---

## 4. `CU-13` · Enviar excusa con soporte

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | `CU-13` · Enviar excusa con soporte |
| **Requisitos que atiende** | `RF-BIO-040`, `RF-BIO-041`, `RF-BIO-043` |
| **Actor primario / secundarios** | Primario: `Aprendiz` · Secundarios: ninguno |
| **Objetivo del actor** | Radicar una justificación con archivo de soporte asociada a una fecha o sesión específica para revisión del instructor. |
| **Precondiciones** | El aprendiz tiene sesión iniciada con cuenta activa y está vinculado a la ficha correspondiente a la fecha o sesión. |
| **Disparador** | El aprendiz ingresa a su historial de asistencias o sección de excusas y selecciona «Enviar excusa». |
| **Flujo principal** | 1. El aprendiz selecciona la fecha o sesión de inasistencia o retraso que desea justificar.<br>2. El aprendiz elige el tipo de excusa, redacta la explicación y adjunta el archivo de soporte.<br>3. El sistema verifica el formato y tamaño permitido del archivo adjunto y comprueba que la sesión corresponda al aprendiz.<br>4. El sistema almacena la excusa en estado inicial «Pendiente» y protege el acceso al adjunto únicamente para los roles autorizados.<br>5. El sistema vincula la excusa al historial propio del aprendiz y la deja visible en la bandeja del instructor líder de la ficha.<br>6. El sistema confirma al aprendiz el radicado con fecha y hora de envío. |
| **Flujos alternos** | **2a.** *Si la excusa corresponde a un motivo que aún no cuenta con soporte adjunto opcional según política:* el sistema permite radicar el texto dejando constancia «Sin soporte adjunto» cuando la regla lo admita.<br>**6a.** *Si el aprendiz consulta posteriormente sus excusas:* el sistema muestra sus radicados propios y su estado («Pendiente» o «Recibida») sin permitir ver excusas de otros aprendices. |
| **Excepciones** | **3a.** *Si el archivo adjunto supera el tamaño máximo o tiene un formato no permitido:* el sistema rechaza la carga, no publica ni almacena el archivo y solicita un formato válido.<br>**3b.** *Si el aprendiz intenta asociar la excusa a una sesión o ficha ajena:* el sistema bloquea la operación por control de acceso. |
| **Postcondiciones** | La excusa queda registrada con estado «Pendiente» asociada al aprendiz y la sesión, disponible para confirmación de recepción por el instructor (`CU-14`). |
| **Reglas de negocio** | `RN-09` (enviar excusa y confirmar recepción no implican aprobación automática). |
| **Pantalla del prototipo** | [`PANT-03 · Contingencia Manual y Gestión de Excusas`](./05-prototipo-pantallas.md#pant-03) |
