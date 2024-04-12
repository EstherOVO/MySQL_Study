USE class_db;

-- 1. 회원 정보 추가
SELECT * FROM member;
INSERT INTO member
VALUES (NULL, '김지수', '서울시 강남구 역삼동', '010-1234-5678'),
(NULL, '이태민', '서울시 서초구 반포동', '010-8765-4321');

-- 2. 트레이너 정보 추가
SELECT * FROM trainer;
INSERT INTO trainer
VALUES (NULL, '박서준', '필라테스'),
(NULL, '최유리', '에어로빅');

-- 3. 클래스 정보 추가
SELECT * FROM class;
INSERT INTO class
VALUES (NULL, '오전 요가', '09:00:00', '10:00:00', 1),
(NULL, '저녁 웨이트 트레이닝', '20:00:00', '21:00:00', 2);

-- 4. 등록 정보 추가
SELECT * FROM enrollment;
INSERT INTO enrollment
VALUES (1, 1, 1), (2, 2, 2);