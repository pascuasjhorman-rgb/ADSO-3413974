# A6. Vista de Despliegue del Sistema (SAB / BioSENA)

**Proyecto:** Sistema de Asistencia Biométrica (SAB / BioSENA) · **Referencia:** `SRS-SAB-001` (v2.3)  
**Autor:** `@pascuasjhorman-rgb` · Ficha 3413974  
**Entregable:** Guía 2 · Producto 1 · Artefacto A6 (RAP 593103)

---

## 1. Diagrama de Nodos y Conexiones de Despliegue

El sistema BioSENA se despliega en **3 nodos físicos/lógicos independientes**, garantizando seguridad perimetral, escalabilidad y aislamiento entre la capa de presentación pública y los datos relacionales:

```
+-----------------------------------------------------------------------------------------+
|                  NODO 1: DISPOSITIVO CLIENTE (USUARIO FINAL)                            |
|  Hardware: Smartphone Android/iOS · PC de Ambiente SENA · Proyector de Formación       |
|  Entorno de Ejecución: Navegador Web Moderno (Chrome, Edge, Firefox, Safari)            |
|                                                                                         |
|  ┌───────────────────────────────────────────────────────────────────────────────────┐  |
|  │ Artefacto: «web-app» BioSENA Frontend Bundle                                      │  |
|  │ - Código compilado HTML5, CSS3 responsivo (320px-1280px), JavaScript ES2022      │  |
|  │ - Capturador de Cámara Web (MediaDevices API) con guía visual de encuadre        │  |
|  │ - Cliente WebAuthn (Navigator Credentials API)                                   │  |
|  │ - Lector y proyector de Códigos QR rotativos                                     │  |
|  └───────────────────────────────────────────────────────────────────────────────────┘  |
+-----------------------------------------------------------------------------------------+
                                             │
                                             │ Protocolo: HTTPS / TLS 1.2+
                                             │ Puerto TCP: 443 (Tráfico Cifrado)
                                             ▼
+-----------------------------------------------------------------------------------------+
|                NODO 2: SERVIDOR DE APLICACIONES (BACKEND API)                           |
|  Hardware Asignado: Máquina Virtual Linux Ubuntu 22.04 LTS (4 vCPU · 8 GB RAM · 80 SSD) |
|  Entorno: Contenedor Docker / Runtime Python 3.12                                        |
|                                                                                         |
|  ┌───────────────────────────────────────────────────────────────────────────────────┐  |
|  │ Artefacto: Proxy Inverso Nginx 1.24                                               │  |
|  │ - Terminación TLS (Certificado SSL/TLS Let's Encrypt / SENA)                     │  |
|  │ - Rate Limiting (Protección anti-fuerza bruta: máx 5 fallos en 15 min)           │  |
|  │ - Cabeceras de seguridad HTTP (HSTS, CSP, X-Frame-Options: DENY)                  │  |
|  └─────────────────────────────────────────┬─────────────────────────────────────────┘  |
|                                            │ Proxy local (Unix Socket / 127.0.0.1:8000)
|                                            ▼
|  ┌───────────────────────────────────────────────────────────────────────────────────┐  |
|  │ Artefacto: «api-service» BioSENA Core API                                         │  |
|  │ - Servidor ASGI Uvicorn con 4 workers asíncronos                                  │  |
|  │ - Aplicación FastAPI (Python 3.12 + Pydantic v2)                                  │  |
|  │ - Pool de conexiones hacia base de datos (SQLAlchemy / PyMySQL)                  │  |
|  │ - Motor de generación de reportes (ReportLab PDF / OpenPyXL)                     │  |
|  │ - Reloj sincronizado con servidor NTP interno (tolerancia ≤ 2 s)                 │  |
|  └───────────────────────────────────────────────────────────────────────────────────┘  |
+-----------------------------------------------------------------------------------------+
                                             │
                                             │ Protocolo: TCP / IP Nativo
                                             │ Puerto TCP: 3306 (Acceso Privado Interno)
                                             │ Red Aislada (Docker Bridge / Firewall ufw)
                                             ▼
+-----------------------------------------------------------------------------------------+
|              NODO 3: SERVIDOR DE BASE DE DATOS (PERSISTENCIA Y DATOS)                   |
|  Hardware: Servidor Dedicado / Instancia de Almacenamiento MariaDB                       |
|  Entorno: MariaDB Server 10.4 (Motor InnoDB ACID)                                       |
|                                                                                         |
|  ┌───────────────────────────────────────────────────────────────────────────────────┐  |
|  │ Artefacto: «schema-db» Base de Datos Relacional `sab_asistencia`                  │  |
|  │ - 12 Tablas normalizadas en 3FN con claves foráneas e integridad referencial      │  |
|  │ - Índices B-Tree optimizados para consultas de sesión e historial                 │  |
|  │ - Tablas de auditoría inmutable con marcas de tiempo automáticas                  │  |
|  │ - Servicio de respaldo diario automatizado (Cron + mysqldump cifrado GPG)         │  |
|  └───────────────────────────────────────────────────────────────────────────────────┘  |
+-----------------------------------------------------------------------------------------+
```

