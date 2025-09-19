/********************
SUBQUERY (서브쿼리)
하나의 SQL문 안에 포함된 또다른 SQL문
메인쿼리(기존쿼리)를 위해 보조 역할을 하는 쿼리문
- SELECT, FROM, WHERE, HAVING 절에서 사용가능


********************/

USE delivery_app;
SELECT * FROM stores;
SELECT * FROM menus;

-- ==============================
-- 1. 기본 서브쿼리 (단일행)
-- ==============================

-- 가장 비싼 메뉴 찾기
-- 1단계 : 최고 가격 찾기
SELECT max(price) FROM menus; -- 38900원

-- 2단계 : 그 가격인 메뉴 찾기
SELECT name, price
FROM menus
WHERE price = 38900;

-- 1단계와 2단계를 조합해서 한 번에 비싼 메뉴 찾기를 진행해보자
SELECT name, price
FROM menus
WHERE price = (SELECT max(price) FROM menus);

/*
stores
id, name, category, address, phone, rating, delivery_fee

menus
id, store_id, name, description, price, is_popular
*/

/* 퀴즈 */
-- 1단계 : 평균 메뉴들의 가격 조회
SELECT AVG(price)
FROM menus;

-- 2단계 : 그 가격인 메뉴 찾기
SELECT name, price
FROM menus
WHERE price >= 15221.4286;

-- 1단계와 2단계를 조합해서 평균보다 비싼 메뉴들만 조회
-- WHERE 절에 price를 기준으로 평균보다 비싼 메뉴들만 조회하는 조건
SELECT name, price
FROM menus
WHERE price >= (SELECT AVG(price) FROM menus);


/* 문제2 */
-- 평점이 가장 높은 매장 찾기
-- 1단계 : 최고 평점 찾기
SELECT MAX(rating) FROM stores; -- 4.9
-- 2단계 : 최고 평점인 매장 찾기
SELECT name, rating
FROM stores
WHERE rating = 4.9;
-- 1단계와 2단계를 조합하여 한 번에 평점 최고인 매장을 조회
SELECT name, rating
FROM stores
WHERE rating = (SELECT MAX(rating) FROM stores);

-- 배달비가 가장 비싼 매장 찾기 stores
-- 1단계: 가게에서 최고로 비싼 배달비 가격을 조회
SELECT MAX(delivery_fee) FROM stores; -- 5500
-- 2단계: 가격이 최고로 비싼 배달비의 매장 명칭과 배달비, 카테고리 조회
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee = 5500;
-- 1단계와 2단계를 조합하여 한 번에 가장 비싼 배달비 가격을 조회하고, 매장의 명칭, 배달비, 카테고리 조회
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee = (SELECT MAX(delivery_fee) FROM stores);

























