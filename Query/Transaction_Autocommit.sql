USE tcl;

-- autocommit 활성화 여부 확인하기
SHOW VARIABLES LIKE 'autocommit';

-- OFF (0) : 비활성화
SET autocommit = 0;

-- ON (1) : 활성화
SET autocommit = 1;

CREATE TABLE Person (
	name VARCHAR(255),
    age INT
);

-- autocommit이 활성화 되어 있는 상태
-- 데이터 조작을 가할 시 즉시 반영
INSERT INTO Person VALUES ('홍길동', 30);
SELECT * FROM Person;

-- autocommit 비활성화
SET autocommit = 0;

INSERT INTO Person VALUES ('임꺽정', 40);
SELECT * FROM Person;

-- 변경 내용을 반영
COMMIT;

-- 이전 COMMIT 작업단위(트랜잭션)로 끊어짐
INSERT INTO Person VALUES ('전우치', 25);
SELECT * FROM Person;

ROLLBACK;

-- 이전 COMMIT으로부터 작업단위가 나누어짐 (트랜잭션)
INSERT INTO Person VALUES ('김철수', 20);
INSERT INTO Person VALUES ('마이콜', 25);

COMMIT;

-- autocommit 재활성화
SET autocommit = 1;
SHOW VARIABLES LIKE 'autocommit';

