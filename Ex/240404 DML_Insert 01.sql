/*
문제 1 : 새 직원 추가하기
다음 정보를 가진 새 직원을 `employees` 테이블에 추가하세요.

- 직원 번호 : 500001 (또는 다음 사용 가능한 `emp_no`)
- 생년월일 : "1990-01-01"
- 이름 : "Jamie"
- 성 : "Reyes"
- 성별 : "F"
- 고용일 : "2023-04-01"

문제 2 : 여러 직원 동시에 추가하기
다음 정보를 가진 여러 직원을 한 번의 `INSERT` 문으로 `employees` 테이블에 추가하세요.

1. 직원 :
    - 직원 번호 : 500002 (또는 다음 사용 가능한 `emp_no`)
    - 생년월일 : "1985-02-15"
    - 이름 : "Alex"
    - 성 : "Smith"
    - 성별 : "M"
    - 고용일 : "2023-04-01"
2. 직원 :
    - 직원 번호 : 500003 (또는 다음 사용 가능한 `emp_no`)
    - 생년월일 : "1978-07-22"
    - 이름 : "Maria"
    - 성 : "Garcia"
    - 성별 : "F"
    - 고용일 : "2023-04-02"
*/

USE ex_insert;

DELETE FROM `ex_insert`.`employees`;

SELECT * FROM `ex_insert`.`employees`;

INSERT INTO `ex_insert`.`employees` VALUES (500001, '1990-01-01', 'Jamie', 'Reyes', 'F', '2023-04-01');

INSERT INTO `ex_insert`.`employees` 
VALUES (500002, '1985-02-15', 'Alex', 'Smith', 'M', '2023-04-01'),
(500003, '1978-07-22', 'Maria', 'Garcia', 'F','2023-04-02');

