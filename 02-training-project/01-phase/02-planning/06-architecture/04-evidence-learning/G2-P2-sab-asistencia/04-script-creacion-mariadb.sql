-- ============================================================================
-- SCRIPT DDL: CREACIÓN DE BASE DE DATOS Y TABLAS (SAB / BioSENA)
-- Proyecto: Sistema de Asistencia Biométrica (SAB / BioSENA)
-- Referencia: SRS-SAB-001 (v2.3)
-- Motor objetivo: MariaDB 10.4+ / MySQL 8.0 (Motor InnoDB)
-- Autor: @pascuasjhorman-rgb · Ficha 3413974 · SENA CIES Neiva
-- Fecha: 27 de noviembre de 2026
-- ============================================================================

DROP DATABASE IF EXISTS sab_asistencia;
CREATE DATABASE sab_asistencia
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE sab_asistencia;

-- ============================================================================
-- 1. TABLA: sede
-- ============================================================================
CREATE TABLE sede (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL,
    ciudad VARCHAR(80) NOT NULL,
    estado ENUM('ACTIVA', 'INACTIVA') NOT NULL DEFAULT 'ACTIVA',
    CONSTRAINT uk_sede_nombre UNIQUE (nombre_sede),
    CONSTRAINT chk_sede_estado CHECK (estado IN ('ACTIVA', 'INACTIVA'))
) ENGINE=InnoDB;

-- ============================================================================
-- 2. TABLA: usuario
-- ============================================================================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    documento VARCHAR(20) NOT NULL,
    correo VARCHAR(120) NOT NULL,
    nombre_completo VARCHAR(150) NOT NULL,
    clave_hash VARCHAR(255) NOT NULL,
    rol ENUM('APRENDIZ', 'INSTRUCTOR', 'COORDINADOR', 'SUPERADMIN') NOT NULL,
    codigo_matricula VARCHAR(30) NULL,
    especialidad VARCHAR(100) NULL,
    estado ENUM('ACTIVO', 'INACTIVO', 'BLOQUEADO') NOT NULL DEFAULT 'ACTIVO',
    ultimo_acceso DATETIME NULL,
    CONSTRAINT uk_usuario_documento UNIQUE (documento),
    CONSTRAINT uk_usuario_correo UNIQUE (correo),
    CONSTRAINT chk_usuario_rol CHECK (rol IN ('APRENDIZ', 'INSTRUCTOR', 'COORDINADOR', 'SUPERADMIN')),
    CONSTRAINT chk_usuario_estado CHECK (estado IN ('ACTIVO', 'INACTIVO', 'BLOQUEADO'))
) ENGINE=InnoDB;

-- ============================================================================
-- 3. TABLA: ficha
-- ============================================================================
CREATE TABLE ficha (
    id_ficha INT AUTO_INCREMENT PRIMARY KEY,
    id_sede INT NOT NULL,
    id_lider INT NOT NULL,
    codigo_ficha VARCHAR(20) NOT NULL,
    programa VARCHAR(120) NOT NULL,
    jornada ENUM('DIURNA', 'NOCTURNA', 'MIXTA') NOT NULL DEFAULT 'DIURNA',
    estado ENUM('ACTIVA', 'FINALIZADA', 'CANCELADA') NOT NULL DEFAULT 'ACTIVA',
    CONSTRAINT uk_ficha_codigo UNIQUE (codigo_ficha),
    CONSTRAINT fk_ficha_sede FOREIGN KEY (id_sede)
        REFERENCES sede (id_sede) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ficha_lider FOREIGN KEY (id_lider)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_ficha_jornada CHECK (jornada IN ('DIURNA', 'NOCTURNA', 'MIXTA')),
    CONSTRAINT chk_ficha_estado CHECK (estado IN ('ACTIVA', 'FINALIZADA', 'CANCELADA'))
) ENGINE=InnoDB;

-- ============================================================================
-- 4. TABLA: vinculacion_ficha (Asociativa N:M)
-- ============================================================================
CREATE TABLE vinculacion_ficha (
    id_vinculacion INT AUTO_INCREMENT PRIMARY KEY,
    id_ficha INT NOT NULL,
    id_usuario INT NOT NULL,
    rol_en_ficha VARCHAR(30) NOT NULL DEFAULT 'APRENDIZ',
    fecha_vinculacion DATE NOT NULL,
    fecha_retiro DATE NULL,
    estado ENUM('MATRICULADO', 'TRASLADADO', 'DESVINCULADO', 'GRADUADO') NOT NULL DEFAULT 'MATRICULADO',
    CONSTRAINT uk_ficha_usuario UNIQUE (id_ficha, id_usuario),
    CONSTRAINT fk_vinculacion_ficha FOREIGN KEY (id_ficha)
        REFERENCES ficha (id_ficha) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_vinculacion_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_vinculacion_estado CHECK (estado IN ('MATRICULADO', 'TRASLADADO', 'DESVINCULADO', 'GRADUADO'))
) ENGINE=InnoDB;

