/*
    DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
    객체들을 생성(CREATE), 변경(ALTER), 삭제(DROP) 하는 구문
    
    <ALTER>
    객체를 변경하는 구문
    
    [표현식]
    ALTER TABLE 테이블명 변경할내용;
    
    * 변경할 내용
    1) 컬럼 추가/수정/삭제
    2) 제약조건 추가/삭제 -- 수정은 불가(수정하고자 한다면 삭제한 후 새로이 추가)
    3) 컬럼명/제약조건명/테이블명 수정
*/

-- 1) 컬럼 추가/수정/삭제
-- 1-1) 컬럼추가(ADD) : ADD 컬럼명 자료형 [DEFAULT 기본값] 제약조건
-- DEPT_COPY에 CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

-- 새로운 컬럼이 만들어지고 기본적으로 NULL로 채워짐

-- LNAME 컬럼 추가 (기본값을 지정한채로)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR(20) DEFAULT '한국';
SELECT * FROM DEPT_COPY;

-- 1-2) 컬럼 수정(MODIFY)
--> 자료형 수정          : MODIFY 컬럼명 바꾸고자하는자료형
--> DEFAULT값 수정       : MODIFY 컬럼명 DEFAULT 바꾸고자하는 기본 값

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- 이건 오류남!! 이미 데이터가 숫자 아닌것도 들어있음
-- 존재하는 데이터가 없어야만 이렇게 바꿀 수 있음

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- 이것도 오류발생, 이미 담긴 데이터들이 초과한 경우도 있어서

-- DEPT_COPY
-- 1. DEPT_TITLE 컬럼을 VARCHAR2(50)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

-- 2. LOCATION_ID 컬럼을 VARCHAR2(4)로 변경
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

-- 3. LNAME 컬럼의 기본값을 '미국'으로 변경
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '미국';

-- 다중변경 가능
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '영국';
    
-- 디폴트값을 바꾼다고 해서 이전에 추가된 데이터가 바뀌는 것은 아니다.

-- 1-3) 컬럼 삭제(DROP COLUMN) : DROP COLUMN 삭제하고자 하는 컬럼명
-- 삭제를 위한 복사본 테이블 생성
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2로부터 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2
    DROP COLUMN CNAME
    DROP COLUMN LNAME;
-- 드랍은 다중 안됨!!

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- ORA-12983: cannot drop all columns in a table
-- 최소 한개의 컬럼은 존재해야함.

--------------------------------------------------------------------------------

-- 2. 제약조건 추가 / 삭제
/*
    2-1) 제약조건 추가
    PRIMARY KEY : ADD PRIMARY KEY(컬럼명)
    FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(컬럼명)]
    UNIQUE      : ADD UNIQUE(컬럼명)
    CHECK       : ADD CHECK(컬럼에 대한 조건)
    NOT NULL    : MODIFY 컬럼명 NOT NULL | NULL => 이거 쓰면 널 허용
    
    제약조건명을 지정하고자 한다면 [CONSTRAINT 제약조건명] 제약조건
*/

-- DEPT_ID에 PRIMARY KEY 제약조건 추가 ADD
-- DEPT_TITLE에 UNIQUE 제약조건 추가 ADD
-- LNAME에 NOT NULL 제약조건 추가 MODIFY

ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_EPTUQ UNIQUE(D_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL; 

-- 2-2) 제약조건 삭제 : DROP CONSTRAINT 제약조건명
-- NOT NULL 삭제말고 MODIFY 컬럼명 NULL로 간다

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
--------------------------------------------------------------------------------
-- 3) 컬럼명 / 제약조건명 / 테이블명 변경 (RENAME)
-- 3-1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명

-- DEPT_TITLE => DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3-2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
-- SYS_C007188 LOCATION_ID NN 자기꺼 가져오기
-- SYS_C007188 -> DCOPY_LID_NN

ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007188 TO DCOPY_LID_NN;

-- 3-3) 테이블명 변경 : RENAME [기존테이블명] TO 바꿀테이블명
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------
/*
    < DROP >
    테이블을 삭제하는 구문
*/

-- 테이블 삭제
DROP TABLE DEPT_TEST;
SELECT * FROM DEPT_TEST;

-- 단, 어딘가에서 참조되고 있는 부모테이블은 함부로 삭제 안됨!!
-- 만약 삭제하고자 한다면
-- 방법1 : 자식테이블 먼저 삭제 한 후 부모테이블 삭제하는 방법
-- 방법2 : 그냥 부모테이블만 삭제하는데 제약조건까지 같이 삭제하는 방법
--      DROP TABLE 테이블명 CASCADE CONSTRAINT;

















