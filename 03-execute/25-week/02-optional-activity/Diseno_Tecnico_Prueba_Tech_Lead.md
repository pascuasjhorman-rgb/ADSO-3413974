# Diseño técnico — Marketplace B2B multi-tenant

**Propuesta de solución · NestJS + TypeScript · PostgreSQL**

> Documento de diseño basado en el enunciado. Describe decisiones y contratos esperados; no afirma que el servicio, la base de datos o las pruebas estén implementados.

## 1. Alcance

La solución separa tres operaciones: calcular una cotización, confirmar una cotización y entregar eventos a sistemas externos. El backend recibe el país, tenant, cliente y carrito; el servidor obtiene precios, reglas comerciales, impuestos y configuración monetaria vigentes. No acepta del navegador precios ni descuentos como fuente de verdad.

### Componentes

- **API NestJS:** validación de solicitudes, autorización y contexto de tenant.
- **Dominio de pedidos:** motor determinista de precios y confirmación.
- **PostgreSQL:** cotizaciones, pedidos, movimientos de cupo, claves idempotentes y outbox.
- **Workers:** publicación de eventos de outbox a push y ERP con reintentos.

## 2. Contrato de cotización

`POST /quotes` recibe `customerId`, `currency`, `country`, `paymentMethod` y una lista de `{ sku, quantity }`. El tenant se obtiene de la identidad autenticada, no de un valor confiado enviado por el cliente.

La respuesta contiene `quoteId`, `version`, vencimiento, moneda, detalle de líneas, descuentos identificados por regla, obsequios, base gravable, impuesto, total y resultado de elegibilidad de crédito. Cada línea detalla cantidades y componentes para que el total pueda reconstruirse y auditarse.

La cotización guarda un **snapshot inmutable** con líneas calculadas, precios, versiones de reglas, tasas, moneda, política de redondeo y total. La confirmación referencia ese snapshot; nunca vuelve a ejecutar el motor comercial. Así los cambios posteriores de catálogo o promociones no alteran el importe ya ofrecido. La cotización expirada no se confirma: se solicita una nueva.

## 3. Orden de cálculo comercial

Se calcula cada pedido en una secuencia única y documentada:

1. Validar SKU, cantidades, vigencia, país, tenant y disponibilidad comercial.
2. Calcular subtotal bruto por SKU: precio unitario × cantidad.
3. Aplicar combos elegibles. Las unidades asignadas a un combo se reservan y no participan en otro combo ni en descuentos por escala; un combo válido tiene prioridad sobre beneficios unitarios. Si dos combos compiten, se ordenan por prioridad explícita de campaña, luego por identificador estable. La regla de negocio debe aprobar esta precedencia.
4. Distribuir el precio del combo entre sus unidades/ líneas participantes en proporción a sus subtotales previos al combo. Los centavos residuales se asignan por un orden estable de SKU para conservar exactamente el total del combo.
5. Aplicar descuentos por escala acumulativa a las unidades elegibles restantes, de menor tramo a mayor tramo, con cada tramo calculado sobre las unidades que le corresponden.
6. Añadir obsequios como líneas separadas con precio de producto cero y regla de origen. Se les asigna la categoría tributaria correspondiente; cero precio comercial no implica automáticamente cero impuesto.
7. Obtener base gravable por línea después de descuentos y calcular impuesto con la tasa y reglas del país.
8. Sumar importes redondeados según la política monetaria configurada.

Cada descuento guarda regla, campaña, unidades cubiertas, valor y líneas afectadas. El dominio impide que una misma unidad quede asignada simultáneamente a dos beneficios incompatibles. La prioridad y compatibilidad deben ser configurables por país/tenant y quedar versionadas con la cotización.

## 4. Dinero, monedas e impuestos

No se usan `number` de JavaScript para operaciones monetarias. Para este diseño, los importes se representan como enteros `bigint` en unidades menores de la moneda (`COP 12.345` se almacena como `12345` centavos/unidades menores definidas por la configuración). La cantidad de decimales no se deduce del código: la configuración de moneda indica su exponente. Tasas y porcentajes se representan como racionales o decimales de precisión fija, nunca como flotantes binarios.

La política de referencia redondea cada descuento monetario por línea y cada impuesto por línea a la unidad menor, usando **half-up**. El total es la suma de líneas redondeadas; no se redondea de nuevo el agregado. El redondeo y exponente son parte de la versión de cotización. Antes de desplegar por país se debe confirmar que esta regla coincide con normativa fiscal local.

Los códigos de moneda, exponentes, tasas, exenciones y reglas fiscales provienen de configuración versionada por país y tenant. No se codifican tasas ni monedas en el motor.

## 5. Crédito

La cotización informa si el cliente parece tener cupo suficiente, pero esa lectura no reserva cupo. Al confirmar, el servicio bloquea la fila de crédito del cliente (`SELECT ... FOR UPDATE`), vuelve a comprobar el saldo disponible y registra el débito asociado al pedido dentro de la misma transacción que lo crea. Dos confirmaciones concurrentes no pueden gastar el mismo saldo. Si el cupo ya no alcanza, la confirmación se rechaza sin crear orden.

