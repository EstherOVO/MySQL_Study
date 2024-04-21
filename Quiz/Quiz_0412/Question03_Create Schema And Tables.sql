CREATE SCHEMA IF NOT EXISTS `class_db`;
USE `class_db`;

-- 1. 멤버(Member) 테이블 생성
CREATE TABLE `Member` (
	`member_ID` INT NOT NULL AUTO_INCREMENT,
	`member_name` VARCHAR(45) NOT NULL,
	`member_addr` VARCHAR(45) NULL,
	`member_number` VARCHAR(45) NULL,
	PRIMARY KEY (`member_ID`));
    
-- 2. 트레이너(Trainer) 테이블 생성
CREATE TABLE IF NOT EXISTS `Trainer` (
	`trainer_ID` INT NOT NULL AUTO_INCREMENT,
	`trainer_name` VARCHAR(45) NOT NULL,
	`trainer_specialty` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`trainer_ID`));
    
-- 3. 강습 클래스(Class) 테이블 생성
CREATE TABLE IF NOT EXISTS `Class` (
	`class_id` INT NOT NULL AUTO_INCREMENT,
	`class_name` VARCHAR(45) NOT NULL,
	`class_start_time` TIME NULL,
	`class_end_time` TIME NULL,
	`trainer_ID` INT NOT NULL,
	PRIMARY KEY (`class_id`),
	CONSTRAINT `fk_Class_Trainer1`
	FOREIGN KEY (`trainer_ID`) REFERENCES `Trainer` (`trainer_ID`) ON DELETE CASCADE ON UPDATE CASCADE);
    
-- 4. 등록(Enrollment) 클래스 관리
CREATE TABLE IF NOT EXISTS `Enrollment` (
	`class_id` INT NOT NULL,
	`trainer_ID` INT NOT NULL,
	`member_ID` INT NOT NULL,
	CONSTRAINT `fk_Enrollment_Class`
	FOREIGN KEY (`class_id`) REFERENCES `Class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_Enrollment_Trainer1`
	FOREIGN KEY (`trainer_ID`) REFERENCES `Trainer` (`trainer_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_Enrollment_Member1`
	FOREIGN KEY (`member_ID`) REFERENCES `Member` (`member_ID`) ON DELETE CASCADE ON UPDATE CASCADE);