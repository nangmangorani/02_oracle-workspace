/*
    JOIN
    �ΰ� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� �����͸� ��� ���� (�ߺ��� �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� ������)
    
    -- � ����� � �μ��� �����ִ��� �ñ���! �ڵ帻�� �̸�����..

    -> ������ �����ͺ��̽����� SQL���� �̿��� ���̺��� ���踦 �δ� ���
       (������ �� ��ȸ�� �ؿ��°� �ƴ϶� �� ���̺� ������ν��� �����͸� ��Ī�ؼ� ��ȸ���Ѿ���!)
       
       JOIN ũ�� "����Ŭ ���뱸��"�� "ANSI ����" (ANSI = �̱�����ǥ����ȸ) => �ƽ�Ű�ڵ�ǥ ����� ��ü!
                                [JOIN ��� ����]
       ����Ŭ���뱸��                    |                      ANSI ����
--------------------------------------------------------------------------------      
       �����                         |   ��������([INNER] JOIN) => JOIN USING/ON
     (EQAUL JOIN)                      |    �ڿ�����(NATURAL JOIN) => JOIN USING
--------------------------------------------------------------------------------      
       ��������                         |  ���� �ܺ�����(LEFT OUTER JOIN)
     (LEFT OUTER)                      |  ������ �ܺ����� (RIGHT OUTER JOIN)
     (RIGHT OUTER)                     | ��ü �ܺ����� (FULL OUTER JOIN)
--------------------------------------------------------------------------------      
    ��ü���� (SELF JOIN)                |  JOIN ON
    ������(NON EQUAL JOIN)
--------------------------------------------------------------------------------      

*/

-- ��ü ������� ���, �����, �μ��ڵ�, �μ��� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE
FROM JOB;

/*
    1. ����� (EQAUL JOIN) / ��������(INNER JOIN)
       �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εż� ��ȸ (��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵ�)
*/
-- ����Ŭ ���뱸��
-- FROM���� ��ȸ�ϰ��� �ϴ� ���̺���� ���� (, �����ڷ�)
-- WHERE���� ��Ī��ų �÷�(�����)�� ���� ������ ������

-- 1) ������ �� �÷����� �ٸ���� (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
--  ���, �����, �μ��ڵ�, �μ��� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵȰ� Ȯ�� ����
-- DEPT_CODE �� NULL�� ��� ��ȸX, DEPT_ID�� D3, D4, D7�� ��ȸ X

-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE : JOB_CODE, JOB : JOB_CODE) 
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE;
-- ambiguously ��ȣ�� 

-- �ذ���1 : ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 2) �ذ���2 : ���̺� ��Ī�� �ο��ؼ� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- ANSI ���뱸��
-- FROM���� ������ �Ǵ� ���̺��� �ϳ� ��� �� ��
-- JOIN���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ���ǵ� ���
-- JOIN USING, JOIN ON


-- 1) ������ �� �÷��� �ٸ� ��� (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
--    ������ JOIN ON �������θ� ��� ����!
--    ���, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE-
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ���� ��� (E : JOB_CODE, J : JOB_CODE)
--    JOIN ON, JOIN USING ���� ��밡��!
--    ���, �����, �����ڵ�, ���޸�

-- �ذ���1) ���̺�� �Ǵ� ��Ī�� �̿��ؼ� �ϴ� ���

SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- �ذ���2) JOIN USING ���� ����ϴ� ��� (�� �÷����� ��ġ�Ҷ��� ��� ����)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE); 

-----�������-----
-- �ڿ�����(NATURAL JOIN) : �� ���̺��� ������ �÷��� �� ���� ������ ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- �߰����� ���ǵ� ��� ���� ����
-- ������ �븮�� ����� �̸�, ���޸�, �޿� ��ȸ

-- ����Ŭ ���� ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '�븮';

-- ANSI ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

---------------------------------�ǽ�����----------------------------------------
--1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_NO, EMP_NAME, BONUS
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '�λ������';

--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '�λ������';

--2. DEPARTMENT�� LOCATION �����ؼ� ��ü�μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
--> ����Ŭ ���뱸��
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

--> ANSI
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE AND BONUS IS NOT NULL;