-- ============================================================================
-- 5. TABLA: plantilla_biometrica (Entidad débil por existencia 0..1)
-- ============================================================================
CREATE TABLE plantilla_biometrica (
    id_plantilla INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    referencia_protegida TEXT NOT NULL,
    acepta_tratamiento TINYINT(1) NOT NULL DEFAULT 1,
    fecha_aceptacion DATETIME NOT NULL,
    estado_vigencia ENUM('VIGENTE', 'REVOCADA', 'EXPIRADA') NOT NULL DEFAULT 'VIGENTE',
    fecha_baja DATETIME NULL,
    CONSTRAINT uk_plantilla_usuario UNIQUE (id_usuario),
    CONSTRAINT fk_plantilla_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_plantilla_vigencia CHECK (estado_vigencia IN ('VIGENTE', 'REVOCADA', 'EXPIRADA')),
    CONSTRAINT chk_plantilla_consentimiento CHECK (acepta_tratamiento = 1)
) ENGINE=InnoDB;

-- ============================================================================
-- 6. TABLA: sesion_formacion
-- ============================================================================
CREATE TABLE sesion_formacion (
    id_sesion INT AUTO_INCREMENT PRIMARY KEY,
    id_ficha INT NOT NULL,
    id_instructor INT NOT NULL,
    fecha_apertura DATETIME NOT NULL,
    fecha_cierre DATETIME NULL,
    estado_sesion ENUM('ABIERTA', 'CERRADA', 'CANCELADA') NOT NULL DEFAULT 'ABIERTA',
    motivo_contingencia VARCHAR(255) NULL,
    soporte_contingencia VARCHAR(255) NULL,
    CONSTRAINT fk_sesion_ficha FOREIGN KEY (id_ficha)
        REFERENCES ficha (id_ficha) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_sesion_instructor FOREIGN KEY (id_instructor)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_sesion_estado CHECK (estado_sesion IN ('ABIERTA', 'CERRADA', 'CANCELADA'))
) ENGINE=InnoDB;

-- ============================================================================
-- 7. TABLA: token_qr
-- ============================================================================
CREATE TABLE token_qr (
    id_token INT AUTO_INCREMENT PRIMARY KEY,
    id_sesion INT NOT NULL,
    codigo_firma VARCHAR(128) NOT NULL,
    emitido_en DATETIME NOT NULL,
    expira_en DATETIME NOT NULL,
    estado_token ENUM('ACTIVO', 'EXPIRADO', 'INVALIDADO') NOT NULL DEFAULT 'ACTIVO',
    CONSTRAINT uk_token_firma UNIQUE (codigo_firma),
    CONSTRAINT fk_token_sesion FOREIGN KEY (id_sesion)
        REFERENCES sesion_formacion (id_sesion) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_token_estado CHECK (estado_token IN ('ACTIVO', 'EXPIRADO', 'INVALIDADO'))
) ENGINE=InnoDB;

-- ============================================================================
-- 8. TABLA: asistencia (Núcleo transaccional)
-- ============================================================================
CREATE TABLE asistencia (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_sesion INT NOT NULL,
    id_aprendiz INT NOT NULL,
    estado_asistencia ENUM('PRESENTE', 'RETARDO', 'EXCUSADO', 'AUSENTE') NOT NULL DEFAULT 'PRESENTE',
    origen_registro ENUM('QR_IDENTIDAD', 'MANUAL_INSTRUCTOR', 'EXCUSA_APROBADA') NOT NULL DEFAULT 'QR_IDENTIDAD',
    marca_tiempo DATETIME NOT NULL,
    motivo_manual VARCHAR(255) NULL,
    registrada_por INT NOT NULL,
    CONSTRAINT uk_sesion_aprendiz UNIQUE (id_sesion, id_aprendiz),
    CONSTRAINT fk_asistencia_sesion FOREIGN KEY (id_sesion)
        REFERENCES sesion_formacion (id_sesion) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_asistencia_aprendiz FOREIGN KEY (id_aprendiz)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_asistencia_registrador FOREIGN KEY (registrada_por)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_asistencia_estado CHECK (estado_asistencia IN ('PRESENTE', 'RETARDO', 'EXCUSADO', 'AUSENTE')),
    CONSTRAINT chk_asistencia_origen CHECK (origen_registro IN ('QR_IDENTIDAD', 'MANUAL_INSTRUCTOR', 'EXCUSA_APROBADA'))
) ENGINE=InnoDB;

-- ============================================================================
-- 9. TABLA: incidencia
-- ============================================================================
CREATE TABLE incidencia (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    id_sesion INT NOT NULL,
    id_aprendiz INT NOT NULL,
    tipo_incidencia VARCHAR(60) NOT NULL,
    intentos_fallidos INT NOT NULL DEFAULT 3,
    estado_resolucion ENUM('PENDIENTE', 'RESUELTA', 'RECHAZADA') NOT NULL DEFAULT 'PENDIENTE',
    decision_resolucion TEXT NULL,
    resuelta_por INT NULL,
    fecha_resolucion DATETIME NULL,
    CONSTRAINT fk_incidencia_sesion FOREIGN KEY (id_sesion)
        REFERENCES sesion_formacion (id_sesion) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_aprendiz FOREIGN KEY (id_aprendiz)
        REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_incidencia_resuelta FOREIGN KEY (resuelta_por)
        REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_incidencia_fallos CHECK (intentos_fallidos >= 1),
    CONSTRAINT chk_incidencia_estado CHECK (estado_resolucion IN ('PENDIENTE', 'RESUELTA', 'RECHAZADA'))
) ENGINE=InnoDB;

