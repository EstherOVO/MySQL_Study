-- ---------------------------------------
-- 제1정규형(1NF : 1st Normal Form)
-- ---------------------------------------
USE normalization;

CREATE TABLE Students (
	Student_ID INT PRIMARY KEY,	-- 학번
    Name VARCHAR(50),	-- 이름
    Courses VARCHAR(255)	-- 과정들
);

INSERT INTO Students
VALUES (1, '홍길동', '수학, 과학'),
(2, '임꺽정', '국어'),
(3, '전우치', '사회, 국어, 영어');
-- 릴레이션의 속성 값은 반드시 원자 값이어야 한다. → 1정규화에 위배됨

SELECT * FROM Students;

CREATE TABLE Students_1NF (
	Student_Course_ID INT PRIMARY KEY AUTO_INCREMENT,	-- 기본 키
	Student_ID INT,	-- 학번
    Name VARCHAR(50),	-- 이름
    Course VARCHAR(255)	-- 과정
);

-- 1정규화 적용을 위해 데이터를 원자값으로 쪼개어 삽입
INSERT INTO Students_1NF (Student_ID, Name, Course)
VALUES (1, '홍길동', '수학'),
(1, '홍길동', '과학'),
(2, '임꺽정', '국어'),
(3, '전우치', '사회'),
(3, '전우치', '국어'),
(3, '전우치', '영어');

-- Course 속성이 원자값으로 변경되어 제1정규형을 만족
SELECT * FROM Students_1NF;

-- ---------------------------------------
-- 제2정규형(2NF : 2nd Normal Form)
-- ---------------------------------------
CREATE TABLE CourseRegist (
    Student_ID INT,
    Course_ID INT,
    Instructor_Name VARCHAR(255),
    Course_Name VARCHAR(255),
    PRIMARY KEY (Student_ID, Course_ID)	-- 복합 기본 키
);

INSERT INTO CourseRegist
VALUES (1, 101, '홍길동', '데이터베이스'),
(1, 102, '이영희', '자료구조'),
(2, 101, '홍길동', '데이터베이스'),
(2, 103, '김철수', '알고리즘');

-- 삭제 이상 : 학생 1번의 102번 강의 수강 정보를 취소하게 되면, '이영희' 강사의 '자료구조'라는 강의 정보도 사라진다.
-- 삽입 이상 : 새로운 강의 '전우치' 강사의 '컴퓨터도술' 강의(새로운 강의 104)가 개설되면, 학생번호에 null 값 삽입 문제가 발생한다.
-- 수정 이상 : '홍길동' 강사가 '데이터베이스' 강의 대신 '안드로이드' 강의를 맡게 되면, 데이터 불일치 발생 가능성이 있다.

-- 제2정규형으로 테이블을 분해
-- CourseRegist (Student_ID (PK), Course_ID (PK), Instructor_Name, Course_Name);
-- 부분 함수 종속이 존재 Course_ID → Instructor_Name, Course_Name

-- 부분 함수 종속성 제거
-- Enrollment (Student_ID (PK), Course_ID (PK))
-- Course (Course_ID (PK), Instructor_Name, Course_Name)

DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;

-- 분리 테이블 1 - 수강 참여
CREATE TABLE Enrollment (
	Student_ID INT,
    Course_ID INT,
    PRIMARY KEY (Student_ID, Course_ID)
);

-- 분리 테이블 2 - 강좌
CREATE TABLE Course (
	Course_ID INT PRIMARY KEY,
    Instructor_Name VARCHAR(255),
    Course_Name VARCHAR(255)
);

-- 기존 데이터 복사하여 삽입
INSERT INTO Enrollment (Student_ID, Course_ID)
SELECT Student_ID, Course_ID FROM CourseRegist;

-- 중복 데이터 제거하여 삽입
INSERT INTO Course (Course_ID, Instructor_Name, Course_Name)
SELECT DISTINCT Course_ID, Instructor_Name, Course_Name FROM CourseRegist;

-- 테이블 정보 확인
SELECT * FROM Enrollment;
SELECT * FROM Course;

-- 삭제 이상 없음 : 학생 1번의 102번 강의 수강 정보를 취소하게 되더라도, '이영희' 강사의 '자료구조'라는 강의 정보는 별개의 테이블에 유지한다.
DELETE FROM Enrollment WHERE Student_ID = 1 AND Course_ID = 102;
-- 삽입 이상 없음 : 새로운 강의 '전우치' 강사의 '컴퓨터도술' 강의(새로운 강의 103)가 개설되더라도, null 값 포함되지 않는다.
INSERT INTO Course VALUES (104, '전우치', '컴퓨터도술');
-- 수정 이상 없음 : '홍길동' 강사가 '데이터베이스' 강의 대신 '안드로이드' 강의를 맡게 되더라도, 한 튜플(행)만 수정하기 때문에 데이터 불일치 가능성이 없다.
UPDATE Course SET Course_Name = '안드로이드' WHERE Instructor_Name = '홍길동';

-- 부분 함수 종속을 제거하여 완전 함수 종속으로 테이블을 분해하면 제2정규형 만족

-- ---------------------------------------
-- 제3정규형(3NF : 3rd Normal Form)
-- ---------------------------------------

CREATE TABLE StudentCourse (
	Student_ID INT,
    Course_ID INT,
    Instructor_Name VARCHAR(255),
    PRIMARY KEY (Student_ID)
);

