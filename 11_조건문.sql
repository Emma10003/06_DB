-- IF EXISTS 해준 후 추후에 데이터베이스가 존재하지 않을 때 문제가 발생하지 않도록 설정
DROP DATABASE IF EXISTS tje;

CREATE DATABASE IF NOT EXISTS tje;
USE tje;

-- 직원 테이블
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    age INT,
    hire_date DATE,
    performance_score DECIMAL(3,1)
);

INSERT INTO employees VALUES
(1, '김철수', 'IT', 5500000, 28, '2020-03-15', 4.2),
(2, '이영희', 'HR', 4800000, 32, '2019-07-22', 3.8),
(3, '박민수', 'Sales', 6200000, 35, '2018-11-10', 4.5),
(4, '정수진', 'IT', 4200000, 25, '2021-01-08', 3.9),
(5, '홍길동', 'Finance', 5800000, 40, '2017-05-20', 4.1),
(6, '송미영', 'Sales', 3800000, 27, '2022-02-14', 3.5),
(7, '장동건', 'IT', 7200000, 45, '2015-09-03', 4.8),
(8, '김미나', 'HR', 5200000, 30, '2020-10-12', 4.0);

-- 제품 테이블
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price INT,
    stock_quantity INT,
    supplier VARCHAR(30)
);

INSERT INTO products VALUES
(1, '노트북', 'Electronics', 1200000, 15, 'TechCorp'),
(2, '마우스', 'Electronics', 25000, 50, 'TechCorp'),
(3, '키보드', 'Electronics', 80000, 30, 'InputDevice'),
(4, '의자', 'Furniture', 150000, 8, 'ComfortSeats'),
(5, '책상', 'Furniture', 300000, 5, 'OfficeFurniture'),
(6, '모니터', 'Electronics', 450000, 12, 'DisplayTech'),
(7, '램프', 'Furniture', 75000, 20, 'LightingSolutions');


-- IF 함수
-- 기본 문법
-- IF(조건, 참일 때 값, 거짓일 때 값);

-- EMPLOYEES 테이블에서 급여에 따른 등급 분류
--                          조건이 존재하고  , 조건이 참일 때,   조건이 거짓일 때  별칭 생략 가능
SELECT emp_name, salary, IF(salary >= 6000000, '고액연봉'    ,   '일반연봉'      )  AS 연봉상태
FROM employees;

-- employees 나이대별 분류
-- 이름, 나이, 30을 기준으로 30 이전이면 30이전, 아니면 30이후 AS 30대 기준 분류
SELECT emp_name, age, IF(age < 30, '30이전', '30이후') AS `30대 기준 분류`
FROM employees;

-- 중첩 IF문 사용
SELECT emp_name, age, IF(age < 30, '20대',
							IF(age < 40, '30대', '40대')
						) AS `30대 기준 분류`
FROM employees;


-- 다양한 IF문 사용
-- 성과급에 따른 결과를 계산하기
SELECT emp_name, salary, performance_score,
-- 						 월급 + 성과급에 따른 보너스, 4.5 이상 = 10%, 4.0 ~ 4.5 = 5%
		salary + IF(performance_score >= 4.5, salary * 0.1,
						IF(performance_score >= 4.0, salary * 0.05, 0)
					) AS `월급 + 성과급`
FROM employees;

-- products		product_name 		stock_quantity
-- 재고가 5개 이하이면 긴급 주문, 재고가 5개 이상 ~ 15개 이하면 주문 필요, 15 초과면 충분하다 AS 주문상태
SELECT product_name, stock_quantity, IF(stock_quantity <= 5, '긴급 주문',
												IF(stock_quantity <= 15, '주문 필요', '충분')
                                                ) AS `주문상태`
FROM products;

-- CASE WHEN 구문
-- 기본 문법
/*
-- 기본 문법
CASE 컬럼명
	WHEN 값1 THEN 결과1
	WHEN 값2 THEN 결과2
	WHEN 값3 THEN 결과3
    ELSE 기본값
END

-- 조건식 CASE(Searched CASE)
CASE 컬럼명
	WHEN 조건1 THEN 결과1
	WHEN 조건2 THEN 결과2
	WHEN 조건3 THEN 결과3
    ELSE 기본값
END
*/

-- 기본 CASE 실습
-- 부서별 한글명 변환해서 반환 후 조회
SELECT emp_name, department,
	CASE department -- 부서 컬럼에서
		WHEN 'IT' THEN '정보기술팀'
		WHEN 'HR' THEN '인사팀'
		WHEN 'Sales' THEN '영업팀'
		WHEN 'Finance' THEN '재무팀'
        ELSE '기타부서'  -- 생략 가능하나, WHEN - THEN 이외 작업에 default 처럼 사용 가능
	END AS `부서명칭 변경 후`
FROM employees;

