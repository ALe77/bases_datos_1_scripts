-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Spotify_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Spotify_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Spotify_DB` DEFAULT CHARACTER SET utf8 ;
USE `Spotify_DB` ;

-- -----------------------------------------------------
-- Table `Spotify_DB`.`Paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Paises` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `nombrePais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`tiposUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`tiposUsuario` (
  `idtiposUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombreTipoUsuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtiposUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `codigoPostal` VARCHAR(45) NOT NULL,
  `idPais` INT NOT NULL,
  `idtiposUsuario` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuarios_Paises1_idx` (`idPais` ASC) VISIBLE,
  INDEX `fk_Usuarios_tiposUsuario1_idx` (`idtiposUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Paises1`
    FOREIGN KEY (`idPais`)
    REFERENCES `Spotify_DB`.`Paises` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_tiposUsuario1`
    FOREIGN KEY (`idtiposUsuario`)
    REFERENCES `Spotify_DB`.`tiposUsuario` (`idtiposUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Passwords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Passwords` (
  `idPassword` INT NOT NULL AUTO_INCREMENT,
  `PasswordDescripcion` VARCHAR(45) NOT NULL,
  `fechaUltimaModificacion` DATE NOT NULL,
  `fechaCaducidad` DATE NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idPassword`),
  INDEX `fk_Passwords_Usuarios_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Passwords_Usuarios`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Spotify_DB`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`estadosPlaylist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`estadosPlaylist` (
  `idestadosPlaylist` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestadosPlaylist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Playlists` (
  `idPlaylists` INT NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NOT NULL,
  `numeroCanciones` VARCHAR(45) NOT NULL,
  `fechaCreacion` DATE NOT NULL,
  `idUsuario` INT NOT NULL,
  `fechaEliminacion` DATE NOT NULL,
  `idestadosPlaylist` INT NOT NULL,
  PRIMARY KEY (`idPlaylists`),
  INDEX `fk_Playlists_Usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_Playlists_estadosPlaylist1_idx` (`idestadosPlaylist` ASC) VISIBLE,
  CONSTRAINT `fk_Playlists_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Spotify_DB`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlists_estadosPlaylist1`
    FOREIGN KEY (`idestadosPlaylist`)
    REFERENCES `Spotify_DB`.`estadosPlaylist` (`idestadosPlaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Artistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Artistas` (
  `idArtista` INT NOT NULL AUTO_INCREMENT,
  `nombreArtista` VARCHAR(45) NOT NULL,
  `imagenArtista` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idArtista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Discograficas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Discograficas` (
  `idDiscografica` INT NOT NULL AUTO_INCREMENT,
  `nombreDiscografica` VARCHAR(45) NOT NULL,
  `idPais` INT NOT NULL,
  PRIMARY KEY (`idDiscografica`),
  INDEX `fk_Discograficas_Paises1_idx` (`idPais` ASC) VISIBLE,
  CONSTRAINT `fk_Discograficas_Paises1`
    FOREIGN KEY (`idPais`)
    REFERENCES `Spotify_DB`.`Paises` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Albunes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Albunes` (
  `idAlbum` INT NOT NULL AUTO_INCREMENT,
  `tituloAlbum` VARCHAR(45) NOT NULL,
  `anioPublicacion` YEAR NOT NULL,
  `imagen` VARCHAR(200) NOT NULL,
  `idArtista` INT NOT NULL,
  `idDiscografica` INT NOT NULL,
  PRIMARY KEY (`idAlbum`),
  INDEX `fk_Albunes_Artistas1_idx` (`idArtista` ASC) VISIBLE,
  INDEX `fk_Albunes_Discograficas1_idx` (`idDiscografica` ASC) VISIBLE,
  CONSTRAINT `fk_Albunes_Artistas1`
    FOREIGN KEY (`idArtista`)
    REFERENCES `Spotify_DB`.`Artistas` (`idArtista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Albunes_Discograficas1`
    FOREIGN KEY (`idDiscografica`)
    REFERENCES `Spotify_DB`.`Discograficas` (`idDiscografica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Canciones` (
  `idCancion` INT NOT NULL AUTO_INCREMENT,
  `tituloCancion` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `numeroReproducciones` MEDIUMINT NOT NULL,
  `cantidadLikes` MEDIUMINT NOT NULL,
  `idAlbum` INT NOT NULL,
  PRIMARY KEY (`idCancion`),
  INDEX `fk_Canciones_Albunes1_idx` (`idAlbum` ASC) VISIBLE,
  CONSTRAINT `fk_Canciones_Albunes1`
    FOREIGN KEY (`idAlbum`)
    REFERENCES `Spotify_DB`.`Albunes` (`idAlbum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Generos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Generos` (
  `idGenero` INT NOT NULL AUTO_INCREMENT,
  `nombreGenero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Spotify_DB`.`Generos_x_canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Spotify_DB`.`Generos_x_canciones` (
  `idGeneros_x_canciones` INT NOT NULL AUTO_INCREMENT,
  `idCancion` INT NOT NULL,
  `_idGenero` INT NOT NULL,
  PRIMARY KEY (`idGeneros_x_canciones`),
  INDEX `fk_Generos_x_canciones_Canciones1_idx` (`idCancion` ASC) VISIBLE,
  INDEX `fk_Generos_x_canciones_Generos1_idx` (`_idGenero` ASC) VISIBLE,
  CONSTRAINT `fk_Generos_x_canciones_Canciones1`
    FOREIGN KEY (`idCancion`)
    REFERENCES `Spotify_DB`.`Canciones` (`idCancion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Generos_x_canciones_Generos1`
    FOREIGN KEY (`_idGenero`)
    REFERENCES `Spotify_DB`.`Generos` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
