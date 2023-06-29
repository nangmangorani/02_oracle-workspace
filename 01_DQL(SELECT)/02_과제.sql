

-- 1.
SELECT *
FROM JOB;

-- 2.
SELECT JOB_NAME
FROM JOB;

-- 3.
SELECT *
FROM DEPARTMENT;

-- 4.
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--5.
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 6.
SELECT EMP_NAME, SALARY*12, (SALARY + SALARY * NVL(BONUS,0))*12 AS "총수령액",
      (SALARY + SALARY * NVL(BONUS,0))*12 - (SALARY*12*0.03) AS "실수령액"
FROM EMPLOYEE;

-- 7.
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 8.
SELECT EMP_NAME, SALARY, (SALARY + SALARY * BONUS)*12 - (SALARY*12*0.03) AS "실수령액",
       HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY + SALARY * BONUS)*12 - (SALARY*12*0.03)>= 50000000;

-- 9.
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- 10.
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE < '02/01/01';

-- 11.
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- 12.
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 13. NULL값 포함함
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%' OR PHONE IS NULL;

-- 14.
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____#_%' ESCAPE '#' AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
AND (HIRE_DATE BETWEEN '90/01/01' AND '00/12/01') AND SALARY >= 2700000;

-- 15. 어케했누
SELECT EMP_NAME, 
EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,6))) AS "생년",
EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO,1,6)))AS "생월",
EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO,1,6)))AS "생일"
FROM EMPLOYEE;

-- 16.
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8), 14, '*') AS "주민번호"
FROM EMPLOYEE;

-- 17.
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) AS "근무일수1", ABS(FLOOR(HIRE_DATE - SYSDATE)) AS "근무일수2"
FROM EMPLOYEE;

-- 18.
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- 19.
SELECT *
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)>= 20;

-- 20.
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999')
FROM EMPLOYEE;

-- 21.
/*
생년월일 -> 문자 : 날짜
TO_DATE로 문자 -> 날짜
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,6)))
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
*/


SELECT EMP_NAME, DEPT_CODE,TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,6),'RRMMDD'),'RRRR"년" MM"월" DD"일"'), EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,6))) AS 나이
FROM EMPLOYEE;

-- 22. CASE WHEN 조건식1 THEN 결과값1

SELECT DEPT_CODE,
DECODE(DEPT_CODE, 'D5', '총무부', 'D6', '기획부', 'D9', '영업부') AS "부서"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE;


-- 23.
SELECT EMP_ID, SUBSTR(EMP_NO,1,6)AS "주민번호 앞자리", SUBSTR(EMP_NO,8,14)AS "주민번호 뒷자리", SUBSTR(EMP_NO,1,6) + SUBSTR(EMP_NO,8,14) AS "주민번호 합"
FROM EMPLOYEE
WHERE EMP_ID = 201;

-- 24.
SELECT DEPT_CODE, SUM((SALARY + SALARY * NVL(BONUS,0))*12)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING DEPT_CODE = 'D5';

-- 25. EXTRACT(YEAR FROM DATE)
/*
SELECT EXTRACT(YEAR FROM HIRE_DATE), COUNT(*)
FROM EMPLOYEE
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
HAVING EXTRACT(YEAR FROM HIRE_DATE) IN (2001,2002,2003,2004);
*/

SELECT COUNT(*) AS "전체직원수",
COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2001', '*')) AS "2001년",
COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2002', '*')) AS "2002년",
COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2003', '*')) AS "2003년",
COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2004', '*')) AS "2004년"
FROM EMPLOYEE;


