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
	
