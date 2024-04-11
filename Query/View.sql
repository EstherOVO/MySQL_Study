-- 뷰(View)
USE scott;

-- 뷰 생성
CREATE VIEW view_emp AS 
SELECT * FROM emp;

-- 생성된 뷰는 새로운 가상의 테이블처럼 접근
SELECT * FROM view_emp;

-- 뷰의 삭제
DROP VIEW view_emp;

-- 1. 뷰의 장점 : 보안에 도움이 되고, 사용자에게 보여주고 싶은 속성만 보여줄 수 있다.
-- 뷰로 조건부 데이터 선택
CREATE VIEW view_emp_30 AS
SELECT * FROM emp WHERE DEPTNO = 30;

-- 일반 테이블처럼 조회하여 사용할 수 있다.
SELECT * FROM view_emp_30;
SELECT ENAME FROM view_emp_30;

-- 2. 복잡한 쿼리를 단순화 시켜줄 수 있다.
SELECT * FROM emp;
SELECT * FROM dept;

CREATE VIEW emp_dept_view AS
SELECT e.ENAME AS employee_name, d.DNAME AS department_name FROM emp e
INNER JOIN dept d ON e.DEPTNO = d.DEPTNO;

-- 두 개 이상의 테이블이 조인된 복잡한 쿼리도 결과 셋을 뷰로 단순화 시킬 수 있다.
-- 쿼리 결과 셋의 컬럼의 별칭은 뷰의 컬럼의 컬럼명이 된다.
SELECT employee_name, department_name FROM emp_dept_view;

-- 뷰 실습
USE sqldb;

CREATE VIEW view_userbuytbl AS
SELECT u.userID AS `User Id`, u.name AS `User Name`, b.prodName AS `Product Name`,
u.addr AS `User Address`, concat_ws('-', u.mobile1, left(u.mobile2, 4), right(u.mobile2, 4)) AS `Mobile Phone`
FROM usertbl u
INNER JOIN buytbl b
ON u.userID = b.userID;

SELECT * FROM view_userbuytbl;
SELECT `User Id`, `User Name` FROM view_userbuytbl;

-- CREATE OR REPLACE VIEW
-- 기존의 동일 이름의 뷰가 있으면 오류 발생하지 않고 덮어쓴다.
CREATE OR REPLACE VIEW view_usertbl AS
SELECT userID, name, addr FROM usertbl;

-- 동일하게 테이블처럼 정보를 확인할 수 있다.
DESC usertbl;
DESC view_usertbl;	-- 데이터 타입은 동일하지만, 기본 키 등의 정보는 확인되지 않는다.

-- 뷰의 생성문(소스코드)을 확인하기
SHOW CREATE VIEW view_usertbl;

-- 뷰를 통해서 데이터를 수정하기 → 원본 테이블의 제약조건 문제가 없어서 성공적 변경
-- 원본 테이블의 정보가 변경된다.
SELECT * FROM view_usertbl;
UPDATE view_usertbl
SET addr = '부산'
WHERE userID = 'JKW';

-- 뷰를 통해서 데이터 입력하기
-- 원본 테이블의 제약조건(birthDate, NOT NULL)을 만족시킬 수 없기 때문에
INSERT INTO view_usertbl (userID, name, addr)
VALUES ('HKD', '홍길동', '제주');

-- 그룹 함수를 포함하는 뷰 생성
CREATE OR REPLACE VIEW view_sum AS
SELECT userID , sum(price * amount) AS 'total'
FROM buytbl
GROUP BY userID;

SELECT * FROM view_sum;
-- 그룹 함수를 사용한 집계 함수 컬럼은 수정할 수 없다.
-- 시스템에 저장된 뷰 정보를 통해 확인했을 때 IS_UPDATABLE이 NO
-- → 데이터 수정 불가
SELECT * FROM information_schema.views
WHERE table_schema = 'sqldb';
-- 집계 함수를 사용하는 뷰, JOIN을 사용하는 뷰, UNION ALL(합집합)을 사용하는 뷰
-- DISTINCT를 사용하거나, GROUP BY를 사용하는 뷰 → 데이터 수정이나 삭제가 불가능하다.

-- CHECK_OPTION
CREATE VIEW view_height_upper177 AS
SELECT * FROM usertbl WHERE height >= 177;

SELECT * FROM view_height_upper177;

SELECT * FROM information_schema.views
WHERE table_schema = 'sqldb';

DELETE FROM view_height_upper177
WHERE height < 177;

-- 원본의 177 미만의 데이터는 남아있음
SELECT * FROM usertbl;

-- 뷰에서 데이터 삽입(도메인 제약조건에 맞게)
INSERT INTO view_height_upper177
VALUES ('SDR', '숏다리', 1990, '부산', '010', '11111111', 150, '2024-01-01');

SELECT * FROM view_height_upper177;	-- → 조회 불가

-- 원본 데이터에서는 삽입이 되어 있다. → 뷰에서는 조회, 수정, 삭제 불가
SELECT * FROM usertbl;

-- 뷰 수정
-- 키가 177 미만인 데이터가 입력되지 않게 끔
ALTER VIEW view_height_upper177 AS
SELECT * FROM usertbl WHERE height >= 177
WITH CHECK OPTION;

-- 뷰를 통해 데이터 삽입
-- → WITH CHECK OPTION으로 데이터 삽입 실패 → 의도하지 않은 경로 삽입을 막음 → 무결성 지킴
INSERT INTO view_height_upper177
VALUES ('SDL', '숏다리2', 1990, '부산', '010', '22222222', 140, '2024-01-01');

-- CHECK_OPTION이 활성화
SELECT * FROM information_schema.views
WHERE table_schema = 'sqldb';

-- 조인을 한 뷰는 업데이트 불가
SHOW CREATE VIEW view_userbuytbl;

-- 도메인 제약조건에 맞게 삽입하여도 조인한 뷰에서는 삽입이 불가하다.
INSERT INTO view_userbuytbl 
VALUES ('ABC', '가나다', '모니터', '서울', '01012345678');

-- 원본 테이블이 삭제되는 경우, 뷰도 조회할 수 없다.
DROP TABLE IF EXISTS buytbl, usertbl;	-- 테이블 삭제
SELECT * FROM view_usertbl;		-- 참조 불가로 인해 조회 불가능

CHECK TABLE view_usertbl;

DROP VIEW view_height_upper177, view_userbuytbl, view_usertbl;