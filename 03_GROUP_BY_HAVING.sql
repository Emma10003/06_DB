/*
SELECT 문 해석 순서

5: SELECT 컬럼명 AS 별칭, 계산식, 함수식
1: FROM   참조할 테이블명
2: WHERE  컬럼명 | 함수식 비교연산자 비교값
3: GROUP BY 그룹을 묶을 컬럼명
4: HAVING 그룹함수식 비교연산자 비교값
6: ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식[NULLS FIRST (ASC) | LAST (DSEC)];

FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
* GROUP BY 에서는 SELECT 에서 지정한 별칭을 사용할 수 있다.
* SELECT 외에는 작은따옴표('') 대신 역따옴표(``) 사용할 것!!
*/

-- employees 테이블에서 사원 수 조회
SELECT dept_id, COUNT(*)
FROM employees
GROUP BY dept_id;

-- employees 테이블에서 부서별로 보너스를 주고싶음
-- 보너스를 주는 조건 : 연봉이 6천만원 이상인 사원만 보너스 제공
-- 보너스를 받는 사원 수를 부서별로 조회
SELECT dept_id, COUNT(*)
FROM employees
WHERE salary >= 60000000
GROUP BY dept_id;

-- employees 테이블에서
-- 부서 ID, 부서별 급여의 합계 AS 급여 합계
-- 부서별 급여의 평균(정수 - 내림처리) AS 급여 평균
-- 인원 수 조회 AS 인원 수
-- 부서 ID 순으로 오름차순 정렬
SELECT dept_id, SUM(salary) AS `급여 합계`, FLOOR(AVG(salary)) AS `급여 평균`, COUNT(emp_id) AS `인원 수`
FROM employees
GROUP BY dept_id
ORDER BY dept_id;

-- 부서 ID 가 4, 5인 부서의 평균 급여 조회 WHERE IN()
-- SELECT dept_id, floor(AVG(salary))
SELECT dept_id, 
		FLOOR(AVG(salary)) AS `급여 평균`
FROM employees
WHERE dept_id IN(4, 5)
GROUP BY dept_id;

-- employees 테이블에서 직급 별 2020년도 이후 입사자들의 급여 합 조회
-- position_id, year(hire_date), salary
-- SELECT FROM WHERE GROUP BY;
SELECT position_id, SUM(salary) AS `2020년 이후 입사자 급여 합`
FROM employees
WHERE year(hire_date) >= 2020
GROUP BY position_id;

/*
GROUP BY 사용 시 주의사항
SELECT 문에 GROUP BY 절을 사용할 경우
SELECT 절에 명시한 조회하려는 컬럼 중
그룹함수가 적용되지 않은 컬럼은
모두 다 GROUP BY 절에 작성해야 함!!!!
*/

-- employees 테이블에서 부서 별로 같은 직급인 사원의 급여 합계를 조회하고
-- 부서ID 오름차순으로 정렬
SELECT position_id, SUM(salary) AS `급여 합`
FROM employees
GROUP BY position_id
ORDER BY dept_id;


/*
0	73	16:30:41	SELECT position_id, SUM(salary) AS `급여 합`
 FROM employees
 GROUP BY position_id
 ORDER BY dept_id
 LIMIT 0, 1000	Error Code: 1055. Expression #1 of ORDER BY clause is not in GROUP BY 
 clause and contains nonaggregated column 
 'employee_management.employees.dept_id' 
 which is not functionally dependent on columns in GROUP BY clause; 
 this is incompatible with sql_mode=only_full_group_by	0.000 sec
*/

select * from employees;

-- 1. employees 테이블에서 부서 별로 직급이 같은 직원의 수를 조회하고
-- 부서ID, 직급 ID 오름차순으로 정렬
SELECT dept_id, position_id, COUNT(*)
FROM employees
GROUP BY dept_id, position_id
ORDER BY dept_id, position_id;
/*
GROUP BY dept_id, position_id
dept_id 와 position_id 의 조합을 기준으로 데이터를 묶는다.
예)
	부서 10, 직위 1
    부서 10, 직위 2
    부서 20, 직위 1
    등등..
    각 조합마다 COUNT(*) 로 몇 명의 직원이 존재하는지 계산하겠다.
ORDER BY dept_id, position_id
	계산한 결과를
    부서ID -> 직위 ID 순서로 오름차순 정렬
    부서로 정렬된 뒤, 그 안에서 직위별로 정렬
*/
-- 2. 부서별 평균 급여를 조회하고
-- 부서를 조회하여 부서ID 오름차순으로 정렬
SELECT dept_id, AVG(salary) AS `평균 급여`
FROM employees
GROUP BY dept_id
ORDER BY dept_id;