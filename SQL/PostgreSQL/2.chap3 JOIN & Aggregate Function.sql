---------------------------------------------------------------------
-- join 예제 테이블 만들기
CREATE TABLE BASKET_A(
ID INT PRIMARY KEY,
FRUIT VARCHAR (100) NOT NULL);

CREATE TABLE BASKET_B(
ID INT PRIMARY KEY,
FRUIT VARCHAR (100) NOT NULL);
--테이블에 값 넣기
INSERT
	INTO
	BASKET_A(ID,
	FRUIT)
VALUES 
(1,'APPLE'),
(2,'ORANGE'),
(3,'BANANA'),
(4,'CUCUMBER');

COMMIT;  --INSERT, UPDATE, DELETE (데이터의 삽입 및 갱신) 명령은 반드시 COMMIT을 해야 함. (여러명이 작업할 때 안꼬이게 하려고 그러나?)

INSERT
	INTO
	BASKET_B (ID,FRUIT)
VALUES 
(1,'ORANGE'),
(2,'APPLE'),
(3,'WATERMELON'),
(4,'PEAR');

COMMIT;

--BASKET_A 테이블 조회
SELECT * FROM BASKET_A;
--BASKET_B 테이블 조회
SELECT * FROM BASKET_B;


---------------------------------------------------------------------------
--INNER JOIN 예제
SELECT
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
FROM
	BASKET_A A
INNER JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;
	

---------------------------------------------------------------------------
--DVDRENTAL 데이터 INNERJOIN 예제
SELECT
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE
FROM
	CUSTOMER A
INNER JOIN PAYMENT B ON
	A.CUSTOMER_ID = B.CUSTOMER_ID --모든 PAYMENT는 CUSTOMER_ID를 가지고 있을 것이기 때문에 결과의 ROW수는 PAYMENT의 ROW수와 같아짐

---------------------------------------------------------------------------
--CUSTOMER ID가 2번인 고객의 결제내역만 조회 (EX. 고객정보에서 결제내역을 조회했을 때 본인의 내역만 뜨게 하려면)
SELECT
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE
FROM
	CUSTOMER A
INNER JOIN PAYMENT B ON
	A.CUSTOMER_ID = B.CUSTOMER_ID
WHERE A.CUSTOMER_ID = 2;
	
---------------------------------------------------------------------------
--3개의 INNERJOIN (A - B  B- C 순으로 JOIN)
SELECT
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE,
	C.FIRST_NAME AS S_FIRST_NAME,
	C.LAST_NAME AS S_LAST_NAME
FROM
	CUSTOMER A
INNER JOIN PAYMENT B  
ON
	A.CUSTOMER_ID = B.CUSTOMER_ID  -- CUSTOMER 테이블과 PAYMENT 테이블 조인
INNER JOIN STAFF c ON
	B.STAFF_ID = C.STAFF_ID;  --PAYMENT 테이블과 STAFF 테이블을 조인
	
---------------------------------------------------------------------------
-- LEFT OUTER JOIN 예시 (A에 B를 JOIN시 A에 매칭되는 B의 일부만 가져옴)
-- LEFT OUTER JOIN은 LEFT JOIN으로 써도 됨
SELECT
	A.ID AS ID_A ,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
LEFT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;
	
---------------------------------------------------------------------------
-- A에만 존재하는 데이터를 뽑는 법
SELECT
	A.ID AS ID_A ,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
LEFT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT
WHERE B.ID IS NULL;

---------------------------------------------------------------------------
-- RIGHT OUTER 조인 (A에 B를 조인시 B에 매칭되는 A의 일부를 가져옴)
-- 마찬가지로 OUTER는 생략해도 됨
SELECT
	A.ID AS ID_A ,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
RIGHT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;
	
------------------------------------------------------
--이번에는 B에만 데이터가 존재하는 ROW를 찾는다
SELECT
	A.ID AS ID_A ,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
RIGHT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT
WHERE A.ID IS NULL;


