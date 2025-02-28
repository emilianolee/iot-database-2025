-- 행번호
-- 4-11 고객 목록에서 고개번호, 이름, 전화번호를 앞의 2명만 나타내시오.
SET @seq := 0;	-- 변수선언 SET시작하고 @를 붙임. 값할당이 =이 아니고 :=

SELECT (@seq := @seq + 1) AS '행번호'
			, custid
			, name
            , phone
	FROM Customer
 WHERE @seq < 2;


SELECT (@seq := @seq + 1) AS '행번호'
			, custid
			, name
            , phone
	FROM Customer LIMIT 2;	-- 순차적인 일부데이터 추출에는 훨씬 탁월

-- 특정범위 추출, 3번째 다음행부터 2개를 추출
SELECT custid
			, name
            , phone
	FROM Customer LIMIT 2 OFFSET 3;