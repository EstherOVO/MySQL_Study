-- 커서(Cursor)
/*
1. 커서 선언 : DECLARE 커서명 CURSOR FOR 커서조건;
2. 반복 조건 선언 : DECLARE CONTINUE HANDLER FOR 반복조건;
3. 커서 열기 : OPEN 커서명;
	- LOOP 반복 구간 지정 : 반복구간명 : LOOP
4. 커서에서 데이터 가져오기 : FETCH
5. 데이터 처리 : 가져온 데이터로 원하는 작업 수행
	- END LOOP 반복 종료 : END LOOP 반복구간명;
6. 커서 닫기 : CLOSE 커서명;
*/

USE store;

-- 커서를 통해 테이블의 키 속성을 가져와서 키의 평균을 구하는 프로시저
DELIMITER $$
CREATE PROCEDURE cursorProc ()
BEGIN
	
    DECLARE userHeight INT;		-- 키 변수 선언
    DECLARE cnt INT DEFAULT 0;	-- 고객 수(= 읽은 행의 수)
    DECLARE totalHeight INT DEFAULT 0;	-- 키 합계
    
    DECLARE endOfRow BOOLEAN DEFAULT FALSE;	-- 행이 끝났는지 여부
    
    -- 1. 커서 선언
    DECLARE userCursor CURSOR FOR
		SELECT height FROM usertbl;		-- 테이블에서 키를 가져온 행들의 커서
	
    -- 2. 반복 조건 선언
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET endOfRow = TRUE;
    
    -- 3. 커서 열기
    OPEN userCursor;
    
    cursorLoop : LOOP	-- LOOP 반복 구간 지정
    
		-- 4. 커서에서 데이터 가져오기
		FETCH userCursor INTO userHeight;
		-- 커서에 있는 데이터를 userHeight 변수에 대입
		
		IF endOfRow THEN LEAVE cursorLoop;
		-- 만약 끝행(TRUE)이면, 루프를 종료해라
		
		END IF;
		
		SET cnt = cnt + 1;	-- 읽을 행의 수를 증가시키고
		SET totalHeight = totalHeight + userHeight;		-- 읽은 값을 합계에 더함
    
	-- 5. 데이터 처리 : 가져온 데이터로 원하는 작업 수행
	END LOOP cursorLoop;
    
    -- 6. 커서 닫기
    CLOSE userCursor;
    
    SELECT (totalHeight / cnt) AS `고객 키의 평균`;

END $$
DELIMITER ;

-- 프로시저 실행
CALL cursorProc();