-----------------------------------------------------
-- SELF JOIN 예제 테이블 만들기
-- employee_id는 종업원, manager_id는 해당 employee를 관리하는 매니저
CREATE TABLE EMPLOYEE(
EMPLOYEE_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR (255) NOT NULL,
LAST_NAME VARCHAR (255) NOT NULL,
MANAGER_ID INT,
FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID) ON
DELETE
	CASCADE
);

INSERT
	INTO
	EMPLOYEE(
EMPLOYEE_ID,
	FIRST_NAME,
	LAST_NAME,
	MANAGER_ID)
VALUES
(1,
'Windy',
'Hays',
NULL), 
(2,
'Ava',
'Christensen',
1), 
(3,
'Hassan',
'Conner',
1), 
(4,
'Anna',
'Reeves',
2), 
(5,
'Sau',
'Norman',
2), 
(6,
'Kelsie',
'Hays',
3), 
(7,
'Tory',
'Goff',
3), 
(8,
'Salley',
'Lester',
3);

COMMIT;
)

SELECT * FROM employee

-------------------------------------------------------------------------
-- SELF JOIN 실습
SELECT
	E.employee_id,
	E.FIRST_NAME || ' ' || E.LAST_NAME EMPLOYEE,  -- FIRST NAME과 LAST NAME을 합쳐서 이름을 만듦
	M.FIRST_NAME || ' ' || M.LAST_NAME MANAGER
FROM
	EMPLOYEE E
INNER JOIN EMPLOYEE M ON   -- E, M 모두 EMPLOYEE 테이블에 해당
	M.EMPLOYEE_ID = E.MANAGER_ID  -- 둘 중 한 데이터가 없는 ROW는 출력되지 않음
ORDER BY
	MANAGER;
	
--------------------------------------------------------------------------
--SELF LEFT OUTER JOIN
--MANAGER_ID가 없는 데이터도 출력하려면?
SELECT
	E.employee_id,
	E.FIRST_NAME || ' ' || E.LAST_NAME EMPLOYEE, 
	M.FIRST_NAME || ' ' || M.LAST_NAME MANAGER
FROM
	EMPLOYEE E
LEFT JOIN EMPLOYEE M ON
	M.EMPLOYEE_ID = E.MANAGER_ID
ORDER BY
	MANAGER;
	
-------------------------------------------------------------------------
--SELF JOIN 예제2 (DVDRENTAL 데이터)
--완전히 같은 COLUMN에 대해서도 SELF JOIN이 가능 (ROW의 특정 카테고리끼리 비교할 때 유용할 듯)
SELECT
	F1.TITLE,
	F2.TITLE,
	F1.LENGTH
FROM
	FILM F1
INNER JOIN FILM F2 ON
	F1.FILM_ID <> F2.FILM_ID  -- 서로 다른 영화들 중에서
	AND F1.LENGTH = F2.LENGTH;  -- 영화의 상영시간이 동일한 집합을 출력
	
--------------------------------------------------------------------------
--FULL OUTER JOIN  (INNER JOIN + LEFT OUTER JOIN + RIGHT OUTER JOIN의 결과를 보여준다 - 당연히 중복없이)
--FULL OUTER JOIN은 합집합과 같음
SELECT
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
FROM
	BASKET_A A
FULL OUTER JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;

--------------------------------------------------------------------------
-- (A∪B) - (A∩B) 를 구하는 법
SELECT
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
FROM
	BASKET_A A
FULL OUTER JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT
WHERE A.ID IS NULL
OR B.ID IS NULL;

--------------------------------------------------------------------------
-- FULL OUTER JOIN 예제2 데이터 생성
CREATE TABLE  --일련번호에 해당하는 부서 명
IF NOT EXISTS DEPARTMENTS  -- 해당 이름의 테이블이 없을 때 생성
(DEPARTMENT_ID SERIAL PRIMARY KEY,  --SERIAL 속성은 ROW 순서대로 일련번호를 부여
DEPARTMENT_NAME VARCHAR (255) NOT NULL);

