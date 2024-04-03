-- 테이블 구조 변경
-- Alter문 실습
CREATE SCHEMA alter_test;
USE alter_test;

-- 샘플 데이터베이스에서 테이블 구조 복사
CREATE TABLE employees
LIKE employees.employees;

-- 복사한 구조 확인
DESCRIBE employees;
SELECT * FROM employees;

-- 새로운 컬럼(열, Column)을 추가
ALTER TABLE employees
ADD COLUMN phone_number VARCHAR(20);

-- 생성한 컬럼(열, Column)을 삭제
ALTER TABLE employees
DROP COLUMN phone_number;

-- 컬럼(열, Column) 명 변경
ALTER TABLE employees
CHANGE COLUMN `first_name` `firstname` VARCHAR(14);

-- 컬럼(열, Column) 데이터 타입 변경하기
ALTER TABLE employees
MODIFY COLUMN `hire_date` DATETIME;

-- 테이블 이름 변경하기
ALTER TABLE employees
RENAME TO employees_backup;
-- 원상복구
ALTER TABLE employees_backup
RENAME TO employees;

DESCRIBE employees;

-- ---------------------------------------

-- 제약조건 추가하기
ALTER TABLE employees ADD COLUMN email VARCHAR(255);

-- UNIQUE 제약조건 추가
ALTER TABLE employees ADD UNIQUE (email);

-- 1. 외래 키 제약조건 추가
-- 1) 참조할 테이블 생성
CREATE TABLE departments (
	department_ID INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- 2) 외래 키로 사용할 필드 추가
ALTER TABLE employees ADD COLUMN department_ID INT;

-- 3) 외래 키 제약조건 추가
ALTER TABLE employees ADD CONSTRAINT fk_department_ID
FOREIGN KEY (department_ID) REFERENCES departments (department_ID);

DESCRIBE employees;

-- 2. 체크 제약조건 추가
-- 1) 체크할 필드 추가
ALTER TABLE employees ADD COLUMN age INT;

-- 2) 체크 제약조건 추가(제약조건의 이름을 명시 : CONSTRAINT 제약조건이름)
ALTER TABLE employees ADD CONSTRAINT chk_age
CHECK (age >= 18);

-- 열에 대한 설명 추가
ALTER TABLE employees ADD COLUMN salary INT COMMENT '직원의 급여와 관련된 속성';

-- 3. 제약조건 삭제하기
-- 1) 외래 키 삭제하기
ALTER TABLE employees DROP FOREIGN KEY fk_department_ID;

-- 2) 체크 명시 제약조건 삭제하기
ALTER TABLE employees DROP CHECK chk_age;

-- ---------------------------------------

-- ALTER COLUMN으로 열 속성 변경하기
-- 1. 기본 값 추가
ALTER TABLE employees ALTER COLUMN age SET DEFAULT 20;

-- 2. 기본 값 삭제
ALTER TABLE employees ALTER COLUMN age DROP DEFAULT;

DESCRIBE departments;
DESCRIBE employees;
SELECT * FROM departments;
SELECT * FROM employees;