-- 함수 종속성 분석 : Student_ID -> Course_ID, Course_ID -> Instructor_Name
-- 학생이 특정 강의에 등록(Student_ID -> Course_ID)하고, 특정 강의는 특정 강사가 가르치는 상태(Course_ID -> Instructor_Name)
-- 이행적 종속 Student_ID -> Instructor_Name 학생번호를 알면, 강사 이름을 알 수 있는 상태

INSERT INTO StudentCourse
VALUES (1, 101, '김강사'), (2, 102, '이강사'), (3, 103, '박강사'), (4, 101, '김강사');

SELECT * FROM StudentCourse;
-- 이상현상
-- 삭제 이상 : 2번 학생이 수강을 취소하면, 102번 강의(이강사) 정보가 삭제된다.
-- 삽입 이상 : 104번 장강사 강의를 개설하면, 학생번호에 null 값 삽입 문제가 발생한다.
-- 수정 이상 : 101번 강의를 조강사가 맡게될 경우, 데이터 불일치 문제 발생 가능성이 생긴다.

-- 테이블 분해
CREATE TABLE Instrucrtor (
	Course_ID INT PRIMARY KEY,		-- 이행적 종속 관계의 결정자를 기본 키로 테이블 분해
    Instructor_Name VARCHAR(255)	-- 종속자
);

INSERT INTO Instrucrtor (Course_ID, Instructor_Name)
SELECT DISTINCT Course_ID, Instructor_Name FROM StudentCourse;

ALTER TABLE StudentCourse DROP COLUMN Instructor_Name;	-- 기본 테이블의 컬럼(이행종속자) 삭제

-- 이행적 종속성 제거
-- 이전 : Student_ID -> Course_ID, Course_ID -> Instructor_Name
-- StudentCourse (Student_ID (PK), Course_ID, Instructor_Name)

-- 이후 :
-- Student_ID -> Course_ID // StudentCourse (Student_ID (PK), Course_ID)
-- Course_ID -> Instructor_Name // Instrucrtor (Course_ID (PK), Instructor_Name)

SELECT * FROM StudentCourse;
SELECT * FROM Instrucrtor;

-- 삭제 이상 없음 : 2번 학생이 수강을 취소하더라도, 102번 강의(이강사) 정보는 남아있다.
DELETE FROM StudentCourse WHERE Student_ID = 2;
-- 삽입 이상 없음 : 104번 장강사 강의를 개설하더라도, 학생번호에 null 값 삽입 문제가 발생하지 않는다.
INSERT INTO Instrucrtor VALUES (104, '장강사');
-- 수정 이상 없음 : 101번 강의를 조강사가 맡게더라도, 데이터 불일치 문제 발생하지 않는다.
UPDATE Instrucrtor SET Instructor_Name = '조강사' WHERE Course_ID = 101;

-- 제3정규형 만족

-- ---------------------------------------
-- Boyce-Codd(보이스 코드) 정규형(BCNF)
-- ---------------------------------------

DROP TABLE IF EXISTS StudentCourse;
-- 한 학생은 한 개 이상의 특강을 신청할 수 있고,
-- 한 강사는 하나의 특강만 담당할 수 있다고 가정
CREATE TABLE StudentCourse (
	Student_ID INT,
    Course_Name VARCHAR(255),
    Instructor_Name VARCHAR(255),
    PRIMARY KEY (Student_ID, Course_Name)
);

INSERT INTO StudentCourse
VALUES (501, '소셜네트워크', '김교수'),
(401, '소셜네트워크', '김교수'),
(402, '인간과동물', '성교수'),
(502, '창업전략', '박교수'),
(501, '창업전략', '홍교수');
 
SELECT * FROM StudentCourse;

-- 1, 2, 3정규형 모두 만족
-- StudentCourse (Student_ID (PK), Course_Name (PK), Instructor_Name)
-- Instructor_Name (교수이름, 기본 키가 아님) -> Course_Name

-- 함수 종속성 분석
-- (Student_ID, Course_Name) -> Instructor_Name
-- Instructor_Name -> Course_Name
-- 모든 결정자가 후보 키(기본 키가 될 수 있는 속성 집합)

-- 이상현상
-- 삭제 이상 : 402번 학생이 수강을 취소하면, '인간과동물' 특강 정보와 교수 정보가 사라진다.
-- 삽입 이상 : 새로운 특강 정보를 개설해서 '최교수'가 담당하면, 학생정보 null 값 삽입 문제 발생
-- 수정 이상 : '김교수'의 특강 제목을 '빅데이터분석'으로 바꾸면, 데이터 불일치 가능성 발생

-- 테이블 분해
-- Enroll (Student_ID (PK), Instructor_Name (PK))
-- Instructor (Instructor_Name (PK), Course_Name)
DROP TABLE IF EXISTS Enroll;
DROP TABLE IF EXISTS Instructor;

CREATE TABLE Enroll (
	Student_ID INT,
    Instructor_Name VARCHAR(255),
    PRIMARY KEY (Student_ID, Instructor_Name)
);

-- 1. 특강 참여 릴레이션
INSERT INTO Enroll
SELECT Student_ID, Instructor_Name FROM StudentCourse;

CREATE TABLE Instructor (
	Instructor_Name VARCHAR(255),
    Course_Name VARCHAR(255),
    PRIMARY KEY (Instructor_Name, Course_Name)
);

-- 2. 교수 특강 릴레이션 
INSERT INTO Instructor
SELECT DISTINCT Instructor_Name, Course_Name FROM StudentCourse;

SELECT * FROM Enroll;
SELECT * FROM Instructor;

SELECT e.Student_ID, i.Instructor_Name, i. Course_Name
FROM Enroll e
JOIN Instructor i ON e.Instructor_Name = i.Instructor_Name;