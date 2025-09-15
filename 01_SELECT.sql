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





