CREATE TABLE -- EMPLOYEE가 일하는 부서의 일련번호와 직원 이름
IF NOT EXISTS EMPLOYEES 
(EMPLOYEE_ID SERIAL PRIMARY KEY,
EMPLOYEE_NAME VARCHAR(255),
DEPARTMENT_ID INTEGER);

INSERT INTO DEPARTMENTS (DEPARTMENT_NAME)
VALUES 
('Sales'),
('Marketing'),
('HR'),
('IT'),
('Production');

COMMIT;

INSERT
	INTO
	EMPLOYEES (EMPLOYEE_NAME,
	DEPARTMENT_ID)
VALUES ('Bette Nicholson',
1),
('Christian Gable',
1),
('Joe Swank',
2),
('Fred Costner',
3),
('Sandra Kilmer',
4),
('Julia Mcqueen',
NULL);

COMMIT;
---------------------------------------------------------------------------
-- FULL OUTER JOIN 예제2
-- 각 employee들의 이름과 일하는 부서를 출력 (해당 결과는 직원이 배정되지 않은 부서의 ROW도 단독으로 출력됨)
SELECT
	E.EMPLOYEE_NAME,
	D.DEPARTMENT_NAME
FROM
	EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D ON
	D.DEPARTMENT_ID = E.DEPARTMENT_ID;
	
----------------------------------------------------------------------------
-- 직원들이 일하는 부서를 출력할 것이기 때문에 직원명이 없는 데이터는 삭제한다
-- 아래 두가지 방법으로 표현 가능
SELECT
	E.EMPLOYEE_NAME,
	D.DEPARTMENT_NAME
FROM
	EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D ON
	D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE
	E.EMPLOYEE_NAME IS NOT NULL AND D.DEPARTMENT_ID IS NOT NULL;	
------------
SELECT
	E.EMPLOYEE_NAME,
	D.DEPARTMENT_NAME
FROM
	EMPLOYEES E
RIGHT JOIN DEPARTMENTS D ON
	D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE
	E.EMPLOYEE_NAME IS NOT NULL;
	
-----------------------------------------------------------------------------
-- CROSS 조인 예제 테이블 만들기
CREATE TABLE CROSS_T1 (LABEL CHAR(1) PRIMARY KEY);

CREATE TABLE CROSS_T2 (SCORE INT PRIMARY KEY);

INSERT
	INTO
	CROSS_T1(LABEL)
VALUES 
('A'),
('B');
COMMIT;

INSERT
	INTO
	CROSS_T2 (SCORE)
VALUES 
(1),
(2),
(3);
COMMIT;

-------------------------------------------------------------------------------
-- CROSS JOIN 예제1
SELECT
	*
FROM
	CROSS_T1
CROSS JOIN CROSS_T2; --T1의 모든 데이터와 T2의 첫번째, 두번째 조합 출력. 따라서 T1의 ABAB순으로 데이터가 들어감

--------------------------------------------------------------------------------
SELECT
	*
FROM
	CROSS_T1
CROSS JOIN CROSS_T2
ORDER BY LABEL;  -- T1을 정렬해서 더 보기좋게 만들어주기

--------------------------------------------------------------------------------
-- CROSS JOIN의 다른 표현방법
SELECT
	*
FROM
	CROSS_T1,
	CROSS_T2 ; --호엑 예제 1이랑 똑같은 결과가 출력됨 (그럼 CROSS JOIN안쓰고도 충분히 복잡한 CROSS JOIN 기능을 할 수 있지 않나?)

--------------------------------------------------------------------------------
-- CROSS JOIN한 뒤에 LABEL별로 다른 컬럼의 값 합치기
SELECT
	CASE
		WHEN LABEL = 'A' THEN SUM(SCORE)
		WHEN LABEL = 'B' THEN SUM(SCORE) * -1
		ELSE 0
	END AS CALC
FROM
	CROSS_T1
CROSS JOIN CROSS_T2
GROUP BY
	LABEL
ORDER BY
	LABEL;
	
