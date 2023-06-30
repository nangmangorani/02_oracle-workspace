-- 1.
SELECT *
FROM EMP;

-- 2.
SELECT EMPNO, ENAME, SAL
FROM EMP;

-- 3. 
SELECT ENAME || SAL
FROM EMP;

-- 4.
SELECT ENAME ||'의 월급은 '||SAL|| '입니다.'
FROM EMP;

-- 5.
SELECT ENAME ||'의 직업은 '||JOB|| '입니다.'
FROM EMP;

-- 6-1.
SELECT DISTINCT JOB
FROM EMP;

-- 6-2.
SELECT JOB
FROM EMP
GROUP BY JOB;

-- 7-1.
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL;

-- 7-2.
SELECT ENAME, SAL AS "월급"
FROM EMP
ORDER BY 월급;

-- 7-3. 뭔소리지..?
SELECT ENAME, SAL AS "월급"
FROM EMP;

-- 8.
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL = 3000;

-- 9.
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL >= 3000;

-- 10.
SELECT ENAME, SAL, JOB, HIREDATE, DEPTNO
FROM EMP
WHERE ENAME = 'SCOTT';

-- 11.
SELECT ENAME, SAL * 12
FROM EMP
WHERE SAL * 12 >= 3600;

-- 12.
SELECT ENAME, SAL, COMM, SAL + COMM
FROM EMP
WHERE DEPTNO = 10;

-- 13-1.
SELECT ENAME, SAL
FROM EMP
WHERE SAL BETWEEN 1000 AND 3000;

-- 13-2.
SELECT ENAME, SAL
FROM EMP
WHERE SAL >= 1000 AND SAL <= 3000;

-- 14.
SELECT ENAME, SAL
FROM EMP
WHERE ENAME LIKE 'S%';

-- 15.
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '_M%';

-- 16.
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%T';

-- 17.
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%A%';

-- 18.
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NULL;

-- 19-1.
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB IN('SALESMAN', 'ANALYST', 'MANAGER');

-- 19-2.
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'SALESMAN' OR JOB = 'ANALYST' OR JOB = 'MANAGER';

-- 20.
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'SALESMAN' AND SAL>= 1200;

-- 21. LOWER, UPPER, INITCAP
SELECT LOWER(ENAME)
FROM EMP;

SELECT UPPER(ENAME)
FROM EMP;

SELECT INITCAP(ENAME)
FROM EMP;

-- 22.
SELECT LOWER(ENAME), SAL
FROM EMP
WHERE ENAME = 'SCOTT';

-- 23.
SELECT SUBSTR('SMITH',1,3)
FROM DUAL;

-- 24.
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- 25.
SELECT LENGTH('가나다라마')
FROM DUAL;

-- 26.
SELECT LENGTHB('가나다라마')
FROM DUAL;

-- 27.
SELECT INSTR(ENAME,'M')
FROM EMP
WHERE ENAME = 'SMITH';

-- 28.
SELECT SUBSTR('abcdefg@naver.com', INSTR('abcdefg@naver.com', '@')+1)
FROM DUAL;

-- 29.
SELECT ENAME, REPLACE(SAL,0,'*')
FROM EMP;

-- 30.
/*
CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형,
        */
CREATE TABLE TEST_ENAME(
ENAME VARCHAR2(10));

SELECT * FROM TEST_ENAME;

-- 31.
INSERT INTO TEST_ENAME VALUES('김시연');
INSERT INTO TEST_ENAME VALUES('차은우');
INSERT INTO TEST_ENAME VALUES('주지훈');

/*
INSERT INTO 테이블명 VALUES (값1, 값2, 값3...);
*/

-- 32.
COMMIT;

-- 33.
SELECT SUBSTR(ENAME,1,1)||'*'||SUBSTR(ENAME,3)
FROM TEST_ENAME;

-- 34. LPAD / RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자 하는 문자])
SELECT ENAME, RPAD(SAL,10,'*')
FROM EMP;

-- 35. 
SELECT 'smith'
FROM DUAL;

SELECT LTRIM('smith','s')
FROM DUAL;

SELECT RTRIM('smith','h')
FROM DUAL;

SELECT TRIM(BOTH  's' FROM 'smiths')
FROM DUAL;

SELECT TRIM(LEADING 's' FROM 'smiths')
FROM DUAL;

SELECT TRIM(TRAILING  's' FROM 'smiths')
FROM DUAL;

-- 36.
SELECT ENAME
FROM EMP;

-- 37.
SELECT ROUND(876.567,2)
FROM DUAL;

-- 38.
SELECT TRUNC(876.567,2)
FROM DUAL;

-- 39.
SELECT MOD(10,3)
FROM DUAL;

-- 40.


SELECT *
FROM DEPT;

SELECT *
FROM EMP;

SELECT *
FROM SALGRADE;