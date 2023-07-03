/*
    DDL(DATA DEFINITION LANGUATE) : 데이터 정의 언어
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE), 구조 변경(ALTER) 하고, 구조자체를 삭제(DROP) 하는 언어
    즉, 실제 데이터값이 아닌 구조 자체를 정의하는 언어
    주로 DB관리자, 설계자가 사용함
    
    오라클에서 제공하는 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
                                 인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),
                                 프로시져(PROCEDURE, 함수(FUNCTOIN), 동의어(SYNONYM), 사용자(USER)

    CREATE
    객체를 새로이 생성하는 구문
    

*/

/*
    1. 테이블 생성
    테이블이란? 행(ROW)과 열(COLUMN)로 구성되는 가장 기볹거인 데이터베이스 객체
            모든 데이터들은 테이블을 통해서 저장됨!
            (DBMS 용어중 하나로, 데이터를 일종의 표 형태로 표현한 것)
            
    [표현식]
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형,
        ... 
        
    );
    * 자료형
    문자 (CHAR(바이트 크기) | VARCHAR2(바이트크기)) => 반드시 크기 지정해야함
    > CHAR : 최대 2000바이트까지 지정 가능. 지정한 범위 안에서만 써야함 / 고정길이 (지정한 크기보다 적은 값이 들어와도 공백으로 채워짐)
             고정된 글자수의 데이터만이 담길 경우 사용 => 일반적으로 '한'글자.(YN/MF)
             
    > VARCHAR2 : 최대 4000바이트까지 지정 가능. 가변 길이(담긴 값에 따라서 공간의 크기 맞춰짐)
            몇 글자의 데이터가 들어올지 모르는 경우 + 긴 글
            
    - 숫자 (NUMBER)
    
    날짜 (DATE)
   
*/

-- 회원에 대한 데이터를 담기 위한 테이블 MEMBER 생성하기
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

DROP TABLE MEMBER;

-- 만약 컬럼명에 오타가 발생했다면?
-- 다시 만들면 될까? ㄴㄴ 삭제하고 다시하든 해야함..
-- DROP TABLE 테이블명;

-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블들
-- [참고] USER_TABLES : 현재 이 계정이 가지고 있는 테이블 구조를 볼 수 있음
SELECT * FROM USER_TABLES;

-- [참고] USER_TAB_COLUMNS : 사용자가 가지고 있는 테이블상의 모든 컬럼 볼 수 있음
SELECT * FROM USER_TAB_COLUMNS;
--------------------------------------------------------------------------------

/*
    컬럼에 주석 달기 (컬럼에 대한 설명같은거)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
    
    잘못 작성해서 실행했을 경우 수정 후 다시 실행하면됨
*/
    
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원버노';
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
    
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';

-- 테이블을 삭제하고자 할 때 : DROP TABLE 테이블명;

-- 테이블에 데이터 추가시키는 구문 (DML : INSERT) 이 때 자세하게 배움
-- INSERT INTO 테이블명 VALUES (값1, 값2, 값3...);

SELECT * FROM MEMBER;

-- INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '홍길동'); -- 다 입력안하면 에러남
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'aaa@naver.com', '20/12/30');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', '홍길녀', '여', null, NULL, SYSDATE);

INSERT INTO MEMBER VALUES(null,null,null,null,null,null,null,null);
-- 유효하지 않은 데이터가 들어가고 있음... 뭔가 조건을 걸어줘야함
--------------------------------------------------------------------------------
/*
    제약조건 CONSTRAINTS
    - 원하는 데이터값 (유효한 형식의 값) 유지하기 위해서 특정 컬럼에 설정하는 제약조건
    - 데이터 무결성 보장을 목적으로 한다!
    
    종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    NOT NULL 제약조건
    해당 컬럼에 반드시 값이 존재해야만 할 경우 (즉, 해당컬럼에 절대 NULL이 들어와서는 안되는 경우)
    삽입 / 수정시 NULL 값을 허용하지 않도록 제한
    
    제약 조건을 부여하는 방식은 크게 두가지(컬럼레벨방식 / 테이블레벨방식)
    NOT NULL 제약조건은 오로지 컬럼레벨방식 밖에 안됨!!!!

*/
-- 컬럼레벨방식 : 컬럼명 자료형 제약조건
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES (1, 'user01', 'pass01', '손흥민', '남', null, null);

