-- 이상현상(Anomaly)

CREATE SCHEMA IF NOT EXISTS normalization;
USE normalization;

-- 계절학기 테이블(스키마 초기화)
DROP TABLE IF EXISTS summer;
CREATE TABLE summer (
	s_ID INT,	-- 학번
    class VARCHAR(30),	-- 과정명
    price INT	-- 수강료
);

-- 초기 값 삽입
INSERT INTO summer
VALUES (100, 'Java', 20000), (150, 'Python', 15000), (200, 'C', 10000), (250, 'Java', 20000);

SELECT * FROM summer;	-- 테이블 확인

-- SELECT 문
-- 1. 계절학기를 듣는 학생의 학번과 과정명은?
SELECT s_ID, class FROM summer;

-- 2. 'C' 강좌의 수강료는?
SELECT class, price FROM summer WHERE class = 'C';

-- 3. 수강료가 가장 비싼 과목은?
SELECT DISTINCT class FROM summer WHERE price = (SELECT max(price) FROM summer);

-- 4. 계절학기를 듣는 학생 수와 수강료 총액은?
SELECT count(*), sum(price) FROM summer;

SELECT * FROM summer;	-- 확인
-- 삭제 이상
-- 질의 : 200번 학생의 계절하기 수강신청을 취소하세요.
DELETE FROM summer WHERE s_ID = 200;

-- 삭제 전에 조회할 수 있었던 'C' 과목의 수강료가 삭제됨 → 의도하지 않음
-- C 과목의 수강료가 조회되지 않음
SELECT class, price FROM summer WHERE class LIKE 'C';	-- 삭제 이상

-- 테이블 초기화
-- 삽입 이상
-- 질의 : 계절학기에 새로운 강좌 'C++'(25000원)을 개설하세요.
INSERT INTO summer (class, price) VALUES ('C++', 25000);
-- 의도하지 않은 null 값이 포함
-- 4번 질의를 수행했을 경우 일관성이 깨지고, 원하지 않는 결과가 수행
SELECT count(*), sum(price) FROM summer;				-- 삽입 이상

-- 원상복구
DELETE FROM summer WHERE class LIKE 'C++';

-- 수정 이상
-- 질의 : Java 강좌의 가격을 15000원으로 수정하세요.
UPDATE summer SET price = 15000 WHERE class LIKE 'Java' AND s_ID = 100;
-- 고유 값을 기반으로 조건부 수정하게 될 경우 최신 값 일관성이 깨진다.
-- Java 강의료를 조회하면 데이터 불일치가 발생하게 된다.(2개의 행)
SELECT price FROM summer WHERE class = 'Java';

-- ---------------------------------------

-- 이상현상을 발생시키지 않기 위해 테이블 구조를 수정
-- 1. 과정명과 가격 정보만 가지고 있는 테이블
CREATE TABLE summerPrice (
	class VARCHAR(30),
    price INT
);

INSERT INTO summerPrice VALUES ('Java', 20000), ('Python', 15000), ('C', 10000);
SELECT * FROM summerPrice;

-- 2. 학생이 어떤 강의를 듣는지에 대한 정보를 가지고 있는 테이블
CREATE TABLE summerEnroll (
	s_ID INT,
    class VARCHAR(30)
);

INSERT INTO summerEnroll VALUES (100, 'Java'), (150, 'Python'), (200, 'C'), (250, 'Java');
SELECT * FROM summerEnroll;

-- (분해된 테이블에서의) SELECT 문
-- 1. 계절학기를 듣는 학생의 학번과 과정명은?
SELECT s_ID, class FROM summerEnroll;

-- 2. 'C' 강좌의 수강료는?
SELECT class, price FROM summerPrice WHERE class = 'C';

-- 3. 수강료가 가장 비싼 과목은?
SELECT class FROM summerPrice WHERE price = (SELECT max(price) FROM summerPrice);

-- 4. 계절학기를 듣는 학생 수와 수강료 총액은?
SELECT count(se.s_ID), sum(sp.price)
FROM summerEnroll se
JOIN summerPrice sp USING (class); 

SELECT * FROM summerPrice;
SELECT * FROM summerEnroll;

-- 삭제 이상 → 다시 수행
-- 질의 : 200번 학생의 계절하기 수강신청을 취소하세요.
DELETE FROM summerEnroll WHERE s_ID = 200;

-- 200번 학생의 수강신청은 취소되었지만, C 강좌의 수강료 정보는 다른 테이블에 남아있다.
SELECT class, price FROM summerPrice WHERE class = 'C';	-- 성공적으로 수행

-- 삽입 이상 → 다시 수행
-- 질의 : 계절학기에 새로운 강좌 'C++'(25000원)을 개설하세요.
INSERT INTO summerPrice VALUES ('C++', 25000);
-- 의도하지 않은 null 값이 삽입되지 않음
-- 수강 신청한 학생 없이도 과정(수강료 포함)만 성공적으로 개설

-- 4번 질의(집계함수) 수행하여도 성공적으로 수행
SELECT count(se.s_ID), sum(sp.price)
FROM summerEnroll se
JOIN summerPrice sp USING (class); 

-- 수정 이상 → 다시 수행
-- 질의 : Java 강좌의 가격을 15000원으로 수정하세요.
UPDATE summerPrice SET price = 15000 WHERE class LIKE 'Java';

-- 3번 질의 재수행
SELECT class FROM summerPrice WHERE price = (SELECT max(price) FROM summerPrice);