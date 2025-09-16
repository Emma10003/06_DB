USE employee_management;

/*
SELECT (조회)
지정된 테이블에서 원하는 데이터를 선택해서 조회하는 SQL

작성법 -1
SELECT 컬럼명, 컬럼명, ...
FROM   테이블명;

작성법 -2 : 테이블 내 모든 컬럼을 선택해서 모든 행, 컬럼 조회
SELECT *
FROM   테이블명;
*/

-- EMPLOYEE 테이블에서 사번, 이름, 이메일 조회
SELECT emp_id, full_name, email 
FROM employees;

SELECT emp_id, full_name, email FROM employees;

/*
SQL 의 경우 예약어 기준으로 세로로 작성하는 경우가 많으며,
세로로 작성하다 작성을 마무리하는 마침표는 반드시 세미콜론(;)으로 작성.
*/

-- employee 테이블에서 이름(full_name), 입사일(hire_date) 만 조회
SELECT full_name, hire_date
FROM employees;

SELECT *
FROM employees;

/* 문제 */
-- departments 테이블의 모든 데이터 조회
SELECT * FROM departments;

-- departments 테이블에서 부서코드(dept_code), 부서명(dept_name) 조회
SELECT dept_code, dept_name
FROM departments;

-- employees 테이블에서 사번, 이름, 급여 (emp_id, full_name, salary) 조회
SELECT emp_id, full_name, salary
FROM employees;

-- training_programs 테이블에서 모든 데이터 조회
SELECT *
FROM training_programs;

-- training_programs 테이블에서 프로그램명, 교육시간(program_name, duration_hours) 조회
SELECT program_name, duration_hours
FROM training_programs;


/********************
컬럼 값 산술 연산자

-- 컬럼 값 : 행과 열이 교차되는, 테이블의 한 칸에 작성된 값.

SELECT 문 작성 시 컬럼명에 산술 연산을 직접 작성하면
조회 결과(RESULT SET)에 연산 결과가 반영되어 조회된다!
********************/

-- 1. Employee 테이블에서 모든 사원의 이름, 급여, 급여+500만원을 했을 때의 인상 결과 조회
SELECT full_name, salary, salary + 5000000
FROM employees;

-- 2. Employee 테이블에서 모든 사원의 사번, 이름, 연봉(급여 * 12) 을 조회
SELECT emp_id, full_name, salary * 12
FROM employees;

-- 3. Training_programs 테이블에서 프로그램명, 교육시간, 하루당 8시간 기준 교육일수 조회
SELECT program_name, duration_hours, duration_hours/8
FROM training_programs;

/* 문제 */
-- Employee 테이블에서 이름, 급여, 급여 * 0.8 조회 (세후급여)
SELECT full_name, salary, salary * 0.8
FROM employees;

-- Positions 테이블 전체 조회
SELECT * 
FROM positions;

-- Positions 테이블에서 직급명, 최소급여, 최대급여, 급여 차이(최대급여 - 최소급여) 조회
SELECT position_name, min_salary, max_salary, (max_salary - min_salary)
FROM positions;

-- Departments 테이블에서 부서명, 예산, 예산 * 1.1 (= 예산 + 10%) 의 총액 조회
SELECT dept_name, budget, budget * 1.1
FROM departments;

-- 모든 SQL 에서는 DUAL 가상 테이블이 존재함. MySQL 에서는 FROM 을 생략할 경우 자동으로 DUAL 가상테이블 사용.
-- (가상 테이블 필요없음)
-- 현재 날짜 확인하기
SELECT NOW(), current_timestamp;

SELECT NOW(), current_timestamp
FROM dual;

CREATE DATABASE IF NOT EXISTS 네이버;
CREATE DATABASE IF NOT EXISTS 라인;
CREATE DATABASE IF NOT EXISTS 스노우;

USE 네이버;
USE 라인;
USE 스노우;


-- 날짜 데이터 연산하기 ( +, - 만 가능)
-- > +1 == 1일 증가
-- > -1 == 1일 감소
SELECT NOW() + interval 1 DAY, NOW() - interval 1 DAY;

-- 날짜 연산 (시간, 분, 초 단위)
SELECT NOW(),
		NOW() + INTERVAL 1 HOUR,
		NOW() + INTERVAL 1 MINUTE,
		NOW() + INTERVAL 1 SECOND;

-- 어제, 현재 시간, 내일, 모레 조회


SELECT '2025-09-15', STR_TO_DATE('2025-09-15', '%Y-%m-%d');
SELECT DATEDIFF('2025-09-15', '2025-09-14');

-- CURDATE() : 시간 정보를 제외한 연/월/일만 조회 가능한 함수
-- 근무일 수 조회                     현재 날짜	 입사한 날짜
SELECT full_name, hire_date, DATEDIFF(CURDATE(), hire_date)
FROM employees;

