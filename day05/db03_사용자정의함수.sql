-- 사용자 정의함수. 내장함수 반대. 개발자가 직접만드는 함수
-- 저장프로시저와 유사. RETURNS, RETURN 키워드가 차이남
-- 1행 1열, 스칼라값 리턴
SELECT char_length('HELLO WORLD');

DELIMITER //
CREATE FUNCTION fnc_Interst(
	price INTEGER
) RETURNS INTEGER
BEGIN
	DECLARE myInterst	INTEGER;
    -- 가격이 3만원 이상이면 10%, 아니면 5%
    IF price >= 30000 THEN SET myInterst = price * 0.1;
    ELSE SET myInterst = price * 0.05;
    END IF;
    RETURN myInterst;
END;

-- 실행
SELECT custid, orderid, saleprice, fnc_Interst(saleprice) AS '이익금'
FROM Orders;