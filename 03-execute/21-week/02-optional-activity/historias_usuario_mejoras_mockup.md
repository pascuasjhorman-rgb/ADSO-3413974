# Historias de usuario y propuestas de mejora – Mockup de Gestión de Horarios SENA

## 1. Introducción

Este documento presenta una revisión del mockup de Gestión de Horarios del SENA desde el punto de vista de un usuario que interactúa con el sistema. También se tomó como referencia la página oficial del SENA sobre el Sistema Integrado de Gestión y Autocontrol (SIGA).

La intención de este trabajo **no es decir que el sistema está mal diseñado**, sino identificar pequeños cambios que podrían hacer que la navegación sea más clara, la información más fácil de encontrar y que se reduzcan pasos o pantallas que cumplen funciones muy parecidas.

No se revisaron las pantallas una por una. En cambio, se analizó el sistema por rol, pensando en qué necesita realmente cada tipo de usuario y qué podría hacerle más fácil la experiencia.

Las propuestas se presentan como historias de usuario, organizadas por los roles que aparecen en el mockup: Aprendiz, Instructor, Coordinador Académico, Director de Centro, Administrador/Soporte y Parametrización.

---

# 2. Rol: Aprendiz

El aprendiz necesita sobre todo consultar su información académica de forma rápida: horarios, ambientes y posibles cambios.

## HU-01 – Consultar el horario

**Como aprendiz, quiero consultar mi horario de manera sencilla, para saber rápidamente qué clase tengo, a qué hora y en qué ambiente.**

- **Qué cambiaría/agregaría:** Que la opción de horario sea de las primeras que se encuentran al entrar, y que muestre primero el día, la hora, el ambiente y el instructor.
- **Por qué:** Es la información que el aprendiz revisa con más frecuencia, así que no debería tomar varios pasos llegar a ella.
- **Beneficio esperado:** El aprendiz encuentra su horario casi de inmediato, sin tener que buscar entre varias opciones.

## HU-02 – Recibir avisos de cambios

**Como aprendiz, quiero recibir una notificación cuando se modifique mi horario, para enterarme de los cambios antes de asistir a clase.**

- **Qué agregaría:** Una sección de notificaciones donde aparezcan cambios de horario, cancelaciones o modificaciones importantes.
- **Por qué:** Actualmente el aprendiz tendría que revisar el horario completo para darse cuenta de un cambio.
- **Beneficio esperado:** El aprendiz se entera a tiempo y evita llegar a una clase que fue cambiada o cancelada.

## HU-03 – Ver los detalles de una clase

**Como aprendiz, quiero seleccionar una clase de mi horario, para consultar sus datos completos.**

- **Qué cambiaría:** Al seleccionar una clase, mostrar instructor, ambiente, ficha, programa, fecha y duración en un solo lugar.
- **Por qué:** Ahora mismo esta información puede estar repartida o no ser tan visible al primer vistazo.
- **Beneficio esperado:** El aprendiz consulta todos los datos de una clase sin tener que buscar en otras pantallas.

## HU-04 – Filtrar información

**Como aprendiz, quiero poder filtrar mi horario por fecha o programa, para encontrar más rápido la información que necesito.**

- **Qué agregaría:** Filtros sencillos en la pantalla de horario.
- **Por qué:** Sin filtros, el aprendiz tendría que revisar todo el horario para encontrar un dato puntual.
- **Beneficio esperado:** Se ahorra tiempo al consultar información específica.

## HU-05 – Consultar desde el celular

**Como aprendiz, quiero consultar mi horario cómodamente desde el celular, para poder revisarlo cuando no tenga un computador disponible.**

- **Qué cambiaría:** Que la versión móvil muestre primero la información principal y evite elementos que ocupen demasiado espacio en la pantalla.
- **Por qué:** Muchos aprendices probablemente consultan el horario desde el celular más que desde un computador.
- **Beneficio esperado:** Consulta más cómoda y rápida desde cualquier dispositivo.

---

# 3. Rol: Instructor

El instructor necesita consultar sus clases y grupos, y enterarse rápido de cualquier cambio en la programación.

## HU-06 – Consultar las clases del día

**Como instructor, quiero visualizar mis clases organizadas por día y hora, para saber qué actividades debo realizar.**

- **Qué cambiaría:** Usar una vista tipo calendario o una lista ordenada por hora.
- **Por qué:** Facilita ver de un vistazo cómo está distribuido el día, en lugar de tener que interpretar una lista sin orden claro.
- **Beneficio esperado:** El instructor organiza mejor su tiempo y evita confusiones con el orden de sus clases.

## HU-07 – Consultar el grupo

**Como instructor, quiero acceder a la información del grupo desde mi horario, para consultar fácilmente la ficha y los aprendices asignados.**

