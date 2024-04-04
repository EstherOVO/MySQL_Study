CREATE SCHEMA ex_insert;
USE ex_insert;

CREATE TABLE employees LIKE employees.employees;

DESC employees;

-- 데이터 삽입 1 : 컬럼을 지정하는 방식
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES (101, '1998-01-01', '길동', '홍', 'M', '2020-01-01');

SELECT * FROM employees;	-- 확인

-- 데이터 삽입 2 : 컬럼을 지정하지 않는 방식
INSERT INTO employees VALUES (102, '2000-01-01', '생', '허', 'M', '2020-01-01');

SELECT * FROM employees;

-- 데이터 구조 변경 : NULL 허용 및 기본 키 자동 증가
ALTER TABLE `ex_insert`.`employees` 
CHANGE COLUMN `emp_no` `emp_no` INT NOT NULL AUTO_INCREMENT,
CHANGE COLUMN `birth_date` `birth_date` DATE NULL,
CHANGE COLUMN `hire_date` `hire_date` DATE NULL;

-- 특정 컬럼만 지정하여 삽입
INSERT INTO employees (first_name, last_name, gender)
VALUES ('사임당', '신', 'F');

SELECT * FROM employees;	-- 확인

-- 컬럼의 순서를 변경하여 삽입
INSERT INTO employees (gender, last_name, first_name)
VALUES ('M', '전', '우치');

SELECT * FROM employees;	-- 확인

-- 여러 줄 삽입
INSERT INTO employees (gender, last_name, first_name)
VALUES ('F', '유', '관순'),
	   ('M', '김', '철수');

SELECT * FROM employees;	-- 확인

-- 대량의 데이터 삽입
INSERT INTO `ex_insert`.`employees`
SELECT * FROM `employees`.`employees`;

SELECT * FROM employees;	-- 확인