--------------------------------------------------------------------------------
-- NATURAL JOIN 예제 테이블 만들기 (단일한 제품번호, 제품명, 중복되는 제품의 카테고리)
CREATE TABLE CATEGORIES
(
	CATEGORY_ID SERIAL PRIMARY KEY,
	CATEGORY_NAME VARCHAR(255) NOT NULL
);

CREATE TABLE PRODUCTS 
(
	PRODUCT_ID SERIAL PRIMARY KEY,
	PRODUCT_NAME VARCHAR (255) NOT NULL,
	CATEGORY_ID INT NOT NULL,
	FOREIGN KEY (CATEGORY_ID)
	REFERENCES CATEGORIES (CATEGORY_ID)
);

INSERT INTO CATEGORIES
(CATEGORY_NAME)
VALUES 
	('Smart Phone'),
	('Laptop'),
	('Tablet')
;

INSERT INTO PRODUCTS 
(PRODUCT_NAME, CATEGORY_ID)
VALUES 
	('iPhone', 1),
	('Samsung Galaxy', 1),
	('HP Elite', 2),
	('Lenovo Thinkpad', 2),
	('iPad', 3),
	('Kinder Fire', 3)
;

--------------------------------------------------------------------------------
-- NATURAL JOIN 예제 (두 개 테이블에서 같은 이름을 가진 컬럼 간의 INNER JOIN 집합을 출력)
SELECT
	*
FROM
	PRODUCTS A --COLUMN 명을 따로 쓰지 않아도 돼서 SQL문이 간단해짐
NATURAL JOIN
	CATEGORIES B 
;

-------------------------------------------------------------------------------
-- 위 예제를 INNER JOIN문으로 표현하면
SELECT
	A.CATEGORY_ID, A.PRODUCT_ID, A.PRODUCT_NAME, B.CATEGORY_NAME 
FROM
	PRODUCTS A
INNER JOIN
	CATEGORIES B
ON (A.CATEGORY_ID = B.CATEGORY_ID)
;

--------------------------------------------------------------------------------
-- NATURAL JOIN 예제2 (DVD RENTAL 데이터) - 만약 두 개 이상의 COLUMN명이 중복된다면 어떻게 될까?

SELECT * FROM CITY;  -- 두 테이블 모두 COUNTRY_ID와 LAST_UPDATE 컬럼을 가지고 있음
SELECT * FROM COUNTRY;

SELECT *   -- COUNTRY_ID와 LAST_UPDATE가 동시에 겹치는 데이터가 출력됨 (그런 데이터는 없음...)
FROM CITY A
NATURAL JOIN COUNTRY B;
-- NATURAL JOIN은 편리하긴 하지만 COLUMN명이 같은 데이터를 무조건 INNER JOIN하기 때문에 의도대로 출력되기 어려워서 실무에서 많이 사용하지 않음
-- 보통 데이터가 새로 들어올 때 LAST UPDATE나 처음 들어온 날짜를 테이블에 기입해두는데 NATURAL JOIN을 이용하면 이런 데이터끼리도 겹쳐야해서 문제 많을 듯
-- 위에서 실패한 JOIN 쿼리를 INNER JOIN을 이용해서 바꾸면 아래와 같음

SELECT
	*
FROM 
	CITY A
INNER JOIN
	COUNTRY B
ON 
	(A.COUNTRY_ID = B.COUNTRY_ID);

---------------------------------------------------------------------------------
-- GROUP BY 예제
SELECT
	CUSTOMER_ID  --GROUP BY 기준인 COLUMN을 출력하면 해당 COLUMN의 값은 DISTINCT 값으로 표현됨
FROM 
	PAYMENT
GROUP BY CUSTOMER_ID;

--즉 위의 출력물은 아래 출력물과 동일함
SELECT
	DISTINCT CUSTOMER_ID
FROM
	PAYMENT
;
-----------------------------------
--거래내역이 가장 많은 고객을 순서대로 출력하기
SELECT
	CUSTOMER_ID,
	SUM(AMOUNT) AS AMOUNT_SUM  --따로 이름 지정 안해주면 'SUM'으로 컬럼명이 지정됨
FROM
	PAYMENT
