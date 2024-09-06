CREATE ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- SQL은 대소문자 구별하지 않음
-- 단, 비밀번호는 구분함
-- DML (CRUD - Creat / Read / Update / Delete)
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




-- 키워드나 예약어는 대소문자 구분 x
-- 데이터는 대소문자 구분함
-- UPPER(''), LOWER('') : 대문자 / 소문자로 변환
-- INITCAP('') : 첫문자만 대문자로 변환
-- LENGTH('') : 문자열 길이
-- LENGTHB('') : 문자열 바이트 수
-- SUBSTR(문자열, 시작위치) / SUBSTR(문자열, 시작위치, 추출길이)
-- INSTR(문자열, 찾으려는 문자)
-- INSTR(문자열, 찾으려는 문자, 위치 찾기를 시작할 대상 문자열 데이터 위치, 시작위치에서 찾으려는 문자가 몇번째인지)
-- REPLACE(문자열, 찾는문자, 대체문자)
-- CONCAT(문자열, 이으려는 문자열) : 한번에 3개이상 연결 불가
-- || == CONCAT
-- (FULL)TRIM / LTRIM / RTRIM : 특정 문자를 제거, 특정문자 입력 안할 시 기본으로 공백 제거

-- smith
SELECT *
FROM EMP e
WHERE UPPER(ENAME) LIKE UPPER('smith');

-- LENGTH('') / LENGTHB('')
SELECT LENGTH('한글'), LENGTHB('한글'), LENGTH('AB'), LENGTHB('AB')
FROM DUAL -- DUAL : 오라클에서 기본으로 제공하는 가상데이터베이스

SELECT JOB, SUBSTR(JOB,1,2),SUBSTR(JOB,3,2),SUBSTR(JOB,5)
FROM EMP;




-- 사원 이름에 s가 있는 행 구하기
-- LIKE
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE '%s%';

-- INSTR
SELECT *
FROM EMP e 
WHERE INSTR(ENAME , 'S') > 0;

-- 010-1234-1535
-- - => 공백 혹은 삭제
SELECT '010-1234-1535' AS  replace_before,
REPLACE ('010-1234-1535', '-', ' ') AS replace_1,
REPLACE('010-1234-1535','-') AS replace_2
FROM DUAL;

-- EMPNO, ENAME 연결 조회
SELECT CONCAT(e.EMPNO , ENAME)
FROM EMP e ;

SELECT 
'[' || TRIM('_ORACLE_') || ']' AS TRIM,
'[' || LTRIM('_ORACLE_') || ']' AS LTRIM,
'[' || LTRIM('<ORACLE>', '_<') || ']' AS LTRIM2,
'[' || RTRIM('_ORACLE_') || ']' AS RTRIM,
'[' || RTRIM('<ORACLE>', '>_') || ']' AS RTRIM2
FROM DUAL;


-- 숫자함수
-- ROUND(숫자,[반올림위치])
-- TRUNC(숫자,[[버림위치])
-- CEIL(숫자) : 지정한 숫자와 가장 가까운  큰 정수 찾기
-- FLOOR(숫자) : 지정한 숫자와 가장 가까운 작은 정수 찾기
-- MOD(숫자, 나눌 숫자) : 나머지 구함

SELECT 
ROUND(1234.5678) AS round_0,
ROUND(1234.5678,0) AS round_1,
ROUND(1234.5678,1) AS round_2,
ROUND(1234.5678,2) AS round_3,
ROUND(1234.5678,-1) AS round_4,
ROUND(1234.5678,-2) AS round_5
FROM DUAL;

SELECT 
TRUNC(1234.5678) AS TRUNC_0,
TRUNC(1234.5678,0) AS TRUNC_1,
TRUNC(1234.5678,1) AS TRUNC_2,
TRUNC(1234.5678,2) AS TRUNC_3,
TRUNC(1234.5678,-1) AS TRUNC_4,
TRUNC(1234.5678,-2) AS TRUNC_5
FROM DUAL;

SELECT CEIL (3.14), FLOOR(3.14), CEIL(-3.14),FLOOR(-3.14)
FROM
DUAL;

SELECT MOD (15,6)
FROM DUAL;

-- 날짜 함수
-- SYSDATE : 오라클 서버가 설치된 OS의 현재날짜와 시간 사용
-- 날짜데이터 + 숫자 : 숫자만큼 일수 연산이 일어남
-- 날짜데이터 - 날짜데이터도 가능
-- 날짜데이터 + 날짜데이터는 불가능
-- ADD_MONTH(날짜데이터, 개월) : 더하기
-- MONTHS_BETWEEN(날짜데이터, 날짜데이터) : 빼기
-- NEXT_DAY(날짜데이터, 요일문자) : 날짜데이터에서 돌아오는 요일의 날짜 반화
-- LAST_DAY(날짜데이터) : 특정 날짜가 속한 달의 마지막 날짜 조회

SELECT SYSDATE,SYSDATE-1,SYSDATE+1 FROM DUAL;

-- 입사 20주년이 되는 날짜 조회
SELECT e.EMPNO , E.ENAME , e.HIREDATE, ADD_MONTHS(E.HIREDATE,240) 
FROM EMP e; 

-- 오늘 날짜에서 입사일 빼기
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE ,
	SYSDATE ,
	MONTHS_BETWEEN(e.HIREDATE, SYSDATE) AS month1,
	MONTHS_BETWEEN(SYSDATE, e.HIREDATE) AS month2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, e.HIREDATE)) AS month3
