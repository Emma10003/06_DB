/*
LIBRARY_MEMBER 테이블을 생성하세요.
제약조건명(CONSTRAINT) 규칙:
- PK: PK_테이블명_컬럼명
- UK: UK_테이블명_컬럼명  
- CK: CK_테이블명_컬럼명

컬럼 정보:
- MEMBER_NO: 회원번호 (숫자, 기본키)
- MEMBER_NAME: 회원이름 (최대 20자, 필수입력)
- EMAIL: 이메일 (최대 50자, 중복불가)
- PHONE: 전화번호 (최대 15자)
- AGE: 나이 (숫자, 7세 이상 100세 이하만 가능)
- JOIN_DATE: 가입일 (날짜시간, 기본값은 현재시간)
*/
USE delivery_app;

CREATE TABLE LIBRARY_MEMBER (
	-- 다른 SQL 에서는 컬럼 레벨로 제약조건을 작성할 때 CONSTRAINT 를 이용해서
    -- 제약조건의 명칭을 설정할 수 있지만
    -- MySQL 은 제약조건 명칭을 MySQL 자체에서 자동생성 해주기 때문에 명칭 작성을 컬럼 레벨에서 할 수 없음.
    -- 컬럼명칭  자료형(자료형크기)	제약조건	제약조건명칭					제약조건들 설정
    -- MEMBER_NO INT 				CONSTRAINT 	PK_LIBRARY_MEMBER_MEMBER_NO 	PRIMARY KEY,
	MEMBER_NO INT PRIMARY KEY,  -- CONSTRAINT PK_LIBRARY_MEMBER_MEMBER_NO 와 같은 명칭 자동생성됨
    MEMBER_NAME VARCHAR(20) NOT NULL,
    EMAIL VARCHAR(50) UNIQUE,   -- CONSTRAINT UK_LIBRARY_MEMBER_EMAIL 와 같은 제약조건 명칭 자동 생성되고 관리됨
    PHONE VARCHAR(15),
    AGE INT CONSTRAINT CK_LIBRARY_AGE_ CHECK(AGE >= 7 AND AGE <= 100),
    JOIN_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*
MEMBER_NO, EMAIL 에는 제약조건 명칭 설정이 안 되지만
AGE 에서는 제약조건 명칭이 설정되는 이유

단순히 PK, UNIQUE, FK, NOT NULL 과 같이 한 단어로 키 형태를 작성하는 경우에는 제약조건 명칭 설정이 불가능
CHECK 처럼 제약조건이 상세할 경우에는 제약조건 명칭 설정 가능
=> CHECK 만 개발자가 지정한 제약조건 명칭 설정이 가능하다!
*/

-- 우리회사는 이메일을 최대 20글자 작성으로 설정 -> 21글자 유저가 회원가입이 안된다고 연락
INSERT INTO LIBRARY_MEMBER (MEMBER_NO, MEMBER_NAME, EMAIL, PHONE, AGE)
VALUES (1, '김독서', 'kim@email.com', '010-1234-5678', 25);

-- Error Code: 1406. Data too long for column 'EMAIL' at row 1
-- 컬럼에서 넣을 수 있는 크기에 비해 데이터양이 많을 때 발생하는 문제
-- 방법 1) DROP 해서 테이블 새로 생성한다. -> 기존 데이터는...? 회사 폐업 엔딩💀

-- 방법 2) EMAIL 컬럼의 크기 변경 (ALTER 수정 사용)
-- 1. EMAIL 컬럼을 5자에서 50자로 변경
ALTER TABLE LIBRARY_MEMBER
MODIFY EMAIL VARCHAR(50) UNIQUE;
-- ALTER 로 테이블 속성을 변경할 경우 컬럼명에 해당하는 정보를 하나 더 만들어놓은 후 해당하는 제약조건 동작
-- ALTER 에서 자세한 설명 진행..

SELECT * FROM library_member;

-- 제약조건 위반 테스트 (에러가 발생해야 정상)
INSERT INTO LIBRARY_MEMBER VALUES (1, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- PK 중복
INSERT INTO LIBRARY_MEMBER VALUES (6, '이나이', 'lee@email.com', '010-7777-6666', 5, DEFAULT); -- 나이 제한 위반
