INSERT INTO MEM_NOTNULL VALUES (2, 'user02', null, '이강인', '여', null, 'aaa@naver.com');
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- 의도했던대로 오류남!! (NOT NULL 제약조건에 위배되어 오류발생)
INSERT INTO MEM_NOTNULL VALUES (2, 'user01', 'pass01', '이승우', null, null, null);
-- 아이디가 중복되어있음에도 추가됨 ㅜ

--------------------------------------------------------------------------------
/*
    UNIQUE 제약조건
    해당 컬럼에 중복된 값이 들어가서는 안 될 경우
    컬럼값에 중복값을 제한하는 제약 조건
    삽입 / 수정시 기존에 있는 데이터값 중 중복값이 있을 경우 오류 발생!!
*/

CREATE TABLE MEM_UNIQUE( -- 컬럼레벨방식
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 콤마 ㄴㄴ 띄어쓰기 ㅇㅇ
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) --> 테이블 레벨방식
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '손흥민', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass01', '이강인', null, null, null);
-- ORA-00001: unique constraint (DDL.SYS_C007086) violated
-- UNIQUE 제약조건에 위배되었음! INSERT 실패!!
-- 오류구문을 제약조건명으로 알려줌! (특정 컬럼에 어떤 문제가 있는지 상세히 알려주지 않음!)
-- 쉽게 파악하기 어려움!
-- 제약조건 부여시 제약조건명을 지정해주지 않으면 시스템에서 임의의 제약조건명을 부여해버림

/*
    제약조건 부여시 제약조건명까지 지어주는 방법
    
    > 컬럼레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건,
        컬럼명 자료형
    );
    
    > 테이블레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    );
    
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) --> 테이블 레벨방식
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '손흥민', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass01', '이강인', null, null, null);
-- ORA-00001: unique constraint (DDL.MEMID_UQ) violated
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass01', '이강인', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user03', 'pass01', '이승우', 'ㄴ', null, null);
-- 성별한 유효한값이 아닌게 들어와도 잘 INSERT가 된다. -> 이러면 안됨..

--------------------------------------------------------------------------------
/*
    CHECK(조건식) 제약조건
    해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해둘 수 있음
    해당 조건에 만족하는 데이터값만 담길 수 있음
*/

CREATE TABLE MEM_CHECK( -- 컬럼레벨방식
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 콤마 ㄴㄴ 띄어쓰기 ㅇㅇ
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 컬럼레벨방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CHECK(GENDER IN('남','여')) -- 테이블 레벨 방식
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '손흥민', '남', null, null);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '이강인', 'z', null, null);
-- ORA-02290: check constraint (DDL.SYS_C007102) violated
-- CHECK 제약조건에 위배됐기 때문에 오류 발생
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '이강인', null, null, null);
-- 만약 GENDER 컬럼에 데이터값을 넣고자한다면 CHECK 제약조건에 만족하는 값을 넣어야됨
-- NOT NULL 아니면 NULL 도 가능하긴함!!

INSERT INTO MEM_CHECK
VALUES (2, 'user03', 'pass03', '이승우', '여', null, null);
-- 회원번호가 동일해도 성공적으로 insert 돼버림;;
--------------------------------------------------------------------------------
/*
    PRIMARY KEY(기본키) 제약조건 => PK
    테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건 (식별자의 역할)
    
    EX) 회원번호, 학번, 사원번호, 부서코드, 직급코드, 주문번호, 예약번호, 운송장번호
    
    PRIMARY KEY 제약조건을 부여하면 그 컬럼에 자동으로 NOT NULL + UNIQUE 제약조건 가진다.
    
    유의사항 : 한 테이블당 오로지 !!! 한개만 가능
*/

CREATE TABLE MEM_PRI( 
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 콤마 ㄴㄴ 띄어쓰기 ㅇㅇ
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 컬럼레벨방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '손흥민', '남', '010-1111-2222', null);

INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', '이강인', '남', null, null);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- 기본키에 중복값을 담으려고 할 때 (UNIQUE 제약조건 위반)

