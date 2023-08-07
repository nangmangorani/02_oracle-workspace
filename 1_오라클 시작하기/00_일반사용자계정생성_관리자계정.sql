-- 한 줄 짜리 주석

/*
    여러줄
    주석
*/

-- 현재 모든 계정들에 대해서 조회하는 명령문
SELECT * FROM DBA_USERS; -- 이건 관리자 계정으로 들어왔기 때문에 보인다.
-- 명령문 하나 실행(왼쪽 위 재생버튼 클릭 | CTRL + ENTER)

-- 일반 사용자 계정 생성하는 구문 (오로지 관리자 계정에서만 할 수 있음)
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;

CREATE USER kh IDENTIFIED BY kh; -- 계정명은 대소문자 안가림


-- 계정 추가해보기 => 오류

-- 위에서 생성된 일반 사용자 계정에게 최소한의 권한 (데이터 관리, 접속 권한) 부여
-- [표현법] GRANT로 권한1, 권한2 .. TO 계정명
GRANT RESOURCE, CONNECT TO KH;

CREATE USER scott IDENTIFIED BY tiger;
GRANT RESOURCE, CONNECT TO scott;     

CREATE USER workbook IDENTIFIED BY workbook;
GRANT RESOURCE, CONNECT TO workbook;


CREATE USER practice1 IDENTIFIED BY practice1;
GRANT RESOURCE, CONNECT TO practice1;

CREATE USER final IDENTIFIED BY final;
GRANT RESOURCE, CONNECT TO final;

CREATE USER JDBC IDENTIFIED BY JDBC;
GRANT CONNECT, RESOURCE TO JDBC;


CREATE USER phonebook IDENTIFIED BY phonebook;

GRANT RESOURCE, CONNECT TO phonebook;

CREATE USER SERVER IDENTIFIED BY SERVER;
GRANT CONNECT, RESOURCE TO SERVER;









