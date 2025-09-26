-- ========================================
-- MySQL 기반: 온라인 쇼핑몰 데이터베이스
-- ========================================

CREATE DATABASE IF NOT EXISTS online_shop;
USE online_shop;

-- ========================================
-- LEVEL 
-- ========================================

-- 문제 1-1: CATEGORY 테이블 생성
/*
조건:
- category_id: 자동증가 기본키
- category_name: 카테고리명 (50자, NULL 불가, 중복 불가)
- description: 설명 (TEXT)
- is_active: 활성상태 (BOOLEAN, 기본값 TRUE)
- created_at: 등록시간 (TIMESTAMP, 기본값 현재시간)
*/
CREATE TABLE CATEGORY (
	CATEGORY_ID INT AUTO_INCREMENT PRIMARY KEY,
    CATEGORY_NAME VARCHAR(50) NOT NULL UNIQUE,
    DESCRIPTION TEXT,
    IS_ACTIVE BOOLEAN DEFAULT TRUE,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- 문제 1-2: CUSTOMER 테이블 생성
/*
조건:
- customer_id: 자동증가 기본키
- username: 사용자명 (30자, NULL 불가, 중복 불가)
- email: 이메일 (100자, NULL 불가, 중복 불가)
- password: 비밀번호 (255자, NULL 불가)
- full_name: 실명 (50자, NULL 불가)
- phone: 전화번호 (20자)
- birth_date: 생년월일 (DATE)
- gender: 성별 (ENUM: 'M', 'F', 'OTHER')
- point: 적립금 (정수, 기본값 0, 0 이상)
- grade: 등급 (VARCHAR(20), 기본값 'BRONZE')
- is_active: 활성상태 (BOOLEAN, 기본값 TRUE)
- join_date: 가입일 (TIMESTAMP, 기본값 현재시간)
- last_login: 마지막 로그인 (TIMESTAMP)
*/
CREATE TABLE CUSTOMER (
	CUSTOMER_ID INT AUTO_INCREMENT PRIMARY KEY,
    USERNAME VARCHAR(30) NOT NULL UNIQUE,
    EMAIL VARCHAR(100) NOT NULL UNIQUE,
    PASSWORD VARCHAR(255) NOT NULL,
    FULL_NAME VARCHAR(50) NOT NULL,
    PHONE VARCHAR(20),
    BIRTH_DATE DATE,
    GENDER ENUM('M', 'F', 'OTHER'),
    POINT INT DEFAULT 0 CHECK(POINT >= 0),
    GRADE VARCHAR(20) DEFAULT 'BRONZE',
    IS_ACTIVE BOOLEAN DEFAULT TRUE,
    JOIN_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LAST_LOGIN TIMESTAMP
);



-- 문제 1-3: PRODUCT 테이블 생성
/*
조건:
- product_id: 자동증가 기본키
- product_name: 상품명 (100자, NULL 불가)
- category_id: 카테고리ID (정수, 외래키)
- price: 가격 (정수, NULL 불가, 0 이상)
- discount_rate: 할인율 (DECIMAL(5,2), 기본값 0.00, 0~100 사이)
- stock_quantity: 재고수량 (정수, 기본값 0, 0 이상)
- description: 상품설명 (TEXT)
- brand: 브랜드 (50자)
- weight: 무게 (DECIMAL(8,2))
- status: 상태 (ENUM: 'AVAILABLE', 'OUT_OF_STOCK', 'DISCONTINUED', 기본값 'AVAILABLE')
- created_at: 등록시간 (TIMESTAMP, 기본값 현재시간)
- updated_at: 수정시간 (TIMESTAMP, 기본값 현재시간, 수정시 자동 업데이트)
*/
CREATE TABLE PRODUCT (
	PRODUCT_ID INT AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(100) NOT NULL,
    CATEGORY_ID INT,
    PRICE INT NOT NULL CHECK(PRICE >= 0),
    DISCOUNT_RATE DECIMAL(5,2) DEFAULT 0.00 CHECK(DISCOUNT_RATE >= 0 AND DISCOUNT_RATE <= 100),
    STOCK_QUANTITY INT DEFAULT 0 CHECK(STOCK_QUANTITY >= 0),
    DESCRIPTION TEXT,
    BRAND VARCHAR(50),
    WEIGHT DECIMAL(8,2),
    STATUS ENUM('AVAILABLE', 'OUT_OF_STOCK', 'DISCONTINUED') DEFAULT 'AVAILABLE',
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
);

-- 문제 1-4: INSERT
-- CATEGORY 테이블에 다음 데이터를 삽입하세요
/*
1. 전자제품, '스마트폰, 노트북, 태블릿 등', TRUE
2. 의류, '남성복, 여성복, 아동복', TRUE
3. 도서, '소설, 전문서적, 교육서적', TRUE
4. 스포츠/레저, '운동용품, 아웃도어 장비', TRUE
5. 식품, '신선식품, 가공식품', FALSE
*/
INSERT INTO category (category_name, description, is_active)
VALUES ('전자제품', '스마트폰, 노트북 태블릿 등', TRUE),
		('의류', '남성복, 여성복, 아동복', TRUE),
		('도서', '소설, 전문서적, 교육서적', TRUE),
		('스포츠/레저', '운동용품, 아웃도어 장비', TRUE),
		('식품', '신선식품, 가공식품', FALSE);




-- CUSTOMER 테이블에 다음 데이터를 삽입하세요
/*
1. hong123, hong@email.com, password123, 홍길동, 010-1111-2222, 1990-05-15, M, 5000, GOLD
2. kim_user, kim@email.com, mypass456, 김영희, 010-3333-4444, 1995-08-20, F, 3000, SILVER  
3. park2024, park@email.com, secure789, 박민수, 010-5555-6666, 1988-12-03, M, 10000, PLATINUM
4. lee_shop, lee@email.com, password999, 이수진, 010-7777-8888, 2000-03-10, F, 1500, BRONZE
5. choi_buy, choi@email.com, pass1234, 최준호, NULL, 1992-07-25, M, 0, BRONZE
*/
INSERT INTO customer (username, email, password, full_name, phone, birth_date, gender, point, grade)
VALUES ('hong123', 'hong@email.com', 'password123', '홍길동', '010-1111-2222', '1990-05-15', 'M', 5000, 'GOLD'),
		('kim_user', 'kim@email.com', 'mypass456', '김영희', '010-3333-4444', '1995-08-20', 'F', 3000, 'SILVER'),
		('park2024', 'park@email.com', 'secure789', '박민수', '010-5555-6666', '1988-12-03', 'M', 10000, 'PLATINUM'),
		('lee_shop', 'lee@email.com', 'password999', '이수진', '010-7777-8888', '2000-03-10', 'F', 1500, 'BRONZE'),
		('choi_buy', 'choi@email.com', 'pass1234', '최준호', 'NULL', '1992-07-25', 'M', 0, 'BRONZE');


-- PRODUCT 테이블에 다음 데이터를 삽입하세요
/*
1. iPhone 15 Pro, 카테고리1, 1200000, 5.00, 50, '최신 아이폰 모델', 'Apple', 200.00, AVAILABLE
2. 삼성 갤럭시 북, 카테고리1, 1500000, 10.00, 30, '고성능 노트북', 'Samsung', 1500.00, AVAILABLE
3. 남성 정장, 카테고리2, 200000, 20.00, 100, '비즈니스 정장', 'Hugo Boss', NULL, AVAILABLE
4. 운동화, 카테고리4, 150000, 15.00, 0, '러닝화', 'Nike', 300.00, OUT_OF_STOCK
5. 요리책, 카테고리3, 25000, 0.00, 200, '집밥 요리 레시피', '맛있는책', 500.00, AVAILABLE
*/
INSERT INTO product (product_name, category_id, price, discount_rate, stock_quantity, description, brand, weight, status)
VALUES ('iPhone 15 Pro', 1, 1200000, 5.00, 50, '최신 아이폰 모델', 'Apple', 200.00, 'AVAILABLE'),
		('삼성 갤럭시 북', 1, 1500000, 10.00, 30, '고성능 노트북', 'Samsung', 1500.00, 'AVAILABLE'),
		('남성 정장', 2, 200000, 20.00, 100, '비즈니스 정장', 'Hugo Boss', NULL, 'AVAILABLE'),
		('운동화', 4, 150000, 15.00, 0, '러닝화', 'Nike', 300.00, 'OUT_OF_STOCK'),
		('요리책', 3, 25000, 0.00, 200, '집밥 요리 레시피', '맛있는책', 500.00, 'AVAILABLE');
        
SELECT * FROM category;
SELECT * FROM customer;
SELECT * FROM product;



-- 문제 1: 상품 및 카테고리 정보 조회 VIEW 생성
-- 요구사항: PRODUCT 테이블의 상품명(product_name)과 CATEGORY 테이블의 카테고리명(category_name)을 함께 볼 수 있는 V_PRODUCT_CATEGORY 라는 이름의 VIEW를 생성하세요.
-- 힌트: PRODUCT 테이블과 CATEGORY 테이블을 category_id로 JOIN 해야 합니다.
-- WHERE 도 사용할 수 있으나, JOIN 방식을 사용해 VIEW를 생성할 것을 권장
CREATE OR REPLACE VIEW V_PRODUCT_CATEGORY AS
SELECT p.product_name, c.category_name
FROM product p
JOIN category c ON p.category_id = c.category_id;

SELECT * FROM v_product_category;


-- 문제 2: 우수 고객 정보 필터링 VIEW 생성
-- 요구사항: CUSTOMER 테이블에서 등급(grade)이 'GOLD' 이상('GOLD', 'PLATINUM')이고, 현재 활성 상태(is_active)인 고객들의 정보만 필터링하는 V_VIP_CUSTOMERS 라는 VIEW를 생성하세요. 
-- 			 VIEW에는 고객의 사용자명(username), 이메일(email), 등급(grade), 적립금(point)이 포함되어야 합니다.
-- 힌트: WHERE 절을 사용하여 두 가지 조건을 동시에 만족하는 데이터를 선택하세요. IN 연산자를 활용하면 등급 조건을 쉽게 처리할 수 있습니다.

-- 보이는 것을 그대로 가져와서 
CREATE OR REPLACE VIEW V_VIP_CUSTOMERS AS  -- 아래 SELECT 문 처럼 보이게 만들어라
SELECT username, email, grade, point
FROM customer
WHERE grade IN ('GOLD', 'PLATINUM')
AND is_active = TRUE;

SELECT * FROM v_vip_customers;


-- 문제 3: 상품 할인 가격 계산 VIEW 생성
-- 요구사항: PRODUCT 테이블의 상품명(product_name), 원래 가격(price), 할인율(discount_rate)을 사용하여 실제 판매 가격을 계산한 discounted_price 컬럼을 포함하는 V_PRODUCT_SALE_PRICE VIEW를 생성하세요.
-- 힌트: price * (1 - discount_rate / 100) 수식을 사용하여 할인된 가격을 계산할 수 있습니다. AS를 사용해 계산된 컬럼의 이름을 지정해주세요.
CREATE OR REPLACE VIEW V_PRODUCT_SALE_PRICE AS
SELECT product_name, price, ROUND(price * (1 - discount_rate / 100)) AS `discounted_price`
FROM product;

SELECT * FROM v_product_sale_price;


-- 문제 4: 카테고리별 상품 통계 VIEW 생성
-- 요구사항: 각 카테고리별로 몇 개의 상품이 등록되어 있는지, 그리고 평균 가격은 얼마인지 계산하는 V_CATEGORY_STATS VIEW를 생성하세요. 
-- 			 VIEW에는 카테고리명(category_name), 해당 카테고리의 상품 수(product_count), 평균 가격(avg_price)이 포함되어야 합니다.
-- 힌트: GROUP BY를 사용하여 카테고리별로 그룹화하고, COUNT()와 AVG() 집계 함수를 사용해야 합니다.

-- category_name 으로 묶여져 있는 각 카테고리별 상품의 개수
CREATE OR REPLACE VIEW V_CATEGORY_STATS AS
SELECT c.category_name, COUNT(p.product_id) AS `product_count`, AVG(p.price) AS `avg_price`
FROM product p
LEFT JOIN category c ON p.category_id = c.category_id
GROUP BY c.category_name;

SELECT * FROM v_category_stats;

/*

JOIN category c ON p.category_id = c.category_id
양쪽 테이블에 모두 데이터가 존재하는 경우만 보여줌
상품이 존재하는 카테고리 정보를 조회

LEFT JOIN category c ON p.category_id = c.category_id
왼쪽 테이블의 데이터는 조건의 일치 여부와 상관없이 모든 데이터를 가져와서 조회
오른쪽 테이블에 일치하는 데이터가 없으면 해당 컬럼은 NULL 표시

결과적으로는
상품이 존재하지 않는 식품 카테고리도 목록에 나타나고
데이터는 NULL 로 표시됨.
LEFT JOIN에서 왼쪽 테이블 결정 기준
FROM 에 작성한 테이블이 왼쪽 테이블이 된다.

*/









