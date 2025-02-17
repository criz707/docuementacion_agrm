CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARIO` (
  `ID_USUARIO` INT NOT NULL COMMENT 'Id del usuario , separa a todos los periles de tipo usuario',
  PRIMARY KEY (`ID_USUARIO`),
  UNIQUE INDEX `idtable1_UNIQUE` (`ID_USUARIO`));



CREATE TABLE IF NOT EXISTS `mydb`.`ADMINISTRADOR` (
  `ID_ADMINISTRADOR` INT NOT NULL COMMENT 'Id del administrador, brinda una diferencia entre el perfil general, y el perfil de administrador',
  PRIMARY KEY (`ID_ADMINISTRADOR`));


-- -----------------------------------------------------
-- Table `mydb`.`MESA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MESA` (
  `ID_MESA` INT NOT NULL COMMENT 'Identificadror unico de la mesa',
  `NUMERO` VARCHAR(10) NOT NULL COMMENT 'Numero con el que se identifica la mesa',
  `SILLAS` VARCHAR(10) NOT NULL COMMENT 'Numero de sillas que posee la mesa',
  `ADMINISTRADOR_ID_ADMINISTRADOR` INT NOT NULL COMMENT 'Llave foranea que conecta al administrador con las multiples reseravas',
  PRIMARY KEY (`ID_MESA`, `ADMINISTRADOR_ID_ADMINISTRADOR`),
  INDEX `fk_MESA_ADMINISTRADOR1_idx` (`ADMINISTRADOR_ID_ADMINISTRADOR`),
  CONSTRAINT `fk_MESA_ADMINISTRADOR1`
    FOREIGN KEY (`ADMINISTRADOR_ID_ADMINISTRADOR`)
    REFERENCES `mydb`.`ADMINISTRADOR` (`ID_ADMINISTRADOR`));


-- -----------------------------------------------------
-- Table `mydb`.`RECEPCIONISTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RECEPCIONISTA` (
  `ID_RECEPCIONISTA` INT NOT NULL COMMENT 'Id que diferencia a los tipos de perfil de recepcionistas',
  PRIMARY KEY (`ID_RECEPCIONISTA`));


-- -----------------------------------------------------
-- Table `mydb`.`RESERVA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RESERVA` (
  `ID_RESERVA` INT NOT NULL COMMENT 'Identificador unico de la reserva',
  `ID_USUARIO` INT NOT NULL COMMENT 'Id del usuario que realiza la reserva',
  `ID_MESA` INT NOT NULL COMMENT 'Identificador unico de la mesa',
  `FECHA` DATETIME NOT NULL COMMENT 'Fecha en la que se llevara a cabo la reserva',
  `HORA_INICIO` DATETIME NOT NULL COMMENT 'Hora en la que inicia la reserva, despues de trancuridos 15 minutos se libera para el uso libre',
  `HORA_FINAL` DATETIME NOT NULL COMMENT 'La hora en la que termina la reserva, se tiene planes a futuro de  implementar una notificacion  para que avise al usuario para que se prepare con quince minutos de antelacion',
  `ID_RECEPCIONISTA` INT NOT NULL COMMENT 'Id del recepcioista que confirma el uso de la reserva',
  PRIMARY KEY (`ID_RESERVA`, `ID_USUARIO`, `ID_MESA`, `ID_RECEPCIONISTA`),
  INDEX `fk_USUARIO_has_MESA_MESA1_idx` (`ID_MESA`) ,
  INDEX `fk_USUARIO_has_MESA_USUARIO_idx` (`ID_USUARIO`),
  INDEX `fk_RESERVA_RECEPCIONISTA1_idx` (`ID_RECEPCIONISTA` ),
  CONSTRAINT `fk_USUARIO_has_MESA_USUARIO`
  FOREIGN KEY (`ID_USUARIO`)
  REFERENCES `mydb`.`USUARIO` (`ID_USUARIO`),
  CONSTRAINT `fk_USUARIO_has_MESA_MESA1`
  FOREIGN KEY (`ID_MESA`)
  REFERENCES `mydb`.`MESA` (`ID_MESA`),
  CONSTRAINT `fk_RESERVA_RECEPCIONISTA1`
  FOREIGN KEY (`ID_RECEPCIONISTA`)
  REFERENCES `mydb`.`RECEPCIONISTA` (`ID_RECEPCIONISTA`));
    


-- -----------------------------------------------------
-- Table `mydb`.`GERENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GERENTE` (
  `ID_GERENTE` INT NOT NULL COMMENT 'Identificador unico de los perfiles de gerente',
  PRIMARY KEY (`ID_GERENTE`));


-- -----------------------------------------------------
-- Table `mydb`.`REPORTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`REPORTE` (
  `ID_REPORTE` INT NOT NULL COMMENT 'Identificador unico del reporte',
  `FECHA` DATETIME NOT NULL COMMENT 'Fecha en la que se genero el reporte, tiene un limite de uno por mes por cuestiones de almacenamiento',
  `URL` VARCHAR(45) NOT NULL COMMENT 'Url de donde se almaceno el reporte',
  `ID_GERENTE` INT NOT NULL COMMENT 'Id del gerente que genero el reporte',
  PRIMARY KEY (`ID_REPORTE`, `ID_GERENTE`),
  INDEX `fk_REPORTE_GERENTE1_idx` (`ID_GERENTE`),
  CONSTRAINT `fk_REPORTE_GERENTE1`
  FOREIGN KEY (`ID_GERENTE`)
  REFERENCES `mydb`.`GERENTE` (`ID_GERENTE`));