FROM
	EMP e ;

SELECT SYSDATE , NEXT_DAY(SYSDATE, '월요일'), LAST_DAY(SYSDATE)
FROM
DUAL;

-- 형변환 함수
-- NUMBER(INT타입) + '문자숫자': 연산해줌
-- '문자 숫자' + '문자 숫자' : 연산 안해줌
-- NUMBER + '문자열' : 연산안해줌
-- TO_CHAR(날짜데이터, '출력되길 원하는 문자형태') : 문자로 변경
-- TO_NUMBER(문자데이터, '인식되길 원하는 숫자형태') : 숫자로 변경
-- 인식 되길 원하는 숫자 형태 : 9(숫자 한자리를 의미하고 빈자리는 채우지 않음) / 0(숫자 한자리를 의미하고 빈자리는 채움)
-- TO_DATE(날짜데이터, '출력되길 원하는 날짜 형태')
SELECT E.EMPNO, E.ENAME, E.EMPNO + '500'
FROM EMP e;

SELECT E.EMPNO, E.ENAME, E.EMPNO + 'ABC'
FROM EMP e;

-- 날짜데이터 ==> 문자데이터
SELECT TO_CHAR(SYSDATE,'YYYY/MM/DD') AS 현재날짜
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'MM') AS 현재월, TO_CHAR(SYSDATE,'MON') AS 현재월2, TO_CHAR(SYSDATE,'MONTH') AS 현재월3
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'DD') AS 현재일, TO_CHAR(SYSDATE,'DDD') AS 일자, TO_CHAR(SYSDATE,'DAY') AS 요일
FROM DUAL;

SELECT
	SYSDATE ,
	TO_CHAR(SYSDATE, 'HH:MI:SS') AS 시간,
	TO_CHAR(SYSDATE,'HH12:MI:SS') AS 12시기준,
	TO_CHAR(SYSDATE,'HH24:MI:SS') AS 24시기준,
	TO_CHAR(SYSDATE,'HH24:MI:SS AM') AS 오전오후
FROM
	DUAL;

-- 문자데이터 ==> 숫자 데이터
SELECT 1300 - '1500', '1300' + 1500
FROM DUAL;

-- 9(숫자 한자리를 의미하고 빈자리는 채우지 않음) OR 0(숫자 한자리를 의미하고 빈자리는 채움)
SELECT  TO_NUMBER('1300','999999') + TO_NUMBER('1500','999999')
FROM DUAL;

-- 문자 데이터 ==> 날짜데이터
SELECT  TO_DATE('2024-09-05', 'YYYY-MM-DD') AS TODATE1, TO_DATE('20240905', 'YYYY-MM-DD') AS TODATE2
FROM DUAL;

-- EMP테이블에서 1981-06-01 이후에 입사한 사원 조회
SELECT E.EMPNO , E.ENAME , E.HIREDATE 
FROM EMP e 
WHERE E.HIREDATE >= '1981-06-01';

SELECT E.EMPNO , E.ENAME , E.HIREDATE 
FROM EMP e 
WHERE E.HIREDATE >= TO_DATE('1981-06-01', 'YYYY-MM-DD');

-- 날짜 데이터 + 날짜 데이터
SELECT '2024-09-05' + '2024-01-02'
FROM DUAL; -- 수치 부적합

