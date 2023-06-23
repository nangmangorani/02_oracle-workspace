/*
    <SELECT>
    데이터 조회할 때 사용되는 구문
    
    >> RESULT SET : SELECT문을 통해 조회된 결과물(즉, 조회된 행들의 집합을 의미)
    
    [표현법]
    SELECT 조회하고자 하는 컬럼1, 컬럼2,...
    FROM 테이블명;
    
    * 반드시 존재하는 컬럼으로 써야한다!! 없는 컬럼 쓰면 오류남!
    
*/

-- EMPLOYEE 테이블의 모든 컬럼(*) 조회
--SELECT EMP_ID, EMP_NAME
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;

-------------------실습문제------------------------------
-- 1. JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;
-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;
-- 3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    SELECT 절 컬럼명 작성부분에 산술연산 기술 가능 (이때, 산술연산된 결과 조회)
    
*/

-- EMPLOYEE 테이블의 사원명, 사원의 연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스를 포함시킨 연봉(((급여 + 보너스) * 급여) * 12) 조회
SELECT EMP_NAME, SALARY, BONUS, BONUS * 12, ((SALARY + BONUS * SALARY)*12)
FROM EMPLOYEE;
--> 산술연산 과정중 NULL 값이 존재할 경우 산술연산한 결과값 마저도 무조건 NULL로 나옴

--> EMPLOYEE 테이블의 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE에 사원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE형식끼리도 연산이 가능함
-- !!오늘 날짜!! : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- DATE - DATE : 결과값은 일 단위가 맞음!
-- 단, 값이 지저분한 이유는 DATE 형식 년/월/일/시/분/초 단위로 시간정보까지도 관리 하기 때문
-- 함수적용하면 깔끔한 결과 확인 가능 => 나중에 배움!

-------------------------------------------------------------------------------
/*
    <컬럼명에 별칭 지정하기>
    산술연산을 하게 되면 컬럼명 지저분함... 이때 컬럼명으로 별칭부여해서 깔끔하게 보여줌
    
    [표현법]
    컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
    
    AS 붙이든 안붙이든 부여하고자 하는 별칭에 띄어쓰기가 있거나 특수문자가 포함될경우 반드시 쌍다옴표로 묶어줘야함
*/

SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY * 12 AS "연봉(원)", (SALARY + SALARY * BONUS) * 12 AS "총 소득(보너스포함)"
FROM EMPLOYEE;

--------------------------------------------------------------------------------------------------
/*
    <리터럴>
    임의로 지정한 문자열('')
    
    SELECT 절에 리터럴을 제시하면 마치 테이블상에 존재하는 데이터처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
    
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_NO, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;

/*
    <연결 연산자 : ||>
    여러 컬럼값들을 마치 하나의 컬럼인 것 처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
    
    System.out.println("num의 값 : " + num); 자바에선 +
*/

-- 사번, 이름, 급여 하나의 컬럼으로 조회
SELECT EMP_NO || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼값과 리터럴값을 연결
-- XXX의 월급은 XXX원입니다. => 컬럼명 별칭 : 급여정보

SELECT EMP_NAME||'의 월급은 '||SALARY||'원입니다.' 급여정보
FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    <DISTINCT>
    컬럼에 중복된 값들을 한 번씩만 표현하고자 할 때 사용
*/

-- 현재 우리회사에 어떤 직급의 사람들이 존재하는지 궁금함.

SELECT JOB_CODE
FROM EMPLOYEE; -- 현재는 23명의 직급이 전부다 조회가 됨.

-- EMPLOYEE에 직급코드(중복제거) 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- 중복 제거 돼서 7행만 조회

-- 사원들이 어떤 부서에 속해있는지 궁금하다.
SELECT DISTINCT DEPT_CODE -- null : 아직 부서배치 안된사람
FROM EMPLOYEE;

-- 유의사항 : DISTINCT는 SELECT 절에 딱 한번만 기술 가능
/* 구문오류
SELECT DISTINCT JOB_CODE DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) 쌍으로 묶어서 중복 판별

-- ==========================================================================

/*

    <WHERE 절>
    조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용
    이때 WHERE절에 조건식을 제시하게 된다.
    조건식에서는 다양한 연산자 사용 가능
    
    [표현식]
    SELECT 컬럼1, 컬럼2, ...
    FROM 테이블명
    WHERE 조건식;
    
    [비교연산자]
    >, <, >=, <=   --> 대소비교
    =              --> 동등비교
    ~=, ^=, <>     --> 동등하지 않은지 비교
*/

