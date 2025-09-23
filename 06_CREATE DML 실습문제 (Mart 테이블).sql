-- 자료형 날짜 : YEAR() 연도  TIME - HH:MM:SS 형태로 저장 (시:분:초)
USE delivery_app;

-- 1. MART 테이블 생성 문제
-- 다음 조건에 맞는 MART 테이블을 생성하세요.
-- - mart_id: 자동증가 기본키
-- - mart_name: 마트명 (100자, NULL 불가)
-- - location: 위치 (255자, NULL 불가)
-- - phone: 전화번호 (20자)
-- - open_time: 개점시간 (TIME 타입)
-- - close_time: 폐점시간 (TIME 타입)
-- - is_24hour: 24시간 운영여부 (BOOLEAN, 기본값 FALSE)
-- - created_at: 등록일시 (TIMESTAMP, 기본값 현재시간)
-- - updated_at: 수정일시 (TIMESTAMP, 기본값 현재시간, 수정시 자동 업데이트)
-- - updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
-- create table 을 실행할 때 2가지 방법
-- 1. 모든 테이블 삭제 후 다시 생성
--    테이블이 존재할 경우에만 삭제
DROP TABLE IF EXISTS mart;
-- 2. 테이블 존재 유무 확인 후 생성
-- 	  테이블이 존재하지 않을 경우에만 생성
CREATE TABLE IF NOT EXISTS mart (
	mart_id INT AUTO_INCREMENT PRIMARY KEY,
    mart_name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    phone VARCHAR(20),  -- INT 는 010 으로 작성할 경우 맨 앞에 있는 0 자동 삭제
    open_time TIME,
    close_time TIME,
    is_24hour BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- 2. INSERT 문제
-- 다음 마트 정보를 INSERT하세요.

-- 문제 2-1: 모든 컬럼값을 지정하여 삽입
-- 이마트 강남점, 서울시 강남구 테헤란로 123, 02-123-4567, 08:00, 24:00, 24시간 운영 아님
-- (TIMESTAMP 컬럼은 DEFAULT 사용)
INSERT INTO mart
VALUES (NULL, '이마트 강남점', '서울시 강남구 테헤란로 123', '02-123-4567', '08:00', '24:00', FALSE, DEFAULT, DEFAULT);


-- 문제 2-2: 컬럼명을 명시하여 삽입 (24시간 운영 정보와 TIMESTAMP 없이)
-- 롯데마트 잠실점, 서울시 송파구 올림픽로 456, 02-456-7890, 09:00, 23:00
INSERT INTO mart (mart_name, location, phone, open_time, close_time)
VALUES ('롯데마트 잠실점', '서울시 송파구 올림픽로 456', '02-456-7890', '09:00', '23:00');


-- 문제 2-3: DEFAULT 값 활용하여 삽입
-- CU 편의점 역삼점, 서울시 강남구 역삼로 789, 02-789-0123, 24시간 운영
INSERT INTO mart
VALUES (DEFAULT, 'CU 편의점 역삼점', '서울시 강남구 역삼로 789', '02-789-0123', NULL, NULL, TRUE, DEFAULT, DEFAULT);
-- AUTO_INCREMENT 는 DEFAULT 를 작성하지 않아도 자동으로 번호순번매김이 DEFAULT 로 설정되어 있음.


-- 삽입된 데이터 확인
SELECT * FROM mart;

-- 3. UPDATE 문제
-- 문제 3-1: 이마트 강남점의 전화번호를 '02-111-1111'로 변경하세요.
UPDATE mart
SET phone = '02-111-1111'
WHERE mart_name = '이마트 강남점';


-- 문제 3-2: 24시간 운영이 아닌 마트들의 폐점시간을 22:00으로 일괄 변경하세요.
UPDATE mart
SET close_time = '22:00' -- '22:00:00'
WHERE is_24hour = 0;
SELECT * FROM mart WHERE is_24hour = 0;


-- 문제 3-3: CU 편의점 역삼점의 개점시간과 폐점시간을 각각 00:00, 23:59로 변경하세요.
SELECT * FROM mart WHERE mart_name = 'CU 편의점 역삼점';
UPDATE mart
SET open_time = '00:00',
	close_time = '23:59'
WHERE mart_name = 'CU 편의점 역삼점';


-- 업데이트 결과 확인 (created_at과 updated_at 시간 차이 확인)
SELECT mart_name, created_at, updated_at FROM mart;

-- 4. DELETE 문제
INSERT INTO mart (mart_name, location, phone, open_time, close_time, is_24hour)
VALUES
('세븐일레븐 논현점', '서울시 강남구 논현로 111', '02-111-2222', NULL, NULL, TRUE),
('GS25 삼성점', '서울시 강남구 삼성로 222', NULL, '06:00:00', '24:00:00', FALSE);

-- 삽입 확인
SELECT * FROM mart;

-- 문제 4-1: 전화번호가 NULL인 마트를 삭제하세요.
SELECT * FROM mart WHERE phone IS NULL;
DELETE FROM mart
WHERE phone IS NULL;


-- 문제 4-2: 24시간 운영이 아니고 폐점시간이 22:00인 마트를 삭제하세요.
SELECT * FROM mart WHERE is_24hour = FALSE AND close_time = '22:00';
DELETE FROM mart
WHERE is_24hour = FALSE AND close_time = '22:00';


-- 문제 4-3: 마트명에 '편의점'이 포함된 마트를 삭제하세요.
SELECT * FROM mart WHERE mart_name LIKE '%편의점%';
DELETE FROM mart
WHERE mart_name LIKE '%편의점%';

-- 삭제 결과 확인
SELECT * FROM mart;


-- 최종 확인
SELECT * FROM mart;
DESCRIBE mart;


INSERT INTO mart (mart_name, location, phone, open_time, close_time, is_24hour)
VALUES
('홈플러스 강남점', '서울시 강남구 도곡로 300', '02-300-4000', '10:00:00', '23:00:00', FALSE),
('코스트코 양재점', '서울시 서초구 양재대로 400', '02-400-5000', '10:00:00', '22:00:00', FALSE),
('하나로마트 서초점', '서울시 서초구 서초대로 500', '02-500-6000', '08:00:00', '21:00:00', FALSE);

-- 현재 시간과     10분이라는 시간 간격 단위
-- DATE_SUB() : 날짜에서 지정한 간격을 빼는 함수
-- 현재시간에서 10분을 뺀 시간이 등록시간보다 큰지 작은지 비교
-- DATE_SUB(NOW(), INTERVAL 10 MINUTE);
-- 를 이용해서 등록된 지 10분 이내의 마트만 조회하기
SELECT *
FROM mart
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 10 MINUTE);

