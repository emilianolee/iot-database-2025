-- 1번
SELECT Email
	 , Mobile
     , Names
     , Addr
  FROM membertbl;

-- 2번 
SELECT Names AS '도서명'
	 , Author AS '저자'
     , ISBN
     , Price AS '정가'
  FROM bookstbl
 ORDER BY ISBN;

-- 3번
select m.Names as '비대여자명'
	 , m.levels as '등급'
     , m.Addr as '주소'
     , r.rentalDate as '대여일'
  from rentaltbl as r right join membertbl as m on m.Idx = r.memberIdx
 where r.memberIdx is Null
 order by m.levels, m.Names;
 
-- 4번
select ifnull(divtbl.Names, '--합계--') as '장르'
	 , concat(format(SUM(bookstbl.Price),0), '원') as '총합계금액'
  FROM bookstbl LEFT join divtbl on bookstbl.Division = divtbl.Division
 group by divtbl.Names
  with rollup;
  