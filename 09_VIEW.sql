-- ======================================
/*
VIEW
논리적 가상 테이블
테이블 모양을 하고 있지만, 실제로 값을 저장하고 있진 않음
값이 저장된 테이블들을 모아서 한 번에 조회하는 테이블

-- SELECT 문의 실행 결과(RESULT SET)을 저장하는 객체

-- VIEW 사용 목적
복잡한 SELECT 문을 쉽게 재사용하기 위해
테이블의 진짜 모습을 감출 수 있어 보안 상 유리

VIEW 사용 시 주의사항
가상의 테이블(실체 X)이기 때문에, ALTER VIEW 구문으로만 수정 가능
VIEW 를 이용한 DML(INSERT, UPDATE, DELETE)를 사용 가능한 경우도 있지만, 제약이 많이 따르기 때문에
	SELECT 용도로 대부분 사용
    
작성법
CREATE [OR REPLACE] VIEW 뷰이름
AS SELECT문
[WITH CHECK OPTION];

1) OR REPLACE 옵션
	- 기존에 동일한 이름의 VIEW 가 존재하면 이를 변경, 없으면 새로 생성
2) WITH CHECK OPTION 옵션
	- WHERE 조건을 위반하는 데이터 수정을 방지
*/
-- ======================================
-- CREATE 에서 에러가 발생하는 것을 방지하기 위해서 IF NOT EXISTS를 작성해준다.
-- DROP   에서 에러가 발생하는 것을 방지하기 위해서 IF EXISTS    를 작성해준다.
CREATE DATABASE IF NOT EXISTS tje;
USE tje;

CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    parent_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(50) NOT NULL,
    brand_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    category_id INT,
    brand_id INT,
    status ENUM('active', 'inactive', 'discontinued') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- 테이블 레벨
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

