USE quiz;

-- 1. 인덱스 생성 전 `employees` 테이블에 `first_name`과 `last_name` 컬럼을 조건으로 하는 쿼리문을 실행하세요.
SELECT first_name, last_name FROM employees;
SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';

-- 2. `EXPLAIN`과 Execution Plan을 사용하여 `first_name`과  `last_name`을 조건으로 하는 SELECT 쿼리의 실행 계획을 확인하세요.
EXPLAIN SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';

-- 3. `employees` 테이블에 `first_name`과  `last_name` 컬럼에 대한 복합 인덱스를 생성하세요.
ALTER TABLE employees ADD INDEX idx_employees_name (first_name, last_name);

-- 4. 인덱스 생성 전후의 쿼리문의 실행 시간을 비교하세요.
SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';
-- 인덱스 생성 전 → 실행 시간 : 0.156초 / Query Cost : 30183.45

SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';
-- 인덱스 생성 후 → 실행 시간 : 0.000초 / Query Cost : 0.70

-- 5. `employees` 테이블의 모든 인덱스 정보를 조회하세요.
SHOW INDEX FROM employees;