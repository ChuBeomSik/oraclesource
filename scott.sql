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
	sal AS SALARY,
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