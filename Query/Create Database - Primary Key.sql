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

