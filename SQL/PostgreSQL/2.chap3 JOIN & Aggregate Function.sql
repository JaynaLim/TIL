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