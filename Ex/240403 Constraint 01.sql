-- 문제 1 : Books 테이블을 생성하세요.
-- PublishedYear는 1500년 이상의 값을 가져야 하며, Genre는 NULL을 허용하지 않습니다.

-- 문제 2 : Members 테이블을 생성하세요.
-- Email 열에는 고유 제약조건을 추가하고, FirstName 및 LastName 열은 빈 문자열을 허용하지 않아야 합니다.

-- 문제 3 : BorrowRecords 테이블을 생성하세요. 이 테이블은 Members와 Books 테이블에 대한 외래 키 제약 조건을 포함해야 합니다.
-- 레퍼런스 옵션으로 ON DELETE CASCADE와 ON UPDATE NO ACTION을 설정해야 합니다.

CREATE DATABASE library_management_DB;

USE library_management_DB;
CREATE TABLE books (
	book_ID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    published_year INT CHECK (published_year >= 1500),
    genre VARCHAR(255) NOT NULL
);

CREATE TABLE members (
	member_ID INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    membership_date DATE DEFAULT (CURRENT_DATE()),
    CHECK (first_name != ''),
    CHECK (last_name != '')
);

CREATE TABLE borrow_records (
	record_ID INT AUTO_INCREMENT PRIMARY KEY,
    member_ID INT,
    book_ID INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_ID) REFERENCES members(member_ID)
    ON DELETE CASCADE ON UPDATE NO ACTION,
    FOREIGN KEY (book_ID) REFERENCES books(book_ID)
    ON DELETE CASCADE ON UPDATE NO ACTION
);

DESC books;
DESC members;
DESC borrow_records;
	
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrow_records;

DELETE FROM books;
DELETE FROM members;
DELETE FROM borrow_records;
