CREATE DATABASE IF NOT EXISTS delivery_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE delivery_db;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `REVIEWS`;
DROP TABLE IF EXISTS `ORDER_ITEMS`;
DROP TABLE IF EXISTS `ORDERS`;
DROP TABLE IF EXISTS `MENUS`;
DROP TABLE IF EXISTS `STORES`;
DROP TABLE IF EXISTS `CATEGORIES`;
DROP TABLE IF EXISTS `CUSTOMERS`;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `CUSTOMERS` (
  `customer_id` INT AUTO_INCREMENT,
  `customer_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(20) UNIQUE,
  `address` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `CATEGORIES` (
  `category_id` INT AUTO_INCREMENT,
  `category_name` VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `STORES` (
  `store_id` INT AUTO_INCREMENT,
  `store_name` VARCHAR(100) NOT NULL,
  `category_id` INT NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(20),
  `description` TEXT,
  `min_order_amount` INT DEFAULT 0,
  `delivery_fee` INT,
  `rating` DECIMAL(2,1),
  `opening_hours` VARCHAR(100),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`store_id`),
  FOREIGN KEY (`category_id`) REFERENCES `CATEGORIES` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `MENUS` (
  `menu_id` INT AUTO_INCREMENT,
  `store_id` INT NOT NULL,
  `menu_name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `price` INT NOT NULL,
  `is_popular` BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (`menu_id`),
  FOREIGN KEY (`store_id`) REFERENCES `STORES` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ORDERS` (
  `order_id` INT AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `order_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `order_status` ENUM('Pending', 'Cooking', 'Delivering', 'Delivered', 'Cancelled') NOT NULL,
  `total_price` INT NOT NULL,
  `delivery_address` VARCHAR(255) NOT NULL,
  `customer_request` VARCHAR(255),
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMERS` (`customer_id`),
  FOREIGN KEY (`store_id`) REFERENCES `STORES` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ORDER_ITEMS` (
  `order_item_id` INT AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price_at_order` INT NOT NULL,
  PRIMARY KEY (`order_item_id`),
  FOREIGN KEY (`order_id`) REFERENCES `ORDERS` (`order_id`) ON DELETE CASCADE,
  FOREIGN KEY (`menu_id`) REFERENCES `MENUS` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `REVIEWS` (
  `review_id` INT AUTO_INCREMENT,
  `order_id` INT NOT NULL UNIQUE,
  `customer_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `rating` TINYINT NOT NULL,
  `comment` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  FOREIGN KEY (`order_id`) REFERENCES `ORDERS` (`order_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMERS` (`customer_id`),
  FOREIGN KEY (`store_id`) REFERENCES `STORES` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `CUSTOMERS` (`customer_name`, `email`, `password`, `phone`, `address`) VALUES
('김철수', 'chulsoo.kim@naver.com', 'pw123a', '010-1111-2222', '서울시 강남구 테헤란로 123'),
('박영희', 'y.park@gmail.com', 'pass1b', '010-3333-4444', '서울시 서초구 서초대로 456'),
('이민준', 'minjun.lee@kakao.com', 'key12c', '010-5555-6666', '서울시 송파구 올림픽로 789'),
('최지우', 'jiwoo.choi@nate.com', 'login4', NULL, '경기도 성남시 분당구 판교역로 101'),
('정다은', 'daeun.jung@gmail.com', 'secr3t', '010-7777-8888', '서울시 마포구 양화로 246'),
('윤서준', 'seojun.yoon@naver.com', 'user5f', '010-9999-0000', '서울시 강남구 압구정로 111'),
('한지민', 'jimin.han@hotmail.com', 'data6g', '010-1234-5678', '서울시 용산구 이태원로 55'),
('강현우', 'hyunwoo.kang@gmail.com', 'code7h', NULL, '경기도 수원시 영통구 광교중앙로 10');

INSERT INTO `CATEGORIES` (`category_name`) VALUES ('Chicken'), ('Korean'), ('Chinese'), ('Japanese'), ('Pizza'), ('Bunsik'), ('Cafe/Dessert');

INSERT INTO `STORES` (`store_name`, `category_id`, `address`, `phone`, `description`, `min_order_amount`, `delivery_fee`, `rating`, `opening_hours`) VALUES
('BHC치킨 역삼점', 1, '서울시 강남구 역삼동 123-4', '02-555-1234', '언제나 맛있는 BHC치킨입니다!', 16000, 3000, 4.8, '매일 11:00 - 23:00'),
('전주현대옥 선릉점', 2, '서울시 강남구 대치동 567-8', '02-555-5678', '따뜻한 국밥 한 그릇 생각날 때 찾아주세요.', 14000, 3500, 4.9, '매일 08:00 - 22:00'),
('홍콩반점0410 강남역점', 3, '서울시 서초구 서초동 910-11', NULL, '백종원의 믿고 먹는 중화요리 전문점', 13000, 4000, 4.6, '매일 10:00 - 21:30'),
('아비꼬 카레 잠실점', 4, '서울시 송파구 잠실동 121-31', '02-414-1213', '100시간 정성으로 만든 일본식 카레 전문점. 매운맛 조절 가능!', 15000, 3000, 4.7, '매일 11:30 - 22:00'),
('도미노피자 서초점', 5, '서울시 서초구 방배동 415-1', '02-588-3082', NULL, 17000, 0, 4.8, '매일 11:00 - 22:30'),
('동대문엽기떡볶이 신림점', 6, '서울시 관악구 신림동 161-71', '02-888-8282', '화끈하게 매운 맛이 땡길 땐 엽떡!', 14000, 3000, 4.5, '매일 12:00 - 24:00'),
('스타벅스 판교점', 7, '경기도 성남시 분당구 삼평동 181-9', '031-701-1819', '스페셜티 커피와 함께하는 휴식', 12000, 4000, 4.9, '매일 07:00 - 22:00');

INSERT INTO `MENUS` (`store_id`, `menu_name`, `description`, `price`, `is_popular`) VALUES
(1, '뿌링클', '마법의 치즈 시즈닝이 가득! BHC의 시그니처 메뉴', 21000, TRUE),
(1, '맛초킹', '숙성간장과 꿀로 만든 오리엔탈 소스 치킨', 21000, TRUE),
(1, '달콤바삭 치즈볼', NULL, 5000, TRUE),
(2, '전주끓이는식콩나물국밥', '남부시장식과 달리 펄펄 끓여나오는 뜨거운 국밥', 8000, TRUE),
(2, '오징어튀김', '바삭하게 튀겨낸 별미 오징어튀김', 12000, FALSE),
(3, '짜장면', '백종원 대표의 비법이 담긴 기본 짜장면', 6000, TRUE),
(3, '탕수육', '쫄깃하고 바삭한 찹쌀 탕수육', 14000, TRUE),
(4, '허브치킨카레라이스', '부드러운 닭다리살과 향긋한 허브의 만남', 10500, TRUE),
(4, '포크세트', '돈까스, 카레, 밥, 샐러드로 구성된 푸짐한 세트', 14000, FALSE),
(5, '블랙타이거 슈림프 피자 (L)', '탱글한 식감의 블랙타이거 슈림프가 듬뿍', 35900, TRUE),
(5, '포테이토 피자 (L)', NULL, 27900, TRUE),
(6, '엽기떡볶이', '오리지널 매운맛 떡볶이. 치즈, 햄, 오뎅 포함', 14000, TRUE),
(6, '주먹김밥', '매운맛을 중화시켜주는 고소한 주먹밥', 2000, TRUE),
(7, '아이스 아메리카노', '가장 신선한 원두로 내린 시원한 아메리카노', 4600, TRUE),
(7, '부드러운 생크림 카스텔라', '촉촉한 카스텔라 속에 부드러운 생크림이 가득', 4500, FALSE);

INSERT INTO `ORDERS` (`customer_id`, `store_id`, `order_status`, `total_price`, `delivery_address`, `customer_request`) VALUES
(1, 1, 'Delivered', 29000, '서울시 강남구 테헤란로 123', '문 앞에 두고 벨 눌러주세요.'),
(2, 3, 'Delivered', 24000, '서울시 서초구 서초대로 456', '단무지 많이 주세요.'),
(3, 5, 'Delivered', 35900, '서울시 송파구 올림픽로 789', NULL),
(4, 6, 'Delivering', 19000, '경기도 성남시 분당구 판교역로 101', '덜 맵게 해주세요!'),
(5, 4, 'Delivered', 27500, '서울시 마포구 양화로 246', '아기신 단계로 해주세요.'),
(6, 2, 'Cancelled', 23500, '서울시 강남구 압구정로 111', '수저 빼주세요.'),
(7, 7, 'Delivered', 13100, '서울시 용산구 이태원로 55', '빨대 2개 부탁드려요.'),
(8, 1, 'Cooking', 24000, '경기도 수원시 영통구 광교중앙로 10', NULL),
(1, 6, 'Delivered', 19000, '서울시 강남구 테헤란로 123', '가장 맵게 해주세요!');

SET @o1 = 1;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o1, 1, 1, 21000), (@o1, 3, 1, 5000);
INSERT INTO `REVIEWS` (`order_id`, `customer_id`, `store_id`, `rating`, `comment`) VALUES (@o1, 1, 1, 5, '역시 뿌링클은 진리입니다. 배달도 빠르고 맛있었어요!');

SET @o2 = 2;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o2, 6, 1, 6000), (@o2, 7, 1, 14000);
INSERT INTO `REVIEWS` (`order_id`, `customer_id`, `store_id`, `rating`, `comment`) VALUES (@o2, 2, 3, 4, '짜장면은 괜찮았는데 탕수육이 조금 식어서 왔네요. 그래도 맛있게 먹었습니다.');

SET @o3 = 3;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o3, 10, 1, 35900);
INSERT INTO `REVIEWS` (`order_id`, `customer_id`, `store_id`, `rating`, `comment`) VALUES (@o3, 3, 5, 5, '도미노피자는 배달비가 없어서 좋네요! 피자도 따뜻하고 맛있었습니다.');

