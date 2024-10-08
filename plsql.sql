-- PL/SQL : 프로그래밍 SQL, 데이터베이스에 프로그램 언어에서 메소드같은 함수기능 지원 
-- 기본 형식
-- 블록
-- DECLARE 
-- 	    변수 선언(선택사항)
-- BEGIN
--		조건문 OR 반복문 OR SELECT문 OR DML OR 함수
-- EXCEPTION
--		오류처리
-- END;
-- PL/SQL에서는 BOOLEAN 타입 선언 가능

-- 실행결과를 화면에 출력
-- SET SERVEROUTPUT ON;

BEGIN 
	DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;


-- 변수
DECLARE 
	V_EMPNO NUMBER(4) := 7788
	V_ENAME VARCHAR(10);
BEGIN
	V_ENAME := 'SCOTT';
	DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;


-- 상수
DECLARE 
	V_TAX CONSTANT NUMBER(1) := 7
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);	
END;


-- DEFAULT 지정
DECLARE 
	V_TAX NUMBER(2) DEFAULT 10;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;

-- 변수에 NULL 값 저장 막기
DECLARE
--	V_TAX NUMBER(2) NOT NULL DEFAULT 10;
	V_TAX NUMBER(2) NOT NULL := 20;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;

-- 참조형(특정 테이블 열의 자료형, 행 하나의 자료구조 참조)
DECLARE
	V_DEPTNO DEPT.DEPTNO%TYPE := 20;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;

DECLARE
	V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
	SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
	FROM DEPT d WHERE DEPTNO = 40;
	DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
	DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
	DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;

-- 조건 제어문
-- IF THEN
-- IF THEN ELSE
-- IF THEN ELSIF ELSE

-- 변수의 값이 홀/짝수 구분
DECLARE
	V_NUMBER NUMBER := 15;
BEGIN
	IF MOD(V_NUMBER,2) = 1 THEN DBMS_OUTPUT.PUT_LINE('V_NUMBER : ' || V_NUMBER || '홀수');
	ELSE DBMS_OUTPUT.PUT_LINE('V_NUMBER : ' || V_NUMBER || '짝수');
	END IF;
END;

-- >=90 A, >=80 B, >=70 C, >=60 D
DECLARE
	V_NUMBER NUMBER := 77;
BEGIN
	IF V_NUMBER >= 90 THEN DBMS_OUTPUT.PUT_LINE('A');
	ELSIF V_NUMBER >= 80 THEN DBMS_OUTPUT.PUT_LINE('B');
	ELSIF V_NUMBER >= 70 THEN DBMS_OUTPUT.PUT_LINE('C');
	ELSIF V_NUMBER >= 60 THEN DBMS_OUTPUT.PUT_LINE('D');
	ELSE
	DBMS_OUTPUT.PUT_LINE('F');
	END IF;
END;


DECLARE
	V_NUMBER NUMBER := 77;
BEGIN
	CASE TRUNC(V_NUMBER/10)
		WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A');
		WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A');
		WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B');
 		WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C');
		WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D');	
		ELSE DBMS_OUTPUT.PUT_LINE('F');
		END CASE;
END;

-- 반복문
-- LOOP ~ END LOOP
-- WHILE ~ LOOP ~ END LOOP
-- FOR IN LOOP ~ END LOOP
-- 종료 선언
-- EXIT 
-- EXIT WHEN
-- CONTINUE
-- CONTINUE WHEN

-- LOOP
DECLARE
	V_NUMBER NUMBER := 0;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE('V_NUMBER : ' || V_NUMBER);
		V_NUMBER := V_NUMBER + 1;
		EXIT WHEN V_NUMBER > 4;
	END LOOP;
END;

-- WHILE
DECLARE
	V_NUMBER NUMBER := 0;
BEGIN
	WHILE V_NUMBER < 4 LOOP
		DBMS_OUTPUT.PUT_LINE('V_NUMBER : ' || V_NUMBER);
		V_NUMBER := V_NUMBER + 1;
	END LOOP;
END;

-- FOR
BEGIN
	FOR I IN 0..4 LOOP
		DBMS_OUTPUT.PUT_LINE('I : ' || I);
	END LOOP;
END;

BEGIN
	FOR I IN REVERSE 0..4 LOOP
		DBMS_OUTPUT.PUT_LINE('I : ' || I);
	END LOOP;
END;

-- 숫자 1~10 숫자 중에서 홀수만 출력

BEGIN
	FOR I IN 1..10 LOOP
		IF MOD(I,2) = 1 THEN
		DBMS_OUTPUT.PUT_LINE('I : ' || I);
	END IF;
	END LOOP;
END;

-- 커서(CURSOR) : SELECT문 또는 DML 과 같은 SQL 구문 실행했을 때 해당 SQL을 처리하는 
-- 정보를 저장한 메모리 공간








































