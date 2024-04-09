-- 서브 쿼리(부속질의, SubQuery)
USE scott;

-- 특정 직원 'ALLEN'보다 급여를 많이 받는 직원 찾기
SELECT ENAME, SAL FROM emp;

-- 서브 쿼리 → 결과 : 1600을 확인 후
SELECT ENAME, SAL FROM emp WHERE ENAME = 'ALLEN';
-- 메인 쿼리 → 비교 조건으로 하드코딩
SELECT ENAME, SAL FROM emp WHERE SAL > 1600;

-- 메인 쿼리의 WHERE 절 조건에 서브 쿼리를 삽입 : 동적으로 조건 설정 가능
SELECT ENAME, SAL FROM emp WHERE SAL > (SELECT SAL FROM emp WHERE ENAME = 'ALLEN');

-- 단일 행 서브 쿼리(Single Row SubQuery)
-- 서브 쿼리의 결과가 반드시 하나의 행만 반환해야 한다.

-- 특정 부서(30)의 평균 급여보다 높은 급여를 받는 직원 조회

-- 집계 함수를 사용하여 결과 값이 단일 행 → 서브 쿼리로 사용
SELECT avg(SAL) FROM emp WHERE DEPTNO = 30;
-- 서브 쿼리의 결과 값을 WHERE 절의 조건으로 받는 메인 쿼리
SELECT ENAME, SAL FROM emp WHERE SAL > 1566.6667;
-- 메인 쿼리와 서브 쿼리를 하나의 쿼리로 사용 
SELECT ENAME, SAL FROM emp WHERE SAL > (SELECT round(avg(SAL), 2) FROM emp WHERE DEPTNO = 30); 

-- IN 함수 : 목록 안에 값이 포함되었는지 확인
SELECT * FROM emp WHERE DEPTNO IN (10, 20, 30);

-- 메인쿼리
SELECT e.EMPNO, e.ENAME, e.SAL, d.DNAME, d.LOC
FROM emp e JOIN dept d ON e.DEPTNO = d.DEPTNO
WHERE e.EMPNO IN (SELECT EMPNO FROM emp WHERE SAL > 2000);

-- 서브쿼리
SELECT EMPNO FROM emp WHERE SAL > 2000;	-- 2000보다 급여를 많이 받는 6명(행) 조회 결과

-- 서브 쿼리 결과 20, 3
SELECT DEPTNO FROM dept WHERE DNAME = 'sales' OR DNAME = 'research';

-- 메인 쿼리 IN ( 20, 30의 결과에 해당하는 서브쿼리 )
SELECT * FROM emp WHERE DEPTNO IN (SELECT DEPTNO FROM dept WHERE DNAME = 'sales' OR DNAME = 'research');

-- 아래 실행문과 동일한 결과를 갖는다.
SELECT * FROM emp WHERE DEPTNO IN (20, 30);

-- ANY 함수 :
SELECT SAL FROM emp WHERE DEPTNO = 20;	-- 서브쿼리의 결과
-- 20번 부서 직원의 급여 → (5행) (800, 2975, 3000, 1100, 3000)

-- 메인 쿼리의 ANY 함수에 사용(비교 연산자와 함께 사용)
-- 하나라도 큰 것이 있으면 참 → 800보다 많이 받는 모든 직원
SELECT ENAME, SAL FROM emp WHERE SAL > ANY (SELECT SAL FROM emp WHERE DEPTNO = 20);

-- ALL 함수
-- (800, 2975, 3000, 1100, 3000) 여러 행의 결과 값 모두보다 이상이어야 함
-- 3000(최댓값)보다 큰 경우만 참
SELECT ENAME, SAL FROM emp WHERE SAL > ALL (SELECT SAL FROM emp WHERE DEPTNO = 20);

-- 800(최솟값)보다 작은 경우만 참
SELECT ENAME, SAL FROM emp WHERE SAL < ALL (SELECT SAL FROM emp WHERE DEPTNO = 20);

-- EXISTS : 주로 상호 연관 서브 쿼리에서 유용하게 사용
-- 상호연관 쿼리 : 메인 쿼리의 칼럼을 서브 쿼리에서 사용하는 것
-- 각 부서에 대해 직원이 존재하는 경우 참, 존재하지 않으면 거짓
SELECT * FROM dept;
SELECT * FROM emp;
SELECT DNAME, LOC FROM dept d
WHERE EXISTS (SELECT * FROM emp e WHERE d.DEPTNO = e.DEPTNO);

-- SELECT 절에서 서브 쿼리 사용
SELECT e.ENAME, e.SAL, e.DEPTNO,
(SELECT avg(SAL) FROM emp WHERE DEPTNO = e.DEPTNO)	-- 각 부서의 평균 급여 → 메인 쿼리의 컬럼의 하나로 사용
FROM emp e;

-- 단일 행을 반환하여 사용
-- 데이터베이스에 따라 성능 및 비용 문제가 발생할 수 있다.(데이터 양이 많을 경우 다른 방법을 사용)
-- 쿼리의 결과를 유연하게 동적으로 표현하고 싶을 때 사용

-- FROM 절 : 인라인 뷰(Inline View)
-- 서브 쿼리가 임시 테이블처럼 동작하게 하여, 메인 쿼리에 사용

-- 생성된 임시 테이블은 쿼리 실행 시점에만 존재하고 사라진다. → 쿼리문 안에서만 사용
-- 부서별 급여 평균
SELECT DEPTNO, avg(SAL) FROM emp GROUP BY DEPTNO;

SELECT dept_avg.DEPTNO, dept_avg.avg_SAL
FROM (SELECT DEPTNO, avg(SAL) AS avg_SAL FROM emp GROUP BY DEPTNO) AS dept_avg;
