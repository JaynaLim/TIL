---------------------------------------------------------------------
--INSERT문 예시
CREATE TABLE LINK (
	ID SERIAL PRIMARY KEY
	,URL VARCHAR (255) NOT NULL
	,NAME VARCHAR (255) NOT NULL
	,DESCRIPTION VARCHAR (255)
	,REL VARCHAR (50)
	);
	
SELECT * FROM LINK  -- 현재 아무 값도 들어있지 않은 상태

INSERT 
	INTO LINK
	(URL, NAME)
	VALUES
	('http://naver.com', 'Naver')
	,('''http://naver.com''', '''Naver''')  --작은따옴표 입력 시 ''로 입력하면 작은따옴표로 인식
	;
	
COMMIT;

SELECT * FROM LINK;

---------------------------------------------------------------
--구조가 동일한 테이블 만들기
CREATE TABLE LINK_TMP AS
SELECT * FROM LINK WHERE 0 = 1;

--LINK에 있는 데이터를 LINK_TMP로 옮김
INSERT INTO LINK_TMP
SELECT * FROM LINK;

--LINK_TMP 중 LINK에 없는 데이터를 확인(0개)
SELECT * FROM LINK_TMP
EXCEPT
SELECT * FROM LINK;

----------------------------------------------------------------
--UPDATE문 예시 (LAST UPDATE 컬럼을 추가하고 값을 지정)
ALTER TABLE LINK ADD COLUMN LAST_UPDATE DATE;  --LINK 테이블을 변경한다: DATE타입의 LAST_UPDATE 컬럼을 추가
ALTER TABLE LINK ALTER COLUMN LAST_UPDATE SET DEFAULT CURRENT_DATE; --LINK 테이블 변경: LAST_UPDATE의 DEFAULT VALUE를 CURRENT_DATE로 변경

SELECT * FROM LINK;

UPDATE LINK
SET LAST_UPDATE = DEFAULT  --LAST_UPDATE 값을 지정한 DEFULAT 값으로 UPDATE
WHERE LAST_UPDATE IS NULL; --조건: LAST_UPDATE컬럼이 NULL인 값에 한정

COMMIT;

SELECT * FROM LINK;

--전체 테이블 수정
UPDATE LINK
SET REL = 'NO DATA'; --rel 컬럼을 하나하나 읽으면서 NO DATA STRING을 집어넣음

COMMIT;
SELECT * FROM LINK; 

UPDATE LINK
SET DESCRIPTION = NAME;
COMMIT;
SELECT * FROM LINK;

-----------------------------------------------------------------
--UPDATE JOIN 실습 (할인율 * 판매가를 계산해 NET_PRICE 컬럼의 값을 얿데이트하기)
CREATE TABLE PRODUCT_SEGMENT
(
	ID SERIAL PRIMARY KEY
	,SEGMENT VARCHAR NOT NULL
	,DISCOUNT NUMERIC (4,2)
);

INSERT INTO PRODUCT_SEGMENT (SEGMENT, DISCOUNT)
VALUES
	('Grand Luxury', 0.05)
	,('Luxury', 0.06)
	,('Mass', 0.1);
COMMIT;

CREATE TABLE PRODUCT(
	ID SERIAL PRIMARY KEY
	,NAME VARCHAR NOT NULL
	,NET_PRICE NUMERIC(10,2)
	,SEGMENT_ID INT NOT NULL
	,FOREIGN KEY(SEGMENT_ID)
	REFERENCES PRODUCT_SEGMENT(ID)
);

INSERT INTO PRODUCT (NAME, PRICE, SEGMENT_ID)
VALUES
	('K5', 804.89, 1)
	,('K7', 228.55, 3)
	,('K9', 366.45, 2)
	,('SONATA', 145.33, 3)
	,('SPARK', 551.77, 2)
	,('AVANTE', 261.58, 3)
	,('LOZTE', 591.62, 2)
	,('SANTAFE', 843.31, 1)
	,('TUSAN', 254.18, 3)
	,('TRAX', 427.78, 2)
	,('ORANDO', 936.29, 1)
	,('RAY', 910.34, 1)
	,('MORNING', 208.33, 3)
	,('VERNA', 985.45, 1)
	,('K8', 841.26, 1)
	,('TICO', 896.38, 1)
	,('MATIZ', 575.74, 2)
	,('SPORTAGE', 530.64, 2)
	,('ACCENT', 892.43, 1)
	,('TOSCA', 161.71, 3);
COMMIT;

--NET PRICE 값 업데이트 (PRODUCT_SEGMENT 테이블의 할인율과 PRODUCT테이블의 가격을 곱함)
UPDATE PRODUCT A
SET NET_PRICE = A.PRICE - (A.PRICE * B.DISCOUNT)
FROM PRODUCT_SEGMENT B
WHERE A.SEGMENT_ID = B.ID;

