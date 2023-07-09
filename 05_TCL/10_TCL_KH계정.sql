/*
    < TCL : TRANSACTION CONTROLL LANGUAGE >
    트랜젝션 제어 언어
    
    * 트렌젝션(TRANSACTION)
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경사항(DML 추가, 수정, 삭제)들을 하나의 트랜젝션에 묶어서 처리
      DML문 한 개를 수행할 때 트랜젝션이 존재하면 해당 트랜젝션에 같이 묶어서 처리
                           트랜젝션이 존재하지 않으면 트랜젝션 만들어서 묶음
      COMMIT 하기 전까지 변경사항들을 하나의 트랜젝션에 담게됨
      커밋을   해야만이 실제 디비에 반영이 된다고 생각하면 됨!
      - 트랜젝션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)
      
      COMMIT(트랜젝션 종료 후 확정)
      ROLLBACK(트랜젝션 취소)
      SAVEPOINT(임시저장)
      
      - COMMIT; 진행 : 한 트랜젝션에 담겨있는 변경사항들을 실제 DB에 반영시키겠다는 의미 (후에 트랜젝션 사라짐)
      - ROLLBACK; 진행 : 한 트랜젝션에 담겨있는 변경사항들을 삭제(취소)한 후 마지막 커밋시점으로 돌아감
      - SAVEPOINT 포인트명; 진행 : 현재 이 시점에서 해당 포인트명으로 임시 저장점을 정의해두는 것
                                ROLLBACK 진행시 전체 변경사항들을 다 삭제하는게 아니라 일부만 롤백가능
                                
*/

SELECT * FROM 
EMP_01;

-- 사번 900번인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 900;
-- 뭔가 진짜 삭제된것처럼 보임!

DELETE FROM EMP_01
WHERE EMP_ID = 901;

ROLLBACK;
-- 변경사항 취소되고, 트랜젝션도 없어짐, 데이터 다시 되살아난다.

--------------------------------------------------------------------------------
-- 200번 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 200;

SELECT * FROM EMP_01;

-- 800번, 황민현, 총무부 사원 추가
INSERT INTO EMP_01
VALUES(800,'황민현','총무부');

COMMIT;
-- 실제 DB 반영됨

ROLLBACK; -- 이미 커밋해서 못돌아감

--------------------------------------------------------------------------------
-- 217, 216, 214 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID IN (217,216,214);

-- 임시저장점 잡기
SAVEPOINT SP;

-- 801, 안효섭, 인사관리부 사원 추가
INSERT INTO EMP_01
VALUES (801, '안효섭', '인사관리부');

-- 218 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01;

-- 801 추가랑 218 삭제만 취소하고 싶다!!
ROLLBACK TO SP;
COMMIT;

--------------------------------------------------------------------------------

-- 900, 901 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

DELETE FROM EMP_01
WHERE EMP_ID = 218;

-- DDL문
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

-- DDL문 (CREATE, ALTER, DROP)을 수행하는 순간 기존에 트랜젝션에 있던 변경사항들을
-- 무조건 COMMIT(실제 DB 반영)
-- 즉, DDL문 수행 전 변경사항이 있었다면 정확히 픽스(COMMIT, ROLLBACK) 하고 하자!!





















