/*
    DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ��ü���� ����(CREATE), ����(ALTER), ����(DROP) �ϴ� ����
    
    <ALTER>
    ��ü�� �����ϴ� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� �����ҳ���;
    
    * ������ ����
    1) �÷� �߰�/����/����
    2) �������� �߰�/���� -- ������ �Ұ�(�����ϰ��� �Ѵٸ� ������ �� ������ �߰�)
    3) �÷���/�������Ǹ�/���̺�� ����
*/

-- 1) �÷� �߰�/����/����
-- 1-1) �÷��߰�(ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻��] ��������
-- DEPT_COPY�� CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

-- ���ο� �÷��� ��������� �⺻������ NULL�� ä����

-- LNAME �÷� �߰� (�⺻���� ������ä��)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR(20) DEFAULT '�ѱ�';
SELECT * FROM DEPT_COPY;

-- 1-2) �÷� ����(MODIFY)
--> �ڷ��� ����          : MODIFY �÷��� �ٲٰ����ϴ��ڷ���
--> DEFAULT�� ����       : MODIFY �÷��� DEFAULT �ٲٰ����ϴ� �⺻ ��

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- �̰� ������!! �̹� �����Ͱ� ���� �ƴѰ͵� �������
-- �����ϴ� �����Ͱ� ����߸� �̷��� �ٲ� �� ����

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- �̰͵� �����߻�, �̹� ��� �����͵��� �ʰ��� ��쵵 �־

-- DEPT_COPY
-- 1. DEPT_TITLE �÷��� VARCHAR2(50)�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

-- 2. LOCATION_ID �÷��� VARCHAR2(4)�� ����
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

-- 3. LNAME �÷��� �⺻���� '�̱�'���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '�̱�';

-- ���ߺ��� ����
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '����';
    
-- ����Ʈ���� �ٲ۴ٰ� �ؼ� ������ �߰��� �����Ͱ� �ٲ�� ���� �ƴϴ�.

-- 1-3) �÷� ����(DROP COLUMN) : DROP COLUMN �����ϰ��� �ϴ� �÷���
-- ������ ���� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2�κ��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2
    DROP COLUMN CNAME
    DROP COLUMN LNAME;
-- ����� ���� �ȵ�!!

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- ORA-12983: cannot drop all columns in a table
-- �ּ� �Ѱ��� �÷��� �����ؾ���.

--------------------------------------------------------------------------------

-- 2. �������� �߰� / ����
/*
    2-1) �������� �߰�
    PRIMARY KEY : ADD PRIMARY KEY(�÷���)
    FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)]
    UNIQUE      : ADD UNIQUE(�÷���)
    CHECK       : ADD CHECK(�÷��� ���� ����)
    NOT NULL    : MODIFY �÷��� NOT NULL | NULL => �̰� ���� �� ���
    
    �������Ǹ��� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] ��������
*/

-- DEPT_ID�� PRIMARY KEY �������� �߰� ADD
-- DEPT_TITLE�� UNIQUE �������� �߰� ADD
-- LNAME�� NOT NULL �������� �߰� MODIFY

ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_EPTUQ UNIQUE(D_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL; 

-- 2-2) �������� ���� : DROP CONSTRAINT �������Ǹ�
-- NOT NULL �������� MODIFY �÷��� NULL�� ����

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
--------------------------------------------------------------------------------
-- 3) �÷��� / �������Ǹ� / ���̺�� ���� (RENAME)
-- 3-1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���

-- DEPT_TITLE => DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3-2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
-- SYS_C007188 LOCATION_ID NN �ڱⲨ ��������
-- SYS_C007188 -> DCOPY_LID_NN

ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007188 TO DCOPY_LID_NN;

-- 3-3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

--------------------------------------------------------------------------------
/*
    < DROP >
    ���̺��� �����ϴ� ����
*/

-- ���̺� ����
DROP TABLE DEPT_TEST;
SELECT * FROM DEPT_TEST;

-- ��, ��򰡿��� �����ǰ� �ִ� �θ����̺��� �Ժη� ���� �ȵ�!!
-- ���� �����ϰ��� �Ѵٸ�
-- ���1 : �ڽ����̺� ���� ���� �� �� �θ����̺� �����ϴ� ���
-- ���2 : �׳� �θ����̺� �����ϴµ� �������Ǳ��� ���� �����ϴ� ���
--      DROP TABLE ���̺�� CASCADE CONSTRAINT;

















