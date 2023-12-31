/*
CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형,
        ...   
    );
*/
-- 1. COMMENT ON COLUMN MEMBER.MEM_NO IS '회원버노';
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER PRIMARY KEY,
    PUB_NAME VARCHAR2(40) NOT NULL,
    PHONE NUMBER
);
ALTER TABLE TB_PUBLISHER MODIFY PHONE VARCHAR2(20);

ALTER TABLE TB_PUBLISHER RENAME CONSTRAINT SYS_C007204 TO PUBLISHER_PK;
ALTER TABLE TB_PUBLISHER RENAME CONSTRAINT SYS_C007203 TO PUBLICHSER_NN;
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사전화번호';

INSERT INTO TB_PUBLISHER VALUES (1,'주원북스','010-1111-1111');
INSERT INTO TB_PUBLISHER VALUES (2,'북북','010-2222-2222');
INSERT INTO TB_PUBLISHER VALUES (3,'책방','010-3333-3333');

SELECT * FROM TB_PUBLISHER;

-- 2.
CREATE TABLE TB_BOOK(
    BK_NO NUMBER PRIMARY KEY,
    BK_TITLE VARCHAR2(60) NOT NULL,
    BK_AUTHOR VARCHAR2(30) NOT NULL,
    BK_PRICE NUMBER,
    BK_STOCK NUMBER DEFAULT 1,
    BK_PUB_NO NUMBER
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서번호';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격';
COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '재고';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사번호';

ALTER TABLE TB_BOOK RENAME CONSTRAINT SYS_C007207 TO BOOK_PK;
ALTER TABLE TB_BOOK RENAME CONSTRAINT SYS_C007205 TO BOOK_NN_TITLE;
ALTER TABLE TB_BOOK RENAME CONSTRAINT SYS_C007206 TO BOOK_NN_AUTHOR;

ALTER TABLE TB_BOOK
    ADD FOREIGN KEY(BK_PUB_NO) REFERENCES TB_PUBLISHER(PUB_NO);
ALTER TABLE TB_BOOK RENAME CONSTRAINT SYS_C007208 TO BOOK_FK;
/*
ALTER TABLE TB_DEPARTMENT
    ADD FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);
ALTER TABLE TB_DEPARTMENT RENAME CONSTRAINT SYS_C007202 TO FK_DEPARTMENT_CATEGORY;
*/



INSERT INTO TB_BOOK VALUES (1,'배고파', '이승준', 1200000, 1, 1);
INSERT INTO TB_BOOK VALUES (2,'배불러', '강주원', 5000, 14, 2);
INSERT INTO TB_BOOK VALUES (3,'졸리다', '무지', 30000, 5, 3);
INSERT INTO TB_BOOK VALUES (4,'당근과채찍', '김캐럿', 7000, 124, 2);
INSERT INTO TB_BOOK VALUES (5,'사자', '라이언', 80000, 33, 1);

-- 3. 
--GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 컬럼레벨방식
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) UNIQUE,
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(1000),
    PHONE VARCHAR2(20),
    STATUS CHAR(1) CHECK(STATUS IN ('Y', 'N')),
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴여부';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';

ALTER TABLE TB_MEMBER RENAME CONSTRAINT SYS_C007214 TO MEMBER_PK;
ALTER TABLE TB_MEMBER RENAME CONSTRAINT SYS_C007215 TO MEMBER_UQ;
ALTER TABLE TB_MEMBER RENAME CONSTRAINT SYS_C007209 TO MEMBER_NN_PWD;
ALTER TABLE TB_MEMBER RENAME CONSTRAINT SYS_C007210 TO MEMBER_NN_NAME;
ALTER TABLE TB_MEMBER RENAME CONSTRAINT SYS_C007212 TO MEMBER_CK_GEN;
ALTER TABLE TB_MEMBER RENAME CONSTRAINT SYS_C007213 TO MEMBER_CK_STA;
ALTER TABLE TB_MEMBER RENAME CONSTRAINT SYS_C007211 TO MEMBER_NN_EN;

SELECT * FROM TB_MEMBER;
INSERT INTO TB_MEMBER VALUES (1,'laker970', '123', '이승준', 'M', '서울시 마포구 어딘가', '010-1234-5678','N',DEFAULT);
INSERT INTO TB_MEMBER VALUES (2,'zzz123', '1233', '강주원', 'M', '서울시 여러분 담배꽁초', '010-1122-2233','N','12/12/12');
INSERT INTO TB_MEMBER VALUES (3,'nasunuk99', '999', '아는형님', 'F', '제주도', '010-1212-1212','N',DEFAULT);
INSERT INTO TB_MEMBER VALUES (4,'zlzl', '111', '강아지', 'F', NULL, NULL,'Y','20/12/11');
INSERT INTO TB_MEMBER VALUES (5,'lier13', '123', '김구라', 'M', '구라동', null,'N',DEFAULT);

-- 4.

CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER ON DELETE CASCADE,  -- 외래키, 부모데이터 삭제시 null값되도록
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK ON DELETE CASCADE, -- 외래키, 부모데이터 삭제시 null값되도록
    RENT_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN TB_RENT.RENT_NO IS '대여번호';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '대여회원번호';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '대여도서번호';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '대여일';

SELECT * FROM TB_RENT;
SELECT * FROM TB_BOOK;
SELECT * FROM TB_PUBLISHER;
SELECT * FROM TB_MEMBER;

INSERT INTO TB_RENT VALUES(1,1,1,DEFAULT);
INSERT INTO TB_RENT VALUES(2,2,2,'20/12/12');
INSERT INTO TB_RENT VALUES(3,3,3,'10/10/10');

SELECT MEMBER_NAME, MEMBER_ID, RENT_DATE, RENT_DATE + 7
FROM TB_MEMBER
JOIN TB_RENT ON RENT_MEM_NO = MEMBER_NO
JOIN TB_BOOK ON BK_NO = RENT_NO
WHERE BK_NO = 2;

