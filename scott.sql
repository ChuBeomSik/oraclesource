CREATE ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- SQL은 대소문자 구별하지 않음
-- 단, 비밀번호는 구분함
-- DML
-- 1) 전체 조회
-- EMP(employee - 사원테이블)
-- 테이블(EMP e) 열 전체(*) 조회
SELECT
	*
FROM
	EMP e; -- e 별칭

-- 2) 선택 조회
-- column 지정
SELECT
	EMPNO,
	ENAME,
	MGR
FROM
	EMP e;
	
-- 중복 조회 : distinct
SELECT
	DISTINCT deptno
FROM
	EMP e;
	
-- 별칭
SELECT
	EMPNO AS "사원번호"
FROM
	EMP e;
	
SELECT
	EMPNO  "사원번호"
FROM
	EMP e;
	
SELECT
	EMPNO AS 사원번호
FROM
	EMP e;
SELECT
	EMPNO AS 사원 번호
FROM
	EMP e; -- 공백 있을 경우만 안됨
	
-- 연봉 컬럼 만들기
SELECT
	EMPNO ,
	ENAME ,
	SAL ,
	COMM ,
	sal * 12 + COMM AS "연봉"
FROM
	EMP e;
	
-- 조회 후 내림차순 정렬
SELECT ENAME , SAL 
FROM EMP e
ORDER BY SAL DESC;

-- 오름차순
SELECT ENAME , SAL 
FROM EMP e
ORDER BY SAL; -- ASC는 생략가능

-- EMPNO 내림차순
SELECT *
FROM EMP e 
ORDER BY EMPNO DESC;
   
-- deptno 오름차순, sal 내림차순
SELECT *
FROM EMP e
ORDER BY DEPTNO ASC , sal DESC;

-- 실습1
SELECT
	EMPNO as EMPLOYEE_NO,
	ENAME AS EMPLOYEE_NAME,
	MGR MANAGER,
	SAL AS SALARY,
	COMM AS COMMISION,
	DEPTNO AS DEPARTMENT_NO
FROM
	EMP
ORDER BY
	deptno DESC,
	ename ASC;

-- 2) 조건 지정
-- 기본 select 컬럼,... from 테이블명 where 조건 나열;

-- 부서번호가 30번인 사원 전체 조회
SELECT * FROM emp WHERE DEPTNO = 30;
-- EMPNO이 7839인 사원
SELECT * FROM EMP e WHERE EMPNO = 7839;
-- 부서번호가 30이고 직책이 salesman인 사원 조회
-- SQL에서 문자열은 '' 사용
SELECT * FROM EMP e WHERE DEPTNO = 30 AND JOB = 'SALESMAN';
-- 사원번호가 7698이고 부서번호가 30인 사원 조회
SELECT * FROM EMP e WHERE DEPTNO = 30 AND EMPNO = 7698;
-- 부서번호가 30이거나 사원직책이 CLERK인 사원 조회
SELECT * FROM EMP e WHERE DEPTNO = 30 OR JOB = 'CLERK';











-- 연봉이 36000인 사원 조회
SELECT * FROM EMP e WHERE SAL * 12 = 36000;

-- 급여가 3000보다 큰 사원 조회
SELECT * FROM EMP e WHERE SAL > 3000;

-- 급여가 3000이상인 사원조회
SELECT * FROM EMP e WHERE SAL >= 3000;

-- IN : 다항 OR 연산
SELECT * FROM EMP e WHERE e.JOB IN ('MANAGER', 'SALESMAN', 'CLERK');
-- NOT IN : AND 연산 
SELECT * FROM EMP e WHERE e.JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');
-- 부서번호가 10번이거나 20번인 사원 조회
SELECT * FROM EMP e WHERE e.DEPTNO IN (10,20);













