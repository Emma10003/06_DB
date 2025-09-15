/*
실행하는 방법 (3가지):
1. 한 줄 실행				: ctrl + Enter
2. 모든 줄 전체 실행			: ctrl + ALL   ->   ctrl + Shift + Enter
3. 파일로 저장 후 SQL 실행	: ctrl + s 	   ->   ctrl + Shift + Enter

줄 전체 주석 단축키 : ctrl + /

여러 줄 주석 방법

한 줄 주석 방법 (2가지):
	1. # 한 줄 주석
    2. -- 한 줄 주석
    
SQL이 문제 없이 잘 동작하는지 확인하는 방법
대표적으로
SELECT VERSION(); -> ctrl + Enter (한 줄 실행) 으로 버전이 무사히 잘 나오면 잘 동작하는 중인 것!
*/

SELECT VERSION();

/*
-- CREATE DATABASE : 데이터베이스를 생성할 것인데
-- IF NOT EXISTS   : 만약에 오른쪽에 작성한 명칭의 데이터베이스가 존재하지 않는다면
-- CREATE DATABASE IF NOT EXISTS 0000000;  0000000 이름의 데이터베이스를 생성해라.
-- 한 줄 작성 완료 시 세미콜론(;)을 반드시 맨 뒤에 붙여야 함.
*/
CREATE DATABASE IF NOT EXISTS employee_management;

/*
-- USE 0000000;    : 개발자나 관리자가 사용할 데이터베이스 명칭을 선택해서 사용.
-- 이후 실행될 모든 sQL 명령어는 0000000 데이터베이스에서 동작하고 작동하도록 설정.
-- PM 직급이나 팀장급 정도의 사람들만 주로 사용하는 명령어.
*/
USE employee_management;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    dept_code VARCHAR(10) NOT NULL UNIQUE,
    description TEXT,
    location VARCHAR(200),
    budget DECIMAL(15,2),
    manager_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE positions (
    position_id INT PRIMARY KEY AUTO_INCREMENT,
    position_name VARCHAR(100) NOT NULL UNIQUE,
    position_level INT NOT NULL,
    min_salary DECIMAL(12,2),
    max_salary DECIMAL(12,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    full_name VARCHAR(100) GENERATED ALWAYS AS (CONCAT(first_name, ' ', last_name)) STORED,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    mobile VARCHAR(20),
    date_of_birth DATE,
    gender ENUM('M', 'F', 'Other'),
    marital_status ENUM('Single', 'Married', 'Divorced', 'Widowed'),
    nationality VARCHAR(50),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100) DEFAULT 'South Korea',
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    hire_date DATE NOT NULL,
    termination_date DATE,
    dept_id INT,
    position_id INT,
    manager_id INT,
    salary DECIMAL(12,2),
    employment_status ENUM('Active', 'Inactive', 'Terminated', 'On Leave') DEFAULT 'Active',
    employment_type ENUM('Full-time', 'Part-time', 'Contract', 'Intern') DEFAULT 'Full-time',
    profile_image VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE SET NULL,
    FOREIGN KEY (position_id) REFERENCES positions(position_id) ON DELETE SET NULL,
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id) ON DELETE SET NULL,
    
    INDEX idx_emp_dept (dept_id),
    INDEX idx_emp_position (position_id),
    INDEX idx_emp_manager (manager_id),
    INDEX idx_emp_status (employment_status),
    INDEX idx_emp_email (email),
    INDEX idx_hire_date (hire_date)
);

CREATE TABLE salary_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    old_salary DECIMAL(12,2),
    new_salary DECIMAL(12,2) NOT NULL,
    change_reason VARCHAR(255),
    effective_date DATE NOT NULL,
    approved_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES employees(emp_id) ON DELETE SET NULL,
    
    INDEX idx_salary_emp (emp_id),
    INDEX idx_salary_date (effective_date)
);

CREATE TABLE department_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    old_dept_id INT,
    new_dept_id INT,
    transfer_date DATE NOT NULL,
    transfer_reason VARCHAR(255),
    approved_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (old_dept_id) REFERENCES departments(dept_id) ON DELETE SET NULL,
    FOREIGN KEY (new_dept_id) REFERENCES departments(dept_id) ON DELETE SET NULL,
    FOREIGN KEY (approved_by) REFERENCES employees(emp_id) ON DELETE SET NULL,
    
    INDEX idx_dept_history_emp (emp_id),
    INDEX idx_dept_history_date (transfer_date)
);

