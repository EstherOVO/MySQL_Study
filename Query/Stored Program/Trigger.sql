-- 트리거(Trigger)
USE store;

-- usertbl 테이블 데이터에 변경이 일어나면
-- backup 테이블에 자동으로 작동하는 트리거를 생성
SELECT * FROM usertbl;

-- ---------------------------------------
-- UPDATE 트리거
-- ---------------------------------------

DROP TABLE IF EXISTS backup_usertbl;
CREATE TABLE backup_usertbl (
	userID CHAR(8) NOT NULL,
	name VARCHAR(10) NOT NULL,
	birthYear INT NOT NULL,
	addr CHAR(2) NOT NULL,
	mobile1 CHAR(3) DEFAULT NULL,
	mobile2 CHAR(8) DEFAULT NULL,
	height SMALLINT DEFAULT NULL,
	mDate DATE DEFAULT NULL,
    modType	CHAR(2),		-- 데이터 변경 타입
    modDate DATE,			-- 데이터 변경 날짜
    modUser VARCHAR(255)	-- 데이터 변경 사용자
);

DROP TRIGGER IF EXISTS updateTrg;
DELIMITER $$
CREATE TRIGGER updateTrg
	AFTER UPDATE	-- 업데이트 작업이 일어난 후
    ON usertbl		-- 부착할 테이블 → 해당 테이블에서 데이터가 변경되면
    FOR EACH ROW	-- 각 행마다 적용
BEGIN

	-- 백업 테이블에 수정 이전 정보를 추가
	INSERT INTO backup_usertbl VALUES
		(OLD.userID, OLD.name, OLD.birthYear, OLD.addr,
			OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, '수정', curdate(), current_user());
   
END $$
DELIMITER ;

-- UPDATE문 수행된 후 트리거 작동
UPDATE usertbl SET addr = '제주' WHERE userID = 'EJW';
UPDATE usertbl SET addr = '미국' WHERE userID = 'EJW';
UPDATE usertbl SET mobile2 = '22222222' WHERE userID = 'BBK';

SELECT * FROM usertbl;
SELECT * FROM backup_usertbl;

-- ---------------------------------------
-- DELETE 트리거 
-- ---------------------------------------

DELIMITER $$
CREATE TRIGGER deleteTrg
	AFTER DELETE	-- 삭제 작업이 일어난 후
    ON usertbl		-- 부착할 테이블 → 해당 테이블에서 데이터가 변경되면
    FOR EACH ROW	-- 각 행마다 적용
BEGIN

	-- 백업 테이블에 삭제 이전 정보를 추가
	INSERT INTO backup_usertbl VALUES
		(OLD.userID, OLD.name, OLD.birthYear, OLD.addr,
			OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, '삭제', curdate(), current_user());
   
END $$
DELIMITER ;

DROP TABLE buytbl;	-- userID의 참조 무결성 제거를 위해 삭제 
DELETE FROM usertbl WHERE height < 175;

SELECT * FROM backup_usertbl;

-- ---------------------------------------
-- 트리거 
-- ---------------------------------------

-- 트리거 목록 확인하기
SHOW TRIGGERS FROM store;