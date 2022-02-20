--------------------------------------------------------------------------
-- UNION연산 예제 테이블 만들기
CREATE TABLE SALES2007_1
(
	NAME VARCHAR(50),
	AMOUNT NUMERIC(15,2)
);

INSERT INTO SALES2007_1
VALUES
  ('Mike', 150000.25)
 ,('Jon', 132000.75)
 ,('Mary', 100000)
;
COMMIT;

CREATE TABLE SALES2007_2
(
  NAME VARCHAR(50)
 ,AMOUNT NUMERIC(15,2)
);

INSERT INTO SALES2007_2
VALUES
  ('Mike', 120000.25)
 ,('Jon', 142000.75)
 ,('Mary', 100000)
;

COMMIT;

-----------------------------------------------------------------------
-- UNION 예제 (공통 중복값이 제거되고 5개 행만 출력됨)
SELECT
	*
FROM
	SALES2007_1
UNION
SELECT
	*
FROM
	SALES2007_2 
;


-- 특정 COLUMN만 SELECT & UNION하기 (중복값 없이 3개 행만 출력됨)
SELECT
	NAME
FROM
	SALES2007_1
UNION
SELECT
	NAME
FROM
	SALES2007_2;
	
-- 특정 COLUMN만 SELECT & UNION (중복값 없이 5개 행만 출력됨)
SELECT
	AMOUNT
FROM
	SALES2007_1
UNION
SELECT
	AMOUNT
FROM
	SALES2007_2;
	
-- ORDER BY 적용 시 UNION되는 마지막 SELECT 문에 기재한다.
SELECT
	*
FROM
	SALES2007_1
UNION
SELECT
	*
FROM
	SALES2007_2
ORDER BY
	AMOUNT DESC;

--------------------------------------------------------
--UNION ALL (중복까지 함께 출력)
SELECT
	AMOUNT
FROM
	SALES2007_1
UNION ALL
SELECT
	AMOUNT
FROM
	SALES2007_2;

--UNION ALL & ORDER BY
SELECT
	*
FROM
	SALES2007_1
UNION ALL
SELECT
	*
FROM
	SALES2007_2
ORDER BY
	AMOUNT DESC;
	
---------------------------------------------------------------------------------
--INTERSECT 예제 테이블 만들기
CREATE TABLE EMPLOYEES
(
  EMPLOYEE_ID SERIAL PRIMARY KEY
  ,
EMPLOYEE_NAME VARCHAR (255) NOT NULL
);

CREATE TABLE KEYS
(
  EMPLOYEE_ID INT PRIMARY KEY,
  EFFRECTIVE_DATE DATE NOT NULL,
  FOREIGN KEY (EMPLOYEE_ID)
  REFERENCES EMPLOYEES (EMPLOYEE_ID)
);

CREATE TABLE HIPOS
(
EMPLOYEE_ID INT PRIMARY KEY,
EFFECTIVE_DATE DATE NOT NULL,
FOREIGN KEY (EMPLOYEE_ID)
REFERENCES EMPLOYEES (EMPLOYEE_ID)
);

INSERT
	INTO
	EMPLOYEES (EMPLOYEE_NAME)
VALUES
('Joyce Edwards'),
('Diane Collins'),
('Alice Stewart'),
('Julie Sanchez'),
('Heather Morris'),
('Teresa Rogers'),
('Doris Reed'),
('Gloria Cook'),
('Evelyn Morgan'),
('Jean Bell')

COMMIT;

INSERT
	INTO
	KEYS
VALUES
(1,'2000-02-01'),
(2,'2001-06-01'),
(5,'2002-01-01'),
(7,'2005-06-01')

COMMIT;

INSERT
	INTO
	HIPOS
VALUES
(9,'2000-01-01'),
(2,'2002-06-01'),
(5,'2006-06-01'),
(10,'2005-06-01');

COMMIT;

