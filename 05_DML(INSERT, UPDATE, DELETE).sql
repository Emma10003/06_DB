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
        NULL, 'jane_smith', 'password456', 'jane@example.com', '김영희', '010-9876-5432', '1992-08-20', 'F', '부산시 해운대구', NOW(), 'ACTIVE'
        );

INSERT INTO member
		VALUES (
        NULL, 'mike_wilson', 'password789', 'mike@example.com', '이철수', '010-5555-7777', '1988-12-03', 'M', '대구시 중구', NOW(), 'ACTIVE'
        );

INSERT INTO member
		VALUES (
        NULL, 'sarah_lee', 'passwordabc', 'sarah@example.com', '박미영', '010-3333-9999', '1995-03-10', 'F', '광주시 서구', NOW(), 'INACTIVE'
        );



-- ===========================
-- INSERT 구문 여러 행을 한 번에 입력
-- INSERT INTO 테이블이름
-- 		  VALUES 
-- 			(데이터1, 데이터1, 데이터1, ...),
-- 		    (데이터2, 데이터2, 데이터2, ...),
-- 		    (데이터3, 데이터3, 데이터3, ...);
-- 콤마(,)로 구분하여 여러 행을 한 번에 입력 후 데이터를 저장할 수 있다.
-- ===========================

INSERT INTO member
	   VALUES 
       (NULL, 'mini1004', 'pass5678', 'mini1004@gamil.com', '김미니', '010-6666-7777', '2001-02-02', 'F', '서울시 강남구 역삼동', NOW(), 'ACTIVE'),
       (NULL, 'soo5678', 'pass9999', 'soo5678@gamil.com', '한철수', '010-8888-9999', '2002-03-03', 'M', '서울시 동작구 흑석동', NOW(), 'ACTIVE');

SELECT * FROM member;


-- ===========================
-- INSERT 구문 필수 컬럼만 입력 -> 모든 컬럼에 데이터를 넣지 않고
-- 컬럼명칭 옆에 NOT NULL 인 컬럼명칭만 지정하여 데이터를 넣을 수 있음.
-- 주의할 점 : NOT NULL 은 필수로 데이터를 넣어야 하는 공간이기 때문에 생략할 수 없음!
-- INSERT INTO 테이블이름 (필수컬럼명1, 필수컬럼명2, 필수컬럼명3, ...)
-- 		  VALUES 
-- 			(데이터1, 데이터1, 데이터1, ...),
-- 		    (데이터2, 데이터2, 데이터2, ...),
-- 		    (데이터3, 데이터3, 데이터3, ...);

-- INSERT INTO 테이블이름 (필수컬럼명1, 필수컬럼명2, 필수컬럼명3, ...)
-- 		  VALUES (데이터1, 데이터1, 데이터1, ...);
-- 콤마(,)로 구분하여 여러 행을 한 번에 입력 후 데이터를 저장할 수 있다.
-- ===========================


-- =============================================
-- 실습 문제 1: 필수 컬럼만 INSERT
-- =============================================
-- 문제: 다음 회원들을 필수 컬럼(username, password, email, name)만으로 INSERT하세요.
-- 나머지 컬럼들은 기본값 또는 NULL이 됩니다.

/*
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

-- 데이터 추가 후 SELECT * FROM member; 를 통해 저장한 데이터 조회
회원1: user_basic1, basicpass123, basic1@email.com, 기본유저1
회원2: user_basic2, basicpass456, basic2@email.com, 기본유저2  
회원3: user_basic3, basicpass789, basic3@email.com, 기본유저3
*/
INSERT INTO member (member_id, username, password, email, name)
		VALUES 
        (NULL, 'user_basic1', 'basicpass123', 'basic1@email.com', '기본유저1'),
		(NULL, 'user_basic2', 'basicpass456', 'basic2@email.com', '기본유저2'),
		(NULL, 'user_basic3', 'basicpass789', 'basic3@email.com', '기본유저3');

SELECT * FROM member;