- **Qué agregaría:** Un botón como "Ver grupo" dentro de la información de cada clase.
- **Por qué:** Evita que el instructor tenga que salir del horario y buscar el grupo en otra parte del sistema.
- **Beneficio esperado:** Acceso más directo a la información del grupo sin pasos adicionales.

## HU-08 – Recibir cambios

**Como instructor, quiero recibir un aviso cuando cambie una clase, para evitar confusiones con los aprendices.**

- **Qué agregaría:** Notificaciones para cambios de ambiente, horario o cancelaciones.
- **Por qué:** Un cambio no informado a tiempo puede generar confusión tanto para el instructor como para los aprendices.
- **Beneficio esperado:** El instructor se entera antes de la clase y puede avisar oportunamente si es necesario.

## HU-09 – Buscar una clase específica

**Como instructor, quiero filtrar mis horarios, para encontrar rápidamente una clase determinada.**

- **Qué cambiaría:** Permitir filtros por fecha, ficha, ambiente o programa.
- **Por qué:** Un instructor con varios grupos puede tardar en encontrar una clase puntual sin filtros.
- **Beneficio esperado:** Menos tiempo buscando y más facilidad para ubicar la información necesaria.

## HU-10 – Consultar ambientes

**Como instructor, quiero consultar la disponibilidad de los ambientes, para conocer los espacios que puedo utilizar.**

- **Qué agregaría:** Una consulta sencilla de ambientes disponibles.
- **Por qué:** Puede ser útil para el instructor saber qué espacios están libres, por ejemplo para actividades adicionales.
- **Beneficio esperado:** Facilita la planeación de actividades fuera del horario habitual.

---

# 4. Rol: Coordinador Académico

El coordinador necesita una visión más amplia de la programación y herramientas para organizarla.

## HU-11 – Consultar programación general

**Como coordinador académico, quiero visualizar los horarios de los diferentes grupos, para tener una visión general de la programación.**

- **Qué cambiaría:** Incluir filtros por programa, ficha, instructor, ambiente y fecha.
- **Por qué:** Con muchos grupos a cargo, revisar todo sin filtros puede ser dispendioso.
- **Beneficio esperado:** El coordinador ubica más rápido la información que necesita revisar.

## HU-12 – Detectar cruces de horarios

**Como coordinador académico, quiero recibir una alerta cuando exista un conflicto de horario, para poder solucionarlo antes de confirmar la programación.**

- **Qué agregaría:** Un mensaje de advertencia cuando dos actividades tengan el mismo ambiente o un horario incompatible.
- **Por qué:** Detectar el cruce a tiempo evita corregirlo después de que ya se haya publicado.
- **Beneficio esperado:** Menos errores de programación y menos correcciones de último momento.

## HU-13 – Modificar un horario

**Como coordinador académico, quiero modificar un horario fácilmente, para solucionar cambios o inconvenientes en la programación.**

- **Qué cambiaría:** Hacer más visible la opción de editar y mostrar una confirmación antes de guardar.
- **Por qué:** Si la opción de editar es difícil de encontrar, se pierde tiempo, y sin confirmación se pueden guardar cambios por error.
- **Beneficio esperado:** Modificaciones más rápidas y con menor riesgo de errores accidentales.

## HU-14 – Consultar ambientes disponibles

**Como coordinador académico, quiero consultar los ambientes disponibles por fecha y hora, para asignarlos correctamente.**

- **Qué agregaría:** Filtros de disponibilidad por fecha y hora.
- **Por qué:** Sin esta consulta, asignar ambientes depende más de la memoria o de revisar manualmente.
- **Beneficio esperado:** Asignaciones más precisas y con menos posibilidad de choques de ambiente.

## HU-15 – Generar reportes

**Como coordinador académico, quiero generar un reporte de la programación, para poder revisar o compartir la información.**

- **Qué agregaría:** Una opción para descargar o generar un reporte.
- **Por qué:** Puede ser necesario compartir la programación con otras personas que no tienen acceso directo al sistema.
- **Beneficio esperado:** Facilita compartir y consultar la información fuera del sistema.

---

# 5. Rol: Director de Centro

Para este rol, las mejoras se enfocan en facilitar la consulta general, sin necesidad de agregar demasiadas funciones nuevas.

## HU-16 – Ver la programación general

**Como director de centro, quiero consultar la programación académica, para conocer cómo están distribuidos los horarios del centro.**

- **Qué cambiaría:** Mostrar un resumen general de programas, fichas, instructores y ambientes.
- **Por qué:** El director necesita una visión completa, no el detalle de cada grupo por separado.
- **Beneficio esperado:** Una idea clara y rápida del estado general de la programación.

