USE scott;

-- 개별 테이블 확인
SELECT * FROM emp;
SELECT * FROM dept;

-- 두 개의 테이블 조회
SELECT * FROM emp, dept;	-- 모든 가능한 행 14 * 4 = 56의 결과 조회(카디션 프로덕드, Cartesian Product)

-- 두 개의 테이블에서 DEPTNO가 같은 경우만 조회(WHERE절 2개의 테이블 조건 명시)
SELECT * FROM emp, dept;
SELECT * FROM emp, dept WHERE emp.DEPTNO = dept.DEPTNO;
-- → 암시적 조인

-- 두 개의 테이블을 결합하고, 결과 셋에서 필요한 속성들만 프로젝션(투영)
SELECT ename, job, sal, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- 양쪽 테이블 모두에 있는 필드 이름인 경우 테이블명을 명시하지 않으면 오류
SELECT ename, job, sal, dept.deptno, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- 일반적으로 프로젝션하는 모든 필드의 이름에 테이블을 함께 명시
SELECT emp.ENAME, emp.JOB, emp.SAL, dept.DEPTNO, dept.DNAME, dept.LOC
FROM emp, dept
WHERE emp.DEPTNO = dept.DEPTNO;

-- 각 필드가 어떤 테이블에 속했는지 명확해졌지만, 내용이 너무 길어진다는 점이 있음
-- 각각의 테이블명에 별칭을 주어 간결화 시킨다.(관례적으로 테이블 앞글자)
SELECT e.ENAME, e.JOB, e.SAL, d.DEPTNO, d.DNAME, d.LOC
FROM emp e, dept d
WHERE e.DEPTNO = d.DEPTNO;

-- 명시적 조인
-- JOIN과 ON 키워드를 함께 사용
-- 1. Inner Join
SELECT *
FROM emp
INNER JOIN dept ON emp.DEPTNO = dept.DEPTNO;

-- 특정 컬럼만 프로젝션
SELECT e.ENAME, d.DNAME
FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;

-- 2. LEFT JOIN & RIGHT JOIN

-- LEFT JOIN 테이블1에 공통 컬럼이 없는 경우도 포함하여, 테이블2를 조회
-- [샘플] DEPTNO가 NULL인 행을 삽입
INSERT INTO emp
VALUES (9999,'Jhon', 'Doe', NULL, NULL, NULL, NULL, NULL);

-- INNER : LEFT (테이블1)와 RIGHT (테이블2) 모두 존재하는 경우
-- LEFT : LEFT (테이블1)에는 존재하고, RIGHT (테이블2)에는 존재하지 않는 행을 포함
-- RIGHT : LEFT (테이블1)에는 존재하지 않고, RIGHT (테이블2)에는 존재하는 행을 포함

-- LEFT JOIN : 9999번 행(DEPTNO가 NULL)은 포함, 40번 부서는 불포함
SELECT *
FROM emp e
LEFT JOIN dept d ON e.DEPTNO = d.DEPTNO;

-- RIGHT JOIN : 9999번 행(DEPTNO가 NULL)은 불포함, 40번 부서는 포함
SELECT *
FROM emp e
RIGHT JOIN dept d ON e.DEPTNO = d.DEPTNO;

-- 샘플 행 삭제
DELETE FROM emp WHERE EMPNO = 9999;

-- SELF JOIN
-- 별칭을 사용해서 동일 테이블을 마치 두 개의 테이블인 것처럼
-- 같은 테이블을 두 번 참조하여 결합하는 방식
SELECT e1.ENAME AS "직원", e2.ENAME AS "매니저"
FROM emp e1
JOIN emp e2 ON e1.MGR = e2.EMPNO;

-- 두 개의 테이블을 결합할 때 컬럼이 이퀄(=, 등호)가 아닌 비교, 범위 등의 조건으로
-- Join Condition 으로 결합한 경우
-- 직원 테이블의 급여(SAL)가 급여 등급 테이블(salgrade)의 LOSAL, HISAL 범위에 있는 경우로 JOIN
SELECT e.ENAME, e.SAL, s.GRADE
FROM emp e
JOIN salgrade s ON e.SAL BETWEEN s.LOSAL AND s.HISAL;

SELECT * FROM salgrade;

-- 3개 이상의 테이블을 결합하는 경우
SELECT e.ENAME, d.DEPTNO, d.DNAME, s.GRADE
FROM emp e
JOIN dept d ON e.DEPTNO = d.DEPTNO
JOIN salgrade s ON e.SAL BETWEEN s.LOSAL and s.HISAL;

-- 그룹화 집계 함수와 함께 사용
-- 부서별 급여 평균(부서의 번호 대신 부서명, 평균)
SELECT d.DNAME "부서명", round(avg(e.SAL)) "부서별 급여평균"
FROM emp e
JOIN dept d ON e.DEPTNO = d.DEPTNO
GROUP BY DNAME;

-- USING 키워드와 함께 사용
-- 두 테이블이 공통적으로 가지고 있는 열을 기준으로 JOIN 할 때 사용
-- 두 테이블에서 열 이름이 동일해야 사용 가능
-- ON d.DEPTNO = e.DEPTNO를 간소화 한 형태
SELECT *
FROM emp e
JOIN dept d USING (DEPTNO);

-- NATURAL JOIN
-- 두 테이블 간의 이름과 데이터 타입이 같은 모든 열을 자동으로 찾아서 해당 열을 기준으로 JOIN
SELECT *
FROM emp e
NATURAL JOIN dept d;

-- CROSS JOIN
-- 양 테이블의 모든 행을 조인, 결과는 두 테이블을 곱한 개수, 카티션 프로덕트
-- 많은 데이터 생성 시 사용
SELECT * FROM emp
CROSS JOIN dept;