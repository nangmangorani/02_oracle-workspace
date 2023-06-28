/*
    �������� (SUBQUERY)
    - �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SELECT ��
    - ���� SQL���� ���� ���� ������ �ϴ� ������
    
*/

-- ���� �������� ����1
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ�ϰ� ����!!!

-- 1) ���� ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; --D9

-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� �� �ܰ踦 �ϳ��� ���������� �� �� ����!!!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '���ö');

-- ���� �������� ����2
-- �� ������ ��ձ޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ

-- 1) �� ������ ��ձ޿���ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE; -- �뷫 3047663�� �ΰ� �˾Ƴ�

-- 2) �޿��� 3047663���̻��� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- ���� 2�ܰ踦 �ϳ��� ����������!!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);

--------------------------------------------------------------------------------
/*
    ���������� ����
    �������� ������ ������� �� �� ��̳Ŀ� ���� �з���
    
    - ������ �������� : ���������� ��ȸ ������� ������ ������ 1���ϴ� (���� �ѿ�)
    - ������ �������� : ���������� ��ȸ ������� �������϶� (������ �ѿ�) => �������� ���ö 2���� ��
    - ���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� �� (���� ������)
    - ������ ���߿� �������� : �������� ��ȸ ������� ������ ���� �÷��� ��(������, ������)
    
    >> �������� ������ ���Ŀ� ���� �������� �տ� �ٴ� �����ڰ� �޶���!
    
*/

/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� ������ ������ 1���� �� (���� �ѿ�)
    �Ϲ� �񱳿����� ��� ����
    =,!=,^=,<>,<,>,>=....
*/

-- 1) �� ������ ��� �޿����� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
-- 2) ���� �޿��� �޴� ����� ���, �̸�, �޿�, �Ի���
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

-- 3) ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '���ö');


-- ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-- 4) �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿� �� ��ȸ
-- 4-1) ���� �μ����� �޿��� �߿����� ���� ū �� �ϳ��� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; --17700000

-- 4-2) �μ��� �޿����� 17700000���� �μ� ��ȸ(�μ��ڵ�, �޿���)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

-- ���� �� �ܰ踦 �ϳ��� ����������!
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
                      
-- �����غ���
-- ������ ����� ���� �μ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ���
-- ��, �������� ����

-- ����Ŭ ���� ����
    
    
   

    SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
    FROM EMPLOYEE, DEPARTMENT
    WHERE DEPT_CODE = DEPT_ID 
    AND DEPT_CODE = (SELECT DEPT_CODE
                     FROM EMPLOYEE
                     WHERE EMP_NAME = '������')
    AND EMP_NAME != '������';
    

   
    SELECT *
    FROM EMPLOYEE;
   
    SELECT *
    FROM DEPARTMENT;

-- ANSI ����


--------------------------------------------------------------------------------
/*
    ������ �������� (MULTI ROW SUBQUERY)
    ���������� ������ ������� ���� �� �϶� (�÷�(��)�� �Ѱ�)
    
    IN �������� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ� 
    
    > ANY �������� : �������� ����� �߿��� "�Ѱ���" Ŭ ��� (�������� ����� �� ���� ���� ������ Ŭ ���)
    < ANY �������� : �������� ����� �߿��� "�Ѱ���" ���� ��� (�������� ����� �߿��� ���� ū ������ ���� ���)
    
    �񱳴�� > ANY (��1, ��2, ��3)
    �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3
    
    ALL �������� : �������� "���" ������� ���� Ŭ ���
    ALL �������� : �������� "���" ������� ���� ���� ���
    
    �񱳴�� > ALL (��1, ��2, ��3)
    �񱳴�� > ALL (��1, ��2, ��3) AND�� ��!!
    
*/

-- 1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿�

-- 1-1) ����� �Ǵ� ������ ����� � �������� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����','������'); -- J3, J7

-- 1-2) J3, J7 ������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('�����','������')); -- =�̶�� ���� ������!! ���������� ��ȸ�Ʊ� ����!!
                   -- ���࿡ ������� ������ ���� �� ������ IN���� ���°� ������
                   
-- ��� -> �븮 -> ���� -> ���� -> ����
-- 2) �븮�����ӿ��� �ұ��ϰ� ���� ���ؼ� ���� ���� �޿��� �� �ּұ޿����� �� ���� �޴� ������ ��ȸ (���,�̸�,����,�޿�)
-- 2-1) ���� ���� ���� ������� �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '����'; -- 2200000 2500000 3760000

-- 2-2) ������ �븮�̸鼭 �޿����� ���� ��ϵ� �� �߿� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (2200000, 2500000, 3760000);

-- ���� �� �ܰ踦 �ϳ��� ������
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT MIN(SALARY)
                  FROM EMPLOYEE E, JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND J.JOB_NAME = '����');

-- ������ ���������ε� ����!!

-- 3) ���� �����ӿ��� �ұ��ϰ� ���������� ������� ��� �޿����ٵ� �� ���� �޴� ������� ���, �̸�, ���޸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
--AND SALARY > (�������� �ֵ��� �޿�)
AND SALARY > ALL(SELECT SALARY
              FROM EMPLOYEE
              JOIN JOB USING(JOB_CODE)
              WHERE JOB_NAME = '����');
--------------------------------------------------------------------------------

/*
    ���߿� ��������
    ������� �� �������� ������ �÷����� �������� ���
    
*/

-- 1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ(�����, �μ��ڵ�, �����ڵ�, �Ի�����)
-- ������ �������� ** 2���� ���������� �ۼ��� ��

SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������')
AND DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������');

-- ���߿� ����������!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
--WHERE (DEPT_CODE, JOB_CODE) = (����������� �μ��ڵ�, ����������� �����ڵ�);
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '������'); -- ���� �߿�!! ���� �������!
        
-- �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');
                                
--------------------------------------------------------------------------------

/*
    4. ������ ���߿� ��������
    �������� ��ȸ ������� ������ �������� ���
    
*/

-- 1) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ (���, �����, �����ڵ�, �޿�)
-- �� ���޺� �ּұ޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY) --3
FROM EMPLOYEE --1
GROUP BY JOB_CODE; --2

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
OR    JOB_CODE = 'J7' AND SALARY = 1380000;

-- ���������� �����ؼ� �غ���!!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);
                             
-- 2) �� �μ��� �ְ� �޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN(SELECT DEPT_CODE, MAX(SALARY)
                          FROM EMPLOYEE
                          GROUP BY DEPT_CODE); 
--------------------------------------------------------------------------------

/*
    �ζ��� ��(INLINE - VIEW)
    
    ���������� ������ ����� ��ġ ���̺�ó�� ����ϴ°�
*/

-- ������� ���, �̸�, ���ʽ����Կ��� (��Ī�ο� : ����), �μ��ڵ� ��ȸ => ���ʽ� ���� ������ ���� NULL�� �ȳ�����
-- ��, ���ʽ� ���� ������ 3000 �̻��� ����鸸 ��ȸ
SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE 
WHERE (SALARY + SALARY * NVL(BONUS,0))*12 >= 30000000;

SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE;
-- �̰� ��ġ �����ϴ� ���̺��� ����� �� ����!! �װ� �ζ��κ�

SELECT EMP_NO, EMP_NAME, ����, DEPT_CODE -- MANAGER_ID�� ������
FROM (SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE) -- 1
WHERE ���� >= 30000000;




SELECT MAX_SAL
FROM SAL_GRADE;

SELECT *
FROM SAL_GRADE;




SELECT *
FROM EMPLOYEE;

SELECT *
FROM DEPARTMENT;

SELECT *
FROM SAL_GRADE;















