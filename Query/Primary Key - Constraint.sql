-- 데이터베이스(스키마 생성)
CREATE DATABASE test_db;

-- 데이터베이스 사용
USE test_db;

-- 테이블 생성
-- 제약조건 설정하기
CREATE TABLE employees (
	employee_ID INT NOT NULL, -- 컬럼에서 제약조건
	first_name VARCHAR(50),
    last_name VARCHAR(50),
    PRIMARY KEY (employee_ID) -- 해당 컬럼을 기본 키로 설정
);

-- 테이블의 정보 확인하기
DESCRIBE employees;

-- 복합 기본 키 설정하기
CREATE TABLE player (
	team_id INT	NOT NULL,
    back_number INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    PRIMARY KEY (team_id, back_number)
    -- team_id, back_numbe 을 조합하여 기본 키로 만들 수 있다.
    -- 각 컬럼은 중복될 수 있지만, 두 조합으로는 고유한 기본키 생성
);

-- 2개의 컬럼으로 기본 키 구성 확인
DESC player;

CREATE TABLE members (
	member_id INT PRIMARY KEY
    -- 복합 키 속성이 하나일 경우
    -- 컬럼에서 제약조건을 지정할 수도 있다.
);

DESC members;

-- UNIQUE 제약조건
-- 동일한 값이 두 번 이상 나타나지 않도록
CREATE TABLE users (
	user_ID INT PRIMARY KEY,
	user_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE -- email 열의 고유 보장, Null 허용
);

DESCRIBE users;
SELECT * FROM users;

-- CHECK 제약조건
CREATE TABLE adults (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    CHECK (age >= 19)	-- age 필드에 값이 들어올 때 19세 이상인지 체크
);

DESCRIBE adults;
SELECT * FROM adults;

-- DEFAULT 제약조건
CREATE TABLE persons (
	id 	INT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
    status VARCHAR(50) DEFAULT '활동 중',	-- 상태 열이 기본 값으로 '활동 중'
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP	-- 가입일 기본 값으로 현재 시간
    -- 혹은 날짜만 넣고 싶을 경우 join_date DATE DEFAULT (CURRENT_DATE)
);

DESCRIBE persons;
SELECT * FROM persons;
DROP TABLE persons;

-- AUTO_INCREMENT 데이터베이스에서 자동으로 값이 증가하는 열 설정
CREATE TABLE products (
	product_ID INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL
);

DESCRIBE products;
SELECT * FROM products;

USE test_db;
DROP TABLE employees;
-- 외래 키(Foreign Key) - 참조 무결성 제약조건
-- 한 테이블의 컬럼이 다른 테이블의 키(기본 키)를 참조

-- 부서 테이블
CREATE TABLE departments (
	department_ID INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

-- 직원 테이블 생성
CREATE TABLE employees (
	employee_ID INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    department_ID INT, 
    -- 직원 테이블의 부서 ID는 부서 테이블의 부서 ID를 참조(외래 키 설정)
    FOREIGN KEY (department_ID) REFERENCES departments (department_ID)
);

-- 외래 키 컬럼에 참조 위치에 존재하지 않는 값을 넣을 경우
-- 참조 무결성을 위반하게 되어 실행되지 않는다. → 참조 무결성 제약조건
SELECT * FROM employees;
SELECT * FROM departments;

DROP TABLE employees;
DROP TABLE departments;

-- 외래 키 레퍼런스 옵션
-- 1. CASCADE
CREATE TABLE departments (
	department_ID INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

CREATE TABLE employees (
	employee_ID INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    department_ID INT, 
    FOREIGN KEY (department_ID) REFERENCES departments (department_ID)
    -- 특정 부서가 삭제될 때 해당 부서 직원 정보도 모두 삭제
    ON DELETE CASCADE
);

DESCRIBE employees;
-- CASCADE 적용 확인
SELECT * FROM employees;
SELECT * FROM departments;

-- 2. SET NULL
-- 테이블 삭제
DROP TABLE employees;
DROP TABLE departments;

CREATE TABLE departments (
	department_ID INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

CREATE TABLE employees (
	employee_ID INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    department_ID INT, 
    FOREIGN KEY (department_ID) REFERENCES departments (department_ID)
    -- 특정 부서가 삭제될 때 해당 부서 직원의 부서 ID가 NULL로 설정된다.
    ON DELETE SET NULL
);

DESCRIBE employees;
-- SET NULL 적용 확인
SELECT * FROM departments;
SELECT * FROM employees;

-- 3. NO ACTION
-- 고객 테이블 생성
CREATE TABLE customers (
	customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL
);

-- 고객 테이블을 참조하는 주문 테이블 생성
CREATE TABLE orders (
	order_ID INT AUTO_INCREMENT PRIMARY KEY,
    customer_ID INT,
    order_date DATE,
    FOREIGN KEY (customer_ID) REFERENCES customers (customer_ID)
    -- 특정 고객 정보를 삭제하려고 하거나 고객 ID를 변경하려고 할 때
    -- 작업을 거부하게 됨
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

DESC customers;
DESC orders;
SELECT * FROM customers;
SELECT * FROM orders;