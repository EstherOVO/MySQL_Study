-- 직원 : 스키마별로 권한 부여
CREATE DATABASE test_db;

USE employees;
SELECT * FROM employees;
DELETE FROM employees;

-- 권한이 있는 스키마에 대해서는 명령 적용 가능
USE shopdb;
SELECT * FROM memberTBL;
DELETE FROM memberTBL WHERE memberID = 'ABC';

SELECT * FROM memberTBL;