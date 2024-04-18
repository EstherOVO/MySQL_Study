DROP SCHEMA IF EXISTS db_index;
CREATE SCHEMA db_index;
USE db_index;

-- 기본 페이지 크기 확인(기본 값 16KB)
SHOW VARIABLES LIKE 'innodb_page_size';

-- ---------------------------------------
-- 1. 클러스터 테이블 생성
-- ---------------------------------------

DROP TABLE IF EXISTS clustertbl;
CREATE TABLE clustertbl(
	userID CHAR(8),
	name VARCHAR(10) 
);

INSERT INTO clustertbl VALUES ('LSG', '이승기');
INSERT INTO clustertbl VALUES ('KBS', '김범수');
INSERT INTO clustertbl VALUES ('KKH', '김경호');
INSERT INTO clustertbl VALUES ('JYP', '조용필');
INSERT INTO clustertbl VALUES ('SSK', '성시경');
INSERT INTO clustertbl VALUES ('LJB', '임재범');
INSERT INTO clustertbl VALUES ('YJS', '윤종신');
INSERT INTO clustertbl VALUES ('EJW', '은지원');
INSERT INTO clustertbl VALUES ('JKW', '조관우');
INSERT INTO clustertbl VALUES ('BBK', '바비킴');

SELECT * FROM clustertbl;

-- 현재 인덱스가 없는 상태 → 데이터 삽입 순으로 조회(정렬)
SHOW INDEX FROM clustertbl;

-- 인덱스 추가
ALTER TABLE clustertbl
ADD CONSTRAINT pk_clustertbl_userID
PRIMARY KEY (userID);

-- 기본 키를 생성함에 따라 클러스터형 인덱스 생성됨
SHOW INDEX FROM clustertbl;

-- 클러스터형 인덱스(userID) 
SELECT * FROM clustertbl;

-- 클러스터형 인덱스의 루트 페이지 → 리프 페이지 또는 인터널페이지의 주소
-- 클러스터형 인덱스의 리프 페이지 → 실제 데이터가 저장이 되어 있다.

-- ---------------------------------------
-- 2. 보조 테이블 생성
-- ---------------------------------------

DROP TABLE IF EXISTS secondarytbl;
CREATE TABLE secondarytbl(
	userID CHAR(8),
	name VARCHAR(10) 
);

INSERT INTO secondarytbl VALUES ('LSG', '이승기');
INSERT INTO secondarytbl VALUES ('KBS', '김범수');
INSERT INTO secondarytbl VALUES ('KKH', '김경호');
INSERT INTO secondarytbl VALUES ('JYP', '조용필');
INSERT INTO secondarytbl VALUES ('SSK', '성시경');
INSERT INTO secondarytbl VALUES ('LJB', '임재범');
INSERT INTO secondarytbl VALUES ('YJS', '윤종신');
INSERT INTO secondarytbl VALUES ('EJW', '은지원');
INSERT INTO secondarytbl VALUES ('JKW', '조관우');
INSERT INTO secondarytbl VALUES ('BBK', '바비킴');

-- 현재 인덱스가 없는 상태 → 데이터 삽입 순으로 조회(정렬)
SHOW INDEX FROM secondarytbl;

-- 보조 인덱스 추가
ALTER TABLE secondarytbl
ADD UNIQUE uq_secondarytbl_userID (userID);

-- 보조 인덱스가 생성됐으나, 데이터는 userID 컬럼 기준으로 정렬되어 있지 않다.
-- 보조 인덱스의 리프 페이지에서는 인덱스 컬럼(userID) 기준으로 정렬되어 있다.
-- 보조 인덱스의 리프 페이지는 실제 데이터를 가지고 있는 것이 아니라, 데이터의 위치를 가리키는 위치 포인터를 가지고 있다.
SHOW INDEX FROM secondarytbl;
SELECT * FROM secondarytbl;

-- 클러스터형 인덱스는 범위 검색 시 우수한 성능을 보인다.
-- 보조 인덱스는 범위 검색을 하기 위해 각기 분산되어 있는 페이지에 접근해야 한다.
-- 페이지 분할은 시스템에 많은 부하를 주게 된다.
INSERT INTO clustertbl VALUES ('FNT', '푸니타');
INSERT INTO clustertbl VALUES ('KAI', '카아이');

-- 보조형 인덱스에 데이터를 삽입하게 될 경우
-- 실제 데이터 페이지의 빈 부분에 삽입되고
-- 인덱스 위치만 조정하게 된다. → 클러스터형 인덱스보다 성능에 주는 부하가 적다.
INSERT INTO secondarytbl VALUES ('FNT', '푸니타');
INSERT INTO secondarytbl VALUES ('KAI', '카아이');

-- ---------------------------------------
-- 3. 혼합 테이블 생성
-- ---------------------------------------

CREATE TABLE mixedtbl (
	userID CHAR(8) NOT NULL,
	name VARCHAR(10) NOT NULL,
	addr char(2)
);

INSERT INTO mixedtbl VALUES('LSG', '이승기', '서울');
INSERT INTO mixedtbl VALUES('KBS', '김범수', '경남');
INSERT INTO mixedtbl VALUES('KKH', '김경호', '전남');
INSERT INTO mixedtbl VALUES('JYP', '조용필', '경기');
INSERT INTO mixedtbl VALUES('SSK', '성시경', '서울');
INSERT INTO mixedtbl VALUES('LJB', '임재범', '서울');
INSERT INTO mixedtbl VALUES('YJS', '윤종신', '경남');
INSERT INTO mixedtbl VALUES('EJW', '은지원', '경북');
INSERT INTO mixedtbl VALUES('JKW', '조관우', '경기');
INSERT INTO mixedtbl VALUES('BBK', '바비킴', '서울');

-- 클러스터형 인덱스 추가
-- 실제 데이터 페이지가 정렬됨
ALTER TABLE mixedtbl
ADD CONSTRAINT pk_mixedtbl_userID
PRIMARY KEY (userID);

-- 이름 컬럼 기준으로 보조형 인덱스 추가
ALTER TABLE mixedtbl
ADD UNIQUE uk_mixedtbl_name (name);

SHOW INDEX FROM mixedtbl;

-- 혼합된 인덱스의 경우
-- 보조 인덱스에서 컬럼명(이름) 기준으로 검색하여 루트 페이지에서 리프 페이지로 탐색
-- 리프 페이지(name 기준으로 정렬되어 있으며, 클러스터형 인덱스의 key 값을 저장)에서 
-- 이름을 기준으로 클러스터형 인덱스의 키 값(userID)을 확인한 후
-- 클러스터형 루트 페이지로 가서 키 값으로 검색한 후 원하는 결과를 찾음

-- WHERE 절에 인덱스를 사용한 컬럼의 이름이 있을 경우 해당 인덱스를 사용하게 된다.
SELECT addr FROM mixedtbl WHERE name = '임재범';
-- 어떤 인덱스를 사용하였는지 쿼리 확인하기
EXPLAIN SELECT addr FROM mixedtbl WHERE name = '임재범';