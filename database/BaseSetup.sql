-- MySQL Script generated by MySQL Workbench
-- Sun Jan 11 14:10:06 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`languages` ;

CREATE TABLE IF NOT EXISTS `mydb`.`languages` (
  `language_id` INT NOT NULL AUTO_INCREMENT,
  `lang_name` VARCHAR(150) NOT NULL,
  `lang_string` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`countries` ;

CREATE TABLE IF NOT EXISTS `mydb`.`countries` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(150) NOT NULL,
  `country_abbr` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`languages_countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`languages_countries` ;

CREATE TABLE IF NOT EXISTS `mydb`.`languages_countries` (
  `languages_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`languages_id`, `country_id`),
  CONSTRAINT `fk_languages_countries_languages`
    FOREIGN KEY (`languages_id`)
    REFERENCES `mydb`.`languages` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_languages_countries_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_languages_countries_languages_idx` ON `mydb`.`languages_countries` (`languages_id` ASC);

CREATE INDEX `fk_languages_countries_countries1_idx` ON `mydb`.`languages_countries` (`country_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`translated_strings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`translated_strings` ;

CREATE TABLE IF NOT EXISTS `mydb`.`translated_strings` (
  `translated_strings_id` INT NOT NULL AUTO_INCREMENT,
  `language_id` INT NOT NULL,
  `content_key` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`translated_strings_id`),
  CONSTRAINT `fk_translated_strings_languages1`
    FOREIGN KEY (`language_id`)
    REFERENCES `mydb`.`languages` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_translated_strings_languages1_idx` ON `mydb`.`translated_strings` (`language_id` ASC);

CREATE UNIQUE INDEX `content_key_UNIQUE` ON `mydb`.`translated_strings` (`content_key` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`translated_contents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`translated_contents` ;

CREATE TABLE IF NOT EXISTS `mydb`.`translated_contents` (
  `translated_content_id` INT NOT NULL AUTO_INCREMENT,
  `translated_strings_id` INT NOT NULL,
  `content` LONGTEXT NOT NULL,
  PRIMARY KEY (`translated_content_id`),
  CONSTRAINT `fk_translated_contents_translated_strings1`
    FOREIGN KEY (`translated_strings_id`)
    REFERENCES `mydb`.`translated_strings` (`translated_strings_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_translated_contents_translated_strings1_idx` ON `mydb`.`translated_contents` (`translated_strings_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`projects` ;

CREATE TABLE IF NOT EXISTS `mydb`.`projects` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `project_name` VARCHAR(200) NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`project_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`projects_translated_strings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`projects_translated_strings` ;

CREATE TABLE IF NOT EXISTS `mydb`.`projects_translated_strings` (
  `projects_project_id` INT NOT NULL,
  `translated_strings_translated_strings_id` INT NOT NULL,
  PRIMARY KEY (`projects_project_id`, `translated_strings_translated_strings_id`),
  CONSTRAINT `fk_projects_translated_strings_projects1`
    FOREIGN KEY (`projects_project_id`)
    REFERENCES `mydb`.`projects` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_translated_strings_translated_strings1`
    FOREIGN KEY (`translated_strings_translated_strings_id`)
    REFERENCES `mydb`.`translated_strings` (`translated_strings_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_projects_translated_strings_translated_strings1_idx` ON `mydb`.`projects_translated_strings` (`translated_strings_translated_strings_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
