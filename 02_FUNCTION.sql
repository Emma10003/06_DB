/*
함수 : 컬럼값 | 지정된 값을 읽어 연산한 결과를 반환하는 것
단일행 함수 : N개의 행의 컬럼 값을 전달하여 N개의 결과가 반환
그룹 함수   : N개의 행의 컬럼 값을 전달하여 1개의 결과가 반환
              (그룹의 수가 늘어나면 그룹의 수 만큼 결과를 반환)

함수는 SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절에서 사용 가능.
*/

-- 단일행 함수
-- 문자열 관련 함수

-- LENGTH(문자열|컬럼명) : 문자열의 길이 반환
SELECT 'HELLO WORLD', LENGTH('HELLO WORLD');

-- employees 테이블에서 이메일 길이가 12 이하인 사원 조회
-- 이메일 길이는 오름차순 정렬
SELECT full_name, email, LENGTH(email) AS '이메일의 총 길이'
FROM employees
WHERE LENGTH(email) > 12
ORDER BY LENGTH(email);

SELECT * 
FROM employees;


-- LOCATE(찾을문자열, 문자열 [, 시작위치])
-- Oracle 에서는 INSTR() 함수
-- 찾을 문자열의 위치를 반환 (1부터 시작, 못 찾으면 0 출력)

-- B의 위치 검색 (5번째 위치부터 시작해서 검색)
SELECT 'AABAACAABBAA', LOCATE('B', 'AABAACAABBAA', 5);

-- B의 위치 검색 (1부터 시작해서 B가 존재하는 위치를 조회할 수 있다)
SELECT 'AABAACAABBAA', LOCATE('B', 'AABAACAABBAA');

-- '@' 문자의 위치 찾기
-- employee의 email 에서 @ 위치 찾아서 조회
SELECT email, LOCATE('@', email)
FROM employees;

-- SUBSTRING(문자열, 시작위치 [, 길이])
-- Oracle 에서는 SUBSTR() 함수
-- 문자열을 시작 위치부터 지정된 길이만큼 잘라내서 반환

-- 시작위치, 자를 길이 지정
SELECT SUBSTRING('ABCDEFG', 2, 3);

-- 시작위치, 자를 길이 미지정
SELECT SUBSTRING('ABCDEFG', 4);

-- employees 테이블에서
-- 사원명(emp_name), 이메일에서 아이디(@ 앞까지의 문자열)을
-- 이메일 아이디라는 별칭으로 오름차순 조회
select * from employees;

SELECT full_name AS `사원명(emp_name)`, 
SUBSTRING(email, 1, LOCATE('@', email)-1) AS `이메일 아이디`,
SUBSTRING(email, LOCATE('@', email)) AS `이메일 도메인`
FROM employees
ORDER BY `이메일 아이디`;
-- SUBSTRING(email, LOCATE('@', email)) -> 자르기 시작할 위치를 @로 설정 ... 이메일의 도메인만 확인 가능한 상태

SELECT * FROM departments;

-- REPLACE(문자열, 찾을문자열, 바꿀문자열)
-- departments 테이블에서 부 -> 팀으로 변경
SELECT dept_name AS "기존 부서 명칭", 
	   REPLACE(dept_name, '부', '팀') AS "변경된 부서 명칭"
FROM departments;

-- 숫자 관련 함수

-- MOD(숫자 | 컬럼명, 나눌 값) : 나머지
SELECT MOD(105, 100);

-- ABS(숫자 | 컬럼명) : 절댓값
SELECT ABS(10), ABS(-10);

-- CEIL(숫자 | 컬럼명) : 소수점 올림
-- FLOOR(숫자 | 컬럼명) : 소수점 내림
SELECT CEIL(1.1), FLOOR(1.1);

-- ROUND(숫자 | 컬럼명 [, 소수점위치]) : 소수점 반올림
-- 소수점 위치 지정 X : 소수점 첫째 자리에서 반올림해서 정수 표현
-- 소수점 위치 지정 O
-- 1) 양수 : 지정된 위치의 소수점 자리까지 표현
-- 2) 음수 : 지정된 위치의 정수 자리까지 표현
SELECT 123.456,
		ROUND(123.456),		-- 123
		ROUND(123.456, 1),	-- 123.5
		ROUND(123.456, 2),	-- 123.46
		ROUND(123.456, -1),	-- 120
		ROUND(123.456, -2);	-- 100


/******************
N 개의 행의 컬럼 값을 전달하여 1개의 결과가 반환
그룹의 수가 늘어나면 그룹의 수 만큼 결과를 반환

SUM(숫자가 기록된 컬럼명) : 그룹의 합계를 반환

AVG(숫자만 기록된 컬럼명) : 그룹의 평균을 반환

MAX(컬럼명)  : 최대값
MIN(컬럼명)  : 최소값

COUNT(* | [DISTINCT] 컬럼명) : 조회된 행의 개수를 반환
COUNT(*)                  : 조회된 모든 행의 개수를 반환
COUNT(컬럼명)             : 지정된 컬럼 값이 NULL 이 아닌 행의 개수를 반환
COUNT([DISTINCT] 컬럼명)  : 지정된 컬럼에서 중복값을 제외한 행의 개수 반환
                            (NULL 인 행 미포함)
******************/













