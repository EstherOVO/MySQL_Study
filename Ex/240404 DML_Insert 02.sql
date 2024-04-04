/*
문제 1 : `Books` 테이블에 새로운 도서 추가하기
`Books` 테이블에 다음 정보를 가진 새로운 도서를 추가하세요.

- 제목 : "The Little Prince"
- 저자 : "Antoine de Saint-Exupéry"
- 출판 연도 : 1943
- 장르 : "Fiction"

문제 2 : `Members` 테이블에 여러 회원 정보 동시에 추가하기
`Members` 테이블에 다음 두 명의 회원 정보를 한 번의 `INSERT` 문으로 추가하세요.

1. 회원
    - 이름 : "Alice"
    - 성 : "Johnson"
    - 이메일 : "alice.johnson@example.com"
    - 회원가입 날짜 : 오늘 날짜
2. 회원
    - 이름 : "Bob"
    - 성 : "Smith"
    - 이메일 : "bob.smith@example.com"
    - 회원가입 날짜 : 오늘 날짜

문제 3 : `BorrowRecords` 테이블에 대출 기록 추가하기
`BorrowRecords` 테이블에 다음 정보를 가진 대출 기록을 추가하세요.
(이 작업을 수행하기 전에, `Members` 및 `Books` 테이블에 해당 회원과 도서가 이미 존재한다고 가정합니다.)

- 회원 ID : 1 
- 도서 ID : 1 
- 대출 날짜 : "2023-03-01"
- 반납 예정 날짜 : "2023-03-15"
*/

USE library_management_db;

SELECT * FROM `library_management_db`.`books`;
SELECT * FROM `library_management_db`.`members`;
SELECT * FROM `library_management_db`.`borrow_records`;

SHOW CREATE TABLE `library_management_db`.`borrow_records`;

-- 문제 1번
INSERT INTO `library_management_db`.`books` VALUES (NULL, 'The Little Prince', 'Antoine de Saint-Exupéry', 1943, 'Fiction', '9783140464079');

-- 문제 2번
INSERT INTO `library_management_db`.`members` VALUES
(NULL, 'Alice', 'Johnson', 'alice.johnson@example.com', CURDATE()),
(NULL, 'Bob', 'Smith', 'bob.smith@example.com', CURDATE());

-- 문제 3번
INSERT INTO `library_management_db`.`borrow_records`
VALUES (NULL, 1, 1, '2023-03-01', '2023-03-15', 'Borrowed');