## HU-17 – Consultar uso de ambientes

**Como director de centro, quiero conocer la disponibilidad y utilización de los ambientes, para tener una visión general de los espacios.**

- **Qué agregaría:** Una consulta sencilla de ambientes ocupados y disponibles.
- **Por qué:** Ayuda a identificar si los espacios se están aprovechando bien.
- **Beneficio esperado:** Mejor panorama para la toma de decisiones sobre el uso de espacios.

## HU-18 – Consultar información resumida

**Como director de centro, quiero visualizar información resumida de la programación, para conocer rápidamente el estado general.**

- **Qué agregaría:** Indicadores sencillos, como grupos activos, ambientes utilizados e instructores programados.
- **Por qué:** No siempre es necesario entrar al detalle; a veces basta con un resumen general.
- **Beneficio esperado:** Consulta más ágil sin tener que revisar toda la información a fondo.

---

# 6. Rol: Administrador / Soporte

Las funciones de soporte deberían facilitar la búsqueda de usuarios y la atención de problemas.

## HU-19 – Buscar usuarios

**Como administrador de soporte, quiero buscar un usuario rápidamente, para poder revisar su información cuando tenga un problema.**

- **Qué agregaría:** Una barra de búsqueda por nombre, identificación o correo.
- **Por qué:** Sin un buscador, ubicar a un usuario específico puede tomar más tiempo del necesario.
- **Beneficio esperado:** Atención más ágil de los casos que llegan a soporte.

## HU-20 – Consultar solicitudes

**Como administrador de soporte, quiero visualizar los problemas reportados por los usuarios, para atenderlos de manera organizada.**

- **Qué agregaría:** Una sección de solicitudes pendientes, atendidas y en proceso.
- **Por qué:** Ayuda a llevar un orden y no dejar casos sin resolver.
- **Beneficio esperado:** Mejor seguimiento de los casos y menos solicitudes olvidadas.

## HU-21 – Consultar estado de cuenta

**Como administrador de soporte, quiero consultar el estado de una cuenta, para identificar rápidamente problemas de acceso.**

- **Qué cambiaría:** Mostrar la información principal de la cuenta en una sola pantalla.
- **Por qué:** Si esta información está repartida en varias pantallas, se pierde tiempo diagnosticando el problema.
- **Beneficio esperado:** Diagnóstico más rápido y atención más eficiente al usuario.

---

# 7. Parametrización

La parametrización puede mantenerse tal como está en su función, pero algunas opciones podrían organizarse mejor.

## HU-22 – Organizar configuraciones

**Como administrador, quiero encontrar las configuraciones agrupadas por categorías, para poder modificarlas con mayor facilidad.**

- **Qué cambiaría:** Agrupar las opciones relacionadas en lugar de mostrarlas todas juntas.
- **Por qué:** Con muchas opciones sueltas es más fácil perderse o no encontrar la que se necesita.
- **Beneficio esperado:** Configuración más ordenada y fácil de entender, incluso para alguien que no la use todos los días.

## HU-23 – Confirmar cambios importantes

**Como administrador, quiero recibir una confirmación antes de guardar cambios importantes, para evitar modificaciones accidentales.**

- **Qué agregaría:** Un mensaje de confirmación antes de guardar, eliminar o modificar información importante.
- **Por qué:** Un cambio accidental en la parametrización puede afectar a todo el sistema.
- **Beneficio esperado:** Menos errores por descuido y más seguridad al hacer cambios.

## HU-24 – Buscar configuraciones

**Como administrador, quiero buscar una configuración específica, para no tener que revisar todas las opciones manualmente.**

- **Qué agregaría:** Un buscador o filtros dentro del apartado de parametrización.
- **Por qué:** Revisar manualmente todas las opciones es lento, sobre todo si hay muchas.
- **Beneficio esperado:** Se encuentra la configuración deseada en menos tiempo.

---

# 8. Elementos que podrían sobrar o simplificarse

Al revisar un sistema con varios roles y bastantes pantallas, también vale la pena preguntarse si todas necesitan existir como pantallas totalmente independientes. Aquí no se afirma que una pantalla puntual sobre o esté de más, porque eso solo se puede comprobar revisándola a fondo. Lo que se plantea son **tipos** de situaciones donde, en general, se podría simplificar.

## 8.1 Consultas repetidas del horario

Si existen varias pantallas que muestran información parecida del horario (por ejemplo, vistas separadas que en el fondo consultan lo mismo), se podrían unificar en una sola pantalla con filtros.

- **Propuesta:** Una sola pantalla de consulta con filtros por fecha, ficha, instructor, programa o ambiente, según el rol.
- **Beneficio:** El usuario no tendría que entrar y salir de varios apartados para consultar información relacionada.

