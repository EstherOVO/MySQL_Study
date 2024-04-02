-- 기본 튜토리얼!
-- Ctrl + / : 주석
-- Ctrl + B : 쿼리문 정리
-- Ctrl + Enter : 해당 코드라인만 실행
-- 행 개수 제한을 선택할 수 있다.(기본은 1,000줄)
-- [Edit] → [Preferences] → [SQL Editor] → [Query Editor] → UPPERCASE keywords on completion : 예약어를 대문자로 자동 완성하고 싶을 때

-- 데이터 선택하여 활용
SELECT * FROM productTBL;
SELECT memberName, memberAddress FROM memberTBL;
SELECT * FROM memberTBL WHERE memberName = '지운이';

-- 테이블의 생성과 삭제
CREATE TABLE `my test_tbl` (id INT);
DROP TABLE `my test_tbl`;

-- 인덱스 생성(데이터 삽입 및 비교)
CREATE TABLE INDEX_TBL (first_name varchar(14), last_name varchar(16), hire_date date);
INSERT INTO INDEX_TBL SELECT first_name, last_name, hire_date FROM employees.employees LIMIT 500;
SELECT * FROM INDEX_TBL;

SELECT * FROM index_tbl WHERE first_Name = 'Mary';

CREATE INDEX IDX_INDEX_TBL_FIRSTNAME ON INDEX_TBL(FIRST_NAME);

-- 사용자 뷰 만들기
CREATE VIEW uv_member_tbl AS SELECT memberName, memberAddress FROM membertbl;
SELECT * FROM uv_member_tbl;

-- 테이블 데이터 삭제
DELETE FROM producttbl;
SELECT * FROM producttbl;