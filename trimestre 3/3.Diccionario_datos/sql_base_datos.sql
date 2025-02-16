-- Crear el esquema
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

-- Crear tabla ADMINISTRADOR
CREATE TABLE `ADMINISTRADOR` (
  `ID_ADMINISTRADOR` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único ascendente para cada administrador',
  `NOMBRE` VARCHAR(45) NOT NULL COMMENT 'Es el nombre del administrador',
  `CORREO` VARCHAR(45) NOT NULL COMMENT 'Correo electrónico del administrador',
  `CONTRASENA` VARCHAR(45) NOT NULL COMMENT 'Contraseña del administrador',
  PRIMARY KEY (`ID_ADMINISTRADOR`)
) ENGINE = InnoDB;

-- Crear tabla USUARIO
CREATE TABLE `USUARIO` (
  `ID_USUARIO` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único ascendente para cada usuario',
  `ID_ADMINISTRADOR` INT NOT NULL COMMENT 'Llave foránea hacia la tabla ADMINISTRADOR',
  `NOMBRE` VARCHAR(45) NOT NULL COMMENT 'Nombre del usuario',
  `CORREO` VARCHAR(45) NOT NULL COMMENT 'Correo electrónico del usuario',
  `CONTRASENA` VARCHAR(45) NOT NULL COMMENT 'Contraseña del usuario',
  PRIMARY KEY (`ID_USUARIO`),
  UNIQUE INDEX `idtable1_UNIQUE` (`ID_USUARIO` ASC),
  INDEX `fk_USUARIO_ADMINISTRADOR_idx` (`ID_ADMINISTRADOR` ASC),
  CONSTRAINT `fk_USUARIO_ADMINISTRADOR`
    FOREIGN KEY (`ID_ADMINISTRADOR`)
    REFERENCES `ADMINISTRADOR` (`ID_ADMINISTRADOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Crear tabla MESA
CREATE TABLE `MESA` (
  `ID_MESA` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único ascendente para cada mesa',
  `ID_ADMINISTRADOR` INT NOT NULL COMMENT 'Llave foránea hacia la tabla ADMINISTRADOR',
  `DESCRIPCION` VARCHAR(45) NULL COMMENT 'Breve descripción de la mesa',
  PRIMARY KEY (`ID_MESA`),
  INDEX `fk_MESA_ADMINISTRADOR_idx` (`ID_ADMINISTRADOR` ASC),
  CONSTRAINT `fk_MESA_ADMINISTRADOR`
    FOREIGN KEY (`ID_ADMINISTRADOR`)
    REFERENCES `ADMINISTRADOR` (`ID_ADMINISTRADOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Crear tabla RECEPCIONISTA
CREATE TABLE `RECEPCIONISTA` (
  `ID_RECEPCIONISTA` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único ascendente para cada recepcionista',
  `ID_ADMINISTRADOR` INT NOT NULL COMMENT 'Llave foránea hacia la tabla ADMINISTRADOR',
  `NOMBRE` VARCHAR(45) NOT NULL COMMENT 'Nombre del recepcionista',
  `CORREO` VARCHAR(45) NOT NULL COMMENT 'Correo electrónico del recepcionista',
  `CONTRASENA` VARCHAR(45) NOT NULL COMMENT 'Contraseña del recepcionista',
  PRIMARY KEY (`ID_RECEPCIONISTA`),
  UNIQUE INDEX `idtable1_UNIQUE` (`ID_RECEPCIONISTA` ASC),
  INDEX `fk_RECEPCIONISTA_ADMINISTRADOR_idx` (`ID_ADMINISTRADOR` ASC),
  CONSTRAINT `fk_RECEPCIONISTA_ADMINISTRADOR`
    FOREIGN KEY (`ID_ADMINISTRADOR`)
    REFERENCES `ADMINISTRADOR` (`ID_ADMINISTRADOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Crear tabla RESERVA
CREATE TABLE `RESERVA` (
  `ID_RESERVA` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único ascendente para cada reserva',
  `ID_USUARIO` INT NOT NULL COMMENT 'Llave foránea hacia la tabla USUARIO',
  `ID_MESA` INT NOT NULL COMMENT 'Llave foránea hacia la tabla MESA',
  `FECHA` DATE NOT NULL COMMENT 'Fecha de la reserva',
  `HORA` TIME NOT NULL COMMENT 'Hora de la reserva',
  PRIMARY KEY (`ID_RESERVA`),
  INDEX `fk_RESERVA_USUARIO_idx` (`ID_USUARIO` ASC),
  INDEX `fk_RESERVA_MESA_idx` (`ID_MESA` ASC),
  CONSTRAINT `fk_RESERVA_USUARIO`
    FOREIGN KEY (`ID_USUARIO`)
    REFERENCES `USUARIO` (`ID_USUARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESERVA_MESA`
    FOREIGN KEY (`ID_MESA`)
    REFERENCES `MESA` (`ID_MESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Crear tabla PAGO
CREATE TABLE `PAGO` (
  `ID_PAGO` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único ascendente para cada pago',
  `ID_RESERVA` INT NOT NULL COMMENT 'Llave foránea hacia la tabla RESERVA',
  `MONTO` DECIMAL(10,2) NOT NULL COMMENT 'Monto del pago',
  `FECHA` DATE NOT NULL COMMENT 'Fecha del pago',
  PRIMARY KEY (`ID_PAGO`),
  INDEX `fk_PAGO_RESERVA_idx` (`ID_RESERVA` ASC),
  CONSTRAINT `fk_PAGO_RESERVA`
    FOREIGN KEY (`ID_RESERVA`)
    REFERENCES `RESERVA` (`ID_RESERVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;