SELECT '2024-09-05' - '2024-01-02'
FROM DUAL; -- 수치 부적합

SELECT TO_DATE('2024-09-05') + TO_DATE('2024-01-02')
FROM DUAL; -- 날짜와 날짜 가산을 할 수 없음

SELECT TO_DATE('2024-09-05') - TO_DATE('2024-01-02')
FROM DUAL;

-- NULL 함수 처리
-- NULL은 산술연산 안됨 => NULL을 다른 값으로 변경해야 함
-- NULL값을 바꾸는 함수
-- NVL(널값, 대체할 값)
-- NVL2(널값, 널이 아닌 경우 반환값, 널인 경우 반환값)

SELECT EMPNO , ENAME , SAL, COMM, SAL+COMM, SAL+NVL(COMM,0) 
FROM EMP;

SELECT EMPNO , ENAME , SAL, COMM, NVL2(COMM,'O','X') 
FROM EMP;

-- NULL이 아니면 SAL*12+COMM
-- NULL이면 SAL*12
SELECT EMPNO , ENAME , SAL, COMM, NVL2(COMM,SAL*12+COMM,SAL*12) 
FROM EMP;

-- DECODE 함수 / CASE문
DECODE(데이터, 
	조건1, 조건1 만족할 때 할것,
	...
	) AS 별칭
	
CASE
	데이터
	WHEN 조건1 THEN 값1
	WHEN 조건2 THEN 값2
	...
END



	
-- JOB이 MANAGER라면 SAL*1.1
-- JON이 SALESMAN이라면 SAL*1.5
-- JOB이 ALALYST라면 SAL
--				그 외 SAL*1.3 
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL,
	DECODE(
	JOB, 
	'MANAGER',E.SAL*1.1,
	'SALESMAN', SAL*1.5,
	'ANALYST', SAL*1.1,
	SAL*1.3) AS UPSAL
FROM
	EMP e ;

SELECT 
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL,
	CASE
		JOB 
		WHEN 'MANAGER' THEN E.SAL * 1.1
		WHEN 'SALESMAN' THEN SAL * 1.5
		WHEN 'ANALYST' THEN SAL * 1.1
		ELSE SAL * 1.3
	END AS UPSAL
FROM
	EMP e ;

-- COMM이 NULL '해당사항없음'
-- COMM이 = 0 '수당없음'
-- COMM > 0 '수당 : COMM'
SELECT 
	E.EMPNO ,
	E.ENAME ,
	E.COMM ,
	E.SAL,
	CASE
		WHEN COMM IS NULL THEN '해당사항없음'
		WHEN COMM = 0 THEN '수당없음'
		WHEN COMM > 0 THEN '수당: ' || E.COMM 
	END AS COMM_TEXT
FROM
	EMP e ;