CREATE TABLE position_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    old_position_id INT,
    new_position_id INT,
    promotion_date DATE NOT NULL,
    promotion_reason VARCHAR(255),
    approved_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (old_position_id) REFERENCES positions(position_id) ON DELETE SET NULL,
    FOREIGN KEY (new_position_id) REFERENCES positions(position_id) ON DELETE SET NULL,
    FOREIGN KEY (approved_by) REFERENCES employees(emp_id) ON DELETE SET NULL,
    
    INDEX idx_position_history_emp (emp_id),
    INDEX idx_position_history_date (promotion_date)
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    work_date DATE NOT NULL,
    check_in_time TIME,
    check_out_time TIME,
    break_start_time TIME,
    break_end_time TIME,
    total_hours DECIMAL(4,2),
    overtime_hours DECIMAL(4,2) DEFAULT 0,
    status ENUM('Present', 'Absent', 'Late', 'Half Day', 'Holiday', 'Sick Leave', 'Personal Leave') DEFAULT 'Present',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    UNIQUE KEY unique_emp_date (emp_id, work_date),
    
    INDEX idx_attendance_emp (emp_id),
    INDEX idx_attendance_date (work_date),
    INDEX idx_attendance_status (status)
);

CREATE TABLE leaves (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    leave_type ENUM('Annual', 'Sick', 'Maternity', 'Paternity', 'Personal', 'Emergency', 'Unpaid') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    days_count INT NOT NULL,
    reason TEXT,
    status ENUM('Pending', 'Approved', 'Rejected', 'Cancelled') DEFAULT 'Pending',
    applied_date DATE DEFAULT (CURRENT_DATE),
    approved_by INT,
    approved_date DATE,
    rejection_reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES employees(emp_id) ON DELETE SET NULL,
    
    INDEX idx_leaves_emp (emp_id),
    INDEX idx_leaves_date (start_date, end_date),
    INDEX idx_leaves_status (status)
);

CREATE TABLE leave_balance (
    balance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    year YEAR NOT NULL,
    leave_type ENUM('Annual', 'Sick', 'Personal') NOT NULL,
    allocated_days INT DEFAULT 0,
    used_days INT DEFAULT 0,
    remaining_days INT GENERATED ALWAYS AS (allocated_days - used_days) STORED,
    carry_forward_days INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    UNIQUE KEY unique_emp_year_type (emp_id, year, leave_type),
    
    INDEX idx_balance_emp (emp_id),
    INDEX idx_balance_year (year)
);

CREATE TABLE performance_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    review_period_start DATE NOT NULL,
    review_period_end DATE NOT NULL,
    reviewer_id INT NOT NULL,
    overall_rating ENUM('Excellent', 'Very Good', 'Good', 'Satisfactory', 'Needs Improvement') NOT NULL,
    goals_achievement DECIMAL(3,1),
    technical_skills DECIMAL(3,1),
    communication_skills DECIMAL(3,1),
    teamwork DECIMAL(3,1),
    leadership DECIMAL(3,1),
    punctuality DECIMAL(3,1),
    strengths TEXT,
    areas_for_improvement TEXT,
    goals_next_period TEXT,
    comments TEXT,
    review_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('Draft', 'Completed', 'Reviewed', 'Approved') DEFAULT 'Draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    
    INDEX idx_reviews_emp (emp_id),
    INDEX idx_reviews_reviewer (reviewer_id),
    INDEX idx_reviews_period (review_period_start, review_period_end)
);

