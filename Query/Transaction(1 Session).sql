-- ---------------------------------------
-- 트랜잭션(Transaction)
-- ---------------------------------------

DROP SCHEMA IF EXISTS tcl; 
CREATE SCHEMA tcl;
USE tcl;

-- 초기 테이블 생성(계좌)
CREATE TABLE accounts (
	account_ID INT AUTO_INCREMENT,
    account_name VARCHAR(255) NOT NULL,	-- 계좌명
    balance BIGINT NOT NULL DEFAULT 0,	-- 잔고 : 0원
    CONSTRAINT `pk_accounts_account_ID` PRIMARY KEY (account_ID)
);

-- 로그 테이블 생성
CREATE TABLE transaction_log (
	transaction_ID INT AUTO_INCREMENT,
    from_account INT,	-- 보낸 계좌 ID
    to_account INT,		-- 받은 계좌 ID
    amount BIGINT,		-- 보낸 금액
    transation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,	-- 보낸 시간
    CONSTRAINT `pk_log_transaction_ID` PRIMARY KEY (transaction_ID),
    CONSTRAINT `fk_log_from_account` FOREIGN KEY (from_account) REFERENCES accounts (account_id),
    CONSTRAINT `fk_log_to_account` FOREIGN KEY (to_account) REFERENCES accounts(account_id)
);

-- 계좌 데이터 삽입
INSERT INTO accounts (account_name, balance)
VALUES ('홍길동', 100000), ('전우치', 200000);

-- 계좌 거래 트랜잭션(작업단위) 예시
START TRANSACTION;	-- 트랜잭션 시작

-- 1. 인출(홍길동 계좌에서 5만 원 인출)
UPDATE accounts SET balance = balance - 50000 WHERE account_name = '홍길동';

SELECT * FROM accounts;	-- 세션 1(현재 세션)에서 조회 → 부분 완료

-- 2. 입금(전우치 계좌로 5만 원 입금)
UPDATE accounts SET balance = balance + 50000 WHERE account_name = '전우치';

SELECT * FROM accounts;	-- 세션 1(현재 세션)에서 조회 → 부분 완료

-- 3. 거래 기록 저장
INSERT INTO transaction_log (from_account, to_account, amount)
VALUES (
(SELECT account_ID FROM accounts WHERE account_name = '홍길동'),	-- 보낸 사람 ID
(SELECT account_ID FROM accounts WHERE account_name = '전우치'),	-- 받은 사람 ID
50000	-- 금액
);

SELECT * FROM transaction_log;	-- 세션 1(현재 세션)에서 조회 → 부분 완료

-- 모든 변경사항을 확정
COMMIT;

SELECT * FROM accounts;
SELECT * FROM transaction_log;

-- ---------------------------------------
-- ROLLBACK
-- ---------------------------------------

START TRANSACTION;

-- 1. 인출(홍길동 계좌에서 15만 원 인출)
UPDATE accounts SET balance = balance - 150000 WHERE account_name = '홍길동';

-- 2. 입금(전우치 계좌로 15만 원 입금)
UPDATE accounts SET balance = balance + 150000 WHERE account_name = '전우치';

SELECT * FROM accounts;

-- 데이터 확인 시 문제 발생 → 변경사항을 취소
ROLLBACK;

-- 트랜잭션 시작 이전(최종 커밋으로 데이터가 취소)
SELECT * FROM accounts;	-- 데이터 확인

-- ---------------------------------------
-- SAVEPOINT
-- ---------------------------------------

START TRANSACTION;

-- 첫 번째 거래
-- 1. 인출(홍길동 계좌에서 3만 원 인출)
UPDATE accounts SET balance = balance - 30000 WHERE account_name = '홍길동';

-- 2. 입금(전우치 계좌로 3만 원 입금)
UPDATE accounts SET balance = balance + 30000 WHERE account_name = '전우치';

-- 3. 거래 기록 저장
INSERT INTO transaction_log (from_account, to_account, amount)
VALUES (
(SELECT account_ID FROM accounts WHERE account_name = '홍길동'),	-- 보낸 사람 ID
(SELECT account_ID FROM accounts WHERE account_name = '전우치'),	-- 받은 사람 ID
30000	-- 금액
);

SELECT * FROM accounts;

SAVEPOINT midway;	-- 첫 번째 거래(입출금) 기록 저장 및 중간점 설정

-- 두 번째 거래
-- 1. 인출(홍길동 계좌에서 10만 원 인출)
UPDATE accounts SET balance = balance - 100000 WHERE account_name = '홍길동';

-- 2. 입금(전우치 계좌로 10만 원 입금)
UPDATE accounts SET balance = balance + 10000 WHERE account_name = '전우치';

SELECT * FROM accounts;	-- 금액이 마이너스인 데이터 확인

-- 세이브 포인트(중간지점(midway)까지 롤백
ROLLBACK TO midway;

-- 일반 롤백을 하게 될 경우, 시작지점으로 복구
-- ROLLBACK;

SELECT * FROM accounts;	-- 첫 번째 거래내역까지 롤백

-- 첫 번째 거래내역(중간지점(midway))까지 확정
-- 두 번째 거래내역은 반영이 안 됨
COMMIT;