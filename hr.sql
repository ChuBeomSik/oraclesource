-- EMPLOYEESS (scott 계정의 emp 테이블 원본)
-- EMPLOYESS 전체 조회
SELECT * FROM EMPLOYEES;
-- first_namem, last_name, job_id 조회
-- 쿼리문 정렬 단축키 :ctlr + shift + f
SELECT
	first_name,
	last_name,
	job_id
FROM
	EMPLOYEES;
SELECT * FROM EMPLOYEES e ;
-- 사원 번호가 176인 사원의 LAST_NAME, 부서번호 조회
SELECT LAST_NAME, DEPARTMENT_ID FROM EMPLOYEES e WHERE EMPLOYEE_ID = 176; 

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME과 연봉 조회
SELECT
	LAST_NAME,
	SALARY AS 연봉
FROM
	EMPLOYEES e
WHERE
	SALARY >=12000;

-- 연봉이 5000에서 12000 범위가 아닌 사람들의 LAST_NAME과 연봉조회
SELECT
	LAST_NAME,
	SALARY AS 연봉
FROM
	EMPLOYEES e
WHERE
	SALARY > 12000
	OR SALARY < 5000;

-- 20번 혹은 50번 부서에서 근무하는 사원들의 last_name, 부서번호를 조회
-- 단, 이름의 오름차순, 부서의 오름차순으로 정렬
SELECT LAST_NAME, e.DEPARTMENT_ID FROM EMPLOYEES e WHERE DEPARTMENT_ID IN (20,50) ORDER BY e.LAST_NAME , e.DEPARTMENT_ID;

-- 커미션을 버는 사원들의 last_name, salary, commission_pct를 조회
-- 단, 연봉의 내림차순, 커미션 내림차순으로 정렬
SELECT e.LAST_NAME, e.SALARY, e.COMMISSION_PCT FROM EMPLOYEES e WHERE e.COMMISSION_PCT > 0 ORDER BY e.SALARY DESC, e.COMMISSION_PCT DESC;

-- 연봉이 2500, 3500, 7000이 아니며 job_id가 SA_PER OR ST_CLERK 인 사원조회
SELECT * FROM EMPLOYEES e WHERE e.SALARY NOT IN (2500,3500,7000) AND e.JOB_ID IN ('SA_PER', 'ST_CLERK');

-- 2018/02/20 ~ 2018/05/01 사이에 고용된 직원들의 LAST_NAME,사번,고용일자 조회
SELECT e.LAST_NAME, e.EMPLOYEE_ID, e.HIRE_DATE 
FROM EMPLOYEES e 
WHERE e.HIRE_DATE >= '2018-02-20' AND e.HIRE_DATE <= '2018-05-01';
	
