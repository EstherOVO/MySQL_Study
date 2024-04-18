-- 테이블 스페이스

-- 시스템 변수에서 데이터 파일 확인
-- '파일명:파일크기:최대파일크기'
SHOW VARIABLES LIKE 'innodb_data_file_path';

-- "C:\ProgramData\MySQL\MySQL Server 8.0\Data"
-- 위치에서 해당 파일 'ibdata1'을 확인할 수 있음

SHOW VARIABLES LIKE 'innodb_file_per_table';
-- ON(기본 값으로 되어 있음) : 테이블마다 데이터와 인덱스를 위한 별도 파일 생성
-- OFF : 테이블들이 공통 테이블 스페이스를 공유

-- 테이블 스페이스 생성(3개)
-- 확장명 ibd(innodb 엔진 데이터 파일)
CREATE TABLESPACE ts_a ADD DATAFILE 'ts_a.ibd';
CREATE TABLESPACE ts_b ADD DATAFILE 'ts_b.ibd';
CREATE TABLESPACE ts_c ADD DATAFILE 'ts_c.ibd';

USE db_index;
-- 테이블을 생성하면서 테이블 스페이스 지정
CREATE TABLE table_a
	(id INT)
	TABLESPACE ts_a;
    
CREATE TABLE table_b (id INT);
ALTER TABLE table_b TABLESPACE ts_b;

-- 대용량 데이터 테이블 복사(약 280만 행)
CREATE TABLE table_c (SELECT * FROM employees.salaries);
ALTER TABLE table_c TABLESPACE ts_c;

-- 쿼리 질의 시간이 오래 걸려서 응답하지 않을 경우
-- [Edit] → [Preferences] → [SQL Editor]
-- [MySQL Session] 부분의 'timeout interval'을 포함하는 2개의 항목을 0으로 설명하면
-- 시간 제한을 없앨 수 있다. (주의!)