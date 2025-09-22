-- DML (Data Manipulation Language) : 데이터 조작 언어

-- 데이터에 값을 삽입하거나, 수정하거나, 삭제하는 구문

-- 주의) COMMIT, ROLLBACK 을 실무에서 혼자서 하지 말 것!!!!!!!

CREATE TABLE member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    gender ENUM('M', 'F', 'Other'),
    address TEXT,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') DEFAULT 'ACTIVE'
);

SELECT * FROM member;
-- ===========================
-- INSERT 구문
-- INSERT INTO 테이블이름
-- 		  VALUES (데이터, 데이터, 데이터, ...)
-- 모든 컬럼에 대한 값을 넣을 때는 컬럼 명칭은 생략하고 순서대로 VALUES 에 추가할 데이터 작성 
-- ===========================

-- 모든 컬럼에 대한 값 저장 (AUTO_INCREMENT 제외)
INSERT INTO member
	   VALUES (
       NULL,				-- member_id	(AUTO_INCREMENT 이므로 NULL)
       'hong1234',  		-- username 	(닉네임)
       'pass1234',  		-- password 	(비밀번호)
       'hong@gamil.com',	-- email 		(유저이메일)
       '홍길동',			-- name 		(유저이름)
       '010-1234-5678',		-- phone 		(핸드폰번호)
       '2000-01-01', 		-- birth_date 	(생일)
       'M',					-- gender 		(성별)
       '서울시 종로구 관철동', -- address 	(주소)
       NOW(),				-- join_date 	(가입일자, 현재시간 기준)
       'ACTIVE'				-- status		(탈퇴, 휴면계정 여부)
       );
       
SELECT * FROM member;

-- =============================================
-- 실습 문제 1: 기본 INSERT 구문
-- =============================================
-- 문제: 다음 회원 정보들을 한 번에 INSERT하세요.
/*
회원1: jane_smith, password456, jane@example.com, 김영희, 010-9876-5432, 1992-08-20, F, 부산시 해운대구, 현재시간, ACTIVE
회원2: mike_wilson, password789, mike@example.com, 이철수, 010-5555-7777, 1988-12-03, M, 대구시 중구, 현재시간, ACTIVE  
회원3: sarah_lee, passwordabc, sarah@example.com, 박미영, 010-3333-9999, 1995-03-10, F, 광주시 서구, 현재시간, INACTIVE
*/
INSERT INTO member
		VALUES (
        NULL,
        'jane_smith',
        'password456',
        'jane@example.com'
        '김영희',
        '010-9876-5432',
        '1992-08-20',
        'F',
        '부산시 해운대구',
        NOW(),
        'ACTIVE'
        );

INSERT INTO member
		VALUES (
        NULL,
        'mike_wilson',
        'password789',
        'mike@example.com'
        '이철수',
        '010-5555-7777',
        '1988-12-03',
        'M',
        '대구시 중구',
        NOW(),
        'ACTIVE'
        );

INSERT INTO member
		VALUES (
        NULL,
        'sarah_lee',
        'passwordabc',
        'sarah@example.com'
        '박미영',
        '010-3333-9999',
        '1995-03-10',
        'F',
        '광주시 서구',
        NOW(),
        'INACTIVE'
        );







