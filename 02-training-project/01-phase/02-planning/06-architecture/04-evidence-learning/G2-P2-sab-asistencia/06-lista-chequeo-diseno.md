# B7. Lista de Chequeo de Verificación del Diseño y Registro de Hallazgos (SAB / BioSENA)

**Proyecto:** Sistema de Asistencia Biométrica (SAB / BioSENA) · **Referencia:** `SRS-SAB-001` (v2.3)  
**Autor:** `@pascuasjhorman-rgb` · Ficha 3413974  
**Entregable:** Guía 2 · Producto 2 · Artefacto B7 (RAP 593102)

---

## 1. Lista de Chequeo Diligenciada (20 Criterios Verificables sobre P1 y P2)

| # | Artefacto Evaluado | Criterio de Aceptación Verificable | Severidad | ¿Cumple? | Evidencia Concreta (Archivo / Sección) |
|---|---|---|---|---|---|
| 1 | P1 · Ficha A1 | La ficha tecnológica incluye al menos 8 RF y 3 RNF con sus identificadores del SRS. | Crítico | Sí | `01-ficha-interpretacion-plataforma.md` (18 RF y 8 RNF identificados). |
| 2 | P1 · Plataforma A1 | El lenguaje OO y el tipo de base de datos están justificados con al menos 3 condiciones del caso. | Mayor | Sí | `01-ficha-interpretacion-plataforma.md` sec. 2 (Python/FastAPI y MariaDB justificados). |
| 3 | P1 · Clases A2 | El diagrama de clases contiene al menos 8 clases de diseño con atributos tipados y métodos con firmas. | Crítico | Sí | `02-diagrama-clases-y-patrones.md` (15 clases/interfaces con métodos tipados). |
| 4 | P1 · Clases A2 | Todas las asociaciones del diagrama de clases tienen multiplicidades explícitas en ambos extremos. | Mayor | Sí | `02-diagrama-clases.png` / `.drawio` (todas las multiplicidades indicadas). |
| 5 | P1 · Clases A2 | Se evidencia al menos una relación de composición o agregación correctamente tipificada. | Mayor | Sí | Composición `Sesion *-- TokenQR` y Agregación `Ficha o-- Aprendiz`. |
| 6 | P1 · Clases A2 | Se utiliza herencia o interfaz con polimorfismo (al menos 2 implementaciones concretas). | Crítico | Sí | Interfaz `IEstrategiaVerificacion` con implementaciones WebAuthn, Facial y Manual. |
| 7 | P1 · Clases A2 | Ninguna clase de diseño mezcla responsabilidades de áreas distintas (UI, lógica, persistencia). | Crítico | Sí | Separación estricta entre servicios (`AsistenciaService`) y repositorios (`AsistenciaRepository`). |
| 8 | P1 · Patrones A3 | Se aplican al menos 2 patrones GoF distintos de Singleton con justificación del problema resuelto. | Crítico | Sí | Patrones Strategy (`IEstrategiaVerificacion`) y Facade (`AsistenciaFacade`). |
| 9 | P1 · Arquitectura A4 | El estilo arquitectónico está definido formalmente con diagrama y sin capas saltadas. | Crítico | Sí | `03-arquitectura-decisiones.md` (Arquitectura en 3 capas lógicas independientes). |
| 10 | P1 · Arquitectura A4 | Se presenta tabla con al menos 3 RNF y la decisión técnica arquitectural que responde a cada uno. | Mayor | Sí | `03-arquitectura-decisiones.md` sec. 2 (6 RNF atendidos con decisiones técnicas). |
| 11 | P1 · Arquitectura A4 | Se documenta al menos una alternativa arquitectural evaluada y descartada con su justificación. | Menor | Sí | `03-arquitectura-decisiones.md` sec. 4 (Microservicios descartados por sobrecosto). |
| 12 | P1 · Componentes A5 | La vista de componentes incluye al menos 5 componentes con interfaces provistas y requeridas. | Crítico | Sí | `04-vista-componentes.md` (6 componentes con contratos `IAuthService`, `ISesionService`, etc.). |
| 13 | P1 · Despliegue A6 | La vista de despliegue define al menos 3 nodos físicos/lógicos con protocolos y puertos mapeados. | Mayor | Sí | `05-vista-despliegue.md` (Cliente Web, Servidor FastAPI, Servidor MariaDB; puertos 443 y 3306). |
| 14 | P1 · Trazabilidad A7 | Cada requisito funcional trazado a diseño cuenta con componente y clase asignada. | Mayor | Sí | `06-matriz-trazabilidad-diseno.md` (100 % de los requisitos funcionales mapeados). |
| 15 | P2 · Conceptual B1 | El modelo conceptual contiene al menos 6 entidades con identificador y cardinalidades mín/máx. | Crítico | Sí | `01-modelo-conceptual-y-logico.md` (11 entidades conceptuales trazadas a RF). |
| 16 | P2 · Lógico B2 | El modelo lógico relacional cuenta con al menos 8 tablas con PKs y FKs y tabla intermedia para N:M. | Crítico | Sí | `01-modelo-conceptual-y-logico.md` (12 tablas relacionales con `vinculacion_ficha`). |
| 17 | P2 · Normalización B3 | Se evidencia la normalización paso a paso de 0FN a 3FN para 2 tablas con dependencias funcionales. | Crítico | Sí | `02-normalizacion.md` (`vinculacion_ficha` con clave compuesta y `sesion_formacion` transitiva). |
| 18 | P2 · Diccionario B4 | El diccionario cubre el 100 % de tablas y columnas con nombre, tipo, tamaño, restricciones y dominio. | Mayor | Sí | `03-diccionario-datos.md` (12 tablas completas con tipo, tamaño y reglas de dominio). |
| 19 | P2 · Script SQL B5 | El script DDL crea el 100 % de las tablas con PK, FK con ON DELETE en $\ge$ 3, NOT NULL, UNIQUE y $\ge$ 3 CHECK. | Crítico | Sí | `04-script-creacion-mariadb.sql` y `04-evidencia-ejecucion.log` (12 tablas sin errores). |
| 20 | P2 · Seguridad B6 | Se definen al menos 6 políticas (2 por CIA), matriz RBAC de $\ge$ 3 roles y hash Argon2id/bcrypt. | Mayor | Sí | `05-politicas-seguridad.md` (6 políticas CIA, matriz de 3 roles y cumplimiento Ley 1581). |

