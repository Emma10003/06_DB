/**************************
  	        JOIN

INNER JOIN : 두 테이블에서 조건을 만족하는 행만 반환
     -> 모든 고객과 그들의 최근 주문번호
     -> 주문이 있는 상품만 주문과 주문상품 조회
     -> 로그인한 사용자의 권한 정보
     -> 결제 완료된 주문 내역
     
LEFT  JOIN : 왼쪽 테이블의 모든 행을 반환하고, 오른쪽 테이블에서 일치하는 행이 있으면 함께 반환
	 -> 모든 상품과 리뷰 개수 (리뷰가 없어도 상품은 표시)
     -> 모든 고객과 그들의 최근 주문 번호 (주문이 없어도 모든 고객은 표시)
     -> 직원과 교육 이수 현황 (교육 안 받은 직원도 포함해서 표시)
     
RIGHT JOIN : 오른쪽 테이블의 모든 행을 반환
     -> LEFT JOIN 으로도 충분히 사용 가능하기 때문에 실무에서는 거의 사용하지 않음
     
FULL OUTER JOIN : MySQL 에서는 지원하지 않지만, UNION 예약어를 통해 구현 가능
          - UNION     : 중복 제거한 후 조회  ->  중복을 제거한 후 조회하기 때문에 상대적으로 느림
          - UNION ALL : 중복 포함한 후 조회  ->  중복을 포함한 모든 행을 반환하기 때문에 빠름
	 -> 두 테이블의 모든 데이터를 다 보고싶을 때 사용하지만, 거의 사용하지 않음.
     
SELF  JOIN : 같은 테이블을 자기 자신과 JOIN
     -> 계층 구조나 같은 테이블 내 관계를 조회할 때 사용
     -> 게시글 - 답글 관계
     -> 추천인 - 피추천인 관계

CROSS JOIN : 두 테이블의 모든 행을 조합
     -> 모든 조합을 만들어야 할 때 사용
     -> 월별 실적 테이블 초기화
     -> 모든 사용자에게 기본 권한 부여

JOIN 은 테이블 간의 기준 컬럼을 통해 하나의 결과를 조회할 때 사용
JOIN 을 이용해서 VIEW 테이블을 생성한 후 VIEW 테이블에서 데이터를 읽어오는 것이 효율적임!!!
**************************/

-/*
USE employee_management;

다른 데이터베이스에서 잠시 조회하고자 하는 테이블을 조회할 때는
SELECT * FROM 다른데이터베이스명.테이블명;
-> SELECT * FROM employee_management.employees;
*/
USE employee_management;
SELECT * FROM employees;
SELECT * FROM departments;
-- 부서가 있는 직원만 조회
-- JOIN 방식
SELECT employees.dept_id, employees.full_name, departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.dept_id;

SELECT E.dept_id, E.full_name, D.dept_name
FROM employees E
INNER JOIN departments D ON E.dept_id = D.dept_id;

-- WHERE 방식
SELECT E.dept_id, E.full_name, D.dept_name
FROM employees E, departments D
WHERE E.dept_id = D.dept_id;





















