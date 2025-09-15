-- 문제 1
-- chun_university 데이터베이스의 STUDENT 테이블에서 
-- 모든 학생의 학번(STUDENT_NO), 이름(STUDENT_NAME), 주소(STUDENT_ADDRESS)를 조회하시오.
SELECT student_no, student_name, student_address
FROM student;

-- 문제 2
-- PROFESSOR 테이블의 모든 데이터를 조회하시오.
SELECT *
FROM professor;


-- 문제 3
-- DEPARTMENT 테이블에서 학과번호(DEPARTMENT_NO)와 학과명(DEPARTMENT_NAME)을 조회하시오.
SELECT department_no, department_name
FROM department;


-- 문제 4
-- STUDENT 테이블에서 모든 학생의 이름, 입학일, 입학일로부터 현재까지의 일수를 조회하시오.
-- (컬럼명은 각각 '학생이름', '입학일', '재학일수'로 별칭 지정)
SELECT student_name "학생이름", entrance_date "입학일", DATEDIFF(NOW(), entrance_date) "재학일수"
FROM student;


-- 문제 5
-- 현재 시간과 어제, 내일을 조회하시오.
-- (컬럼명은 각각 '현재시간', '어제', '내일'로 별칭 지정)
SELECT NOW() "현재시간", NOW() - INTERVAL 1 DAY "어제", NOW() + INTERVAL 1 DAY "내일";


-- 문제 6
-- STUDENT 테이블에서 학번과 이름을 연결하여 하나의 컬럼으로 조회하시오.
-- (컬럼명은 '학번_이름'으로 별칭 지정)
SELECT CONCAT(student_no, "_", student_name) AS `학번_이름`
FROM student;


-- 문제 7
-- STUDENT 테이블에서 존재하는 학과번호의 종류만 중복 없이 조회하시오.
SELECT DISTINCT department_no
FROM student;


-- 문제 8
-- GRADE 테이블에서 중복 없이 존재하는 학기번호(TERM_NO) 종류를 조회하시오.
SELECT DISTINCT term_no
FROM grade;


-- 문제 9
-- STUDENT 테이블에서 휴학여부(ABSENCE_YN)가 'Y'인 학생의 
-- 학번, 이름, 학과번호를 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NO
FROM student
WHERE ABSENCE_YN = 'Y';



-- 문제 10
-- DEPARTMENT 테이블에서 정원(CAPACITY)이 25명 이상인 학과의 
-- 학과명, 분류, 정원을 조회하시오.
SELECT department_name, category, capacity
FROM department
WHERE capacity >= 25;


-- 문제 11
-- STUDENT 테이블에서 학과번호가 '001'이 아닌 학생의 
-- 이름, 학과번호, 주소를 조회하시오.
SELECT student_name, department_no, student_address
FROM student
WHERE department_no != '001';


-- 문제 12
-- GRADE 테이블에서 성적(POINT)이 4.0 이상인 성적 데이터의 
-- 학기번호, 과목번호, 학번, 성적을 조회하시오.
SELECT term_no, class_no, student_no, point
FROM grade
WHERE point >= 4.0;


-- 문제 13
-- STUDENT 테이블에서 2005년에 입학한 학생의 
-- 학번, 이름, 입학일을 조회하시오.
SELECT student_no, student_name, entrance_date
FROM student
WHERE YEAR(entrance_date) = 2005;


-- 문제 14 (보기만 하기)
-- WHERE DEPARTMENT_NO IS NOT NULL;
-- PROFESSOR 테이블에서 소속 학과번호(DEPARTMENT_NO)가 NULL이 아닌 교수의 
-- 교수번호, 이름, 학과번호를 조회하시오.
SELECT professor_no, professor_name, department_no
FROM professor
WHERE department_no IS NOT NULL;


-- 문제 15
-- CLASS 테이블에서 과목유형(CLASS_TYPE)이 '전공필수'인 과목의 
-- 과목번호, 과목명, 과목유형을 조회하시오.
SELECT class_no, class_name, class_type
FROM class
WHERE class_type = "전공필수";


-- 문제 16 (보기만 하기)
-- WHERE STUDENT_ADDRESS LIKE("서울시%");
-- STUDENT 테이블에서 주소가 '서울시'로 시작하는 학생의 
-- 이름, 주소, 입학일을 조회하시오.
SELECT student_name, student_address, entrance_date
FROM student
WHERE student_address LIKE("서울시%");


-- 문제 17
-- GRADE 테이블에서 성적이 3.0 이상 4.0 미만인 성적 데이터의 
-- 학번, 과목번호, 성적을 조회하시오.
SELECT student_no, class_no, point
FROM grade
WHERE point >= 3.0 AND point < 4.0;


-- 문제 18
-- STUDENT 테이블에서 지도교수번호(COACH_PROFESSOR_NO)가 'P001'인 학생의 
-- 학번, 이름, 학과번호를 조회하시오.
SELECT student_no, student_name, department_no
FROM student
WHERE coach_professor_no = "P001";


-- 문제 19
-- DEPARTMENT 테이블에서 분류(CATEGORY)가 '인문사회'인 학과의 
-- 학과명, 분류, 개설여부를 조회하시오.
SELECT department_no, category, open_yn
FROM department
WHERE category = "인문사회";


-- 문제 20 (보기만 하기)
-- WHERE STUDENT_NO LIKE '%A%';
-- STUDENT 테이블에서 학번에 'A'가 포함된 학생의 
-- 학번, 이름, 입학일을 조회하시오.
SELECT student_no, student_name, entrance_date
FROM student
WHERE student_no LIKE '%A%';
