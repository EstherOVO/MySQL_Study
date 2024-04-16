-- 세션 2 : 쓰기 트랜잭션
USE tcl;

-- ---------------------------------------
-- 1. READ UNCOMMITTED / 더티 리드
-- ---------------------------------------

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

-- 쓰기 후 커밋하지 않음
UPDATE Person SET age = 50 WHERE name = '홍길동';

ROLLBACK;	-- 커밋하지 않은 내용 초기화

SELECT * FROM Person;

-- ---------------------------------------
-- 2. READ COMMITTED / 반복 불가능 읽기
-- ---------------------------------------

START TRANSACTION;

-- 1) 쓰기
UPDATE Person SET age = 50 WHERE name = '홍길동';

-- 2) 커밋
COMMIT;

-- ---------------------------------------
-- 3. REPEATABLE READ / 반복 가능 읽기
-- ---------------------------------------

START TRANSACTION;

-- 1) 쓰기
UPDATE Person SET age = 50 WHERE name = '홍길동';

-- 2) 커밋
COMMIT;

-- ---------------------------------------
-- 4. SERIALIZABLE
-- ---------------------------------------

START TRANSACTION;

SELECT * FROM Person;

-- 1) 쓰기 → 쓰기 자체가 불가능 → 트랜잭션의 수정이 베타 Lock 설정한 효과
UPDATE Person SET age = 70 WHERE name = '홍길동';

COMMIT;