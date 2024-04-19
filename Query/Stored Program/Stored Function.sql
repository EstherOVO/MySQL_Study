-- 스토어드 함수(Stored Function)
USE store;

-- 스토어드 함수 생성 권한 허용
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION userFunc (value1 INT, value2 INT) 
	RETURNS INT
BEGIN

	RETURN value1 + value2;

END //
DELIMITER ;

-- 저장 함수 사용하기
SELECT userFunc(10, 20);

-- 출생년도를 입력하고 나이가 출력되는 함수
DELIMITER $$
CREATE FUNCTION getAgeFunc (bYear INT)
	RETURNS INT
BEGIN

	DECLARE age INT;	-- 계산한 나이를 담을 변수 선언
    SET age = year(CURDATE()) - bYear;	-- 현재 년도에서 출생년도 계산
    RETURN age;

END $$
DELIMITER ;

SELECT getAgeFunc(1998);

-- 내장함수처럼 SQL문과 연결하여 사용 가능
SELECT name AS `이름`, birthYear AS `출생년도`, getAgeFunc(birthYear) AS `만 나이` FROM usertbl;

-- 저장함수 확인하기
SHOW CREATE FUNCTION getAgeFunc;

-- 함수 삭제하기
DROP FUNCTION getAgeFunc;