-- 컬럼명 별칭 지정하기
/*************************
컬럼명 별칭 지정하기 (Alias)
1) 컬럼명 AS 별칭   : 문자 OK, 띄어쓰기 X, 특수문자 X
2) 컬럼명 AS `별칭` : 문자 OK, 띄어쓰기 OK, 특수문자 OK
3) 컬럼명 별칭      : 문자 OK, 띄어쓰기 X, 특수문자 X
4) 컬럼명 `별칭`    : 문자 OK, 띄어쓰기 OK, 특수문자 OK

`` 이나 "" 나 '' 모두 사용 가능
대소문자 구분
*************************/

-- 별칭 이용해서 근무일수로 컬럼명 설정 후 조회하기
SELECT full_name, hire_date, DATEDIFF(CURDATE(), hire_date) AS `근무일수`
FROM employees;

/* 문제 */
-- 1. employees 테이블에서 사번, 이름, 이메일로 해당 컬럼 데이터 조회 (AS `` 사용하지 않고 조회)
SELECT emp_code 사번, full_name 이름, email 이메일
FROM employees;

-- 2. employees. 테이블에서 이름, 급여, 연봉(급여*12) 로 해당컬럼 데이터 조회 (AS `` 사용하고 조회)
SELECT full_name AS `이름`, salary AS `급여`, ceil(salary * 12) AS `연봉(급여*12)`
FROM employees;

-- 3. positions 테이블에서 직급명, 최소급여, 최대급여, 급여차이 명칭으로
-- 해당 컬럼 데이터 조회 (별칭에서 as "" 사용하고 조회)
SELECT position_name AS "직급명", ceil(min_salary) AS "최소급여", ceil(max_salary) AS "최대급여", ceil(max_salary - min_salary) AS "급여차이"
FROM positions;

-- training_programs 테이블에서 프로그램명, 교육시간, 교육일수(8시간) 기준 조회
-- 교육일수를 반올림 처리하여 정수로 조회
SELECT program_name AS `교육프로그램`, duration_hours AS 총교육시간, round(duration_hours / 8) AS "교육일수"
FROM training_programs;


/****************************
DISTINCT (별개의, 전혀 다른)
--> 중복 제거
-- 조회 결과 집합(RESULT SET)에서 
   지정된 컬럼의 값이 중복되는 경우
   이를 한 번만 표시할 때 사용
****************************/
-- STEP 01. employees 테이블에서 모든 사원의 부서코드 조회
SELECT dept_id
FROM employees;

-- STEP 02. employees 테이블에서 사원이 존재하는 부서코드만 조회
SELECT *
FROM departments;

-- 조회한 결과가 존재하지 않는다. -> 조회결과 : 0
-- 에러가 아님!!
SELECT DISTINCT manager_id
FROM employees;

-- employees 테이블에서 사원이 있는 부서 ID만 중복을 제거한 후 조회
SELECT DISTINCT dept_id
FROM employees;


# error code 1046 : 어떤 DB를 사용할 것인지 지정해주지 않아서 발생하는 문제 - USE 사용해서 지정해주기!
-- employees 테이블에서 존재하는 position_id 코드의 종류를 중복 없이 조회
SELECT DISTINCT position_id
FROM employees;



/****************************
		   WHERE 절
테이블에서 조건을 충족하는 행을 조회할 때 사용.
WHERE 절에는 조건식(true/false)만 작성.

비교연산자 : >, <, >=, <=, =(같다), !=(같지 않다)
논리연산자 : AND, OR, NOT

SELECT 컬럼명, 컬럼명, ...
FROM   테이블명
WHERE  조건식;
****************************/
-- employees 테이블에서 급여가 300만원 초과하는 사원의 사번, 이름, 급여, 부서코드 조회
/*3*/ SELECT emp_id, full_name, ceil(salary), dept_id
/*1*/ FROM employees
/*2*/ WHERE salary > 3000000;
/* FROM 절에 지정된 테이블에서  --> 1번
** WHERE 절로 행을 먼저 추려내고, 추려진 결과 행들 중에서  --> 2번
** SELECT 절로 원하는 컬럼만 조회.  --> 3번
*/

/* 문제 */
-- employees 테이블에서 연봉이 5천만원 이하인 사원의 사번, 이름, 연봉 조회
SELECT emp_id AS `사번`, full_name AS `이름`, salary*12 AS `연봉`
FROM employees
WHERE (salary*12) >= 50000000;

-- employees 테이블에서 부서코드가 2번이 아닌 사원의 이름, 부서코드, 전화번호 조회
SELECT full_name AS `이름`, dept_id AS `부서코드`, phone AS `전화번호`
FROM employees
WHERE dept_id != 2;

/* 연결 연산자 CONCAT() */
SELECT CONCAT(emp_id, full_name) AS 사번이름연결
FROM employees;


/**************************
          LIKE 절
**************************/
USE employee_management;

-- employees 테이블에서 성이 '김' 씨인 사원의 사번, 이름 조회
SELECT emp_id, full_name
FROM employees
WHERE first_name LIKE '김%';

-- employees 테이블에서 full_name 이름에 '장'이 포함된 사원의 사번, 이름 조회
SELECT emp_id, full_name
FROM employees
WHERE full_name LIKE '%장%';

SELECT *
FROM employees;

