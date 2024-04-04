-- 스키마(Schema) 생성 및 사용
CREATE SCHEMA IF NOT EXISTS ex_insert;
USE ex_insert;

DROP TABLE IF EXISTS `ex_insert`.`employees`;
CREATE TABLE `ex_insert`.`employees` LIKE `employees`.`employees`;

DESC `ex_insert`.`employees`;
SELECT * FROM `ex_insert`.`employees`;	-- 확인

-- 샘플 데이터 대량 삽입
INSERT INTO `ex_insert`.`employees` SELECT * FROM `employees`.`employees`;

-- first_name이 Georgi인 사람의 생일을 수정
UPDATE `ex_insert`.`employees`
SET birth_date = '1970-09-02'
WHERE first_name = 'Georgi'; -- → 오류 : 해당 조건에 매치되는 사람 253행(레코드) 모두를 수정

-- 속성이 고유한 키를 사용하여 수정할 경우, 해당 조건에 매치되는 한 행만 수정된다.
UPDATE `ex_insert`.`employees`
SET birth_date = '1953-09-02'
WHERE emp_no = '10001';

-- WHERE 절을 생략하면 테이블의 모든 내용 변경
UPDATE `ex_insert`.`employees`
SET last_name = '없음';

-- 비교 연산자 사용
-- 고용일이 '1990-01-01' 이후인 사람만 이름을 'none'으로 변경
UPDATE `ex_insert`.`employees`
SET first_name = 'none', last_name = '없음'
WHERE hire_date = '1990-01-01';

-- 복합 연산자 사용
-- 고용일이 '1990-01-01' 이후이며, 성별이 남자인 사람만 '김남자'로 변경
UPDATE `ex_insert`.`employees`
SET first_name = '남자', last_name = '김'
WHERE gender <> 'F' AND hire_date <= '1990-01-01';