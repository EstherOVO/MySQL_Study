USE scott;

-- 문제 1 : EMP 테이블에서 전체 직원 수를 계산하세요.
SELECT count(ENAME) AS "전체 직원 수" FROM emp;

-- 문제 2 : EMP 테이블에서 각 부서(DEPTNO)별 직원 수를 계산하세요.
SELECT DEPTNO AS "부서" , count(ENAME) AS "전체 직원 수" FROM emp GROUP BY DEPTNO ORDER BY DEPTNO;

-- 문제 3 : EMP 테이블에서 전체 직원의 평균 급여(SAL)를 계산하세요.
SELECT round(avg(SAL), 2) AS "평균 급여" FROM emp;

-- 문제 4 : EMP 테이블에서 각 직무(JOB)별 평균 급여를 계산하되, 평균 급여가 2000 이상인 직무만 포함하세요.
SELECT JOB AS "직무" , round(avg(SAL), 2) AS "평균 급여" FROM emp GROUP BY JOB HAVING round(avg(SAL), 2) >= 2000;

-- 문제 5 : EMP 테이블에서 가장 높은 급여와 가장 낮은 급여를 조회하세요.
SELECT ENAME, SAL FROM emp WHERE SAL = (SELECT min(SAL) FROM emp) OR SAL = (SELECT max(SAL) FROM emp);

-- 문제 6 : EMP 테이블에서 각 부서별로 가장 높은 급여를 받는 직원의 급여를 조회하세요.
SELECT DEPTNO, ENAME, SAL FROM emp WHERE SAL IN (SELECT max(SAL) FROM emp GROUP BY DEPTNO);
SELECT DEPTNO, max(SAL) FROM emp GROUP BY DEPTNO;

-- 문제 7 : EMP 테이블에서 각 부서별 총 급여(SAL)를 계산하세요.
SELECT DEPTNO AS "부서", sum(SAL) AS "총 급여" FROM emp GROUP BY DEPTNO ORDER BY DEPTNO;