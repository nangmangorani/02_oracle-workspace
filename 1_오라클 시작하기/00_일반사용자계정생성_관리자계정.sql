-- �� �� ¥�� �ּ�

/*
    ������
    �ּ�
*/

-- ���� ��� �����鿡 ���ؼ� ��ȸ�ϴ� ��ɹ�
SELECT * FROM DBA_USERS; -- �̰� ������ �������� ���Ա� ������ ���δ�.
-- ��ɹ� �ϳ� ����(���� �� �����ư Ŭ�� | CTRL + ENTER)

-- �Ϲ� ����� ���� �����ϴ� ���� (������ ������ ���������� �� �� ����)
-- [ǥ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ;

CREATE USER kh IDENTIFIED BY kh; -- �������� ��ҹ��� �Ȱ���


-- ���� �߰��غ��� => ����

-- ������ ������ �Ϲ� ����� �������� �ּ����� ���� (������ ����, ���� ����) �ο�
-- [ǥ����] GRANT�� ����1, ����2 .. TO ������
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