-- -----------------------------------------------------
-- Table `mydb`.`PERFIL`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `mydb`.`PERFIL` (
  `ID_PERFIL` INT NOT NULL COMMENT 'Identificador unico del perfil en la base de datos de perfiles',
  `NOMBRE` VARCHAR(45) NOT NULL COMMENT 'Nombre del perfil',
  `CORREO` VARCHAR(45) NOT NULL COMMENT 'Corre del perfil',
  `FOTO` VARCHAR(45) NOT NULL COMMENT 'Url de la foto del perfil',
  `CONTRASENA` VARCHAR(45) NOT NULL COMMENT 'Contrasena del perfil',
  `ID_USUARIO` INT NULL COMMENT 'Llave foranea que conecta la tabla perfil con la tabla usuario',
  `ID_RECEPCIONISTA` INT NULL COMMENT 'Llave foranea que conecta la tabla recepcionista con la tabla usuario',
  `ID_ADMINISTRADOR` INT NOT NULL COMMENT 'Llave foranea que conecta la tabla administrador con la tabla usuario',
  `ID_GERENTE` INT NOT NULL COMMENT 'Llave foranea que conecta la tabla gerente con la tabla usuario',
  PRIMARY KEY (`ID_PERFIL`, `ID_USUARIO`, `ID_RECEPCIONISTA`, `ID_ADMINISTRADOR`, `ID_GERENTE`),
  INDEX `fk_PERFIL_USUARIO1_idx` (`ID_USUARIO`) ,
  INDEX `fk_PERFIL_RECEPCIONISTA1_idx` (`ID_RECEPCIONISTA`) ,
  INDEX `fk_PERFIL_ADMINISTRADOR1_idx` (`ID_ADMINISTRADOR`) ,
  INDEX `fk_PERFIL_GERENTE1_idx` (`ID_GERENTE`) ,
  CONSTRAINT `fk_PERFIL_USUARIO1`
  FOREIGN KEY (`ID_USUARIO`)
  REFERENCES `mydb`.`USUARIO` (`ID_USUARIO`),
  CONSTRAINT `fk_PERFIL_RECEPCIONISTA1`
  FOREIGN KEY (`ID_RECEPCIONISTA`)
  REFERENCES `mydb`.`RECEPCIONISTA` (`ID_RECEPCIONISTA`),
    
  CONSTRAINT `fk_PERFIL_ADMINISTRADOR1`
  FOREIGN KEY (`ID_ADMINISTRADOR`)
  REFERENCES `mydb`.`ADMINISTRADOR` (`ID_ADMINISTRADOR`),
    
  CONSTRAINT `fk_PERFIL_GERENTE1`
  FOREIGN KEY (`ID_GERENTE`)
  REFERENCES `mydb`.`GERENTE` (`ID_GERENTE`)
    );


-- -----------------------------------------------------
-- Table `mydb`.`ACTUALIZACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ACTUALIZACION` (
  `PERFIL_ID_PERFIL` INT NOT NULL COMMENT 'Llave foranea entre la actualizacion y el perfil general',
  `PERFIL_ID_USUARIO` INT NULL COMMENT 'Llave foranea entre la actualizacion y el tipo deperfil usuario',
  `PERFIL_ID_RECEPCIONISTA` INT NULL COMMENT 'Llave foranea entre la actualizacion y el tipo de perfil de recepcionista',
  `PERFIL_ID_ADMINISTRADOR` INT NULL COMMENT 'Llave foranea entre la actualizacion y el tipo de perfil administrador',
  `PERFIL_ID_GERENTE` INT NULL COMMENT 'Llave foranea entre la actualizacion y el tipo de perfil gerente',
  `ID_ADMINISTRADOR` INT NOT NULL COMMENT 'Llave foranea entre administrador y actualizacion',
  PRIMARY KEY (`PERFIL_ID_PERFIL`, `PERFIL_ID_USUARIO`, `PERFIL_ID_RECEPCIONISTA`, `PERFIL_ID_ADMINISTRADOR`, `PERFIL_ID_GERENTE`, `ID_ADMINISTRADOR`),
  INDEX `fk_PERFIL_has_ADMINISTRADOR_ADMINISTRADOR1_idx` (`ID_ADMINISTRADOR` ASC) ,
  INDEX `fk_PERFIL_has_ADMINISTRADOR_PERFIL1_idx` (`PERFIL_ID_PERFIL` ASC, `PERFIL_ID_USUARIO` ASC, `PERFIL_ID_RECEPCIONISTA` ASC, `PERFIL_ID_ADMINISTRADOR` ASC, `PERFIL_ID_GERENTE` ASC) ,
  CONSTRAINT `fk_PERFIL_has_ADMINISTRADOR_PERFIL1`
  FOREIGN KEY (`PERFIL_ID_PERFIL` , `PERFIL_ID_USUARIO` , `PERFIL_ID_RECEPCIONISTA` , `PERFIL_ID_ADMINISTRADOR` , `PERFIL_ID_GERENTE`)
  REFERENCES `mydb`.`PERFIL` (`ID_PERFIL` , `ID_USUARIO` , `ID_RECEPCIONISTA` , `ID_ADMINISTRADOR` , `ID_GERENTE`),
  CONSTRAINT `fk_PERFIL_has_ADMINISTRADOR_ADMINISTRADOR1`
  FOREIGN KEY (`ID_ADMINISTRADOR`)
  REFERENCES `mydb`.`ADMINISTRADOR` (`ID_ADMINISTRADOR`));