-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 하루 근무시간을 8시간으로 봤을 때
-- 사원들의 하루 급여(DAY_DAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다
-- 사번, 이름, SAL, DAY_PAY,TIME_PAY 출력
-- 단, 하루급여는 소수점 셋째자리에서 버리고, 시급은 두번째 소수점에서 반올림하기
SELECT
	E.EMPNO ,
	E.ENAME ,
	SAL,
	TRUNC(SAL / 21.5,2) AS DAY_PAY,
	ROUND( SAL / 21.5 / 8,1) AS TIME_PAY
FROM
	EMP e ;




-- EMP테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일애 정직원이 된다. 사원들의 
-- 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 출력한다
-- 사번 , 이름, 고용일, R_JOB 출력
SELECT
	EMPNO ,
	ENAME,
	E.HIREDATE ,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일') AS R_JOB
FROM
	EMP e ;

-- 위 예제 + 추가수당
-- COMM이 없으면 'N/A', 있으면 COMM출력
SELECT
	EMPNO ,
	ENAME,
	E.HIREDATE ,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일') AS R_JOB,
	CASE
		WHEN COMM IS NULL THEN 'N/A'
		WHEN COMM IS NOT NULL THEN COMM || ''
	END AS COMM	
FROM
	EMP e ;

SELECT
	EMPNO ,
	ENAME,
	E.HIREDATE ,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일') AS R_JOB,
	NVL(TO_CHAR(COMM), 'N/A') AS COMM 
FROM
	EMP e ;


-- EMP테이블의 모든 사원을 대상으로 직속상관의 사원번호(MGR)를 변환해서 CHG_MGR에 출력
-- 사번, 이름, MGR, CHG_MGR 출력
-- 단, MGR이 NULL이면 '0000' / MGR의 앞 두자리가 75이면 '5555' / 76이면 '6666' / 77이면 '7777' / 78이면 '8888' CNFFUR
SELECT
	EMPNO,
	ENAME,
	MGR,
	CASE 
		WHEN  E.MGR IS NULL THEN '0000'
		WHEN E.MGR LIKE '75%' THEN '5555'
		WHEN E.MGR LIKE '76%' THEN '6666'
		WHEN E.MGR LIKE '77%' THEN '7777'
		WHEN E.MGR LIKE '78%' THEN '8888'
		ELSE '9999'
	END AS CHG_MGR	
FROM
	EMP e ;
SELECT
	EMPNO,
	ENAME,
	MGR,
	DECODE(
	SUBSTR(TO_CHAR(MGR),1,2),
	NULL, '0000',
	'75','5555',
	'76','6666',
	'77','7777',
	'78','8888',
	'9999') AS CHG_MGR	
FROM EMP e ;

-- 다중행 함수
-- SUM : 합계를 낼 열
-- DISTINCT : 중복 제거
-- COUNT : 행의 개수
-- MAX : 최댓값
-- MIN : 최솟값
-- AVG : 평균값

SELECT  SUM(SAL) AS 합 
FROM EMP e ;

SELECT  SUM(DISTINCT SAL), SUM(ALL SAL), SUM(SAL)
FROM EMP e ;

SELECT  COUNT(DISTINCT SAL), COUNT(ALL SAL), COUNT(SAL)
FROM EMP e ;

SELECT MAX(SAL), MIN(SAL) FROM EMP e;

SELECT MAX(SAL), MIN(SAL) FROM EMP e WHERE E.DEPTNO = 10;

-- 부서번호가 20번인 사원의 최근 입사일 조회
SELECT 
	MAX(E.HIREDATE) 
FROM EMP e WHERE E.DEPTNO = 20;

SELECT 
	MIN(E.HIREDATE) 
FROM EMP e WHERE E.DEPTNO = 20;

SELECT  AVG(DISTINCT SAL), AVG(ALL SAL), AVG(SAL)
FROM EMP e ; 

-- 부서번호가 30인 사원들의 평균 추가 수당
SELECT
	AVG(COMM) 
FROM EMP e WHERE E.DEPTNO = 30 ;


-- GROUP BY절 : 결과 값을 원하는 열로 묶어 출력
-- 각 부서별 평균 급여 출력
SELECT E.DEPTNO ,AVG(SAL) 
FROM EMP e 
GROUP BY E.DEPTNO
ORDER BY DEPTNO ;

-- 각 부서별, 직책별 평균 급여 출력
SELECT E.DEPTNO, JOB, AVG(SAL) 
FROM EMP e 
GROUP BY E.DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- GROUP BY 절 옆의 열이 SELECT 열에 없으면 사용불가
SELECT ENAME, AVG(SAL) -- GROUP BY 열에 해당하는 열이 조회되지 않으므로 오류
FROM EMP e 
GROUP BY E.DEPTNO ;

-- HAVING 절 : GROUP BY 절에 조건을 줄 때 사용

-- 각 부서의 직채결 평균 급여(평균 급여가 2000 이상인 그룹만 조회)

SELECT E.DEPTNO , JOB, AVG(SAL)
FROM EMP e 
GROUP BY E.DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY E.DEPTNO, JOB;

-- 부서별, 평균급여, 최고급여, 최저급여, 사원 수 출력
-- 평균급여 출력 시 소수점을 제외하고 출력
SELECT E.DEPTNO , TRUNC(AVG(SAL)), MAX(SAL), MIN(SAL),COUNT(DEPTNO) 
FROM EMP e 
GROUP BY E.DEPTNO ;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT E.JOB, COUNT(JOB) 
FROM EMP e
GROUP BY JOB
HAVING COUNT(JOB) >= 3 ;

-- 사원들의 입사년도를 기준으로 부서별로 몇 명의 입사인원이 있는지 출력
SELECT TO_CHAR(E.HIREDATE, 'YYYY') AS HIRE_YEAR, E.DEPTNO, COUNT(*) 
FROM EMP e 
GROUP BY TO_CHAR(E.HIREDATE), E.DEPTNO ;

-- JOIN(조인) : 두 개이상의 테이블을 연결하여 하나의 테이블처럼 출력, 조인시 동일한 컬럼명이 있을 경우 정확한 테이블명(별칭) + 도트연산자로 지칭해줘야함
-- 내부조인(INNER JOIN) : 일반적으로 등가조인을 (내부)조인이라 부름
 -- 등가조인 : 테이블 연결 후 출력행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 테이블 출력
 --  		 두 테이블이 기본키(PK)-외래키(FK)관계일 때 (서로 다른 테이블에 동일한 필드가 있을 때 같은 값을 같는 관계일 때)
 -- 비등가 조인 
-- 외부조인(OUTER JOIN) : [FULL | LEFT | RIGHT] JOIN
-- LEFT : 오른쪽 테이블에 + 기호
-- RIGHT : 왼쪽 테이블에 + 기호

SELECT * FROM EMP,DEPT; -- 각 테이블의 행의 개수 곱으로 출력됨

SELECT *
FROM EMP e , DEPT d 
WHERE E.DEPTNO = D.DEPTNO ;

-- 위 sql문에서 sal이 3000이상인 사원 조회
SELECT *
FROM EMP e , DEPT d 
WHERE E.DEPTNO = D.DEPTNO AND e.SAL >= 3000 ;

-- 비등가 조인 : 등가조인 이외의 방식, 다른 두 테이블에서 한 테이블의 필드값이 다른 테이블 필드의 값 범위내에 들어갈 수 있는 경우
-- ENP / SALGRADE
SELECT *
FROM EMP e , SALGRADE s 
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL ;

-- 자체 조인 : 같은 테이블내에서 조인, 잘 사용하지는 않지만 조직관계도를 나타낼 때 사용함
SELECT E.EMPNO, E.ENAME, E.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
FROM EMP e , EMP e2
WHERE E.MGR = E2.EMPNO; 

-- LEFT JOIN
SELECT E.EMPNO, E.ENAME, E.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
FROM EMP e , EMP e2
WHERE E.MGR = E2.EMPNO(+);

-- LIGHT JOIN
SELECT E.EMPNO, E.ENAME, E.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
FROM EMP e , EMP e2
WHERE E.MGR(+) = E2.EMPNO;

-- 쿼리문 변화
-- 내부조인 : JOIN ~ ON
-- 외부조인 : [FULL | LEFT(생략 시 기본값) | RIGHT] JOIN ~ ON

SELECT *
FROM EMP e JOIN DEPT d 
ON E.DEPTNO = D.DEPTNO ;

SELECT *
FROM EMP e JOIN DEPT d 
ON E.DEPTNO = D.DEPTNO
WHERE e.SAL >= 3000 ;

SELECT E.EMPNO, E.ENAME, E.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
FROM EMP e LEFT OUTER JOIN EMP e2
ON E.MGR = E2.EMPNO;

SELECT E.EMPNO, E.ENAME, E.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
FROM EMP e RIGHT OUTER JOIN EMP e2
ON E.MGR = E2.EMPNO;

-- TABLE 3개 조인
--SELECT *
--FROM EMP e1 JOIN EMP e2 ON E1.MRG = E2.EMPNO JOIN EMPE3 ON E1.MRG...

-- 각 부서별 평균급여, 최대급여, 최소급여, 사원수를 조회
-- 부서번호, 부서명, 평균급여(AVG_SAL), 최대급여(MAX_SAL), 최소급여(MIN_SAL), 사원수(CNT)
SELECT
	D.DEPTNO,
	D.DNAME, 
	AVG(E.SAL) AS AVG_SAL,
	MAX(E.SAL) AS MAS_SAL,
	MIN(E.SAL) AS MIN_SAL,
	COUNT(E.DEPTNO) AS CNT
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
GROUP BY
	D.DEPTNO, D.DNAME 
ORDER BY
	D.DEPTNO ;

-- 모든 부서정보와 사원정보를 조회
-- 부서번호, 부서명, 사원번호, 사원명, 직무(JOB) 조회
SELECT
	D.DEPTNO ,
	D.DNAME ,
	E.EMPNO ,
	E.ENAME ,
	E.JOB
FROM
	EMP e
RIGHT OUTER JOIN DEPT d 
ON E.DEPTNO = D.DEPTNO 
ORDER BY D.DEPTNO , E.EMPNO ;

-- 서브쿼리 : 쿼리문 안에 또 다른 쿼리문이 포함
-- SELECT, FROM, WHERE절 안에 다 들어갈 수 있음
-- 서브쿼리로 들어갈 수 있는 것들 : SELECT, FROM, WHERE, UPDATE, DELETE, INSERT등 

-- JONES의 월급보다 많은 월급을 받는 사원 조회
SELECT *
FROM EMP e 
WHERE E.SAL > (SELECT E2.SAL FROM EMP e2 WHERE E2.ENAME = 'JONES');

-- 생성 결과가 하나인 단일행 서브쿼리 : 비교연산자
-- KING보다 빠른 입사자 조회
SELECT *
FROM EMP e 
WHERE E.HIREDATE < (SELECT E2.HIREDATE FROM EMP e2 WHERE E2.ENAME = 'KING');

-- ALLEN 보다 추가수당 많이 받는 사원 조회
SELECT *
FROM EMP e 
WHERE E.COMM > (SELECT E2.COMM FROM EMP e2 WHERE E2.ENAME = 'ALLEN');

-- 20번 부서의 근무하는 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
SELECT *
FROM EMP e 
WHERE E.SAL > (SELECT AVG(E2.SAL) FROM EMP e2 WHERE E.DEPTNO = 20);

-- 20번 부서에 근무하는 사원 중 전체 사원의 평균급여보다 높은 급여를 받은 사원 조회 + 부서명, 부서위치
SELECT E.ENAME , D.DNAME , D.LOC 
FROM EMP e JOIN DEPT d ON E.DEPTNO = D.DEPTNO AND E.SAL > (SELECT AVG(E2.SAL) FROM EMP e2 WHERE E.DEPTNO = 20);

-- 실행 결과가 여러 개인 다중행 서브쿼리
-- IN : 메인 쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 TRUE
-- ANY(SOME) : 메인 쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 TRUE
-- ALL : 메인 쿼리의 조건식을 서브 쿼리의 결과 모두가 만족하면 TRUE
-- EXISTS : 서브 쿼리의 결과가 존재하면(즉, 행이 1개 이상일 경우) TRUE

-- 각 부서별 최고 급여와 동일하거나 큰 급여를 받는 사원 조회
SELECT  *
FROM EMP e 
WHERE E.SAL IN (SELECT MAX(E2.SAL) FROM EMP e2 GROUP BY E2.DEPTNO);

SELECT  *
FROM EMP e 
WHERE E.SAL = ANY (SELECT MAX(E2.SAL) FROM EMP e2 GROUP BY E2.DEPTNO);

SELECT  *
FROM EMP e 
WHERE E.SAL = SOME (SELECT MAX(E2.SAL) FROM EMP e2 GROUP BY E2.DEPTNO);

-- 30번 부서의 급여보다 적은 급여를 받는 사원조회 == 30번 부서의 최대 급여보다 적은 급여를 받는 사원조회
SELECT  *
FROM EMP e 
WHERE E.SAL < ANY (SELECT E2.SAL FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO ;

-- 30번 부서의 최소 급여보다 적은 급여를 받는 사원조회
SELECT  *
FROM EMP e 
WHERE E.SAL < ALL (SELECT E2.SAL FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO ;

SELECT  *
FROM EMP e 
WHERE E.SAL < ANY (SELECT MIN(E2.SAL) FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO ;

-- EXISTS
SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT d WHERE DEPTNO = 50);

SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT d WHERE DEPTNO = 10);

-- FROM 절 서브쿼리 작성 : 인라인뷰(INLINE VIEW)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP e WHERE DEPTNO = 10) E10, (SELECT * FROM DEPT) D 
WHERE E10.DEPTNO = D.DEPTNO;

SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP e WHERE DEPTNO = 10) E10, (SELECT * FROM DEPT) D 
WHERE E10.DEPTNO = D.DEPTNO;

-- SELECT(스칼라 서브쿼리) 절에 작성하는 서브쿼리는 단 하나의 결과만 반환해야 함, ()로 묶어야함
SELECT
	E.EMPNO ,
	E.JOB ,
	E.SAL ,
	(
	SELECT
		GRADE
	FROM
		SALGRADE s
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL) AS SALGRADE,
	E.DEPTNO,
	(
	SELECT
		DNAME
	FROM
		DEPT d
	WHERE
		E.DEPTNO = D.DEPTNO) AS DNAME
FROM
	EMP e ;
















































































































 


















