CREATE TABLE training_programs (
    program_id INT PRIMARY KEY AUTO_INCREMENT,
    program_name VARCHAR(200) NOT NULL,
    description TEXT,
    provider VARCHAR(100),
    duration_hours INT,
    cost DECIMAL(10,2),
    certification BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee_training (
    training_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    program_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    completion_status ENUM('Enrolled', 'In Progress', 'Completed', 'Cancelled') DEFAULT 'Enrolled',
    score DECIMAL(5,2),
    certificate_issued BOOLEAN DEFAULT FALSE,
    certificate_number VARCHAR(100),
    cost DECIMAL(10,2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (program_id) REFERENCES training_programs(program_id) ON DELETE CASCADE,
    
    INDEX idx_emp_training_emp (emp_id),
    INDEX idx_emp_training_program (program_id),
    INDEX idx_emp_training_date (start_date)
);

ALTER TABLE departments 
ADD CONSTRAINT fk_dept_manager 
FOREIGN KEY (manager_id) REFERENCES employees(emp_id) ON DELETE SET NULL;

INSERT INTO positions (position_name, position_level, min_salary, max_salary, description) VALUES
('CEO', 1, 100000000, 200000000, '최고경영자'),
('CTO', 2, 80000000, 120000000, '최고기술책임자'),
('부장', 3, 70000000, 90000000, '부서 총괄 관리자'),
('차장', 4, 60000000, 75000000, '팀 관리자'),
('과장', 5, 50000000, 65000000, '프로젝트 관리자'),
('대리', 6, 40000000, 55000000, '중급 개발자/관리자'),
('주임', 7, 35000000, 45000000, '초급 관리자'),
('사원', 8, 30000000, 40000000, '신입/일반 직원'),
('인턴', 9, 20000000, 25000000, '인턴십');

INSERT INTO departments (dept_name, dept_code, description, location, budget) VALUES
('경영관리부', 'MGT', '회사 전반적인 경영 관리', '서울 본사 10층', 1000000000),
('인사부', 'HR', '인적자원 관리 및 채용', '서울 본사 9층', 500000000),
('재무부', 'FIN', '회계 및 재무 관리', '서울 본사 8층', 800000000),
('개발부', 'DEV', '소프트웨어 개발 및 유지보수', '서울 본사 5-7층', 2000000000),
('마케팅부', 'MKT', '마케팅 및 홍보', '서울 본사 4층', 1200000000),
('영업부', 'SALES', '영업 및 고객 관리', '서울 본사 3층', 1500000000),
('디자인부', 'DESIGN', 'UI/UX 및 그래픽 디자인', '서울 본사 2층', 600000000),
('품질관리부', 'QA', '제품 품질 관리 및 테스팅', '서울 본사 6층', 400000000);

INSERT INTO employees (emp_code, first_name, last_name, email, phone, date_of_birth, gender, hire_date, dept_id, position_id, salary, employment_type) VALUES
('EMP001', '김', '대표', 'ceo@company.com', '02-1234-5678', '1975-03-15', 'M', '2020-01-01', 1, 1, 150000000, 'Full-time'),
('EMP002', '이', '기술이사', 'cto@company.com', '02-1234-5679', '1980-07-22', 'M', '2020-02-01', 4, 2, 100000000, 'Full-time'),
('EMP003', '박', '인사부장', 'hr.manager@company.com', '02-1234-5680', '1978-11-08', 'F', '2020-03-01', 2, 3, 80000000, 'Full-time'),
('EMP004', '최', '개발팀장', 'dev.manager@company.com', '02-1234-5681', '1985-05-12', 'M', '2020-04-01', 4, 4, 70000000, 'Full-time'),
('EMP005', '정', '마케팅부장', 'mkt.manager@company.com', '02-1234-5682', '1982-09-30', 'F', '2020-05-01', 5, 3, 75000000, 'Full-time');

UPDATE departments SET manager_id = 1 WHERE dept_id = 1;
UPDATE departments SET manager_id = 3 WHERE dept_id = 2;
UPDATE departments SET manager_id = 4 WHERE dept_id = 4;
UPDATE departments SET manager_id = 5 WHERE dept_id = 5;

INSERT INTO training_programs (program_name, description, provider, duration_hours, cost, certification) VALUES
('신입사원 오리엔테이션', '회사 소개 및 기본 교육', '사내', 16, 0, FALSE),
('리더십 교육', '관리자급 리더십 역량 강화', '외부기관', 24, 500000, TRUE),
('기술 교육 - Python', 'Python 프로그래밍 기초', '온라인', 40, 200000, TRUE),
('영어 회화', '비즈니스 영어 회화', '어학원', 60, 800000, FALSE),
('프로젝트 관리', 'PMP 자격증 취득 과정', 'PMI', 35, 1200000, TRUE);

INSERT INTO leave_balance (emp_id, year, leave_type, allocated_days, used_days) VALUES
(1, YEAR(CURDATE()), 'Annual', 25, 0),
(1, YEAR(CURDATE()), 'Sick', 10, 0),
(2, YEAR(CURDATE()), 'Annual', 25, 0),
(2, YEAR(CURDATE()), 'Sick', 10, 0),
(3, YEAR(CURDATE()), 'Annual', 25, 0),
(3, YEAR(CURDATE()), 'Sick', 10, 0),
(4, YEAR(CURDATE()), 'Annual', 25, 0),
(4, YEAR(CURDATE()), 'Sick', 10, 0),
(5, YEAR(CURDATE()), 'Annual', 25, 0),
(5, YEAR(CURDATE()), 'Sick', 10, 0);