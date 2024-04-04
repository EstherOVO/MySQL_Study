-- library_management_db 스키마에서 ALTER TABLE을 사용하여 구조를 변경해 주세요.

-- 문제 1 : Books 테이블에 ISBN 열 추가하기
-- Books 테이블에 국제 표준 도서 번호(ISBN)를 저장할 수 있는 열을 추가하세요. ISBN은 문자열이며, 고유해야 합니다.

-- 문제 2 : Members 테이블의 Email 열 고유 제약조건 삭제하기
-- Members 테이블에서 Emai 열의 고유 제약조건을 삭제하세요.

-- 문제 3 : BorrowRecords 테이블에 Status 열 추가하기
-- BorrowRecords 테이블에 대출 상태를 나타내는 Status 열을 추가하세요. 가능한 값은 'Borrowed', 'Returned'입니다.

-- 문제 4 : Books 테이블의 PublishedYear 열의 CHECK 제약조건 변경하기
-- Books 테이블에 PublishedYear이 1900 이상이 되도록 기존의 CHECK 제약조건을 변경하세요.
-- (MySQL에서는 기존의 CHECK 제약조건을 직접 수정할 수 없으므로, 제약조건을 삭제한 후 새로 추가해야 합니다.)

-- 문제 5 : Members 테이블에서 MembershipDate 열의 기본값 변경하기
-- Members 테이블의 MembershipDate 열에 대한 기본값을 현재 날짜에서 '2020-01-01'로 변경하세요.

-- 문제 6: BorrowRecords 테이블의 외래 키 제약조건의 레퍼런스 옵션 변경하기
-- BorrowRecords 테이블의 MemberID 외래 키 제약조건에 대한 레퍼런스 옵션을 ON DELETE NO ACTION로 변경하세요.
-- 이를 위해서는 먼저 제약조건을 삭제하고, 새로운 옵션으로 다시 추가해야 합니다.

USE library_management_db;

-- 문제 1번
ALTER TABLE books ADD COLUMN `ISBN` VARCHAR(255) UNIQUE;

-- 문제 2번
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'members';  -- 테이블명
ALTER TABLE members DROP CONSTRAINT email;
-- = ALTER TABLE members DROP INDEX email;

-- 문제 3번
ALTER TABLE borrow_records ADD COLUMN `status` ENUM ('Borrowed', 'Returned');

-- 문제 4번
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'books';  -- 테이블명
-- 혹은 SHOW CREATE TABLE books;
ALTER TABLE books DROP CHECK books_chk_1;
ALTER TABLE books ADD CONSTRAINT chk_year CHECK (published_year >= 1900);

-- 문제 5번
ALTER TABLE members ALTER COLUMN membership_date DROP DEFAULT;
ALTER TABLE members ALTER COLUMN membership_date SET DEFAULT ('2020-01-01');

-- 문제 6번
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'borrow_records';  -- 테이블명
ALTER TABLE borrow_records DROP FOREIGN KEY borrow_records_ibfk_1;
ALTER TABLE borrow_records ADD CONSTRAINT fk_member_ID
FOREIGN KEY (member_ID) REFERENCES members (member_ID) ON DELETE NO ACTION;