-----------------------------------------------------------------
--INTERSECT 연산 실습 (교집합 출력)
SELECT
	EMPLOYEE_ID
FROM
	KEYS
INTERSECT
SELECT
	EMPLOYEE_ID
FROM
	HIPOS
ORDER BY EMPLOYEE_ID;

--INNER JOIN으로 다시 표현 (실무에서는 INTERSECT보다 INNER JOIN을 더 많이 씀)
---성능적으로도 INNER JOIN이 더 좋은 성능을 보일 수 있음
SELECT A.EMPLOYEE_ID
FROM KEYS A
INNER JOIN HIPOS B
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
ORDER BY A.EMPLOYEE_ID DESC;

--WHERE 절 이용시
SELECT A.EMPLOYEE_ID
FROM KEYS A, HIPOS B
WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID
ORDER BY A.EMPLOYEE_ID DESC;

-------------------------------------------------------------------------------------
--EXCEPT 연산 예제 (dvdrental 테이블 사용)
SELECT * FROM INVENTORY LIMIT 10; --재고 데이터
SELECT * FROM FILM LIMIT 10; --모든 영화 아이디와 제목 정보

--이때 필름:인벤토리 는 1:n관계에 해당. 필름에 영화와 영화 id는 고유한 한개씩 들어있으나, inventory에는 한 영화에 대해 여러개의 재고 상태가 들어있음

SELECT
	DISTINCT INVENTORY.FILM_ID, --inventory와 film테이블에 동시에 들어있는 고유한 film_id를 출력
	TITLE
FROM
	INVENTORY
INNER JOIN FILM ON
	FILM.FILM_ID = INVENTORY.FILM_ID  
ORDER BY
	TITLE;

--그럼 재고가 존재하지 않는 영화는 어떻게 출력하는가? 이 때 intersect를 쓸 수 있음
--film.film_id - inventory.film_id의 집합을 계산

SELECT -- 전체 FILM (중복값 없음)
	FILM_ID,
	TITLE
FROM
	FILM
EXCEPT
SELECT --재고가 존재하는 FILM 집합
	DISTINCT INVENTORY.FILM_ID,
	TITLE
FROM
	INVENTORY
INNER JOIN FILM ON
	FILM.FILM_ID = INVENTORY.FILM_ID
ORDER BY
	TITLE;
	
-- A-B의 B에 중복이 들어가있으면 안되나 확인해봄. (확인 결과 아래 코드도 동작함. 굳이 DISTINCT를 안 써도 됨.. )
SELECT -- 전체 FILM (중복값 없음)
	FILM_ID,
	TITLE
FROM
	FILM
EXCEPT
SELECT --재고가 존재하는 FILM 집합
	INVENTORY.FILM_ID,
	TITLE
FROM
	INVENTORY
INNER JOIN FILM ON
	FILM.FILM_ID = INVENTORY.FILM_ID
ORDER BY
	TITLE;
	
-------------------------------------------------------------------------------------------
--중첩 서브쿼리 예시 
--RENTAL_RATE가 평균값보다 큰 FILM을 구하고 싶다!
SELECT
	FILM_ID,
	TITLE,
	RENTAL_RATE
FROM
	FILM
WHERE
	RENTAL_RATE > 
(
	SELECT
		AVG(RENTAL_RATE)
	FROM
		FILM
);

--인라인 뷰 예시(FROM 절에서 서브쿼리를 만듦)
SELECT
	A.FILM_ID,
	A.TITLE,
	A.RENTAL_RATE
FROM
	FILM A,
	(
	SELECT
		AVG(RENTAL_RATE) AS AVG_RENTAL_RATE
	FROM
		FILM) B
WHERE
	A.RENTAL_RATE > B.AVG_RENTAL_RATE;
	
--스칼라 서브쿼리 예시(SELECT문 리스트에서 서브쿼리를 만듦)
SELECT
	A.FILM_ID,
	A.TITLE,
	A.RENTAL_RATE
