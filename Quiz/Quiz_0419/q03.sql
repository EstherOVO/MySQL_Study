USE quiz;

-- 1. 입력 매개변수 : 직원의 ID(`emp_no`)와 연도(`year`)를 입력받습니다.
-- 2. 입력받은 연도에 해당 직원이 받은 급여 정보(급여 `salary`와 해당 급여의 시작 날짜 `from_date`)를 조회합니다.
-- 3. 스토어드 프로시저를 작성하고 호출합니다.

DELIMITER //
CREATE PROCEDURE GetEmployeeSalariesByYear (IN user_emp_no INT, IN user_year INT)
BEGIN
    SELECT emp_no, salary, from_date FROM salaries WHERE emp_no = user_emp_no AND year(from_date) = user_year;
END //
DELIMITER ;

CALL GetEmployeeSalariesByYear(10001, 2000);
CALL GetEmployeeSalariesByYear(10020, 1997);
CALL GetEmployeeSalariesByYear(10100, 1991);