GROUP BY
	CUSTOMER_ID
ORDER BY 
	SUM(AMOUNT) DESC;   --호곡 SUM 같이 집계된 결과로도 정렬이 가능함
-- 이렇게도 정렬가능
SELECT
	CUSTOMER_ID,
	SUM(AMOUNT) AS AMOUNT_SUM  --따로 이름 지정 안해주면 'SUM'으로 컬럼명이 지정됨
FROM
	PAYMENT
GROUP BY
	CUSTOMER_ID
ORDER BY 
	2 DESC; 
-------------------------------------
--거래를 가장 많이 처리한 직원을 순서대로 출력하기
SELECT
	STAFF_ID,
	COUNT(PAYMENT_ID) AS COUNT
FROM
	payment
GROUP BY
	STAFF_ID
ORDER BY
	2 DESC;
	
--만약에 GROUP BY를 하면서 SELECT는 여러개라면...
--거래를 가장 많이 처리한 직원을 순서대로 출력하는데, STAFF 테이블에서 해당 스태프의 이름도 함께 가져오려고 함
SELECT
	A.STAFF_ID,
	B.STAFF_ID,
	B.FIRST_NAME,
	B.LAST_NAME,
	COUNT(A.PAYMENT_ID) AS COUNT
FROM
	PAYMENT A,
	STAFF B
WHERE
	A.STAFF_ID = B.STAFF_ID
GROUP BY               -- GROUP BY 집계함수를 쓴 COLUMN을 제외하고 모든 컬럼을 써줘야 오류 없음 (STAFF당 ID, NAME이 모두 하나이기 때문)
	A.STAFF_ID,
	B.STAFF_ID,
	B.FIRST_NAME,
	B.LAST_NAME;
	
------------------------------------------------------------------------------------
--HAVING절 예제 (HAVING을 이용해 GROUP BY 결과를 필터링하기)
SELECT
	CUSTOMER_ID, 
	SUM(AMOUNT) AS AMOUNT
FROM 
	PAYMENT
GROUP BY CUSTOMER_ID
HAVING SUM(AMOUNT) > 200;  --ORDER BY눈 새 컬럼명 지정한대로 AMOUNT DESC로 써도 되는데.. HAVING절은 AMOUNT로 쓰면 오류남..

--CUSTOMER_ID에 EMAIL을 JOIN해서 함께 출력해보자
SELECT
	A.CUSTOMER_ID,
	B.EMAIL,
	SUM(A.AMOUNT) AS AMOUNT
FROM
	PAYMENT A,
	CUSTOMER B
WHERE
	A.CUSTOMER_ID = B.CUSTOMER_ID
GROUP BY
	A.CUSTOMER_ID,
	B.EMAIL
	-- 한 ID당 한 EMAIL이니 둘 다로 GRUOP BY 해주고
HAVING
	SUM(A.AMOUNT) > 200
;

-- STORE 당 CUSTOMER의 수를 출력한다
SELECT
	STORE_ID,
	COUNT(CUSTOMER_ID) AS COUNT
FROM
	CUSTOMER
GROUP BY
	STORE_ID
;

-------------------------------------------------------------------------
--GRUOPING SET 절 예제 데이터 생성
CREATE TABLE SALES
(
BRAND VARCHAR NOT NULL, 
SEGMENT VARCHAR NOT NULL, 
QUANTITY INT NOT NULL, 
PRIMARY KEY (BRAND, SEGMENT)
);

INSERT INTO SALES (BRAND, SEGMENT, QUANTITY)
VALUES 
('ABC', 'Premium', 100),
('ABC', 'Basic', 200),
('XYZ', 'Premium', 100),
('XYZ', 'Basic', 300);

--GROUP BY SET은 UNION ALL을 여러개 사용한 SQL과 같은 결과를 도출
SELECT            --BRAND, SEGMENT로 그룹핑한 QUANTITY 합
	BRAND,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY 
	BRAND,
	SEGMENT
UNION ALL 
SELECT BRAND,     --BRAND로 그룹핑한 QUANTITY 합
	NULL,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY
	BRAND
