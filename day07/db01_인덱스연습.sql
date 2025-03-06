-- 기존 테이블 삭제
DROP TABLE IF EXISTS NewBook;

-- 테이블 생성
CREATE TABLE NewBooK(
	bookid INT AUTO_INCREMENT PRIMARY KEY,
    bookname VARCHAR(100),
    publisher VARCHAR(100),
    price INT
);

-- 500만건 더미데이터 생성 설정
SET SESSION CTE_MAX_RECURSION_DEPTH = 5000000;

-- 더미데이터 생성
INSERT INTO NewBooK (bookname, publisher, price)
WITH RECURSIVE CTE(n) AS
(
	SELECT 1
    UNION ALL
    SELECT n+1 FROM CTE WHERE n < 5000000
)
SELECT CONCAT('Book', lpad(n, 7, '0')) -- Book0002104
	 , CONCAT('Comp', lpad(n, 7, '0')) -- Comp5000000
     , FLOOR(3000 + rand() * 30000) AS Price -- 책 가격 3000~33000원
FROM CTE;

-- 데이터 확인
SELECT COUNT(*) FROM NewBooK;

-- 가격을 7개 정도 검색할 수 있는 쿼리 작성
SELECT * FROM NewBooK	
 WHERE price IN (8377, 14567, 24500, 33000, 5600, 6700, 15000);

-- 인덱스 생성
CREATE INDEX idx_book ON NewBooK(price);


