CREATE SCHEMA store;
USE store;

DELIMITER $$
CREATE PROCEDURE userProc ()
BEGIN
	
    SELECT * FROM usertbl;
    
END $$
DELIMITER ;

CALL userProc;	-- 스토어드 프로시저 호출

-- 매개변수 사용하기
DELIMITER %%
CREATE PROCEDURE userProc1 (IN userName VARCHAR(10))
BEGIN
	
    SELECT * FROM usertbl WHERE name = userName;
    
END %%
DELIMITER ;

CALL userProc1('김범수');
CALL userProc1('바비킴');

-- 매개변수 여러 개 사용하기
DELIMITER ^^
CREATE PROCEDURE userProc2 (
	IN userBirth INT,
    IN userHeight INT)
BEGIN

	SELECT * FROM usertbl WHERE birthYear > userBirth AND height > userHeight;
    
END ^^
DELIMITER ;

CALL userProc2(1980, 170);
CALL userProc2(1970, 175);

DROP PROCEDURE IF EXISTS userProc3;
DELIMITER !!
CREATE PROCEDURE userProc3 (
	IN textValue CHAR(10),
    OUT outValue INT)
BEGIN
	
    INSERT INTO testtbl VALUES (NULL, textValue);
    SELECT max(id) INTO outValue FROM testtbl;
    
END !!
DELIMITER ;
-- 프로시저 작성 시점에는 테이블이 없어도 작성이 되지만, 호출 시점에는 테이블이 존재해야 한다.

CREATE TABLE testtbl (
	id INT PRIMARY KEY AUTO_INCREMENT,
    text CHAR(255));

-- 첫 번째 매개변수(IN)는 저장 프로시저의 INSERT 문에 사용되고,
-- 두 번째 매개변수(OUT)는 해당 변수(@myValue)에 SELECT 문의 결과로 저장된다.
CALL userProc3('테스트', @myValue);
SELECT * FROM testtbl;
SELECT @myValue AS `테스트 테이블 아이디의 최댓값`;

-- INOUT
DELIMITER //
CREATE PROCEDURE swap (INOUT a INT, INOUT b INT)
BEGIN

	SET @temp = a;
    SET a = b;
    SET b = @temp;
    
END //
DELIMITER ;

SET @a = 7;
SET @b = 5;
CALL swap(@a, @b);
SELECT @a, @b;

-- 조건문
DELIMITER %%
CREATE PROCEDURE ifelseProc (IN userName VARCHAR(10))
BEGIN

	DECLARE bYear INT;	-- 변수 선언(저장 프로시저 내부에서 선언 및 사용)
    
    -- 쿼리문의 결과(생년)를 선언한 변수에 대입
    SELECT birthYear INTO bYear FROM usertbl WHERE name = userName;
    
    IF (bYear >= 1980) THEN SELECT '젊습니다.';
    ELSE SELECT '중년입니다.';
    END IF;

END %%
DELIMITER ;

CALL ifelseProc('이승기');

-- CASE 문
DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc (IN userName VARCHAR(10))
BEGIN
	
    DECLARE bYear INT;	-- 생년을 저장하는 변수 선언
    DECLARE tti CHAR(3);	-- 띠를 저장하는 변수 선언

    SELECT birthYear INTO bYear FROM usertbl WHERE name = userName;
    
    CASE
		WHEN (bYear % 12 = 0) THEN SET tti = '원숭이';
        WHEN (bYear % 12 = 1) THEN SET tti = '닭';
        WHEN (bYear % 12 = 2) THEN SET tti = '개';
        WHEN (bYear % 12 = 3) THEN SET tti = '돼지';
        WHEN (bYear % 12 = 4) THEN SET tti = '쥐';
        WHEN (bYear % 12 = 5) THEN SET tti = '소';
        WHEN (bYear % 12 = 6) THEN SET tti = '호랑이';
        WHEN (bYear % 12 = 7) THEN SET tti = '토끼';
        WHEN (bYear % 12 = 8) THEN SET tti = '용';
        WHEN (bYear % 12 = 9) THEN SET tti = '뱀';
        WHEN (bYear % 12 = 10) THEN SET tti = '말';
        ELSE SET tti = '양';
        END CASE;
        
        SELECT tti AS 띠;
        
END $$
DELIMITER ;

CALL caseProc('이승기');

-- 반복문
-- WHILE문
DROP PROCEDURE IF EXISTS printNum;
DELIMITER //
CREATE PROCEDURE printNum ()
BEGIN

	DECLARE counter INT DEFAULT 1;
	
    WHILE (counter <= 5) DO
		SELECT counter;				-- 숫자 표시
        SET counter = counter + 1;	-- 1씩 증가
	END WHILE;
	
END //
DELIMITER ;

CALL printNum();

-- 예외처리
-- DECLARE 액션[CONTINUE|EXIT] HANDLER FOR 오류조건 처리할문장

SELECT * FROM notable;	-- 존재하지 않는 테이블 조회 시 에러코드 : 1146

DELIMITER $$
CREATE PROCEDURE errorProc ()
BEGIN

	-- 1146번 코드를 만날 때 예외를 핸들링하고 계속 진행하는 예외처리
	DECLARE CONTINUE HANDLER FOR 1146 SELECT '테이블이 존재하지 않습니다.' AS `오류 메시지`;
	SELECT * FROM notable;
    
END $$
DELIMITER ;

CALL errorProc();

-- 프로시저 목록 표시하기
SHOW PROCEDURE STATUS;
SHOW PROCEDURE STATUS WHERE DB LIKE 'store';

-- 프로시저 정의 확인하기
SHOW CREATE PROCEDURE userProc;