--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
WHERE BONUS IS NOT NULL;

--4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �μ��� ��ȸ
--> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID = DEPT_CODE AND DEPT_TITLE <> '�ѹ���';

--> ANSI
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
WHERE DEPT_TITLE <> '�ѹ���';

SELECT *
FROM LOCATION;

SELECT *
FROM EMPLOYEE;

SELECT *
FROM DEPARTMENT;

-- ���� ���� DEPT_CODE�� NULL�ΰ��� ������ ���� ����

--------------------------------------------------------------------------------
/*
    2. �������� / �ܺ����� (OUTER JOIN)
    �� ���̺� ���� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT / RIGHT �����ؾߵ�!! (������ �Ǵ� ���̺� ����)
*/

-- �����, �μ���, �޿�, ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- �μ� ��ġ�� ���� �ȵ� ��� 2�� ���� ������ ��ȸ X
-- �μ��� ������ ����� ���� �μ����� ��쵵 ��ȸ X

-- 1) LEFT [OUTER] JOIN : �� ���̺� �� ���� ����� ���̺� �������� JOIN
-- ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE -- EMPLOYEE�� �ִ°� �ٳ���, ���ʿ� �־
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- �μ���ġ ���� �ʾҴ� 2���� ��� ������ ��ȸ��.

-- ����Ŭ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- �������� ������ϴ� ���̺��� �ݴ����� �÷��ڿ� (+)�� ���̱�!!!

-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
-- ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ����Ŭ ���뱸��
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3. FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ���� (��, ����Ŭ ���뱸�����δ� �ȵ�)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

/*
    3. �� ���� (NON EQUAL JOIN) => ��� �׳� �����
    ��Ī��ų �÷��� ���� ���� �ۼ��� '=(��ȣ)' �� ������� �ʴ� ���ι�
    ANSI �������δ� JOIN ON �� ��� ����
*/

SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE;

SELECT *
FROM SAL_GRADE;

-- �����, �޿�, �ִ� ���� �ѵ�
-- ����Ŭ ����
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI ����
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

--------------------------------------------------------------------------------
/*
    4. ��ü���� (SELF JOIN)
    ���� ���̺��� �ٽ��ѹ� �����ϴ� ���
    
*/

SELECT * FROM EMPLOYEE;

-- ��ü ����� ���, �����, ����μ��ڵ�       => EMPLOYEE E
--     ����� ���, �����, ����μ��ڵ�       => EMPLOYEE M

-- ����Ŭ ���뱸��
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE AS "����μ��ڵ�",
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE AS "����μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID FROM EMPLOYEE;

-- ANSI ���뱸��
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE AS "����μ��ڵ�",
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE AS "����μ��ڵ�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);
-- ������� ����� ������ �Ϸ��� LEFT JOIN

--------------------------------------------------------------------------------
/*
    ���� JOIN
    2�� �̻��� ���̺��� ������ JOIN �� ��
*/

-- ���, �����, �μ���, ���޸� ����

SELECT * FROM EMPLOYEE;         -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT;       -- DEPT_ID
SELECT * FROM JOB;              --            JOB_CODE

-- ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;

-- ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN JOB USING(JOB_CODE);

-- ���, �����, �μ���, ������
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE

-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

-- ANSI ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
----------------------------------�ǽ�����---------------------------------------
-- 1. ���, �����, �μ���, ������, ������ ��ȸ (EMP, DEP, LOC, NAT ����)

-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_ID = DEPT_CODE AND LOCATION_ID = LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING(NATIONAL_CODE);

 -- 2. ���, �����, �μ���, ���޸�, ������, ������, �ش� �޿���޿��� ���� �� �ִ� �ִ�ݾ� ��ȸ
 
 -- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME ,LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J
WHERE DEPT_ID = DEPT_CODE AND LOCATION_ID = LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE
      AND E.JOB_CODE = J.JOB_CODE;



-- ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME ,NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN JOB USING(JOB_CODE);
 

SELECT *
FROM EMPLOYEE;

SELECT *
FROM DEPARTMENT;

SELECT *
FROM LOCATION;

SELECT *
FROM NATIONAL;

SELECT *
FROM JOB;