SET @o4 = 4;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o4, 12, 1, 14000), (@o4, 13, 1, 2000);

SET @o5 = 5;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o5, 8, 1, 10500), (@o5, 9, 1, 14000);
INSERT INTO `REVIEWS` (`order_id`, `customer_id`, `store_id`, `rating`, `comment`) VALUES (@o5, 5, 4, 5, '카레 너무 맛있어요! 항상 여기서만 시켜 먹습니다.');

SET @o6 = 6;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o6, 4, 1, 8000), (@o6, 5, 1, 12000);

SET @o7 = 7;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o7, 14, 2, 4600), (@o7, 15, 1, 4500);
INSERT INTO `REVIEWS` (`order_id`, `customer_id`, `store_id`, `rating`, `comment`) VALUES (@o7, 7, 7, 5, '커피가 식지 않고 빨리 와서 좋았어요.');

SET @o8 = 8;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o8, 2, 1, 21000);

SET @o9 = 9;
INSERT INTO `ORDER_ITEMS` (`order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES (@o9, 12, 1, 14000), (@o9, 13, 1, 2000);
INSERT INTO `REVIEWS` (`order_id`, `customer_id`, `store_id`, `rating`, `comment`) VALUES (@o9, 1, 6, 3, '너무 매워서 다 못 먹었어요 ㅠㅠ 그래도 스트레스는 풀리네요');

COMMIT;