FROM
	( --인라인 뷰에 해당  
	SELECT
		A.FILM_ID,
		A.TILTE,
		A.RENTAL_RATE,
		( --스칼라 서브쿼리 사용
		SELECT
			AVG(L.RENTAL_RATE)
			FROM FILM L 
		)AS AVG_RENTAL_RATE  -- 스칼라 서브쿼리 끝
		FROM
			FILM A 
		) A --인라인 뷰 끝
	WHERE
		A.RENTAL_RATE > A.AVG_RENTAL_RATE;

----------------------------------------------------------------------------------
--ANY 연산자 실습
--영화 카테고리별 상영시간이 가장 긴 영화들의 영화이름을 구하기 =>근데 이렇게 짜면 카테고리에서 가장 길지 않아도 뽑히게 될 거 같음. 강사가 문제를 잘못 설명했음.
	--카테고리별 상영시간이 가장 긴 영화들의 상영시간과 같거나 상영시간이 더 큰 영화를 구하는 쿼리로 설명하는 게 맞음
SELECT
	TITLE,
	LENGTH
FROM
	FILM
WHERE LENGTH >= ANY (  --ANY가 없으면 서브쿼리의 결과는 CATEGORY별로 16개가 되게 되는데, LENGTH가 16개의 값과 한번에 비교할 수 있는 방법이 없기 때문에 오류가 난다
	SELECT
		MAX(LENGTH)
	FROM FILM A, FILM_CATEGORY B
	WHERE A.FILM_ID = B.film_id 
	GROUP BY B.category_id 
);

--영화 카테고리별 가장 긴 상영시간과 영화시간이 같은 어떠한 영화든지 출력
SELECT
	TITLE,
	LENGTH
FROM
	FILM
WHERE LENGTH = ANY ( 
	SELECT
		MAX(LENGTH)
	FROM FILM A, FILM_CATEGORY B
	WHERE A.FILM_ID = B.film_id 
	GROUP BY B.category_id 
);

-- '= ANY' 는 'IN' 과 동일함 (더 직관적)
SELECT
	TITLE,
	LENGTH
FROM
	FILM
WHERE LENGTH IN ( 
	SELECT
		MAX(LENGTH)
	FROM FILM A, FILM_CATEGORY B
	WHERE A.FILM_ID = B.film_id 
	GROUP BY B.category_id 
);

----------------------------------------------------------------------------------------
--ALL 연산자 예시 (서브쿼리의 모든 결과값이 만족해야 조건이 성립함)
-- 카테고리별 가장 긴 영화 길이보다 크거나 같은 영화 이름을 출력 (결국 가장 상영시간이 긴 영화이름을 출력하는 것과 같음)
SELECT
	TITLE,
	LENGTH
FROM
	FILM
WHERE
	LENGTH >= ALL (
	SELECT
		MAX(LENGTH)
	FROM
		FILM A,
		FILM_CATEGORY B
	WHERE
		A.FILM_ID = B.FILM_ID
	GROUP BY
		B.CATEGORY_ID);
		
--ALL 연산자 실습2
--평가기준(카테고리 데이터임)별 상영시간 평균길이(소수점 둘째자리까지 계산)의 모든 값보다 더 상영시간이 긴 데이터를 출력
SELECT
	FILM_ID,
	TITLE,
	LENGTH
FROM
	FILM
WHERE
	LENGTH > ALL (
	SELECT
		ROUND(AVG(LENGTH), 2)
	FROM
		FILM GROUP BY RATING)
ORDER BY
	LENGTH;
	
--------------------------------------------------------------------------------------------------
--EXISTS 연산자 예시
--고객 리스트 중 사용금액이 11달러를 초과한 고객이름을 출력(전체 599개 데이터 중 8개 데이터 출력)
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER C
WHERE
	EXISTS ( SELECT 1  -- 'SELECT 1'은 모든 ROW가 상수 1로 채워진 COLUMN을 반환한다
			FROM PAYMENT P
			WHERE P.CUSTOMER_ID = C.CUSTOMER_ID
			AND P.AMOUNT > 11)   --지불내역이 11달러를 초과한 고객이 존재하는지 확인하기
