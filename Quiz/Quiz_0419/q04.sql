USE quiz;

-- 직원의 ID(`emp_no`)를 입력받습니다.
-- 해당 직원의 모든 급여 이력(급여 `salary`, 급여 시작 날짜 `from_date`, 급여 종료 날짜 `to_date`)을 조회합니다.
-- 결과는 급여 시작 날짜(`from_date`) 기준으로 오름차순으로 정렬해야 합니다.

-- 1. 동적으로 입력받을 값과 SQL문을 변수로 선언하세요.
SET @sql = 'SELECT emp_no AS `직원번호`, salary AS `급여`, from_date AS `급여 시작 날짜`, to_date AS `급여 종료 날짜` FROM salaries WHERE emp_no = ? ORDER BY from_date';
SET @user_emp_no = 10001;

-- 2. PREPARE 문으로 동적 SQL문을 준비하세요.
PREPARE myQuery FROM @sql;

-- 3.  EXECUTE 문을 매개변수를 바인딩 하여 실행하세요.
EXECUTE myQuery USING @user_emp_no;

-- 4. 준비된 문장을 메모리 해제하세요.
DEALLOCATE PREPARE myQuery;