## 6. Confirmación idempotente y consistencia

`POST /orders` requiere `Idempotency-Key` y `quoteId`. La unicidad se aplica a `(tenant_id, cliente_id, idempotency_key)`. La fila también guarda hash de la solicitud y respuesta final: repetir la misma clave y el mismo contenido devuelve la orden original; reutilizar la clave con contenido distinto produce conflicto.

En una sola transacción PostgreSQL se hace lo siguiente:

1. Reclamar la clave idempotente mediante índice único.
2. Validar que la cotización pertenece al tenant y cliente, sigue vigente y no está ya consumida por otra clave.
3. Bloquear y debitar el cupo cuando corresponda.
4. Insertar el pedido y sus líneas copiadas del snapshot.
5. Marcar la cotización consumida y guardar la respuesta idempotente.
6. Insertar eventos `OrderConfirmed` y `PushNotificationRequested` en la tabla outbox.
7. Confirmar la transacción.

La API devuelve `201` y número de orden **solo después del commit**. El número de orden y el pedido están en la misma base transaccional; por tanto, una respuesta exitosa implica que la orden ya es consultable. Si la transacción falla, no se devuelve éxito ni queda débito parcial.

La outbox se entrega con semántica **al menos una vez**. Los workers reclaman filas pendientes, publican con `eventId` estable, registran éxito y aplican reintentos con espera creciente y cola de fallos. Los consumidores deben deduplicar por `eventId`; no se promete entrega exactamente una vez a través de redes externas. Si ERP o push se cae, el pedido permanece confirmado y el evento espera reintento; la API no intenta revertir una orden confirmada por un fallo externo.

**Consistencia elegida:** fuerte dentro de PostgreSQL para orden, cupo, clave idempotente y outbox; eventual para ERP y notificaciones. Se prioriza no perder pedidos ni consumir el cupo dos veces. Se sacrifica la confirmación inmediata de los sistemas externos.

## 7. Esquema mínimo sugerido

- `quotes`: tenant, cliente, versión, estado, vencimiento, moneda y snapshot JSON validado.
- `orders`: tenant, cliente, número único, quote_id único, total y estado.
- `order_lines`: SKU, cantidad, base, impuestos, descuentos y referencias a reglas.
- `credit_accounts` y `credit_ledger`: cupo y movimientos inmutables vinculados a orden.
- `idempotency_records`: tenant, cliente, clave, hash de solicitud, order_id y respuesta.
- `outbox_events`: event_id, tipo, payload, estado, intentos, próxima ejecución y fecha de entrega.

Toda consulta y clave de unicidad incluye `tenant_id`. Las claves foráneas y restricciones únicas respaldan las invariantes también ante errores de aplicación.

## 8. Pruebas golden obligatorias

El repositorio debería incluir fixtures de entrada y salida exacta, ejecutables con un comando único (`npm test`):

1. Escala acumulativa de dos tramos: unidades por tramo y descuento final exactos.
2. Combo: precio final distribuido, sin duplicar como descuento de escala las unidades consumidas.
3. Obsequio: línea separada con cantidad, valor cero y tratamiento fiscal explícito.
4. Combo con impuesto: verificar base, impuesto por línea y total.
5. Crédito insuficiente: rechazo sin pedido ni movimiento de cupo.
6. Regresión de cotización: cotizar, cambiar catálogo/promoción, confirmar y comprobar igualdad de total contra el snapshot.
7. Idempotencia: repetir la misma clave devuelve un solo pedido y un solo débito.
8. Atomicidad: simular fallo antes del commit y verificar que no existe pedido, débito ni outbox parcial.
9. Outbox: evento pendiente se reintenta tras fallo externo y se entrega con ID estable.

Los tests de concurrencia e invariantes transaccionales se deben ejecutar contra PostgreSQL de prueba, no solo contra mocks en memoria.

## 9. ADR — decisiones y límites

**Decisión:** NestJS, PostgreSQL, snapshot de cotización y transactional outbox. Se eligen por transacciones, restricciones de unicidad y facilidad para modelar consistencia local.

**Alternativas descartadas:** recalcular al confirmar (puede cambiar el precio ofrecido); coordinar ERP dentro de la transacción (acopla disponibilidad externa y la transacción local); confiar solo en idempotencia del frontend (no cubre reintentos de red); publicar eventos antes del commit (puede anunciar una orden inexistente).

**Fuera del alcance inicial:** motor visual de campañas, reserva de inventario, compensaciones distribuidas, entrega push específica por proveedor y cumplimiento fiscal exhaustivo para todos los países. Se agregan con adaptadores/reglas versionadas tras validar necesidades del negocio y asesoría tributaria local.

**Revisión de código:** verificar límites de tenant en todas las consultas, precisión monetaria, reglas de asignación de unidades, bloqueo de cupo, restricciones únicas, almacenamiento seguro de claves, expiración de cotizaciones y observabilidad de reintentos.

**Riesgo:** reglas de combo ambiguas y cambios de interpretación fiscal por país. Mitigación: reglas explícitas con prioridad/versionado, fixtures golden aprobados por negocio y configuración tributaria revisada localmente antes de habilitar el país.