UNION ALL
SELECT            --SEGMENT로 그룹핑한 QUANTITY 합
	NULL,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY
	SEGMENT
UNION ALL
SELECT            --전체 QUANTITY의 합
	NULL,
	NULL,
	SUM(QUANTITY)
FROM
	SALES;
	
SELECT * FROM SALES;

-- GROUPING SET을 이용하면 아래와 같이 단순화할 수 있다.
SELECT
	BRAND,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY
	GROUPING SETS 
	( 
	(BRAND,
	SEGMENT),
	(BRAND),
	(SEGMENT),
	()
	)
ORDER BY BRAND, SEGMENT;

-- GROUPING SET절 결과를 보기 좋게 표현
SELECT
	CASE WHEN GROUPING(BRAND) = 0 AND GROUPING(SEGMENT) = 0 THEN '브랜드별+등급별'
		 WHEN GROUPING(BRAND) = 0 AND GROUPING(SEGMENT) = 1 THEN '브랜드별'
		 WHEN GROUPING(BRAND) = 1 AND GROUPING(SEGMENT) = 0 THEN '등급별'
		 WHEN GROUPING(BRAND) = 1 AND GROUPING(SEGMENT) = 1 THEN '전체합계'
		 ELSE ''
		 END AS "집계기준"    -- 헐.. COLUMN 이름 지칭할 땐 큰 따옴표 쓰고.. value를 지칭할 땐 작은따옴표 써야 함.. 안 그러면 오류남.. 
	, BRAND
	, SEGMENT
	, SUM(QUANTITY)
FROM 
	SALES 
GROUP BY 
GROUPING SETS 
	( 
	(BRAND,SEGMENT),
	(BRAND),
	(SEGMENT),
	()
	)
ORDER BY BRAND, SEGMENT;

-----------------------------------------------------------------------------------------
-- ROLLUP 함수 예제 (GROUPING SET SALES 데이터 예제 다시 활용)
SELECT
	BRAND,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY
	ROLLUP (BRAND, SEGMENT)
ORDER BY
	BRAND,
	SEGMENT;
	
----------------------------------------------------------------------------------------
--부분 ROLLUP을 사용할 때는 전체 합계를 구하지 않음
SELECT
	BRAND,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY SEGMENT,
	ROLLUP (BRAND)
ORDER BY
	BRAND,
	SEGMENT;

-----------------------------------------------------------------------------------------
--CUBE절 예제 (SALES 데이터 활용)
-- GROUP BY 절 합계 + BRAND 별 + SEGMENT별 + 전체합계를 출력
SELECT 
	BRAND, SEGMENT,
	SUM(QUANTITY)
FROM SALES 
GROUP BY
	CUBE (BRAND, SEGMENT)  -- 근데 GROUPING SET이랑 뭐가 달라?
ORDER BY  
	BRAND, SEGMENT;
	
--부분 CUBE
SELECT BRAND, SEGMENT, SUM(QUANTITY)
FROM SALES
GROUP BY BRAND,
		CUBE (SEGMENT)
ORDER BY 
	BRAND, SEGMENT; 
	
------------------------------------------------------------------------------------------
--분석함수 예제 데이터 만들기
CREATE TABLE PRODUCT_GROUP(
	GROUP_ID SERIAL PRIMARY KEY,
	GROUP_NAME VARCHAR(255) NOT NULL
);

CREATE TABLE PRODUCT(
	PRODUCT_ID SERIAL PRIMARY KEY
	,PRODUCT_NAME VARCHAR (255) NOT NULL
	,PRICE DECIMAL (11,2)
	,GROUP_ID INT NOT NULL
	,FOREIGN KEY (GROUP_ID)
	REFERENCES PRODUCT_GROUP(GROUP_ID)
)

INSERT INTO PRODUCT_GROUP(GROUP_NAME)
VALUES
	('Smartphone'),
	('Laptop'),
	('Tablet');

