CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);

-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�!
-- 3-1) CREATE TABLE ���� �ޱ�
-- 3-2) TABLESPACE �Ҵ� �ޱ�

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, '�ȳ�'); 
-- CREATE TABLE ���� ������ ���̺�� �ٷ� ���� ����

--------------------------------------------------------------------------------

-- KH������ �ִ� EMPLOYEE ���̺� ����
-- ��ȸ������ ��� �ȵ�!
-- 4. SELECT ON KH.EMPLOYEE ���� �ο�����

SELECT * FROM KH.EMPLOYEE;

-- 5. INSERT ON KH.DEPARTMENT ���� �ο�����
INSERT INTO KH.DEPARTMENT
VALUES('D0', 'ȸ���', 'L1');

COMMIT;

SELECT * FROM DEPARTMENT;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D0';



