## 8.2 Pantallas que solo muestran instrucciones

Si una pantalla únicamente explica qué debe hacer el usuario y después lo envía a otra pantalla para realizar la acción, ese paso intermedio podría reducirse.

- **Propuesta:** Poner una explicación corta directamente en la pantalla donde se realiza la acción, en vez de usar una pantalla aparte solo para instrucciones.
- **Beneficio:** Se ahorra un clic y un paso de navegación.

## 8.3 Confirmaciones innecesarias

Las confirmaciones son útiles para acciones importantes, pero si aparecen para cualquier acción pueden volverse molestas.

- **Propuesta:** Reservarlas para eliminar, guardar o modificar información importante, y evitarlas en consultas simples.
- **Beneficio:** Navegación más fluida sin perder la protección en los cambios que sí importan.

## 8.4 Información duplicada entre pantallas

Si dos pantallas muestran prácticamente los mismos datos con pequeñas diferencias, se podría usar una sola pantalla con opciones para elegir qué ver.

- **Propuesta:** Centralizar la consulta y dejar que el usuario seleccione qué información quiere visualizar mediante filtros o pestañas.
- **Beneficio:** Menos pantallas que mantener y menos confusión sobre cuál usar.

## 8.5 Opciones administrativas poco usadas

Algunas opciones de administración pueden ser necesarias, pero no siempre necesitan una pantalla completamente independiente si se usan con poca frecuencia.

- **Propuesta:** Agrupar configuraciones relacionadas dentro de un mismo apartado en lugar de separarlas en distintas pantallas.
- **Beneficio:** Panel de administración más compacto y fácil de recorrer.

**Aclaración importante:** ninguna de estas ideas implica eliminar funciones. Antes de quitar o unir una pantalla real, habría que confirmar que su función no sea necesaria para otro rol, especialmente en las partes administrativas.

---

# 9. Resumen final

## Qué mantendría

- La separación de funciones según el tipo de usuario (cada rol ve lo que necesita).
- La consulta de horarios como función principal.
- Las opciones necesarias para administrar la programación.
- Las funciones administrativas importantes (parametrización, soporte).
- La información relacionada con ambientes, grupos e instructores.

## Qué cambiaría

- La forma de encontrar algunas opciones (que sean más visibles).
- La presentación de la información del horario (datos clave primero).
- La visibilidad de filtros y búsquedas.
- La forma de mostrar cambios o notificaciones.
- La adaptación de algunas vistas para celular.

## Qué simplificaría o uniría

- Pantallas que muestran información muy parecida del horario.
- Pasos innecesarios antes de llegar a una consulta.
- Confirmaciones para acciones que no son importantes.
- Menús con demasiadas opciones juntas.
- Información repetida entre pantallas.

## Mejoras generales propuestas

| Mejora | Para qué serviría |
|---|---|
| Buscador | Encontrar información rápidamente |
| Filtros | Reducir la cantidad de información que hay que revisar |
| Notificaciones | Avisar cambios importantes a tiempo |
| Vista de calendario | Visualizar mejor los horarios |
| Confirmaciones | Evitar modificaciones accidentales |
| Vista móvil | Facilitar el uso desde el celular |
| Reportes | Consultar o compartir la información |
| Botón volver | Facilitar la navegación entre pantallas |

## Prioridad de las mejoras

**Alta:**
- Mejorar la consulta de horarios.
- Agregar filtros.
- Notificar cambios de horario.
- Detectar conflictos de horarios.
- Facilitar el uso desde el celular.

**Media:**
- Generar reportes.
- Mejorar la consulta de ambientes.
- Agregar buscadores.
- Organizar mejor las configuraciones.

**Baja:**
- Indicadores generales.
- Ayudas adicionales.
- Cambios visuales menores.

---

# 10. Conclusión

Después de revisar el mockup desde el punto de vista de un usuario, no se considera necesario cambiar el sistema por completo. La mayoría de las propuestas son ajustes puntuales que podrían mejorar la experiencia sin modificar la idea principal del proyecto.

Las mejoras más importantes tienen que ver con facilitar la consulta de horarios, agregar filtros y notificaciones, organizar mejor la información y reducir pasos que no son estrictamente necesarios.

También se identificó que algunas pantallas podrían cumplir funciones parecidas y, en esos casos, podrían unirse mediante filtros o pestañas en lugar de mantenerse separadas. Esto no significa que deban eliminarse: antes habría que confirmar que esa función no sea necesaria para otro rol.

En general, la intención de estas propuestas es que cada usuario, sin importar su rol, pueda encontrar lo que necesita de forma más rápida y sencilla, manteniendo las funciones importantes del sistema.