SELECT * FROM PRODUCT;

------------------------------------------------------------------
--DELETE문

DELETE FROM LINK
WHERE ID = 2;  --ID가 2인 데이터를 삭제
COMMIT;

--테이블을 조인해서 조건을 주고 삭제하기
DELETE FROM LINK_TMP A
USING LINK B
WHERE A.ID = B.ID;    --LINK_TMP 중 ID가 LINK에도 들어있는 데이터 삭제
COMMIT;
SELECT * FROM LINK_TMP; --확인 (LINK에서 ID = 2인 데이터가 없으니 ID=2인 LINK_TMP 데이터만 남음)

--테이블 데이터 전체를 날리기
DELETE FROM LINK;
COMMIT;

-------------------------------------------------------------------
--UPSERT문
--예시 테이블 만들기
CREATE TABLE CUSTOMERS
(
	CUSTOMER_ID SERIAL PRIMARY KEY
	,NAME VARCHAR UNIQUE   --UNIQUE 제약조건으로 인해 NAME은 중복된 컬럼이 없음
	,EMAIL VARCHAR NOT NULL
	,ACTIVE BOOL NOT NULL DEFAULT TRUE
);

INSERT INTO CUSTOMERS (NAME, EMAIL)
VALUES
	('IBM', 'contact@ibm.com')
	,('Microsoft', 'contact@microsoft.com')
	,('Intel', 'contact@intel.com');
COMMIT;

--SQL 에러 발생 시 UPDATE를 하지 않게 설정
INSERT INTO CUSTOMERS (NAME, EMAIL)
VALUES
	('Microsoft', 'hotline@microsoft.com')  --NAME 컬럼 UNIQUE 제약조건 어김
ON CONFLICT (NAME)  --충돌시
DO NOTHING;         --아무것도 안함
COMMIT;

--UPDATE
INSERT INTO CUSTOMERS (NAME, EMAIL)
VALUES (
	'Microsoft','hotline@microsoft.com'
	) ON CONFLICT (NAME)    --NAME에서 충돌시
	DO UPDATE               --UPDATE를 한다
		SET EMAIL = EXCLUDED.EMAIL || ';' || CUSTOMERS.EMAIL --EXCLUDED.EMAIL은 위에서 INSERT를 시도한 hotline~ 이메일을 가리킴
	;                                                        --str||str||str 은 string을 이어붙인다는 뜻
COMMIT;
)

SELECT * FROM customers;

---------------------------------------------------------------
--EXPOTR 예제

--실습1(엑셀 형식으로 출력하기)
COPY CATEGORY(CATEGORY_ID, NAME, LAST_UPDATE)  --추출할 테이블, 컬럼 지정
TO 'G:\tmp\DB_category.csv'   --경로 지정 (이미 있는 폴더여야 함)
DELIMITER ','                 --구분자 지정
CSV HEADER                    --파일형식 지정(header이 있으면 column명도 함께 나옴)
;

--실습2(텍스트 파일로 출력)
COPY CATEGORY(CATEGORY_ID, NAME, LAST_UPDATE)   --추출할 테이블과 컬럼 지정
TO 'G:\tmp\DB_CATEGORY.txt'          
DELIMITER '|' 
CSV HEADER
;

--------------------------------------------------------------
--IMPORT 예제

--실습테이블 만들기
CREATE TABLE CATEGORY_IMPORT
(
	CATEGORY_ID SERIAL NOT NULL
	,"NAME" VARCHAR(25) NOT NULL
	, LAST_UPDATE TIMESTAMP NOT NULL DEFAULT NOW()
	,CONSTRAINT CATEGORY_IMPORT_PKEY PRIMARY KEY (CATEGORY_ID)
);

SELECT * FROM CATEGORY_IMPORT;

--export 예제에서 만들었던 파일을 import해옴
COPY CATEGORY_IMPORT(CATEGORY_ID, "NAME", LAST_UPDATE)
FROM 'G:\tmp\DB_CATEGORY.csv'
DELIMITER ','
CSV HEADER  --HEADER 쓰지 않으면 header값 안 들어옴, header가 없는 파일에서 header를 가져오면 첫번째 데이터가 헤더로 인식돼서 누락됨
;

--텍스트파일 import
COPY CATEGORY_IMPORT(CATEGORY_ID, "NAME", LAST_UPDATE)
FROM 'G:\tmp\DB_CATEGORY.txt'
DELIMITER '|'
CSV HEADER
;    --csv파일을 category_import로 불러오고 이 쿼리를 실행하면 오류 발생(category_id에 중복값 들어와서)
DELETE FROM category_import;--해당 테이블 값 삭제 후 다시 txt불러오기를 실행하면 오류 없음