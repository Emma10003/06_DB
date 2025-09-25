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

SELECT b.brand_name, b.brand_description, c.category_name
FROM brands b, categories c
WHERE b.brand_name = ;






























