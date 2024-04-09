USE scott;

-- 문제 1 : 회사 전체 평균 급여보다 많이 받는 모든 직원의 이름을 조회하세요.
-- 사용 테이블: EMP (ENAME, SAL)
SELECT ENAME, SAL FROM emp WHERE SAL > (SELECT avg(SAL) FROM emp);

-- 문제 2 : 가장 많은 급여를 받는 직원의 이름을 조회하세요.
-- 사용 테이블: EMP (ENAME, SAL)
SELECT ENAME, SAL FROM emp WHERE SAL IN (SELECT max(SAL) FROM emp);

-- 문제 3 : SMITH보다 먼저 입사한 모든 직원의 이름을 조회하세요.
-- 사용 테이블: EMP (ENAME, HIREDATE)
SELECT ENAME, HIREDATE FROM emp WHERE HIREDATE >= (SELECT HIREDATE FROM emp WHERE ENAME = 'SMITH') ORDER BY HIREDATE;

-- 문제 4 : 자신의 부서에서 평균보다 더 많은 급여를 받는 직원의 이름을 조회하세요.
-- 사용 테이블: EMP (ENAME, SAL, DEPTNO)
SELECT DEPTNO, ENAME, SAL FROM emp WHERE SAL > (SELECT avg(SAL) FROM emp GROUP BY DEPTNO) ORDER BY DEPTNO;