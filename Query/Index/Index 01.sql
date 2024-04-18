CREATE SCHEMA db_index;
USE db_index;

CREATE TABLE table1 (
	pk INT,
    col_a INT,
    col_b INT,
    CONSTRAINT pk_table1_pk PRIMARY KEY (pk)
);

-- 인덱스 확인하기
-- Key_name : 인덱스의 이름, PRIMARY는 기본 키 클러스터형 인덱스
-- Column_name : 인덱스에 포함된 컬럼의 이름
SHOW INDEX FROM table1;

CREATE TABLE table2 (
	pk INT,		-- 클러스터형 인덱스 자동 생성
    col_a INT UNIQUE,	-- 유니크 인덱스 자동 생성
    col_b INT UNIQUE,	-- 보조 인덱스는 여러 개 가능
    col_c INT,		-- 제약 조건이 없으면 자동 생성하지 않음
    CONSTRAINT pk_table1_pk PRIMARY KEY (pk)	
);

SHOW INDEX FROM table2;

-- PRIMARY KEY가 없는 경우(모두 보조 인덱스로 지정)
CREATE TABLE table3 (
	col_z INT UNIQUE,
    col_a INT UNIQUE,
    col_b INT UNIQUE,
    col_c INT
);

SHOW INDEX FROM table3;

-- 기본 키가 없고 고유 속성과 NOT NULL 속성이 존재하는 컬럼은 자동으로 클러스터형 인덱스가 생성된다.
CREATE TABLE table4 (
	col_z INT UNIQUE NOT NULL,	-- 고유값 + NOT NULL
    col_a INT UNIQUE,
    col_b INT UNIQUE,
    col_c INT
);

SHOW INDEX FROM table4;

-- 클러스터형 인덱스는 테이블 당 하나만 존재하기 때문에, 기본 키만 클러스터형 인덱스가 생성된다.
CREATE TABLE table5 (
	col_z INT UNIQUE NOT NULL,	-- 고유값 + NOT NULL → 보조 인덱스
    col_a INT UNIQUE,
    col_b INT UNIQUE,
    col_c INT PRIMARY KEY	-- 기본 키 → 클러스터형 인덱스
);

SHOW INDEX FROM table5;

-- 외래 키 인덱스 자동 생성
CREATE TABLE table6 (
	col_z INT PRIMARY KEY,	
    col_a INT UNIQUE,
    col_b INT,
    col_c INT,
    CONSTRAINT fk_table6_col_c FOREIGN KEY (col_c) REFERENCES table5 (col_c)
);

SHOW INDEX FROM table6;