INSERT INTO MEM_PRI
VALUES(NULL, 'user02', 'pass02', '이강인', '남', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- 기본키에 NULL을 담으려 할 때 (NOT NULL 제약조건에 위배됨)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', '이강인', '남', null, null);

CREATE TABLE MEM_PRI2( 
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 컬럼레벨방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
-- ORA-02260: table can have only one primary key
-- 기본키 하나만 된다!!
);
CREATE TABLE MEM_PRI2( 
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 컬럼레벨방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- 묶어서 PRIMARY KEY 제약 조건 부여 (복합키)
);

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2
VALUES(1, 'user02', 'pass02', '이강인', null, null, null);

INSERT INTO MEM_PRI2
VALUES(2, 'user02', 'pass02', '이승우', null, null, null);

INSERT INTO MEM_PRI2
VALUES(null, 'user02', 'pass02', '이강인', null, null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- primary key 특성상 절대적으로 null을 허용하지 않음

-- 복합키 사용 예시 (찜하기, 좋아요, 구독)
-- 찜하기 : 한 상품은 오로지 한번만 찜할 수 있음
-- 어떤 회원이 어떤 상품을 찜하는지에 대한 데이터를 보관하는 테이블
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(30),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1, '감자', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '고구마', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '감자', SYSDATE); -- 에러발생! 한번만 찜해야됨
INSERT INTO TB_LIKE VALUES(2, '감자', SYSDATE); 

--------------------------------------------------------------------------------
-- 회원등급에 대한 데이터를 따로 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY, 
    GRADE_NAME VARCHAR2(30) NOT NULL
);

SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

CREATE TABLE MEM( 
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 컬럼레벨방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- 회원의 등급번호 같이 보관할 컬럼
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '손흥민', '남', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '이강인', null, null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이승우', '남', null, null, 40);
-- 유효한 회원등급 번호가 아님에도 불구하고 잘 insert 됨...

--------------------------------------------------------------------------------
/*
    FOREIGN KEY(외래키) 제약조건
    다른 테이블에 존재하는 값만 들어와야 되는 특정 컬럼에 부여하는 제약 조건
    -- 다른 테이블을 참조한다고 표현
    -- 주로 FOREIGN KEY 제약조건에 의해 테이블간 관계 형성됨!
    
    > 컬럼레벨방식
    컬럼명 자료형 [CONSSTRAINT 제약조건명] REFERENCES 참조할 테이블명[(참조할 컬럼명)]
    
    > 테이블레벨방식
    [CONSSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[(참조할 컬럼명)]
    
    -- 참조할 컬럼명 생략시 참조할 테이블 PRIMARY KEY로 지정된 컬럼으로 자동매칭
    
    
*/

DROP TABLE MEM;

CREATE TABLE MEM( 
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) -- 컬럼레벨방식
    --, FOREIGNKEY (GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);


SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '손흥민', '남', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '이강인', null, null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이승우', '남', null, null, 20);
-- ORA-02291: integrity constraint (DDL.SYS_C007136) violated - parent key not found

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '안정환', null, null, null, 10);

-- MEM_GRADE(부모테이블) MEM(자식테이블)
-- 이때 부모테이블 (MEM_GRADE)에서 데이터값을 삭제할 경우 어떤 문제가 발생할까?
-- 데이터 삭제 : DELETE FROM 테이블명 WHERE 조건;

-- MEM_GRADE 테이블에서 10번 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- ORA-02292: integrity constraint (DDL.SYS_C007136) violated - child record found
-- 자식테이블 (MEM)에 10이라는 값을 사용하기 있기 때문에 삭제가 안됨!

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;
-- 자식테이블 (MEM)에 30이라는 값을 사용하고 있지 않기 때문에 삭제가 잘됨!!

-- 자식테이블에 이미 사용하고 있는 값이 있을 경우
-- 부모테이블로부터 무조건 삭제가 안되게하는 "삭제제한"옵션이 걸려있음

ROLLBACK; -- 커밋하기 이전 시점으로 돌림

SELECT * FROM MEM_GRADE;


DROP TABLE MEM_CHECK;

--------------------------------------------------------------------------------

/*
    자식테이블 생성시 외래키 제약조건 부여할 때 삭제옵션 지정가능
    * 삭제옵션 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식테이블의 값을
                어떻게 처리할건지
    - ON DELETE RESTRICTED (기본값) : 삭제제한옵션으로, 자식데이터로 쓰이는 부모데이터는
                                     아예 안되게끔
    - ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터의 값을
                           NULL로 변경
    - ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터 쓰고 있는 자식데이터 같이 삭제시킴
  
*/

DROP TABLE MEM;

-- ON DELETE SET NULL

CREATE TABLE MEM( 
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
    --, FOREIGNKEY (GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
); -- DDL 자동커밋?? 
INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '손흥민', '남', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '이강인', null, null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이승우', '남', null, null, 20);
-- ORA-02291: integrity constraint (DDL.SYS_C007136) violated - parent key not found

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '안정환', null, null, null, 10);