---

## 2. Registro de Hallazgos y Ajustes del Diseño (Mejora Continua)

| # ID | Artefacto Afectado | Criterio Incumplido Inicialmente | Situación Antes (Defecto detectado) | Corrección Aplicada (Situación Después) | Verificación de Cierre |
|---|---|---|---|---|---|
| **H-DIS-01** | `02-diagrama-clases-y-patrones.md` | Principio de Inversión de Dependencias (IoC) | Las clases de servicio (`AsistenciaService`) instanciaban directamente la clase concreta de verificación biométrica, generando alto acoplamiento. | Se introdujo la interfaz polimórfica `IEstrategiaVerificacion` bajo el patrón Strategy, permitiendo inyectar WebAuthn, Facial o Manual sin tocar el servicio. | Cumple (Verificado en diagrama A2 y componente A5). |
| **H-DIS-02** | `04-script-creacion-mariadb.sql` | Integridad y Prevención de Asistencias Duplicadas (`RN-006`) | La tabla `asistencia` solo tenía clave primaria autoincremental, permitiendo teóricamente que un aprendiz marcara dos veces en la misma sesión. | Se añadió la restricción de clave única compuesta `CONSTRAINT uk_sesion_aprendiz UNIQUE (id_sesion, id_aprendiz)` a nivel de motor DDL. | Cumple (Error 1062 verificado en `04-evidencia-ejecucion.log`). |
| **H-DIS-03** | `03-diccionario-datos.md` y `05-politicas-seguridad.md` | Cumplimiento Ley 1581 de 2012 y Minimización | Se proponía almacenar la imagen de la huella en formato binario base64, violando el principio de minimización de datos sensibles. | Se eliminó el campo binario de huella y se reemplazó por `referencia_protegida TEXT` (descriptor/hash cifrado) con campo obligatorio de consentimiento `acepta_tratamiento`. | Cumple (Alineado con POL-SEC-02 y tabla `plantilla_biometrica`). |
| **H-DIS-04** | `04-script-creacion-mariadb.sql` | Acciones Referenciales de Base de Datos | Las llaves foráneas no especificaban cláusula `ON DELETE`, dejando el comportamiento al azar o provocando registros huérfanos. | Se declararon explícitamente acciones referenciales en las llaves foráneas: `ON DELETE CASCADE` en tokens/plantillas, `ON DELETE RESTRICT` en fichas/asistencias y `ON DELETE SET NULL` en auditoría. | Cumple (Probado y registrado en log de ejecución). |