-- EMPLOYEE 에서 부서코드가 'D9'인 사원들만 조회(이때, 모든 컬럼 조회)
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드만 조희
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE에서 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';
-- 급여 400만원 이상인 사원들의 사원명, 부서코드 ,급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE에서 재직중(ENT_YN 컬럼값이 'N')인 사원들의 사번, 이름, 입사일
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

----------------------------------실습문제------------------------------------------

-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(보너스 미포함) 조회
-- 2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
-- 3. 직급코드 'J3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회

-- 1.
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY * 12
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2.
SELECT EMP_NAME, SALARY, SALARY * 12, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000;
-- WHERE절에서는 SELECT 절에 작성된 별칭 사용 불가!!

-- 쿼리 실행 순서
-- FROM절 => WHERE절

-- 3.
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE <> 'J3';

-- 부서코드가 'D9' 이면서 급여가 5000000원 이상인 사원들의 사번, 사원명, 급여, 부서코드 조회

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D6' 이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY>= 3500000 AND SALARY <= 6000000; -- 일반적으로는 이 순서로!!
------------------------------------------------------------------------------

/*
    <BETWEEN AND>
    조건식에서 사용되는 구문
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자
    
    [표현법]
    비교대상컬럼 BETWEEN A(값1) AND B(값2)
    => 해당 컬럼값이 A(값1) 이상이고 B(값2) 이하인 경우
    
*/ 

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- 위의 쿼리 범위 밖의 사람들 조회하고 싶다면? 350 미안 + 600 초과
-- NOT : 논리부정연산자 => 자바에서의 !
-- 컬럼명 앞 또는 BETWEEN 앞에 기입가능!

-- 입사일이 '90/01/01' ~ '01/01/01'
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01'; -- DATE 형식은 대소비교 가능
WHERE HIRE_DATE BETWEEN '90-01-01' AND '01-01-01';

------------------------------------------------------------------------------------------

/*
    <LIKE>
    비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴'
    
    - 특정패턴 제시시 '%', '_' 를 와일드카드로 사용할 수 있음
    
    >> '%' : 0글자 이상
    
    EX) 비교대상컬럼 LIKE '문자%' => 비교대상의 컬럼값이 문자로 시작되는걸 조회
        비교대상컬럼 LIKE '%문자' => 비교대상의 컬럼값이 문자로 끝나는걸 조회
        비교대상컬럼 LIKE '%하%' => 비교대상의 컬럼값에 문자가 "포함"되는걸 조회 (키워드 검색)

    >> '_' : 1글자 이상
    EX) 비교대상컬럼 LIKE '_문자'       => 비교대상의 컬럼값에 문자앞에 무조건 한글자만 올 경우 조회
        비교대상컬럼 LIKE '__문자'      => 비교대상의 컬럼값에 문자앞에 무조건 두글자가 올 경우 조회
        비교대상컬럼 LIKE '_문자_'      => 비교대상의 컬럼값에 문자앞과 뒤에 무조건 한글자가 올 경우
        
*/
-- 사원들 중에 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

-- 이름이 하로 끝나는 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하';

-- 이름중에 하가 포함된 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 이름의 가운데 글자가 하 인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의 3번째 자리가 1인 사원들의 사번, 사원명, 전번, 이메일 조회
-- 와일드카드 : _(1글자), %(0글자)
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ** 특이케이스
-- 이메일 중 _ 기준으로 앞글자가 3글자인 사원들의 사번, 이름, 이메일 조회
-- ex) sim_bs@kh.or.kr sun_di@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- 원했던 결과 도출 못함!
-- 와일드카드로 사용되고 있는 문자와 컬럼값에 담긴 문자가 동일하기 때문에 제대로 조회가 안됨
--> 어떤게 와일드카드고 어떤게 데이터값인지 구분지어야됨!
--> 데이터 값으면 취급하고자 하는 값 앞에 나만의 와일드 카드를 제시하고 나만의 카드를 ESCAPE OPTION으로 등록해야됨!

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--------------------------------실습문제-------------------------------
-- 1. EMPLOYEE 테이블에서 이름이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE 테이블에서 전화번호가 처음 3자리가 010이 아닌 사원들의 사원명, 전번을 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. EMPLOYEE 테이블에서 이름에 '하'가 포함되어있고 급여가 240만원 이상인 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;

-- 4. DEPARTMENT 테이블에서 해외영업부 부서들의 코드, 부서명을 조회
SELECT DEPT_ID, DEPT_TITLE 
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';