COMMIT;

-- 10번 등급 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- 잘 삭제됨! (단 10을 가져다 쓰고 있던 자식데이터 값은 NULL로 변경)

SELECT * FROM MEM;

ROLLBACK;

DROP TABLE MEM;
-- ON DELETE CASCADE
CREATE TABLE MEM( 
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
    --, FOREIGNKEY (GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '손흥민', '남', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '이강인', null, null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이승우', '남', null, null, 20);
-- ORA-02291: integrity constraint (DDL.SYS_C007136) violated - parent key not found

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '안정환', null, null, null, 10);

COMMIT;

-- 10번 등급 삭제 쿼리
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

--------------------------------------------------------------------------------

/*
    <DEFAULT 기본값> ** 제약조건 아님 **
    컬럼을 선정하지 않고 INSERT시 NULL이 아닌 기본값을 INSERT 하고자 할 때 세팅해둘 수 있는 값
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

SELECT * FROM MEMBER;

-- INSERT INTO 테이블명 VALUES(값1, 값2, ...)

INSERT INTO MEMBER VALUES (1, '손흥민', 20, '축구', '22/01/01');
INSERT INTO MEMBER VALUES (2, '이강인', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES (3, '이승우', NULL, DEFAULT, DEFAULT); -- 내가 설정한 디폴트값으로 들어감!!

-- INSERT INTO 테이블명 (컬럼명, 컬럼명) VALUES (값1, 값2);
-- NOT NULL인건 꼭 써야함.

INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES (4, '안정환');
-- 선택되지 않은 컬럼 기본적으로 NULL이 들어감
-- 단, 해당 컬럼에 DEFUALT값이 있을 경우 NULL이 아닌 DEFAULT 값이 들어감!

--------------------------------------------------------------------------------

/*
    KH계정에서 작업할거!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    <SUBQUERY 이용한 테이블 생성>
    테이블 복사 뜨는 개념
    
    [표현식]
    CREATE TABLE 테이블명
    AS 서브쿼리;
*/
    
-- EMPLOYEE 테이블을 복제한 새로운 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT * 
    FROM EMPLOYEE;
    
SELECT * FROM EMPLOYEE_COPY;
-- 컬럼, 데이터값, 제약조건 같은 경우 NOT NULL만 복사됨..

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE -- 테이블 구조만 가져오고싶다!!
    WHERE 1 = 0; -- 1=0은 FALSE, FALSE인 조건을 쓰면 데이터를 못가져옴 (데이터 값은 필요 없을 때)

SELECT * FROM EMPLOYEE_COPY2; 

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "연봉"
    FROM EMPLOYEE;
-- ORA-00998: must name this expression with a column alias
-- alias : 별칭
SELECT * FROM EMPLOYEE_COPY3;
-- 서브쿼리 SELECT 절에 산술식 또는 함수식 기술된 경우 반드시 별칭 지정해야됨!

--------------------------------------------------------------------------------
/*
    테이블 다 생성된 후에 뒤늦게 제약조건 추가
    
    ALTER TABLE 테이블명 변경할 내용;
    
    - PRAMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[(참조할컬럼명)];
    - UNIQUE      : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
    - CHECK       : ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한 조건식)
    - NOT NULL    : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL; -- 약간 특이함ㅋ
*/

-- 서브쿼리를 이용해서 복제한 테이블 NN 제약조건 빼고 복제 안됨
-- EMPLOYEE_COPY 테이블에 PRIMARY KEY 제약조건 추가 (EMP_ID)

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE 테이블에 DEPT_CODE 외래키 제약조건 추가 (참조하는 테이블 (부모) : DEPARTMENT(DEPT_ID))
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT; -- 생략하면 부모테이블의 PK로 자동매칭됨.

-- EMPLOYEE 테이블에 JOB_CODE에 외래키 제약조건 추가 (JOB참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;

-- EMPLOYEE 테이블에 SAL_LEVEL에 외래키 제약조건 추가 (SAL_GRADE 참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;

-- DEPLARTMENT 테이블에 LOCATION_ID에 외래키 제약조건 추가(LOCATION 참조)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;

SELECT * FROM DEPARTMENT;
INSERT INTO DEPARTMENT VALUES('S1', '테스트부', 'S1');







