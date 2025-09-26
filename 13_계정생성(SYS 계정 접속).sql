-- SYS 계정 접속
/*
===========================================================
SYS 데이터베이스란?
SYSTEM 데이터베이스로, 시스템 성능을 모니터링하는 데이터베이스
===========================================================
*/

/*
최고 권한자가 계정을 생성하러 가는 방법
cmd(명령 프롬프트 창) 기준
mysql -u root -p
패스워드 입력: 처음에 설정해준 패스워드 입력

특정 호스트 지정 접속
mysql -h localhost -u root -p
최고권한자가 아닌, 특정 호스트로 접속


[계정 생성 문법]
CREATE USER '사용자명'@'호스트' IDENTIFIED BY '비밀번호';

1. 로컬 접속용 계정
-- 내 컴퓨터에서만 접속 가능
-- localhost에서만 접속 가능
CREATE USER 'john'@'localhost' IDENTIFIED BY 'mypassword123';


2. 원격 접속용 계정
-- 내 컴퓨터 이외 다른 IP(위치)에서 접속 가능
-- 모든 호스트에서 접속 가능
CREATE USER 'remote_user'@'%' IDENTIFIED BY 'remotepass456';

-- 특정 IP에서만 접속 가능
CREATE USER 'office_user'@'192.168.1.100' IDENTIFIED BY 'officepass';

-- 특정 IP 대역에서 접속 가능  -> 개발1팀 사용하는 IP 접속 허용과 같이, 팀이나 부서 단위별로 접속 제한 가능
CREATE USER 'network_user'@'192.168.1.%' IDENTIFIED BY 'networkpass';


3. 비밀번호 없이 접속하는 유저 GUEST 생성
CREATE USER 'guest'@'localhost';

만들어놓은 계정마다 접근, 작성할 수 있는 명령어 제한을 둘 수 있음.
*/

/* 계정 생성 */
CREATE USER 'john'@'localhost' IDENTIFIED BY 'mypassword123';
CREATE USER 'remote_user'@'%' IDENTIFIED BY 'remotepass456';
CREATE USER 'office_user'@'192.168.1.100' IDENTIFIED BY 'officepass';
CREATE USER 'network_user'@'192.168.1.%' IDENTIFIED BY 'networkpass';
CREATE USER 'guest'@'localhost';





