-- 전화번호, 핸드폰번호, 주민등록번호의 경우에는 VARCHAR 사용
-- ex) 010- 형태와, 00년생부터 시작하는 사람들을 위해 VARCHAT 사용 (INT 는 0으로 시작하는 숫자의 첫 0을 생략하기 때문)




-- ========================================
-- MySQL DML 문제
-- ========================================
-- ========================================
-- 1. CREATE TABLE 문제
-- ========================================
-- 문제 1-1: 다음 조건에 맞는 employees 테이블을 생성하세요.
/*
조건:
- emp_id: 자동증가 기본키
- emp_name: 직원명 (50자, NULL 불가)
- department: 부서명 (30자, 기본값 'GENERAL')
- position: 직급 (20자, NULL 불가)
- salary: 급여 (정수, 기본값 0)
- hire_date: 입사일 (DATE 타입, NULL 불가)
- email: 이메일 (100자, 유니크 제약조건)
- phone: 전화번호 (20자)
- is_active: 재직여부 (BOOLEAN, 기본값 TRUE)
- created_at: 등록시간 (TIMESTAMP, 기본값 현재시간)
- updated_at: 수정시간 (TIMESTAMP, 기본값 현재시간, 수정시 자동 업데이트)
*/
CREATE TABLE IF NOT EXISTS employees (
	emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    department VARCHAR(30) DEFAULT 'GENERAL',
    position VARCHAR(20) NOT NULL,
    salary INT DEFAULT 0,
    hire_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- 문제 1-2: 다음 조건에 맞는 projects 테이블을 생성하세요.
/*
조건:
- project_id: 자동증가 기본키
- project_name: 프로젝트명 (100자, NULL 불가)
- manager_id: 매니저ID (INT)
- budget: 예산 (DECIMAL(12,2))
- start_date: 시작일 (DATE)
- end_date: 종료일 (DATE)
- status: 상태 (ENUM 타입: 'PLANNING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED', 기본값 'PLANNING')
- description: 설명 (TEXT)
- created_at: 등록시간 (TIMESTAMP, 기본값 현재시간)
*/
CREATE TABLE IF NOT EXISTS projects (
	project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    manager_id INT,
    budget DECIMAL(12, 2),
    start_date DATE,
    end_date DATE,
    status ENUM('PLANNING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') DEFAULT 'PLANNING',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ========================================
-- 2. INSERT 
-- ========================================
-- 문제 2-1: employees 테이블에 다음 직원들을 INSERT하세요.
/*
직원1: 김철수, IT, 팀장, 5000000, 2023-01-15, kim.cs@company.com, 010-1111-2222
직원2: 이영희, HR, 대리, 4000000, 2023-03-20, lee.yh@company.com, 010-3333-4444  
직원3: 박민수, FINANCE, 과장, 5500000, 2022-11-10, park.ms@company.com, 010-5555-6666
*/
SELECT * FROM employees;
INSERT INTO employees (emp_name, department, position, salary, hire_date, email, phone)
VALUES 
	('김철수', 'IT', '팀장', 5000000, '2023-01-15', 'kim.cs@company.com', '010-1111-2222'),
    ('이영희', 'HR', '대리', 4000000, '2023-03-20', 'lee.yh@company.com', '010-3333-4444'),
    ('박민수', 'FINANCE', '과장', 5500000, '2022-11-10', 'park.ms@company.com', '010-5555-6666');


-- 문제 2-2: projects 테이블에 다음 프로젝트들을 INSERT하세요.
/*
프로젝트1: 웹사이트 리뉴얼, 매니저ID: 1, 예산: 50000000, 시작일: 2024-01-01, 종료일: 2024-06-30, 상태: IN_PROGRESS
프로젝트2: 모바일 앱 개발, 매니저ID: 3, 예산: 80000000, 시작일: 2024-02-15, 종료일: 2024-12-31, 상태: PLANNING
*/
SELECT * FROM projects;
INSERT INTO projects (project_name, manager_id, budget, start_date, end_date, status)
VALUES
	('웹사이트 리뉴얼', 1, 50000000, '2024-01-01', '2024-06-30', 'IN_PROGRESS'),
	('모바일 앱 개발', 3, 80000000, '2024-02-15', '2024-12-31', 'PLANNING');


-- 문제 2-3: 필수 컬럼만으로 INSERT하세요.
/*
직원4: 최수진, MARKETING, 사원, 3500000, 2024-01-05
직원5: 정태현, IT, 주임, 4200000, 2023-08-12
*/
SELECT * FROM employees;
INSERT INTO employees (emp_name, department, position, salary, hire_date)
VALUES
	('최수진', 'MARKETING', '사원', 3500000, '2024-01-05'),
	('정태현', 'IT', '주임', 4200000, '2023-08-12');


-- ========================================
-- 3. INSERT 서브쿼리
-- MySQL 에서 같은 테이블을 INSERT 하면서 동시에 SELECT 를 하려할 때 발생하는 문제를 만날 것!
-- ERROR 1093 : 동시에 할 수 없음!
-- 조회할 데이터를 INSERT 내에서만 사용하는 파생테이블 형태로 만들고
-- INSERT 데이터를 저장하는 형식을 사용
-- ========================================
-- 문제 3-1: employees 테이블에 새로운 직원을 추가하는데,
-- salary는 같은 부서의 평균 급여로 설정하세요.
/*
직원명: 홍길동, 부서: IT, 직급: 사원, 입사일: 2024-09-01, 이메일: hong.gd@company.com
급여: IT 부서의 평균 급여로 설정
*/
-- SELECT 로 IT 직원들의 평균 급여 조회
SELECT AVG(salary) FROM employees WHERE department = 'IT';
-- 조회된 내용을 SALARY 에 집어넣기
INSERT INTO employees (emp_name, department, position, hire_date, email, salary)
-- 																						 FROM 테이블만 서브쿼리 형태로 테이블 명칭을 임시 변경
VALUES ('홍길동', 'IT', '사원', '2024-09-01', 'hong.gd@company.com', (SELECT AVG(salary) FROM (SELECT salary FROM employees WHERE department = 'IT') AS 잠시사용할테이블));
/*
테이블 별칭을 쓰는 방법도 有
INSERT INTO employees (emp_name, department, position, hire_date, email, salary)
VALUES ('홍길동', 'IT', '사원', '2024-09-01', 'hong.gd@company.com', (SELECT AVG(e.salary) FROM employees e WHERE e.department = 'IT'));
*/

-- SQL = 변수가 존재!
-- 변수명 사용방법
-- SET @변수이름 = (쿼리);
-- 어디서부터 어디까지가 변수명에 들어갈 쿼리인지 () 형태로 감싸서 명시적으로 표시하기!
SET @평균급여 = (SELECT AVG(salary) FROM employees WHERE department = 'IT');
INSERT INTO employees (emp_name, department, position, hire_date, email, salary)
VALUES ('홍길동', 'IT', '사원', '2024-09-01', 'hong.gd@company.com', @평균급여);


-- 문제 3-2: projects 테이블에 새 프로젝트를 추가하는데,
-- manager_id는 IT 부서에서 급여가 가장 높은 직원의 ID로 설정하세요.
/*
프로젝트명: AI 챗봇 개발, 예산: 120000000, 시작일: 2024-10-01, 종료일: 2025-03-31, 상태: PLANNING
매니저ID: IT 부서에서 급여가 가장 높은 직원의 ID
*/
SELECT * FROM projects;
SET @직원아이디 = (SELECT emp_id FROM employees e WHERE salary = (SELECT MAX(salary) FROM employees WHERE department = 'IT') AND department = 'IT');
-- SET 해서 변수명으로 사용하는 것은 INSERT 와 UPDATE 에서 주로 사용
-- SET 변수는 데이터 1개의 값만 저장 가능!! (배열 형태 저장 X)
INSERT INTO projects (project_name, budget, start_date, end_date, status, manager_id)
VALUES ('AI 챗봇 개발', 120000000, '2024-10-01', '2025-03-31', 'PLANNING', @직원아이디);


-- 문제 3-3: employees 테이블에 새 직원을 추가하는데,
-- hire_date는 가장 최근에 입사한 직원의 입사일로 설정하세요.
/*
직원명: 윤서연, 부서: HR, 직급: 사원, 급여: 3800000, 이메일: yoon.sy@company.com
입사일: 가장 최근 입사 직원의 입사일과 동일하게 설정
*/
SELECT * FROM employees;
SET @마지막입사일 = (SELECT MAX(hire_date) FROM employees);
INSERT INTO employees (emp_name, department, position, salary, hire_date, email)
VALUES ('윤서연', 'HR', '사원', 3800000, @마지막입사일, 'yoon.sy@company.com');


-- ========================================
-- 4. UPDATE
-- ========================================
-- 문제 4-1: IT 부서 직원들의 급여를 10% 인상하세요.
SELECT * FROM employees WHERE department = 'IT';
UPDATE employees
SET salary = salary * 1.1
WHERE department = 'IT';


-- 문제 4-2: 김철수 직원의 직급을 '부장'으로, 급여를 6000000으로 변경하세요.
SELECT * FROM employees;
UPDATE employees
SET position = '부장',
	salary = 6000000
WHERE emp_name = '김철수';


-- 문제 4-3: 2023년에 입사한 모든 직원의 부서를 'TRAINING'으로 변경하세요.
SELECT * FROM employees WHERE YEAR(hire_date) = 2023;
UPDATE employees
SET department = 'TRAINING'
WHERE YEAR(hire_date) = 2023;


-- ========================================
-- 5. UPDATE 서브쿼리
-- ========================================
-- 문제 5-1: FINANCE 부서의 모든 직원 급여를 전체 직원의 평균 급여로 업데이트하세요.
SET @average_salary = (SELECT AVG(salary) FROM (SELECT salary FROM employees) AS temp);
UPDATE employees 
SET salary = @average_salary
WHERE department = 'FINANCE';


-- 문제 5-2: 각 부서에서 가장 높은 급여를 받는 직원의 직급을 '팀장'으로 변경하세요.
/*
UPDATE employees e1
SET position = '팀장'
WHERE salary = (SELECT MAX(salary) FROM (SELECT * FROM employees) AS e2 WHERE e2.department = e1.department);
*/
UPDATE employees e1
SET position = '팀장'
WHERE salary = (
	SELECT MAX(salary)
    FROM (SELECT * FROM employees) AS e2 
    WHERE e2.department = e1.department
);
UPDATE employees e1
SET position = '팀장'
WHERE (e1.department, e1.salary) IN (
	SELECT e2.department, MAX(e2.salary)
	FROM employees e2
	GROUP BY e2.department
);
-- 부서별 가장 높은 급여 조회 -> 부서별로 높은 급여를 조회하는 쿼리의 결과가 단일 데이터가 아닌, 다중열 다중행이라서 변수로 사용은 안 되는 듯...?
SELECT department, max(salary)
FROM employees
GROUP BY department;


-- 문제 5-3: 'COMPLETED' 상태인 프로젝트의 매니저들의 급여를 20% 인상하세요.
-- 5-2 문제와 마찬가지로 현재는 @manager_id 가 null 이라 문제가 발생하지 않지만, 추후에 여러 id가 있는 경우 변수로 사용할 수 없을 것 같은데...?
/*
UPDATE employees 
SET salary = salary * 1.2 
WHERE emp_id IN (SELECT manager_id FROM projects WHERE status = 'COMPLETED');
*/
SELECT * FROM projects WHERE status = 'COMPLETED';
-- SET @manager_id = (SELECT manager_id FROM projects WHERE status = 'COMPLETED');
UPDATE employees 
SET salary = salary * 1.2 
WHERE emp_id IN (SELECT manager_id FROM projects WHERE status = 'COMPLETED');



-- ========================================
-- 6. DELETE 문제
-- ========================================

-- 문제 6-1: 재직하지 않는 직원(is_active = FALSE)들을 삭제하세요.



-- 문제 6-2: 급여가 3000000 미만이고 2024년 이전에 입사한 직원들을 삭제하세요.



-- 문제 6-3: 'CANCELLED' 상태인 프로젝트들을 모두 삭제하세요.









