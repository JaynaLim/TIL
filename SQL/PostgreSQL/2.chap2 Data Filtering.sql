SELECT
	*
FROM
	customer;

-----------------------------------------------

SELECT
	first_name,
	last_name,
	email
FROM
	customer;

-----------------------------------------------

SELECT
	a.first_name,
	a.last_name,
	a.email
FROM
	customer a;

-----------------------------------------------

SELECT
	first_name,
	last_name
FROM
	customer
ORDER BY
	first_name ASC;
	
-----------------------------------------------

select
	first_name,
	last_name
from
	customer
order by
	first_name desc;

------------------------------------------------

select
	first_name,
	last_name
from
	customer
order by
	first_name asc,
	last_name desc;

------------------------------------------------

select
	first_name,
	last_name
from
	customer
order by
	1 asc,
	2 desc ;
	

------------------------------------------------
--select distinct 확인용 테이블 만들기

create table T1 (ID SERIAL not null primary key,
BCOLOR VARCHAR,
FCOLOR VARCHAR);

insert
	into
	t1(bcolor,
	fcolor)
values 
('red',
'red'),
('red',
'red'),
('red',
null),
(null,
'red'),
('red',
'green'),
('red',
'blue'),
('green',
'red'),
('green',
'blue'),
('green',
'green'),
('blue',
'red'),
('blue',
'green'),
('blue',
'blue');


-------------------------------------------------------------------------
--만든 테이블 속성 확인
select * from t1;

-------------------------------------------------------------------------

SELECT
	DISTINCT BCOLOR
FROM
	T1
ORDER BY
	BCOLOR;
	
-------------------------------------------------------------------------
--BCOLOR 기준으로 중복이 제거된 결과를 보여줌( ASC 정렬되어 각 중복 행의 FCOLOR 마지막 값이 남게 됨)
SELECT
	DISTINCT ON
	(BCOLOR)BCOLOR,
	FCOLOR
FROM
	T1
ORDER BY
	BCOLOR,
	FCOLOR;
	
---------------------------------------------------------------------------
--BCOLOR 기준 중복제거 BUT FCOLOR 기준으로 이번에는 중복행의 FCOLOR 첫번재 값을 남김
SELECT
	DISTINCT ON
	(BCOLOR) BCOLOR,
	FCOLOR
FROM
	T1
ORDER BY
	BCOLOR,
	FCOLOR DESC;

---------------------------------------------------------------------------
--조건절 실습
SELECT
	LAST_NAME, --3
	FIRST_NAME
FROM
	CUSTOMER --1
WHERE
	FIRST_NAME = 'Jamie' --2
	AND LAST_NAME = 'Rice';
---------------------------------------------------------------------------

SELECT
	CUSTOMER_ID,
	AMOUNT,
	PAYMENT_DATE
FROM
	PAYMENT
WHERE
	AMOUNT <= 1
	OR AMOUNT >= 8;

---------------------------------------------------------------------------
-- LIMIT 예시
SELECT
	FILM_ID,
	TITLE,
	RELEASE_YEAR
FROM
	FILM
ORDER BY
	FILM_ID
LIMIT 5;

---------------------------------------------------------------------------
-- 4번째 행부터 결과 출력
SELECT
	FILM_ID,
	TITLE,
	RELEASE_YEAR
FROM
	FILM
ORDER BY
	FILM_ID
LIMIT 4 OFFSET 3;

---------------------------------------------------------------------------
SELECT
	FILM_ID,
	TITLE,
	RENTAL_RATE
FROM
	FILM
ORDER BY
	RENTAL_RATE DESC
LIMIT 100 OFFSET 5;

---------------------------------------------------------------------------
--FETCH문
SELECT
	FILM_ID,
	TITLE
FROM
	FILM
ORDER BY
	TITLE --TITLE로 정렬한 집합 중에 최초의 단 한 건을 RETURN
FETCH FIRST ROW ONLY;

---------------------------------------------------------------------------
SELECT
	FILM_ID,
	TITLE
FROM
	FILM
ORDER BY
	TITLE --TITLE로 정렬한 집합 중에 5건을 RETURN
FETCH FIRST 5 ROW ONLY;

