-- 집계 함수
USE scott;

SELECT * FROM emp;

-- 집계 함수의 결과는 단일행
-- 관심 있는 Attribute에 주로 사용

-- count() : 주어진 조건을 만족하는 행의 개수를 반환
SELECT count(*) FROM emp;		-- 직원 수
SELECT count(ename) FROM emp;	-- 직원 이름의 수
-- 행의 값이 null인 경우는 제외
SELECT count(mrg) FROM emp;		-- 매니저의 수(매니저가 없는 경우 제외)
SELECT count(comm) FROM emp;	-- 커미션의 수(커미션이 없는 경우 제외)

-- sum() : 숫자로 이루어진 열(속성, Attribute)의 총합을 계산
SELECT sum(sal) FROM emp;
SELECT sum(comm) FROM emp;	-- 관심 있는 열에 null 값이 포함될 경우 제외하고 요약

-- avg() : 숫자로 이루어진 열(속성, Attribute)의 평균을 계산 → 소수로 리턴
SELECT avg(sal) FROM emp;
-- round() 함수와 같이 사용하면 반올림 → round(소수 숫자, 자리 수)
SELECT round(avg(sal)) FROM emp;		-- 0의 자리에서 반올림
SELECT round(avg(sal), 2) FROM emp;		-- 소수점 2자리에서 반올림
SELECT round(avg(sal), -2) FROM emp;	-- 10의 자리에서 반올림

-- mim() & max() : 열에서 최대값 최소값을 찾음
SELECT min(sal), max(sal) FROM emp;
SELECT min(sal) AS '최소 급여', max(sal) '최대 급여' FROM emp;
-- mim() & max()는 숫자 이외의 다양한 데이터 형식에도 사용 가능
SELECT min(ename), max(ename) FROM emp;
SELECT min(hiredate), max(hiredate) FROM emp;

-- stddev() : 표준편차
-- var_samp() : 분산
SELECT stddev(sal) FROM emp;
SELECT var_samp(sal) FROM emp;

-- GROUP BY : 특정 컬럼의 값에 따라 행들을 그룹화
-- JOB 별로 평균 급여를 계산
SELECT job, avg(sal)
FROM emp
GROUP BY job;

-- 주의사항! GROUP BY 절에 지정된 열 외에 다른 열을 SELECT 절에 포함시킬 수 없다.
SELECT job, deptno, avg(sal)
FROM emp
GROUP BY job, deptno;

-- GROUP BY 절의 순서
-- WHERE 절 다음 ORDER BY 절 이전에 위치해야 한다.
SELECT deptno, avg(sal) AS 평균급여
FROM emp
GROUP BY deptno
ORDER BY 평균급여 DESC;

-- HAVING 절
-- GROUP BY로 인해 생성된 그룹에 조건을 적용할 때 사용
-- WHERE 절과의 차이점
-- WHERE 절 : 테이블의 각 개별 행에 대해 조건을 정의
-- HAVING 절 : 그룹화된 결과에 대해 조건을 정의

-- 평균 급여가 2000 이상인 부서의 급여 조회
SELECT deptno, avg(sal) AS 평균급여
FROM emp
-- WHERE sal > 1500 : 원 테이블의 각 행에 대하여 
GROUP BY deptno
HAVING 평균급여 >= 2000;	-- 그룹화된 결과에 대한 조건

-- WHERE, GROUP BY, HAVING 절은 순서가 바뀔 수 없다.

-- WITH ROLLUP
-- 각 그룹별 소합계 및 총 합계를 계산
-- 요약 보고서 작성이나 데이터 분석에 사용
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY deptno, job WITH ROLLUP;