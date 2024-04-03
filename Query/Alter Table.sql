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