--------------------------------------------------------------------------
SELECT
	FILM_ID,
	TITLE
FROM
	FILM
ORDER BY
	TITLE
	OFFSET 5 ROWS --0 1 2 3 4 5
FETCH FIRST 5 ROW ONLY;  -- FILM_ID 6번째부터 RETURN하게 됨

---------------------------------------------------------------------------
--IN 연산자 예제
SELECT
	CUSTOMER_ID,
	RENTAL_ID,
	RETURN_DATE
FROM
	RENTAL
WHERE
	CUSTOMER_ID IN (1, 2) --CUSTOMER_ID가 1 OR 2에 해당하는 행 출력
ORDER BY
	RETURN_DATE DESC;

---------------------------------------------------------------------------
--IN 연산자는 OR && = 과 같음
SELECT
	CUSTOMER_ID,
	RENTAL_ID,
	RETURN_DATE
FROM
	RENTAL
WHERE
	CUSTOMER_ID = 1
	OR CUSTOMER_ID = 2
ORDER BY
	RETURN_DATE DESC;

---------------------------------------------------------------------------
--NOT IN
SELECT
	CUSTOMER_ID,
	RENTAL_ID,
	RETURN_DATE
FROM
	RENTAL
WHERE
	CUSTOMER_ID NOT IN (1, 2)  --1,2를 제외한 나머지 전부
ORDER BY
	RETURN_DATE DESC;

---------------------------------------------------------------------------
SELECT
	CUSTOMER_ID,
	RENTAL_ID,
	RETURN_DATE
FROM
	RENTAL
WHERE
	CUSTOMER_ID <> 1
	AND CUSTOMER_ID <>2
ORDER BY
	RETURN_DATE DESC;

---------------------------------------------------------------------------
SELECT
	CUSTOMER_ID
FROM
	RENTAL
WHERE
	CAST (RETURN_DATE AS DATE) = '2005-05-27'; --RETURN_DATE를 DATE 현식으로 인식하고 이 값이 2005-05-27일 때의 CUSTOMER_ID 출력
	-- CAST는 데이터 타입을 변경하는 함수
---------------------------------------------------------------------------
--서브쿼리 예시
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER
WHERE
	CUSTOMER_ID IN ( --1을 만족하는 CUSTOMER_ID를 가진 CUSTOMER의 FIRST_NAME과 LAST_NAME 출력
	SELECT
		customer_id
	FROM
		rental
	WHERE
		CAST (RETURN_DATE AS DATE) = '2005-05-27'); --1) RETURN_DATE가 해당 날짜인 CUSTOMER_ID
---------------------------------------------------------------------------
--BETWEEN 예제
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT
FROM
	PAYMENT
WHERE
	AMOUNT BETWEEN 8 AND 9;

----------------------------------------------------------------------------
-- BETWEEN은 AND연산자로 다시 표현 가능 (근데 BETWEEN보다 이게 더 빠르다고 나오네..?  -> 가독성 측면에서 BETWEEN이 우위)
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT
FROM
	PAYMENT
WHERE AMOUNT >= 8
AND AMOUNT <= 9;

----------------------------------------------------------------------------
--NOT BETWEEN 예제
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT
FROM
	PAYMENT
WHERE
	AMOUNT NOT BETWEEN 8 AND 9;

-----------------------------------------------------------------------------
--NOT BETWEEN은 OR연산자로 다시 표현 가능
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT
FROM
	PAYMENT
WHERE AMOUNT < 8 OR AMOUNT > 9;

-----------------------------------------------------------------------------
--일자비교 예제
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT,
	PAYMENT_DATE
FROM
	PAYMENT
WHERE
	CAST(PAYMENT_DATE AS DATE) BETWEEN '2007-02-07' AND '2007-02-15';
	
------------------------------------------------------------------------------
--PAYMENT_DATE를 날짜형으로 바꾸지 않고 지정된 형식의 문자열로 변환해서 해당 값만 볼 수 있다.(to_char이지만 날짜형으로 인식되나봄?)
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT,
	PAYMENT_DATE
FROM
	PAYMENT
WHERE to_char(PAYMENT_DATE, 'yyyy-mm-dd') BETWEEN '2007-02-07' AND '2007-02-15'; 