-- 1. products 테이블에서 카테고리를 한국어로 변환해서 출력
-- Electronics -> 전자제품
-- Furniture -> 가구
-- SELECT category, 명칭 변경 후
SELECT product_name, category,
	CASE category
		WHEN 'Electronics' THEN '전자제품'
		WHEN 'Furniture' THEN '가구'
        ELSE '기타'
	END AS `명칭 변경 후`        
FROM products;

-- 2. products 테이블에서 공급업체별 등급 매기기
-- TechCorp		-> A급
-- DisplayTech	-> A급
-- InputDevice	-> B급
-- 나머지 C급
-- SELECT 제품명, 공급업체, 공급업체 등급
SELECT product_name, supplier,
	CASE supplier
		WHEN 'TechCorp' THEN 'A급'
		WHEN 'DisplayTech' THEN 'A급'
		WHEN 'InputDevice' THEN 'B급'
        ELSE 'C급'
	END AS `공급업체 등급`
FROM products;

-- 다중의 조건이 존재할 경우 BETWEEN AND나 OR과 같은 범위 형태를 사용할 수 있다.
SELECT product_name, supplier,
	CASE supplier
		WHEN 'TechCorp' AND 'DisplayTech' THEN 'A급'
		WHEN 'InputDevice' THEN 'B급'
        ELSE 'C급'
	END AS `공급업체 등급`
FROM products;

-- Searched case
-- 나이별로 세대 분류
SELECT emp_name, age,
	CASE
		WHEN age BETWEEN 20 AND 29 THEN 'MZ세대'
		WHEN age BETWEEN 30 AND 39 THEN '밀레니얼세대'
		WHEN age >= 40 THEN 'X세대'
        ELSE '기타'  -- 선택 사항으로 ELSE를 작성하지 않아도 문제되지 않음
	END AS `세대분류`
FROM employees;

-- Search case 이용해서
-- products 에서 제품 가격에 따른 등급
-- 가격이 10만원 미만은 저가형
-- 가격이 10만원 ~ 50만원 미만은 중가형
-- 가격이 50만원 초과는 고가형
-- 나머지는 분류 불가
-- AS 가격등급
-- SELECT product_name, price, 가격등급
SELECT product_name, price, 
	CASE
		WHEN price < 100000 THEN '저가형'
		WHEN price BETWEEN 100000 AND 500000 THEN '중가형'
		WHEN price > 500000 THEN '고가형'
		ELSE '분류 불가'
    END AS `가격등급`
FROM products;

-- 급여와 성과 종합평가로 등급 평가 진행
SELECT emp_name, salary, performance_score,
	CASE
		WHEN salary >= 6000000 AND performance_score >= 4.5 THEN '최우수'
		WHEN salary >= 5000000 AND performance_score >= 4.0 THEN '우수'
		WHEN salary >= 4000000 AND performance_score >= 3.5 THEN '보통'
        ELSE '개선 필요'
	END AS `종합평가`
FROM employees;

-- 일반 구문과 서치형 구문의 차이
/*
Simple Case 특징
- 정확한 값 매칭이 필요할 때 사용
- 문자열이나 고정값 비교에 적합

Searched Case 특징
- 복잡한 조건식이 필요할 때 사용
- 범위 검사, 복합 조건에 적합
- BETWEEN, AND, OR, >= 등 다양한 연산자를 사용하여 조건 설정
- ELSE 절은 선택사항이나, NULL 을 방지하기 위해 항상 포함하는 것이 좋음
- 조건의 순서 중요
- 데이터 타입은 일치시킬 것
- WHEN 으로 설정한 조건을 VIEW 형태의 테이블로 만들어주기도 함
*/



-- employees 테이블에서 나이, 급여, 성과점수를 종합해서 승진 후보자를 선정하세요.승진 기준:
-- 35세 이상이면서 급여 550만원 이상이고 성과 4.2 이상 → 임원 후보
-- 30세 이상이면서 급여 500만원 이상이고 성과 4.0 이상 → 팀장 후보
-- 25세 이상이면서 급여 450만원 이상이고 성과 3.8 이상 → 선임 후보
-- 성과 3.5 미만 → 교육 필요
-- 그 외 → 현재 유지
-- 출력: 직원명, 나이, 급여, 성과점수, 승진구분

SELECT emp_name, age, salary, performance_score
	CASE
		WHEN age >= 35 AND salary >= 5500000 AND performance_score >= 4.2 THEN '임원 후보'
		WHEN age >= 30 AND salary >= 5000000 AND performance_score >= 4.0 THEN '팀장 후보'
		WHEN age >= 25 AND salary >= 4500000 AND performance_score >= 3.8 THEN '선임 후보'
		WHEN performance_score < 3.5 THEN '교육 필요'
        ELSE '현재 유지'
	END AS `승진구분`
FROM employees;
















