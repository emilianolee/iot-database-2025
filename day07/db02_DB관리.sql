-- 데이터베이스 관리 쿼리
SHOW DATABASES;

-- information_schema, performance_schema, mysql 등은 시스템 DB라서 개발자, DBA 사용하는게 아님
USE madang;

-- 하나의 DB내 존재하는 테이블들 확인
SHOW TABLES;

-- 테이블의 구조
desc madang.NewBooK;

SELECT * FROM v_orders;

-- 사용자 추가
-- madang 데이터베이스만 접근할 수 있는 사용자 madang 생성
-- 내부접속용
CREATE USER madang@localhost IDENTIFIED BY 'madang';
-- 외부접속용
CREATE USER madang@'%' IDENTIFIED BY 'madang';

-- DCL: GRANT, REVOKE
-- 데이터 삽입, 조회, 수정만 권한을 부여
GRANT SELECT, INSERT, UPDATE ON madang.* to madang@localhost with grant option;
GRANT SELECT, INSERT, UPDATE ON madang.* to madang@'%' with grant option;

-- 사용자 madang에게 madangDB를 사용할 수 있는 모든 권한 부여
GRANT ALL PRIVILEGES ON madang.* to madang@localhost with grant option;
GRANT ALL PRIVILEGES ON madang.* to madang@'%' with grant option;
FLUSH PRIVILEGES;

-- 권한해제
-- madang사용자의 권한 중 select 권한만 제거
REVOKE SELECT ON madang.* FROM madang@localhost;
REVOKE ALL PRIVILEGES on madang.* FROM madang@localhost;
REVOKE ALL PRIVILEGES on madang.* FROM madang@'%';
FLUSH PRIVILEGES;