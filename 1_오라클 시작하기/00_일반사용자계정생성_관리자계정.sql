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





