CREATE TABLE IF NOT EXISTS product_tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS product_tag_relations (
    product_id INT,
    tag_id INT,
    PRIMARY KEY (product_id, tag_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES product_tags(tag_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    reviewer_name VARCHAR(50),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

INSERT INTO categories (category_name, parent_id) VALUES 
('전자제품', NULL),
('스마트폰', 1),
('노트북', 1),
('의류', NULL),
('상의', 4),
('하의', 4);

INSERT INTO brands (brand_name, brand_description) VALUES 
('삼성', '대한민국 대표 전자기업'),
('애플', '미국 프리미엄 전자기업'),
('나이키', '글로벌 스포츠 브랜드'),
('아디다스', '독일 스포츠 브랜드');

INSERT INTO products (product_name, product_description, price, stock_quantity, category_id, brand_id) VALUES 
('갤럭시 S24', '삼성 최신 플래그십 스마트폰', 1200000, 50, 2, 1),
('아이폰 15', '애플 최신 스마트폰', 1300000, 30, 2, 2),
('맥북 프로', '애플 고성능 노트북', 2500000, 20, 3, 2),
('나이키 에어맥스', '편안한 러닝화', 150000, 100, 4, 3),
('아디다스 후디', '따뜻한 후드 티셔츠', 80000, 75, 5, 4);

INSERT INTO product_tags (tag_name) VALUES 
('신상품'), ('인기상품'), ('할인'), ('무료배송'), ('베스트'), ('프리미엄');

INSERT INTO product_tag_relations (product_id, tag_id) VALUES 
(1, 1), (1, 4), (1, 6),  -- 갤럭시: 신상품, 무료배송, 프리미엄
(2, 1), (2, 2), (2, 6),  -- 아이폰: 신상품, 인기상품, 프리미엄  
(3, 5), (3, 6),          -- 맥북: 베스트, 프리미엄
(4, 2), (4, 4),          -- 나이키: 인기상품, 무료배송
(5, 3), (5, 4);          -- 아디다스: 할인, 무료배송

INSERT INTO reviews (product_id, reviewer_name, rating, review_text) VALUES 
(1, '김철수', 5, '정말 좋은 폰입니다. 카메라 화질이 뛰어나요.'),
(1, '이영희', 4, '배터리 지속시간이 만족스럽습니다.'),
(2, '박민수', 5, '아이폰은 역시 아이폰이네요. 완벽합니다.'),
(4, '최영수', 4, '신발이 정말 편해요. 러닝할 때 좋습니다.');



SELECT * FROM brands;
SELECT * FROM categories;
SELECT * FROM products;

-- 브랜드 * 카테고리를 모두 한 번에 조회하는 SELECT 완성
-- JOIN OK, WHERE OK
-- PRODUCTS, CATEGORIES, BRANDS
-- PRODUCTS - BRANDS      -> brand_id
-- PRODUCTS - CATEOGORIES -> category_id
SELECT b.brand_name, b.brand_description, c.category_name
FROM brands b
JOIN products p ON b.brand_id = p.brand_id
JOIN categories c ON c.category_id = p.category_id;
-- 현재는 brands 테이블과 categories 테이블에 연결고리가 없음!


-- ALTER TABLE을 사용해 brands 테이블에 category_id 컬럼을 추가하고 외래 키 제약 조건을 설정
-- ALTER TABLE brands ADD COLUMN category_id VARCHAR(50);  -- ERROR 3780 : 참조하는 컬럼과 참조되는 컬럼의 자료형이 일치하지 않아 발생하는 에러
ALTER TABLE brands ADD COLUMN category_id INT;
ALTER TABLE brands ADD FOREIGN KEY(category_id) REFERENCES categories(category_id);

/*
하나의 테이블에서 여러 수정을 진행할 경우, 콤마(,)를 이용해서 2개 이상의 쿼리를 수행할 수 있다.
ALTER TABLE brands ADD COLUMN category_id INT,
					ADD FOREIGN KEY(category_id) REFERENCES categories(category_id);
*/
--  category_id 컬럼은 현재 NULL 값으로 채워져 있다. 각 브랜드에 맞는 카테고리 ID를 UPDATE 문으로 지정
SELECT * FROM categories;
SELECT * FROM brands;
SELECT * FROM products;

SET SQL_SAFE_UPDATES = 1;

-- ERROR 1146 : table이 존재하지 않음, table에 해당하는 컬럼명칭이 없음
-- ERROR 1175 : KEY 형태의 데이터를 변경하지 않아서 안전모드
UPDATE brands
SET category_id = 1
WHERE brand_description LIKE '%전자기업%';

-- category_id WHERE IN 을 활용해서 브랜드 명칭을 넣고, 나이키와 아디다스에 해당하는 브랜드 카테고리 아이디는 4로 지정
UPDATE brands
SET category_id = 4
WHERE brand_name IN ('나이키', '아디다스');

-- void -> 데이터 추가할 때 많이 사용
-- return -> 몇 개가 있는지 혹은 UPDATE를 했을 때 몇 개가 수정되었는지 개수 확인 후, 클라이언트에게 개수에 따른 결과값 전달

-- 위 사례를 적용한 후, -- 브랜드 * 카테고리를 모두 한 번에 조회하는 SELECT 완성
-- JOIN OK WHERE OK
-- PRODUCTS CATEGORIES BRANDS   
-- PRODUCTS BRANDS brand_id
-- PRODUCTS CATEGORIES category_id

-- 테이블 간의 컬럼 연결은 보통 JOIN 형태를 쓰며, 2개 이상의 JOIN이 될 경우에는 WHERE 보다 JOIN을 써 주는 것이 좋다!

/* VIEW 생성하기 */
-- VIEW 의 경우에는 생성할 때 기존에 존재하는지 확인하고,
-- 존재할 경우에 대해 에러가 발생하지 않도록 설정할 수 있음
-- CREATE OR REPLACE VIEW  -> 새로운 VIEW로 존재한다면 기존 VIEW 테이블은 제거하고 덮어씌우기
CREATE VIEW category_brand AS
SELECT b.brand_name, b.brand_description, c.category_name, b.category_id
FROM BRANDS b
JOIN categories c ON b.category_id = c.category_id;

-- JOIN 형태로 데이터를 조회할 경우
-- Java 에서는 KEYWORD 라는 변수명으로 클라이언트가 HTML에서 작성한 데이터를
-- DB에 전달함
SELECT b.brand_name, b.brand_description, c.category_name, b.category_id
FROM BRANDS b
JOIN categories c ON b.category_id = c.category_id
WHERE b.brand_description = '%KEYWORD%'
AND b.brand_name = '%KEYWORD%'
AND c.category_name = '%KEYWORD%';

-- VIEW 를 사용하면: 조회할 때 JOIN을 하는 시간 소요 줄일 수 있음, alias 에 해당하는 제약설정을 하지 않아도 됨
SELECT * FROM category_brand;

-- 종합검색에서 AND 를 사용할 때: 검색결과를 좁히고 싶을 때 사용하는 용도
-- 특정 인물이나 사원을 조회할 때 사용
SELECT b.brand_name, b.brand_description, c.category_name, b.category_id
FROM category_brand
WHERE b.brand_description = '%KEYWORD%'
AND b.brand_name = '%KEYWORD%'
AND c.category_name = '%KEYWORD%';

-- 종합검색에서 OR 를 사용할 때: 검색결과 범위를 넓히고 싶을 때 사용
-- ex) 카테고리가 스마트폰이거나, 상품설명에 '전자'가 들어있는 제품들 모두 조회
-- 다양한 제품을 소비자들이 조회할 수 있도록 많은 상품을 보여줄 때 사용
SELECT b.brand_name, b.brand_description, c.category_name, b.category_id
FROM category_brand
WHERE b.brand_description = '%KEYWORD%'
OR b.brand_name = '%KEYWORD%'
OR c.category_name = '%KEYWORD%';

-- Java 에서 JOIN 관련 SQL문이 제일 힘듦..!

















