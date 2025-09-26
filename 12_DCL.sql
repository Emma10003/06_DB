/*
DCL(Data Control Language)
데이터베이스의 접근 권한을 제어하는 SQL 명령어
주로 사용자 권한 관리와 보안 설정에 사용됨.

GRANT - 권한 부여
		사용자에게 특정 권한을 부여할 때 사용
        [기본 문법]
        GRANT 권한종류 ON 데이터베이스명.테이블 TO '사용자'@'호스트';
        
REVOKE - 권한 회수
		 사용자로부터 특정 권한을 회수할 때 사용
         [기본 문법]
         REVOKE 권한종류 ON 데이터베이스명.테이블 FROM '사용자'@'호스트';
*/

CREATE USER 'john'@'localhost' IDENTIFIED BY 'mypassword123';
CREATE USER 'remote_user'@'%' IDENTIFIED BY 'remotepass456';
CREATE USER 'office_user'@'192.168.1.100' IDENTIFIED BY 'officepass';
CREATE USER 'network_user'@'192.168.1.%' IDENTIFIED BY 'networkpass';
CREATE USER 'guest'@'localhost';

-- 5.7 버전은 아래 명령어가 가능
-- 8.0 버전 이상부터는 아래 명령어가 불가능
-- guest 라는 유저가 어느 범위까지 IP로 접속할 수 있는 유저인지를 반드시 명시해야 함.
GRANT SELECT ON tje.employees TO 'guest';  -- error 1410 권한을 생성할 수 없음.
-- 권한 회수
REVOKE SELECT ON tje.employees FROM 'guest';

-- DATABASE tje 에서 employees 테이블만 SELECT 제공
-- guset 에게 SELECT 권한 부여
GRANT SELECT ON tje.employees TO 'guest'@'localhost';
-- 권한 회수
REVOKE SELECT ON tje.employees FROM 'guest'@'localhost';

-- office_user 에게 SELECT, INSERT, UPDATE 권한 동시 부여
-- 조회, 수정, 저장은 가능하나 삭제가 불가능한 유저
GRANT SELECT, INSERT, UPDATE ON tje.employees TO 'office_user'@'192.168.1.100';
-- 권한 회수
REVOKE SELECT, INSERT, UPDATE ON tje.employees FROM 'office_user'@'192.168.1.100';

-- network_user 에게 SELECT, INSERT, UPDATE 권한 동시 부여
-- tje 데이터베이스에서 모든 테이블에 접근 권한이 있는 유저
-- 조회, 수정, 저장은 가능하나 삭제가 불가능한 유저
GRANT SELECT, INSERT, UPDATE ON tje.* TO 'network_user'@'192.168.1.%';
-- 권한 회수
REVOKE SELECT, INSERT, UPDATE ON tje.employees FROM 'network_user'@'192.168.1.%';

-- 모든 권한 부여
-- 회사에 존재하는 모든 데이터베이스, 모든 테이블에 접근 권한이 있는 유저
-- 조회, 수정, 저장, 삭제까지 모든 게 가능한 유저
GRANT ALL PRIVILEGES ON *.* TO 'remote_user'@'%';
-- 권한 회수
REVOKE ALL PRIVILEGES ON *.* FROM 'remote_user'@'%';

-- 모든 권한을 준 후 권한 적용을 하지 않으면 GRANT 로 부여한 권한이 의미 없어짐
FLUSH PRIVILEGES;

