ORDER BY
	FIRST_NAME,
	LAST_NAME;

--NOT EXISTS문 예제
--지불내역이 11달러를 초과한 적 없는 고객이름을 출력 (591개 데이터 출력)
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER C
WHERE
	NOT EXISTS ( SELECT 1  --지불내역이 11달러를 초과한 고객이 존재하는지 확인하기
			FROM PAYMENT P
			WHERE P.CUSTOMER_ID = C.CUSTOMER_ID
			AND P.AMOUNT > 11)   
ORDER BY
	FIRST_NAME,
	LAST_NAME;
	


----------------------------------------------------------------------------------------------------
-------------------------------------------실습문제1 -------------------------------------------------
--아래 SQL문은 FILM 테이블을 2번이나 스캔하고 있다. FILM 테이블을 한번만 SCAN하여 동일한 결과 집합을 구하는 SQL을 작성하라--
----------------------------------------------------------------------------------------------------
--문제 SQL
SELECT
	FILM_ID,
	TITLE,
	RENTAL_RATE
FROM
	FILM
WHERE
	RENTAL_RATE > (
	SELECT
		AVG(RENTAL_RATE)
	FROM
		FILM);
	
-- FROM 절에서 데려오면 될 거 같은데..?
-- AVG를 테이블을 읽어서 데려오지 말고 분석함수로 바로 구함
SELECT
	*
FROM
	(
	SELECT
		FILM_ID,
		TITLE,
		RENTAL_RATE,
		AVG(A.RENTAL_RATE) OVER() AS AVG_RENTAL_RATE
	FROM
		FILM A) A
WHERE
	RENTAL_RATE > AVG_RENTAL_RATE;

----------------------------------------------------------------------------------------------------
-------------------------------------------실습문제2--------------------------------------------------
-------아래 SQL문은 EXCEPT 연산을 사용하여 재고가 없는 영화를 구하고 있다. EXCEPT 연산 없이 같은 결과를 도출하라---------
----------------------------------------------------------------------------------------------------
--문제 SQL
SELECT
	FILM_ID,
	TITLE
FROM
	FILM
EXCEPT
SELECT
	DISTINCT INVENTORY.film_id,
	TITLE
FROM
	INVENTORY
INNER JOIN FILM ON
	FILM.FILM_ID = INVENTORY.FILM_ID
ORDER BY
	TILTE;

	
--NOT EXISTS를 사용하면 더 빠른 쿼리가 되지 않을까? (내 답안인데 틀렸음)
SELECT A.FILM_ID, A.TITLE
FROM FILM A
WHERE 
	NOT EXISTS (
		SELECT DISTINCT B.film_id  
		FROM INVENTORY B
	)
ORDER BY TITLE;

-- 위에껀 틀렸고 진짜 정답
SELECT A.FILM_ID, A.TITLE
FROM FILM A
WHERE 
	NOT EXISTS (  --말 그대로 있느냐 없느냐만 확인해줌
		SELECT 1
		FROM INVENTORY B, FILM C
		WHERE B.FILM_ID = C.FILM_ID  -- 이 WHERE절을 만족해주는 ROW들은 1의 값을 가진 채로 출력되게 됨
		AND A.FILM_ID = C.FILM_ID
		)	
ORDER BY TITLE;

		
--위 답안보다 더 좋은 답안 (필름 테이블을 1번만 조회하는 방법)
SELECT A.FILM_ID, A.TITLE
FROM FILM A
WHERE 
	NOT EXISTS (
		SELECT 1
		FROM INVENTORY B
		WHERE 1=1
		AND A.FILM_ID = B.FILM_ID
		)	
ORDER BY TITLE;
