-- 동적 SQL
USE store;

/*
PREPARE 문장이름 FROM 문장;		-- 1. 문장 준비
EXECUTE 준비문장이름;			-- 2. 실행
DEALLOCATE PREPARE 준비문장이름;	-- 3. 메모리 해제
*/

-- 1. SQL문 준비
PREPARE myQuery FROM 'SELECT * FROM usertbl WHERE userID = "BBK"';

-- 2. SQL문 실행
EXECUTE myQuery;

-- 3. 준비된 SQL문 해제
DEALLOCATE PREPARE myQuery;

-- ---------------------------------------
-- USING 키워드 활용
-- ---------------------------------------

-- 준비된 문장에서 ? 로 향후 입력될 값을 비워놓고 USING 키워드를 이용하여 값을 전달
-- 1. 변수 선언
SET @userName = '조관우';

-- 2. SQL문 준비
PREPARE myQuery FROM 'SELECT * FROM usertbl WHERE name = ?';

-- 3. SQL문 실행
EXECUTE myQuery USING @userName;

-- 4. 준비된 SQL문 해제
DEALLOCATE PREPARE myQuery;

-- ---------------------------------------

-- 1. 변수 선언
SET @userName = '바비킴';
SET @id = 'BBK';
SET @sql = 'SELECT * FROM usertbl WHERE userID = ? AND name = ?';

-- 2. SQL문 준비
PREPARE statement FROM @sql;	-- 준비

-- 3. SQL문 실행
EXECUTE statement USING @id, @userName;		-- 2개 이상의 변수가 있을 경우, 순서대로 대입한다.

-- 4. 준비된 SQL문 해제
DEALLOCATE PREPARE statement;

-- ---------------------------------------

-- 다양한 조건과 CONCAT 문을 통한 문자열 결합 사례
-- 1. 변수 선언
SELECT * FROM buytbl;
SET @tableName = 'buytbl';
SET @columnName = 'price';
SET @limitPrice = 100;
SET @query = concat('SELECT * FROM ', @tableName, ' WHERE ', @columnName, ' > ?');

-- 2. SQL문 준비
PREPARE stmt FROM @query;

-- 3. SQL문 실행
EXECUTE stmt USING @limitPrice;

-- 4. 준비된 SQL문 해제
DEALLOCATE PREPARE stmt;