/*
    <DCL : DATAT CONTROL LANGUAGE>
    ������ ���� ���
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ����
    
    > �ý��� ���� : DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    > ��ü���ٱ��� : Ư�� ��ü���� ������ �� �ִ� ����
*/

/*
    * �ý��۱��� ����
    - CREATE SESSION : ������ �� �ִ� ����
    - CREATE TABLE : ���̺��� ������ �� �ִ� ����
    - CREATE VIEW : �並 ������ �� �ִ� ����
    - CREATE SEQUENCE : �������� ������ �� �ִ� ����
    ..... : �Ϻδ� Ŀ��Ʈ �ȿ� ���Ե�����!
*/

-- 1. SAMPLE /SAMPLE
CREATE USER SAMPLE1 IDENTIFIED BY SAMPLE1;
-- ����: ���� -�׽�Ʈ ����: ORA-01045: user SAMPLE1 lacks CREATE SESSION privilege; logon denied

-- 2. ������ ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE1;

-- 3-1. ���̺� ������ �� �ִ� CRATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE1;

-- 3-2. TABLESPACE �Ҵ� (SAMPLE ���� ����)
ALTER USER SAMPLE1 QUOTA 2M ON SYSTEM;

--------------------------------------------------------------------------------
/*
    * ��ü ���� ���� ����
      Ư�� ��ü�� �����ؼ� ������ �� �ִ� ����
      
      ��������         Ư����ü
      SELECT     TABLE, VIEW, SEQUENCE    
      INSERT     TABLE, VIEW
      UPDATE     TABLE, VIEW
      DELETE     TABLE, VIEW
      ...
      [ǥ����]
      GRANT �������� ON Ư����ü TO ����
*/

GRANT SELECT ON KH.EMPLOYEE TO SAMPLE1;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE1;

--------------------------------------------------------------------------------
GRANT CONNECT, RESOURCE TO ������;

/*
    <�� ROLE>
    - Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    CONNECT : ������ �� �ִ� ���� CREATE SESSION
    RESOURCE : Ư�� ��ü���� ������ �� �ִ� ���� CREATE TABLE, CREATE SEQUENCE...
*/

SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE')
ORDER BY 1;




