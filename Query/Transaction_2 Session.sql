-- 세션 : 데이터베이스를 사용하는 동안 유지되는 상태 정보
USE tcl;

-- ---------------------------------------
-- 트랜잭션(Transaction)
-- ---------------------------------------

-- 세션 2 : 계좌 테이블 정보를 확인
SELECT * FROM accounts;

-- 트랜잭션(작업단위)이 시작된 상태에서 다른 세션에 조회를 하면, 부분 완료된 업데이트 내용(중간처리 과정)은 확인할 수 없다.
-- → Isolation(고립성)
SELECT * FROM accounts;
SELECT * FROM transaction_log;

-- 세션 1에서 커밋이 완료되면, 작업단위 내의 모든 SQL 문이 한 번에 수행된다. → Atomicity(원자성)
-- 변경사항이 영구적으로 반영된 상태 : "Commited"
-- 시스템 장애가 되어도 유지된다. → Durability(지속성)
-- 트랜잭션이 수행된 후에도 모든 무결성 제약조건 만족 → Consistency(일관성)
SELECT * FROM accounts;
SELECT * FROM transaction_log;

-- ---------------------------------------
-- SAVEPOINT
-- ---------------------------------------

-- SAVEPOINT에서 저장된 내용(커밋되지 않은 수정사항)은
-- 다른 세선에서 커밋되기 전까지 반영되지 않는다.

-- ---------------------------------------
-- autocommit
-- ---------------------------------------

-- autocommit 확인 : 활성화된 상태에서는 다른 세션에서도 바로 확인 가능 
-- autocommit이 비활성화된 상태에서는 다른 세션에서 확인 불가(DB에 반영이 안 됨)
SELECT * FROM Person;
-- COMMIT 실행 시 트랜잭션에 수행되어 DB 반영 확인 가능

-- ---------------------------------------
-- 락(Lock)
-- ---------------------------------------

-- 현재 트랜잭션 중인 테이블의 행에 접근하게 될 경우
-- → 락이 걸려있어 해당 자원에 접근할 수 없음
-- (락이 있는 동안) 수정 불가하고, 락 해제 후 수정이 가능하다.
UPDATE lock_demo SET data = '다른 세션에서 수정' WHERE id = 1;

-- 조회 가능
SELECT * FROM lock_demo;
SELECT data FROM lock_demo WHERE id = 1;

-- 읽기 락
-- 락 읽기 시도
SELECT * FROM lock_demo;

-- 락 수정 시도(수정 불가) → 대기
UPDATE lock_demo SET data = '읽기 락' WHERE id = 1;

-- ---------------------------------------

-- 쓰기 락
-- 현재 세션 락 읽기 시도(읽기 불가)
SELECT * FROM lock_demo;

-- 현재 세션 락 수정 시도(쓰기 불가)
UPDATE lock_demo SET data = '쓰기 락' WHERE id = 1;