INSERT INTO PRODUCT (PRODUCT_NAME, GROUP_ID, PRICE)
VALUES
	('Microsoft Lumia', 1, 200),
	('HTC One', 1, 400),
	('Nexus', 1, 500),
	('iPhone', 1, 900),
	('HP Elite', 2, 1200),
	('Lenovo Thinkpad', 2, 700),
	('Sony VAIO', 2, 700),
	('Dell Vostro', 2, 800),
	('iPad', 3, 700),
	('Kindle Fire', 3, 150),
	('Samsung Galaxy Tab', 3, 200);


--------------------------------------------------------------------------------------
--분석함수 예시  (COUNT와 다르게 해당 결과값을 출력한 계산 집합을 함께 출력해줌)
-- 집계결과 + 테이블의 내용
SELECT
	COUNT(*) OVER(), A.*
FROM 
	PRODUCT A

--------------------------------------------------------------------------------------
--AVG 함수 (집계)
SELECT
	AVG(PRICE)
FROM
	PRODUCT;

-- 제품 카테고리별로 가격 평균을 구하기
-- GROUP BY + AVG 
SELECT
	B.GROUP_NAME,
	AVG(PRICE)
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B ON
	(A.GROUP_ID = B.GROUP_ID)
GROUP BY
	B.GROUP_NAME;

-- 분석 함수를 사용해서 테이블 내용까지 전부 출력하기 (테이블 컬럼들 조합 + AVG)
SELECT
	A.PRODUCT_NAME,
	A.PRICE,
	B.GROUP_NAME,
	AVG(A.PRICE) OVER (PARTITION BY B.GROUP_NAME)
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B ON
	(A.GROUP_ID = B.GROUP_ID);

-- 분석함수 안에 있는 ORDER BY는 단순한 정렬 X 정렬한 뒤에 집계 기준값의 누적 평균을 보여줌
SELECT
	A.PRODUCT_NAME,
	A.PRICE,
	B.GROUP_NAME,
	AVG(A.PRICE) OVER (PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)  --GROUP_NAME별로 정렬하고 PRICE의 누적평균를 보여줌
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B ON
	(A.GROUP_ID = B.GROUP_ID);

------------------------------------------------------------------------------------------
-- ROW_NUMBER 예제
-- ROW_NUMBER를 GROUP_NAME 별로 그룹화 + PRICE 기준 오름차순 정렬해서 누적 ROW_NUM을 구함
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	ROW_NUMBER () OVER 
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)  -- ROW_NUM은 ORDER BY 기준에 같은 값이 있어도 무조건 순차적으로 (1,2,3,4,5...) 감
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B 
	ON (A.GROUP_ID = B.GROUP_ID);

--------------------------------------------------------------------------------------------
--RANK 예쩨
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	RANK () OVER 
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)  -- RANK는 동순위는 같은 값으로 매겨짐 (다음순위는 건너뜀)
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B 
	ON (A.GROUP_ID = B.GROUP_ID);

----------------------------------------------------------------------------------------------
--DENSE_RANK 예제
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	DENSE_RANK () OVER 
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)  -- 동순위는 같은 값으로 매겨지고, 다음 순위 건너뛰지 않음
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B 
	ON (A.GROUP_ID = B.GROUP_ID);


-----------------------------------------------------------------------------------------------
--FIRST_VALUE 예제
--product_group 별로 가장 가격이 낮은 데이터를 뽑아보자
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE, 
	FIRST_VALUE (A.PRICE) OVER
	(PARTITION BY B.GROUP_NAME ORDER BY A.price)
	AS LOWEST_PRICE_PER_GROUP
	FROM PRODUCT A
	INNER JOIN PRODUCT_GROUP B
		ON (A.GROUP_ID = B.group_id)
		
------------------------------------------------------------------------------------------------
--LAST_VALUE 예제
SELECT
	A.PRODUCT_NAME, B.GROUP_NAME, A.PRICE, LAST_VALUE (A.PRICE) OVER
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE DESC)  --현재 ROW 포함 이전까지의 ROW 중 마지막 값을 뽑음
	AS LOWEST_PRICE_PER_GROUP
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);

