USE chun_university;

-- 문제 1
-- CLASS 테이블에서 모든 과목의 과목번호, 과목명, 학과번호를 조회하시오.
SELECT class_no, class_name, department_no
FROM class;

-- 문제 2
-- GRADE 테이블의 모든 성적 데이터를 조회하시오.
SELECT *
FROM grade;

-- 문제 3
-- CLASS_PROFESSOR 테이블에서 과목번호와 교수번호를 조회하시오.
SELECT *
FROM class_professor;

-- 문제 4
-- PROFESSOR 테이블에서 교수번호, 교수명, 학과번호를 조회하되, 
-- 컬럼명을 각각 '교수코드', '교수이름', '소속학과'로 별칭을 지정하시오.
SELECT professor_no AS `교수코드`, professor_name AS `교수이름`, department_no AS `학과번호`
FROM professor;

-- 문제 5
-- DEPARTMENT 테이블에서 학과명과 정원을 연결하여 '학과명(정원명)' 형태로 조회하시오.
SELECT CONCAT(department_name, '(', capacity, ')')
FROM department;

-- 문제 6
-- 현재 날짜에서 7일 후, 30일 후, 365일 후를 조회하시오.
SELECT NOW() + INTERVAL 7 DAY, NOW() + INTERVAL 30 DAY, NOW() + INTERVAL 365 DAY;

-- 문제 7
-- STUDENT 테이블에서 학번 앞에 'STU-'를 붙여서 조회하시오.
SELECT CONCAT('STU-', student_no)
FROM student;

-- 문제 8
-- PROFESSOR 테이블에서 교수명 앞에 '교수님'을 붙여서 조회하시오.
SELECT CONCAT('교수님 ', professor_name)
FROM professor;

-- 문제 9
-- GRADE 테이블에서 성적에 0.5를 더한 값을 '조정성적'으로 조회하시오.
SELECT point + 0.5 AS '조정성적'
FROM grade;

-- 문제 10
-- DEPARTMENT 테이블에서 정원에서 5명을 뺀 값을 '실제모집인원'으로 조회하시오.
SELECT department_name, capacity - 5 AS '실제모집인원'
FROM department;

-- 문제 11
-- CLASS 테이블에서 중복을 제거하고 학과번호만 조회하시오.
SELECT DISTINCT(class_no)
FROM class;

-- 문제 12
-- PROFESSOR 테이블에서 중복을 제거하고 학과번호만 조회하시오.
SELECT DISTINCT(department_no)
FROM professor;

-- 문제 13
-- GRADE 테이블에서 중복을 제거하고 과목번호만 조회하시오.
SELECT DISTINCT(class_no)
FROM grade;

-- 문제 14
-- STUDENT 테이블에서 학과번호가 '002'인 학생들의 모든 정보를 조회하시오.
SELECT *
FROM student
WHERE department_no = '002';

-- 문제 15
-- CLASS 테이블에서 과목유형이 '교양'인 과목들의 과목번호와 과목명을 조회하시오.
SELECT class_no, class_name
FROM class
WHERE class_type = '교양';

-- 문제 16
-- DEPARTMENT 테이블에서 개설여부(OPEN_YN)가 'Y'인 학과의 학과명과 분류를 조회하시오.
SELECT department_name, category
FROM department
WHERE open_yn = 'Y';

-- 문제 17
-- PROFESSOR 테이블에서 학과번호가 '003'인 교수들의 교수번호와 이름을 조회하시오.
SELECT professor_no, professor_name
FROM professor
WHERE department_no = '003';

-- 문제 18
-- GRADE 테이블에서 성적이 3.0 미만인 성적 데이터를 조회하시오.
SELECT *
FROM grade
WHERE point < 3.0;

-- 문제 19
-- STUDENT 테이블에서 2003년에 입학한 학생들의 학번과 이름을 조회하시오.
SELECT student_no, student_name, entrance_date
FROM student
WHERE entrance_date LIKE '2003%';

-- 문제 20
-- DEPARTMENT 테이블에서 정원이 30명 이하인 학과의 학과명과 정원을 조회하시오.
SELECT department_name, capacity
FROM department
WHERE capacity <= 30;

-- 문제 21
-- STUDENT 테이블에서 이름이 '박'으로 시작하는 학생들의 학번과 이름을 조회하시오.
SELECT student_no, student_name
FROM student
WHERE student_name LIKE '박%';

-- 문제 22
-- CLASS 테이블에서 과목명에 '론'이 포함된 과목들의 과목번호와 과목명을 조회하시오.
SELECT class_no, class_name
FROM class
WHERE class_name LIKE '%론%';

-- 문제 23
-- STUDENT 테이블에서 주소에 '경기도'가 포함된 학생들의 이름과 주소를 조회하시오.
SELECT student_name, student_address
FROM student
WHERE student_address LIKE '%경기도%';

-- 문제 24
-- PROFESSOR 테이블에서 이름이 '교수'로 끝나는 교수들의 교수번호와 이름을 조회하시오.
SELECT professor_no, professor_name
FROM professor
WHERE professor_name LIKE '%교수';

-- 문제 25
-- GRADE 테이블에서 성적이 2.5 이상 3.5 이하인 성적 데이터를 성적 오름차순으로 정렬하여 조회하시오.
SELECT *
FROM grade
WHERE point BETWEEN 2.5 AND 3.5
ORDER BY point;

-- 문제 26
-- STUDENT 테이블에서 학과번호가 '004', '005', '006'인 학생들의 정보를 학과번호 순으로 정렬하여 조회하시오.
SELECT *
FROM student
WHERE department_no IN ('004', '005', '006')
ORDER BY department_no;

-- 문제 27
-- CLASS 테이블에서 과목유형이 '전공선택'인 과목들을 과목명 내림차순으로 정렬하여 조회하시오.
SELECT *
FROM class
WHERE class_type = '전공선택'
ORDER  BY class_name DESC;

-- 문제 28
-- PROFESSOR 테이블에서 소속 학과가 있는 교수들을 교수명 오름차순으로 정렬하여 조회하시오.
SELECT *
FROM professor
WHERE department_no IS NOT NULL
ORDER BY professor_name;

-- 문제 29
-- STUDENT 테이블에서 휴학하지 않은 학생들을 입학일 내림차순으로 정렬하여 조회하시오.
SELECT *
FROM student
WHERE absence_yn = 'N'
ORDER BY entrance_date DESC;

-- 문제 30
-- GRADE 테이블에서 '200501' 학기가 아닌 성적 데이터를 학기번호 오름차순, 성적 내림차순으로 정렬하여 조회하시오.
SELECT *
FROM grade
WHERE term_no != '200501'
ORDER BY term_no ASC, point DESC;