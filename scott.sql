CREATE ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- SQL은 대소문자 구별하지 않음
-- 단, 비밀번호는 구분함
-- DML
-- 조회(select문) 
-- 기본형식 (해석 순서)
-- SELECT 컬럼명 ---- ⑤
-- FROM 테이블명 ---- ①
-- WHERE 조건절 ---- ②
-- GROUP BY 컬럼명 ---- ③
-- HAVING 집계함수, 조건절 ---- ④
-- ORDER BY 컬럼명... ---- ⑥
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











-- BETWEEN A AND B :일정 범위 내의 데이터 조회 시 사용
-- 급여가 2000 이상이고 3000 이하인 조회
SELECT *
FROM EMP e 
WHERE e.SAL BETWEEN 2000 AND 3000;

-- NOT BETWEEN A AND B : 사이의 범위가 아닌
-- 급여가 2000이하 3000 이상인 직원 조회
SELECT *
FROM EMP e 
WHERE e.SAL NOT BETWEEN 2000 AND 3000;








-- LIKE 연산자와 와일드 카드(%, _)
-- 문자열을 찾을 때 부분 글자만 알 경우 사용
-- %는 문자열 전체 (LIKE '%d') : d문자로 끝나는 문자열 
-- _는 문자 한글자에 대응 (LIKE '_d') : d문자로 끝나는 길이가 2인 문자열
SELECT * FROM EMP e WHERE  ENAME LIKE '_j%';
SELECT * FROM EMP e WHERE  ENAME LIKE '_L%';

-- 사원명에 AM문자가 포함된 사원 조회
SELECT * FROM EMP e WHERE  ENAME LIKE '%AM%';

-- AM문자가 포함되지 않는 사원
SELECT * FROM EMP e WHERE  ENAME NOT LIKE '%AM%';















-- IS NULL
-- null은 동등연산자 사용x
-- IS OR IS NOT 연산자 사용
SELECT * FROM EMP e WHERE e.COMM IS NULL;
SELECT * FROM EMP e WHERE e.COMM IS NOT NULL;








-- 집합 연산자
-- UNION : 합집합(결과 값의 중복 제거)
-- UNION ALL : 합집합(결과 값의 중복 있음)
-- MINUS : 차집합
-- INTERSECT : 교집합

-- 두개의 결과를 합쳐서 출력
-- 부서번호가 10인 사원 조회(사번, 이름, 급여, 부서번호)
-- 부서번호가 20인 사원 조회(사번, 이름, 급여)
SELECT e.EMPNO , e.ENAME , e.SAL , e.DEPTNO 
FROM  EMP e 
WHERE e.DEPTNO = 10
UNION 
SELECT e.EMPNO , e.ENAME , e.SAL 
FROM  EMP e 
WHERE e.DEPTNO = 20; -- 에러 : 합집합의 경우 열의 수는 맞춰야함, 그외 타입과 열_이름도 동일해야 함

SELECT e.EMPNO , e.ENAME , e.SAL 
FROM  EMP e 
WHERE e.DEPTNO = 10
UNION 
SELECT e.EMPNO , e.ENAME , e.SAL 
FROM  EMP e 
WHERE e.DEPTNO = 20; -- 다르게 조회할 수 있지만 조회 속도를 높이기 위해 union쓰는 경우도 있음

SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO
FROM  EMP e 
WHERE e.DEPTNO = 10
UNION ALL 
SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO
FROM  EMP e 
WHERE e.DEPTNO = 10;

SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO
FROM  EMP e 
MINUS 
SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO
FROM  EMP e 
WHERE e.DEPTNO = 10;

SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO
FROM  EMP e 
MINUS 
SELECT e.EMPNO , e.ENAME , e.SAL, e.DEPTNO
FROM  EMP e 
WHERE e.DEPTNO = 10;
































































