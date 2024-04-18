USE db_index;

-- 샘플 테이블 생성(usertbl, buytbl), 샘플 SQL 실행

SELECT * FROM usertbl;

-- 인덱스 확인하기
SHOW INDEX FROM usertbl;

-- 인덱스 크기 확인하기 → 테이블의 크기 16384, 16KB / (페이지1개 크기 = 16KB) : 페이지 수 1개
SHOW TABLE STATUS LIKE 'usertbl';

-- 인덱스 생성하기(주소 컬럼 기준)
CREATE INDEX idx_usertbl_addr ON usertbl (addr);

SHOW INDEX FROM usertbl;	-- 인덱스 생성 확인
SHOW TABLE STATUS LIKE 'usertbl';	-- 테이블 상태 확인

-- 생성한 인덱스를 실제 적용하려면 ANALYZE로 분석해야 한다.
ANALYZE TABLE usertbl;

SHOW TABLE STATUS LIKE 'usertbl';	-- 테이블 상태 확인
-- 테이블의 인덱스 크기가 확인됨 16KB

-- 고유 인덱스 만들기
CREATE UNIQUE INDEX idx_usertbl_birthYear ON usertbl (birthYear);
-- 생성 불가 : 고유 인덱스를 만들기 위해서는 컬럼의 데이터 값이 고유해야 한다.

-- 컬럼의 값들이 고유할 경우 고유 인덱스 생성 가능
CREATE UNIQUE INDEX idx_usertbl_name ON usertbl (name);

SHOW INDEX FROM usertbl;	-- 인덱스 생성 확인

-- 고유 인덱스로 생성한 경우, 해당 컬럼 기준 중복 값 허용 불가
INSERT INTO usertbl VALUES ('BBC', '바비킴', 1972, '부산', '010', '11111111', '177', '2012-06-06');

-- 복합 인덱스 만들기
CREATE INDEX idx_usertbl_name_birthYear ON usertbl (name, birthYear);	-- 기준 컬럼 2개 이상

SHOW INDEX FROM usertbl;	-- 인덱스 생성 확인

SELECT * FROM usertbl WHERE name = '윤종신' AND birthYear = '1969';

-- 쿼리 실행 계획 확인하기
-- 인덱스가 있는 경우 가능한 인덱스와 key가 나오고, 검색한 행의 갯수가 효율적으로 찾아짐
EXPLAIN SELECT * FROM usertbl WHERE name = '윤종신' AND birthYear = '1969';

-- WHERE 컬럼에 인덱스가 없는 경우,
-- Full Table Scan 모든 테이블의 행을 다 찾아보고 결과를 알려준다.
-- 가능한 인덱스도 없음
SELECT * FROM usertbl WHERE height = 170;

-- 인덱스로 사용하는 컬럼은 고유 값의 개수가 적은 경우 성능에 도움이 되지 않는다.

-- 인덱스 삭제하기
DROP INDEX idx_usertbl_name_birthYear ON usertbl;
ALTER TABLE usertbl DROP INDEX idx_usertbl_name;

-- 기본 키(클러스터형 인덱스)는 ALTER 문으로만 제거가 가능하다.
-- 참조하고 있는 외래 키가 있을 경우 참조 무결성에 의해 제거할 수 없다.
ALTER TABLE usertbl DROP PRIMARY KEY;

DESC buytbl;
SHOW INDEX FROM buytbl;

SELECT * FROM information_schema.table_constraints WHERE table_name = 'buytbl';
-- 참조가 되어 있는 경우 참조 무결성을 제거하고 삭제가 가능
ALTER TABLE buytbl DROP FOREIGN KEY buytbl_ibfk_1;
ALTER TABLE usertbl DROP PRIMARY KEY;