---

## 2. Descripción de Nodos, Artefactos y Protocolos

| Nodo | Especificación de Hardware / OS | Artefactos Alojados | Protocolos y Puertos | Justificación Técnica |
|---|---|---|---|---|
| **Nodo 1: Cliente** | Dispositivo móvil o PC con navegador web (mínimo 320 px). | `BioSENA WebApp` (bundle web estático en caché de navegador). | **HTTPS (Puerto 443):** Salida segura hacia el servidor de aplicaciones. | Permite que el aprendiz y el instructor interactúen desde cualquier terminal del ambiente sin necesidad de instalar software cliente nativo. |
| **Nodo 2: Servidor API** | Servidor virtual Linux (4 vCPU, 8 GB RAM, 80 GB SSD). | Proxy `Nginx`, servicio `Uvicorn` + `FastAPI`, generadores de reportes PDF/XLSX. | **HTTPS (443)** entrante desde clientes; **TCP (3306)** saliente exclusivo hacia MariaDB. | Aísla la lógica del negocio. Nginx filtra ataques y mitiga peticiones maliciosas antes de llegar a Python. |
| **Nodo 3: Base de Datos** | Servidor de base de datos MariaDB 10.4 (InnoDB). | Esquema `sab_asistencia`, archivos de datos `.ibd`, bitácora transaccional WAL. | **TCP (Puerto 3306):** Escucha configurada únicamente en interfaz privada interna (sin acceso desde internet público). | Máxima seguridad: la base de datos nunca está expuesta a internet, solo responde al pool de conexiones del servidor API. |

---

## 3. Decisiones de Despliegue que responden a los Requisitos No Funcionales (RNF)

1. **Seguridad y Confidencialidad (`RNF-SAB-002` y `RNF-SAB-026`):**
   - El puerto 3306 de MariaDB está cerrado para internet mediante firewall (`ufw`). Solo el contenedor de FastAPI en la subred privada de Docker puede conectarse mediante credenciales inyectadas por variables de entorno (`.env` seguro fuera del repositorio).
2. **Alta Disponibilidad y Capacidad Concurrente (`RNF-SAB-008` y `RNF-SAB-009`):**
   - El runtime Uvicorn corre con 4 procesos *worker* en paralelo, lo que permite atender hasta 100 peticiones concurrentes de verificación de asistencia en menos de 3 segundos durante el momento pico de inicio de clase.
3. **Sincronización Horaria y Validez de QR (`RNF-SAB-011` y `RN-004`):**
   - El nodo 2 tiene activado el servicio `systemd-timesyncd` sincronizado con servidores NTP oficiales de Colombia (`co.pool.ntp.org`), garantizando una desviación menor a 2 segundos para la rotación del QR cada 15 segundos.
4. **Respaldo y Recuperación (`RNF-SAB-010` y `RNF-SAB-029`):**
   - Se programa una tarea `cron` diaria que ejecuta `mysqldump` con transacción consistente (`--single-transaction`), comprime y cifra el volcado con AES-256 hacia un almacenamiento secundario, cumpliendo el RPO de 24 horas y RTO de 4 horas.
