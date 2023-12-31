-- 3.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                        FROM TB_DEPARTMENT
                        WHERE DEPARTMENT_NAME = '국어국문학과')
AND ABSENCE_YN = 'Y' AND SUBSTR(STUDENT_SSN,8,1) IN (2,4);


-- 12.
SELECT SUBSTR(TERM_NO,1,4) AS "년도", ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
HAVING SUBSTR(TERM_NO,1,4) BETWEEN 2001 AND 2004
ORDER BY SUBSTR(TERM_NO,1,4);

-- 13.
SELECT DEPARTMENT_NO, COUNT(DECODE(ABSENCE_YN,'Y','Y'))
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 14.
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) >= 2;

-- 15.
SELECT SUBSTR(TERM_NO,1,4), NVL(SUBSTR(TERM_NO,5,2),' '), ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2))
ORDER BY SUBSTR(TERM_NO,1,4);


-- 10.
SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME;


SELECT *
FROM TB_DEPARTMENT;

SELECT *
FROM TB_CLASS;

SELECT *
FROM TB_CLASS_PROFESSOR;

SELECT *
FROM TB_PROFESSOR;

SELECT *
FROM TB_STUDENT;

SELECT *
FROM TB_GRADE;
