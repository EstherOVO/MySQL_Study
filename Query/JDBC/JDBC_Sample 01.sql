CREATE SCHEMA jdbc;
USE jdbc;

-- 사용자 테이블
CREATE TABLE users (
	userID VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- 게시판 테이블
CREATE TABLE boards (
	boardNo INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT NOT NULL,
    writer VARCHAR(255) NOT NULL,
    date DATETIME DEFAULT NOW(),	-- 기본 제약조건 날짜
    filename VARCHAR(255) NULL,		-- 파일 이름(필수 아님)
    filedata LONGBLOB NULL			-- 파일 이진 데이터
);

-- 계좌 테이블
CREATE TABLE accounts (
	accountNo VARCHAR(255) PRIMARY KEY,
    owner VARCHAR(255) NOT NULL,
    balance INT NOT NULL
);

INSERT INTO accounts VALUES ('111-111-1111', '홍길동', 1000000);
INSERT INTO accounts VALUES ('222-222-2222', '전우치', 0);

SELECT * FROM users;
SELECT * FROM boards;
SELECT * FROM accounts;

ALTER TABLE boards AUTO_INCREMENT = 4;