-- employees 테이블에서 전화번호가 02 로 시작하는 사원의 이름, 전화번호 조회
SELECT full_name, phone
FROM employees
WHERE phone LIKE '02%';

-- employees 테이블에서 email 의 아이디가 @ 기준 3글자인 사원의 이름, 이메일 조회
SELECT full_name, email
FROM employees
WHERE email LIKE '___@%'; -- 뒤에 '%' 도 붙여줘야 함!!!

-- employees 테이블에서 사원코드가 EMP 로 시작하고 EMP 포함해서 총 6자리인 사원 조회
SELECT emp_code, full_name, email
FROM employees
WHERE emp_code LIKE 'EMP___';


/********************
       WHERE절
 AND OR BETWEEN IN()
********************/
-- employees 테이블에서
-- 급여가 4000만 이상, 7000만 이하인 사원의 사번, 이름, 급여 조회
-- emp_id, full_name, salary
-- AND, BETWEEN 구문 이용한 두 가지 SQL문 작성하기
SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 AND 70000000;

SELECT emp_id, full_name, salary
FROM employees
WHERE salary >= 40000000 AND salary <= 70000000;


-- employees 테이블에서
-- 급여가 4000만 미만 또는 8000만 초과인 사원의 사번, 이름, 급여 조회
-- emp_id, full_name, salary
-- OR, NOT BETWEEN 구문 이용한 두 가지 SQL문 작성하기
SELECT emp_id, full_name, salary
FROM employees
WHERE salary NOT BETWEEN 40000000 AND 80000000;

SELECT emp_id, full_name, salary
FROM employees
WHERE salary < 40000000 OR salary > 80000000;


-- employees 테이블에서
-- 입사일이 2020-01-01 부터 2020-12-31 사이인 사원의 이름, 입사일 조회
-- BETWEEN 구문 이용
-- full_name, hire_date
SELECT full_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2020-01-01' AND '2020-12-31';


-- employees 테이블에서
-- 생년월일(date_of_birth)이 1980년대인 사원 조회
-- BETWEEN 구문 이용
-- emp_id, full_name, date_of_birth
-- emp_id, full_name, date_of_birth
SELECT emp_id, full_name, date_of_birth
FROM employees
WHERE date_of_birth BETWEEN '1980-01-01' AND '1989-12-31';



-- employees 테이블에서 부서ID가 4인 사원 중
-- 급여가 4000만 이상, 7000만 이하인 사원의 사번, 이름, 급여 조회
-- emp_id, full_name, salary
-- AND, BETWEEN 구문 이용한 두 가지 SQL문 작성하기
SELECT emp_id, full_name, salary, dept_id
FROM employees
WHERE dept_id = 4 AND salary >= 40000000 AND salary <= 70000000;

SELECT emp_id, full_name, salary, dept_id
FROM employees
WHERE dept_id = 4
AND salary BETWEEN 40000000 AND 70000000;


-- employees 테이블에서
-- 부서코드가 2, 4, 5인 사원의
-- 이름, 부서코드, 급여 조회
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id = 2
OR dept_id = 4
OR dept_id = 5;

-- 컬럼의 값이 () 내 값과 일치하면 true
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id IN(2, 4, 5);

-- employees 테이블에서
-- 부서코드가 2, 4, 5인 사원을 제외하고
-- 이름, 부서코드, 급여 조회
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id NOT IN(2, 4, 5);
-- -> dept_id 가 NULL 인 사람들 또한 제외된 후 조회.

-- NULL 값을 가지면서, 부서코드가 2, 4, 5 를 제외한
-- 모든 사원들을 결과에 추가하는 구문
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id NOT IN(2, 4, 5)
OR dept_id IS NULL;

SELECT *
FROM employees;


-- ORDER BY 절 / WHERE 응용 / IN() 절 / JOIN 문

/************************
ORDER BY 절
- SELECT 문의 조회 결과(RESULT SET)를 정렬할 때 사용하는 구문.

SELECT 구문에서 가장 마지막에 해석됨.
[작성법]
SELECT 컬럼명 AS 별칭, 컬럼명, 컬럼명, ...
FROM 테이블명
WHERE 조건식
ORDER BY 컬럼명 | 별칭 | 컬럼 순서[오름/내림차순]
	* 컬럼이 오름차순인지 내림차순인지 작성되지 않았을 때는 기본으로 오름차순 정렬
    * ASC  : 오름차순 (=ASCENDING)
    * DESC : 내림차순 (=DESCENDING)
************************/

-- employees 테이블에서 모든 사원의 이름, 급여 조회
-- 단, 급여 오름차순으로 정렬
SELECT full_name, salary
FROM employees
ORDER BY salary;  -- ASC 기본값

SELECT full_name, salary
FROM employees
ORDER BY salary ASC;

SELECT full_name, salary
FROM employees
ORDER BY salary DESC;

-- employees 테이블에서
-- 급여가 4천만원 이상, 1억 이하인 사람의
-- 사번, 이름, 급여를 이름 내림차순으로 조회
SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 AND 100000000
ORDER BY full_name DESC;







