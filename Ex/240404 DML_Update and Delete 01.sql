-- library_management_db 스키마에서 진행해 주세요.
CREATE SCHEMA IF NOT EXISTS library_management_db;
USE library_management_db;

-- 문제 1 : 'books' 테이블에 새로운 도서 추가하기
-- 제목 : "Learning SQL", 저자 : "Alan Beaulieu", 출판 연도 : 2020, 장르 : "Educational"
INSERT INTO `library_management_db`.`books`
VALUES (NULL, 'Learning SQL', 'Alan Beaulieu', 2020, 'Educational', '9780596007270');

-- 문제 2 : 'members' 테이블에 새로운 회원 추가하기
-- 이름 : "Lucy", 성 : "Heartfilia", 이메일 : "lucy.heart@example.com", 회원가입 날짜 : 오늘 날짜
INSERT INTO `library_management_db`.`members`
VALUES (NULL, 'Lucy', 'eartfilia', 'lucy.heart@example.com', CURDATE());

-- 문제 3 : 'borrow_records' 테이블에 대출 기록 추가하기
-- 회원 ID : 1, 도서 ID : 1, 대출 날짜 : "2023-03-15", 반납 예정 날짜 : "2023-04-14"
INSERT INTO `library_management_db`.`borrow_records`
VALUES (NULL, 1, 1, '2023-03-15', '2023-04-14', 'Borrowed');

-- 문제 4 : 'books' 테이블에서 제목이 "Learning SQL"인 도서의 장르를 "Technical"로 변경하기
UPDATE `library_management_db`.`books` SET genre = 'Technical' WHERE title = 'Learning SQL';

-- 문제 5 : 'members' 테이블에서 회원 ID가 1인 회원의 이메일 주소를 "lucy.h@example.com"으로 변경하기
UPDATE `library_management_db`.`members` SET email = 'lucy.h@example.com' WHERE member_ID = 1;

-- 문제 6 : 'borrow_records' 테이블에서 회원 ID가 1이고 도서 ID가 1인 대출 기록의 반납 예정 날짜를 "2023-04-30"으로 변경하기
UPDATE `library_management_db`.`borrow_records` SET return_date = '2023-04-30' WHERE member_ID = 1 AND book_ID = 1;

-- 문제 7 : 'books' 테이블에서 출판 연도가 2020년인 모든 도서의 출판 연도를 2021로 변경하기
UPDATE `library_management_db`.`books` SET published_year = 2021 WHERE published_year = 2020;

-- 문제 8 : 'members' 테이블에서 이메일 주소가 "lucy.h@example.com"인 회원을 삭제하기
DELETE FROM `library_management_db`.`members` WHERE email = 'lucy.h@example.com';

-- 문제 9 : 'borrow_records' 테이블에서 반납 예정 날짜가 "2023-04-30"인 모든 대출 기록을 삭제하기
DELETE FROM `library_management_db`.`borrow_records` WHERE return_date = '2023-04-30';

SELECT * FROM `library_management_db`.`books`;
SELECT * FROM `library_management_db`.`members`;
SELECT * FROM `library_management_db`.`borrow_records`;