------------------------------------------------------------------------------
--DATE타입으로 완전히 바꾸면 시/분/초가 생기지만, to_char함수로 바꾸면 내가 지정한 형식의 값만 남음 (yyyy-mm으로 설정시 달까지만 남음)
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT,
	PAYMENT_DATE, to_char(PAYMENT_DATE, 'yyyy-mm-dd'), CAST(PAYMENT_DATE AS DATE)
FROM
	PAYMENT
WHERE to_char(PAYMENT_DATE, 'yyyy-mm-dd') BETWEEN '2007-02-07' AND '2007-02-15'; 

-------------------------------------------------------------------------------
--LIKE 예제
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER
WHERE
	FIRST_NAME LIKE 'Jen%';  --first_name 이 Jen으로 시작되는 모든 행 출력
	
-------------------------------------------------------------------------------
--LIKE 예제
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER
WHERE
	FIRST_NAME LIKE '%er%';  -- first_name 에 er이 들어가는 모든 행 출력

-------------------------------------------------------------------------------
--LIKE 예제
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER
WHERE
	FIRST_NAME NOT LIKE 'Jen%'; --first_name 이 Jen으로 시작하지 않는 모든 행 출력
	
-------------------------------------------------------------------------------
--ISNULL 실습 테이블 생성
CREATE TABLE CONTACTS
(ID INT GENERATED BY DEFAULT AS IDENTITY,
FIRST_NAME VARCHAR(50) NOT NULL,  --NOTNULL로 치면 오류가 뜨는데 , NOT NULL이랑 NOTNULL 차이가 뭘까?
LAST_NAME VARCHAR(50) NOT NULL, 
EMAIL VARCHAR(255) NOT NULL, 
PHONE VARCHAR(15),
PRIMARY KEY(ID)
);

INSERT
	INTO
	CONTACTS(FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE)
VALUES ('John',
'Doe',
'John.doe@example.com',
NULL), 
('Lily',
'Bush',
'lily.bush@example.com',
'(408-234-2764');

COMMIT;

-----------------------------------------------------------------------------
--IS NULL 예제  (=NULL로 하면 NULL값 못 찾음)
SELECT
	ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE
FROM
	CONTACTS
WHERE
	PHONE = NULL;

-----------------------------------------------------------------------------
--IS NULL 예제2 (IS NULL로 해야 NULL값 출력됨)
SELECT
	ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE
FROM
	CONTACTS
WHERE
	PHONE IS NULL;

-----------------------------------------------------------------------------
--IS NOT NULL 예제
SELECT
	ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE
FROM
	CONTACTS
WHERE PHONE IS NOT NULL;

-----------------------------------------------------------------------------
------------------------------CHAP2 실습문제(1)--------------------------------
--PAYMENT 테이블에서 단일 거래의 AMOUNT 액수가 가장 많은 고객들의 CUSTOMER_ID를 추출하라. 단, CUSTOMER_ID값은 유일해야 함--
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
SELECT DISTINCT customer_id 
FROM PAYMENT
WHERE amount =  (  -- IN 을 =으로 바꿔도 되네
	SELECT amount 
	FROM payment
	ORDER BY amount DESC LIMIT 1);


--강사 답안 (더 가독성 있게)
SELECT
	DISTINCT p.customer_id
FROM
	payment p
WHERE
	p.amount = (
	SELECT
		k.amount
	FROM
		payment k
	ORDER BY
		amount DESC
	LIMIT 1);

------------------------------------------------------------------------------
-------------------------------CHAP2 실습문제(2)--------------------------------
--고객들에게 단체 이메일을 전송하고자 한다. CUSTOMER 테이블에서 고객의 EMAIL 주소를 추출하고, 이메일 형식에 맞지 않는 이메일 주소는 제외시켜라--
--단, 이메일 형식은 '@'가 존재해야 하고, '@'로 시작하지 말아야 하고 '@'로 끝나지 말아야 한다--
------------------------------------------------------------------------------
------------------------------------------------------------------------------
SELECT c.email 
FROM customer c
WHERE c.email LIKE '_%@%_' AND c.email NOT LIKE '@%' AND c.email NOT LIKE '%@';

--강사 답안과 같음