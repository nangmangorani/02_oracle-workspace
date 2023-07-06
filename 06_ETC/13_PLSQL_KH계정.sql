/*
    < PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SAL
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    SQL ���峻���� ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE) ���� �����Ͽ� SQL�� ���� ����
    �ټ��� SQL���� �� ���� ���� ���� (BLOCK ����) + ����ó���� ����
   
   * PL / SQL ����
   - [�����] : DECLARE�� ���� ������ ����� ���� �� �ʱ�ȭ �ϴ� �κ�
   - ����� : BEGIN���� ����, ������ �־����! SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ ����ϴ� �κ�
   - [����ó����] : EXCEPTION���� ����, ���ܹ߻��� �ذ��ϱ� ���� ������ �̸� ����ص� �� �ִ� ����
*/

SET SERVEROUTPUT ON;

-- �����ϰ� ȭ�鿡 HELLO ORACLE ���! HELLO WORLD ����ߴ� ��ó��

BEGIN
    -- System.out.println("Hello Oracle";);
    DBMS_OUTPUT.PUT_LINE('Hello Oracle');
END;
/

--------------------------------------------------------------------------------
/*
    1. DECLARE �����
    ���� �� ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
    �Ϲ�Ÿ�Ժ���,  ���۷���Ÿ�Ժ���, ROWŸ�Ժ���
    
    1-1) �Ϲ�Ÿ�Ժ��� ���� �� �ʱ�ȭ
        [ǥ����] ������ [CONSTANT -> ����� ��] �ڷ��� [:=��];
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    -- EID := 800;
    -- ENAME := '������';
    
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
    
END;
/
--------------------------------------------------------------------------------
-- 1-2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (� ���̺��� � �÷��Ǥ� ������ Ÿ���� �����ؼ� �� Ÿ������ ����)
--        [ǥ����] ������ ���̺��.�÷���&TYPE;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    --EID := '300';
    --ENAME := '�̽���';
    --SAL := 3000000;
    
    -- ����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ� �� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL   
    FROM EMPLOYEE
    -- WHERE EMP_ID = 200;
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);

END;
/

---------------------------------�ǽ�����----------------------------------------
/*
    ���۷���Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�
    �� �ڷ����� EMPLOYEE, DEPARTMENT ���̺���� �����ϵ���
    
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� �� �� ������ ��� ���
*/
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
INTO EID, ENAME, JCODE, SAL, DTITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE EMP_ID = &���;

    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);

END;
/
--------------------------------------------------------------------------------
--1-3) ROWŸ�� ���� ����
--     ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
--     [ǥ����] ������ ���̺��%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * -- ����÷��� �ش��ϴ� ���� �־����
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

    -- DBMS_OUTPUT.PUT_LINE(E);
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS,0));

END;
/
--------------------------------------------------------------------------------
-- 2. BEGIN �����

-- < ���ǹ� >

-- 1) IF ���ǽ� THEN ���೻�� END IF; (�ܵ� IF��)

-- ��� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);

    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
    
END;
/

-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF; (IF-ELSE��)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
    END IF;
END; 
/
---------------------------------�ǽ�����----------------------------------------

DECLARE
    -- ���۷���Ÿ�Ժ���(EID, ENAME, DTITLE, NCODE)
    -- ���������̺� EMPLOYEE, DEPARTMENT, NATIONAL
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;


    -- �Ϲ�Ÿ�Ժ��� (TEAM ���ڿ�) => �̵��� '������' �Ǵ� '�ؿ���' ���� ����
    TEAM VARCHAR2(10);
BEGIN
    -- ����ڰ� �Է��� ����� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO'
        THEN TEAM := '������';
    ELSE
        TEAM := '�ؿ���';
    END IF;

    -- ���, �̸�, �μ�, �Ҽ�(������, �ؿ���)�� ���� ���
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);

END;
/

--------------------------------------------------------------------------------
-- 3) IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ELSE ���೻�� END IF(IF - ELSE - ELSE ��)
-- ������ �Է¹޾� SCORE ������ ������ ��
-- 90�� �̻��� 'A', 80�� �̻��� 'B', 70�� �̻��� 'C', 60�� �̻��� 'D' 60�� �̸��� 'F'�� ó���� ��
-- GRADE ������ ����
-- '����� ������ XX���̰�, ������ X���� �Դϴ�.'

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &����;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;

    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������ ' || GRADE || '�����Դϴ�.');

END;
/

--------------------------------------------------------------------------------
-- 4) CASE �񱳴���� WHEN ������Ұ� THEN �����1 WHEN �񱳰�2 THEN �����2... ELSE ����� END;
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); -- �μ����� ������ ����
BEGIN

    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE
             WHEN 'D1' THEN '�λ���'
             WHEN 'D2' THEN 'ȸ����'
             WHEN 'D3' THEN '��������'
             WHEN 'D4' THEN '����������'
             WHEN 'D9' THEN '�ѹ���'
             ELSE '�ؿܿ�����'
        END;
        
        
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '��(��)' || DNAME || '�Դϴ�');
    
    
END;
/
--------------------------------------------------------------------------------

-- 1. ����� ������ ���ϴ� PL/SQL ���ۼ�, ���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���
-- ���ʽ��� ������ ���ʽ������Կ���
-- ���ʽ��� ������ ���ʽ����Կ���
-- ��¿���
-- �޿� �̸� ��ȭǥ�� 999,999,999 ��¦ �̷��������δٰ�
SELECT * FROM EMPLOYEE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    YEONBONG VARCHAR2(15);
    
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS, YEONBONG
    INTO EID, ENAME, SAL, BONUS, YEONBONG
    FROM EMPLOYEE    
    WHERE EMP_ID = &���;
    
    YEONBONG := (SAL + SAL * NVL(BONUS,0)) * 12; 
    
    DBMS_OUTPUT.PUT_LINE(SAL || ENAME || '���� ������' || TO_CHAR(YEONBONG, 'L999,999,999') || '�Դϴ�.');

END;
/