-- ============================================================================
-- 10. TABLA: excusa
-- ============================================================================
CREATE TABLE excusa (
    id_excusa INT AUTO_INCREMENT PRIMARY KEY,
    id_aprendiz INT NOT NULL,
    id_sesion INT NOT NULL,
    tipo_excusa ENUM('MEDICA', 'LABORAL', 'FUERZA_MAYOR', 'CALAMIDAD') NOT NULL,
    observacion TEXT NOT NULL,
    ruta_soporte VARCHAR(255) NULL,
    estado_recepcion ENUM('RADICADA', 'RECIBIDA', 'APROBADA', 'RECHAZADA') NOT NULL DEFAULT 'RADICADA',
    confirmada_por INT NULL,
    fecha_confirmacion DATETIME NULL,
    CONSTRAINT fk_excusa_aprendiz FOREIGN KEY (id_aprendiz)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_excusa_sesion FOREIGN KEY (id_sesion)
        REFERENCES sesion_formacion (id_sesion) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_excusa_confirmador FOREIGN KEY (confirmada_por)
        REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_excusa_tipo CHECK (tipo_excusa IN ('MEDICA', 'LABORAL', 'FUERZA_MAYOR', 'CALAMIDAD')),
    CONSTRAINT chk_excusa_estado CHECK (estado_recepcion IN ('RADICADA', 'RECIBIDA', 'APROBADA', 'RECHAZADA'))
) ENGINE=InnoDB;

-- ============================================================================
-- 11. TABLA: bitacora_auditoria (Inmutable)
-- ============================================================================
CREATE TABLE bitacora_auditoria (
    id_auditoria BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_actor INT NULL,
    entidad_recurso VARCHAR(60) NOT NULL,
    id_registro_afectado INT NOT NULL,
    operacion ENUM('INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT') NOT NULL,
    valor_anterior TEXT NULL,
    valor_nuevo TEXT NULL,
    resultado VARCHAR(20) NOT NULL DEFAULT 'EXITO',
    fecha_evento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_auditoria_actor FOREIGN KEY (id_actor)
        REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_auditoria_operacion CHECK (operacion IN ('INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT'))
) ENGINE=InnoDB;

-- ============================================================================
-- 12. TABLA: parametro_sistema
-- ============================================================================
CREATE TABLE parametro_sistema (
    clave_parametro VARCHAR(50) PRIMARY KEY,
    valor_parametro VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    actualizado_por INT NOT NULL,
    actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_parametro_admin FOREIGN KEY (actualizado_por)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================
-- DATOS SEMILLA BÁSICOS PARA PRUEBA DE INTEGRIDAD
-- ============================================================================
INSERT INTO sede (id_sede, nombre_sede, ciudad, estado) VALUES
(1, 'Centro de la Industria, la Empresa y los Servicios - CIES', 'Neiva', 'ACTIVA');

INSERT INTO usuario (id_usuario, documento, correo, nombre_completo, clave_hash, rol, estado) VALUES
(1, '1075000001', 'superadmin@sena.edu.co', 'Administrador General CIES', '$argon2id$v=19$m=65536,t=3,p=4$demoHashAdmin123$', 'SUPERADMIN', 'ACTIVO'),
(2, '1075000002', 'instructor.lider@sena.edu.co', 'Instructor Lider Ficha', '$argon2id$v=19$m=65536,t=3,p=4$demoHashInstructor123$', 'INSTRUCTOR', 'ACTIVO'),
(3, '1075000003', 'aprendiz.demo@soy.sena.edu.co', 'Aprendiz ADSO Prueba', '$argon2id$v=19$m=65536,t=3,p=4$demoHashAprendiz123$', 'APRENDIZ', 'ACTIVO');

INSERT INTO ficha (id_ficha, id_sede, id_lider, codigo_ficha, programa, jornada, estado) VALUES
(1, 1, 2, '3413974', 'Analisis y Desarrollo de Software (ADSO)', 'DIURNA', 'ACTIVA');

INSERT INTO vinculacion_ficha (id_vinculacion, id_ficha, id_usuario, rol_en_ficha, fecha_vinculacion, estado) VALUES
(1, 1, 3, 'APRENDIZ', '2026-02-10', 'MATRICULADO');

INSERT INTO parametro_sistema (clave_parametro, valor_parametro, descripcion, actualizado_por) VALUES
('ROTACION_QR_SEGUNDOS', '15', 'Tiempo de expiracion del codigo QR dinamico en pantalla', 1),
('TOLERANCIA_RETARDO_MIN', '15', 'Minutos posteriores a la apertura para considerar retardo', 1),
('INTENTOS_MAX_IDENTIDAD', '3', 'Maximo de fallos permitidos antes de escalar incidencia', 1);