--그룹 내의 전체 ROW 중 마지막값을 뽑개 하려면 LAST_vALUE의 RANGE를 변경해야 함
SELECT
	A.PRODUCT_NAME, B.GROUP_NAME, A.PRICE, LAST_VALUE (A.PRICE) OVER
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE DESC
	RANGE BETWEEN UNBOUNDED PRECEDING 
	AND UNBOUNDED FOLLOWING)  -- DEFAULT는 UNBOUNDED PRECEDING AND CURRENT ROW 임
	AS LOWEST_PRICE_PER_GROUP
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);

-------------------------------------------------------------------------------------------------
--LAG 함수 예제
--PRICE 열의 바로 이전 값을 찾아서 현재 값과 빼기
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	LAG(A.PRICE, 1) OVER  -- PRICE 열의 1번째 이전 행을 찾아서 PREV_PRICE로 
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)
	AS PREV_PRICE,
	A.PRICE - LAG(PRICE,1) OVER (  -- 현재 PRICE와 이전행의 차를 구해서 새 열로 넣기
	PARTITION BY GROUP_NAME ORDER BY A.PRICE )
	AS CUR_PREV_DIFF
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);

--PRICE 열의 2번째 전 값을 찾아 현재 값과 차이 구하기
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	LAG(A.PRICE, 2) OVER   
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)
	AS PREV_PRICE,
	A.PRICE - LAG(PRICE,2) OVER (  
	PARTITION BY GROUP_NAME ORDER BY A.PRICE )
	AS CUR_PREV_DIFF
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);
	
---------------------------------------------------------------------------------------------------------
--LEAD 함수 예제
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	LEAD(A.PRICE, 1) OVER   
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)
	AS NEXT_PRICE,
	A.PRICE - LEAD(PRICE,1) OVER (  
	PARTITION BY GROUP_NAME ORDER BY A.PRICE )
	AS CUR_NEXT_DIFF
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);
	
----------------------------------------------------------------------------------------------------------
--------------------------------------------CHAP.3 실습문제1-------------------------------------------------
----DVDRENTAL 데이터의 RENTAL 테이블을 이용하여 연,월,연월일,전체 각각의 기준으로 RENTAL_ID 기준 렌탈이 일어난 횟수를 출력하라----
--(전체 데이터를 기준으로 모든 행을 출력해야 함)----------------------------------------------------------------------
-- 분석함수 이용해야 겟군.. COUNT(RENTAL_DATE), GROUP BY를 하는데 RENTAL ID는 무조건 포함해야 함
SELECT 
	TO_CHAR(RENTAL_DATE, 'YYYY') Y,
	TO_CHAR(RENTAL_DATE, 'MM') M,
	TO_CHAR(RENTAL_DATE, 'DD') D,
	COUNT(RENTAL_ID)
FROM RENTAL
GROUP BY
ROLLUP
(
	TO_CHAR(RENTAL_dATE, 'YYYY'),
	TO_CHAR(RENTAL_DATE, 'MM'),
	TO_CHAR(RENTAL_DATE, 'DD')
);

------------------------------------------------------------------------------------------------------------
----------------------------------------------CHAP.3 실습문제2------------------------------------------------
-------RENTAL과 CUSTOMER 테이블을 이용하여 현재까지 가장 많이 RENTAL을 한 고객의 ID, 렌탈순위, 누적렌탈횟수, 이름을 출력하라------

SELECT
	A.customer_id ,
	ROW_NUMBER() OVER(ORDER BY COUNT(A.RENTAL_ID) DESC) AS RENTAL_RANK,
	COUNT(A.RENTAL_ID) RENTAL_COUNT,
	MAX(B.FIRST_NAME) AS FIRST_NAME,
	MAX(B.LAST_NAME) AS LAST_NAME
FROM 
	RENTAL A, CUSTOMER B
WHERE
	A.CUSTOMER_ID = B.customer_id 
GROUP BY A.CUSTOMER_ID ORDER BY RENTAL_RANK LIMIT 1;

	