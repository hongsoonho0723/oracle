  /*문자열 함수
    - upper(문자열) => 모두 대문자
    - lower(문자열) => 모두 소문자
    - initcap(문자열)=> 단어의 첫 글자 대문자로 표현
    
    - length(문자열) => 문자열의 길이
    
    - substr(문자열, 시작, 개수) => 문자의 일부분 추출
       EX) substr(문자열, INDEX) : 문자열에서 INDEX 부터 끝까지 추출
           substr(문자열, INDEX, 개수) : 문자열에서 INDEX 부터 개수 까지 추출
           
           * INDEX는 1 부터 시작한다.
           
           
    - instr(문자열, 찾을문자열) => 찾을 문자열의 출현 위치(INDEX) 알려줌
    - instr(문자열, 찾을문자열, 시작번지수, 몇번째 출현)
       ex)instr(job,'A') => JOB에서 왼쪽부터 A 가 처음 출현하는 위치를 알려준다.
          instr(job,'A' , 시작번지수) => JOB에서 왼쪽에서 시작번지수 부터 A 가 처음 출현하는 위치를 알려준다.
          instr(job,'A' , -1) => JOB에서 오른쪽부터 A 가 처음 출현하는 위치를 알려준다.
          
          instr(job,'A' ,3,  2) =>왼쪽부터 A를 찾는데 3째부터 시작해서 2번째로 나오는 A를 찾아라
          
          * 만약, 찾는 문자열이 없으면 0 이다. 
          
    - lpad(문자열, 전체자리수, 특정문자) 
     => 오른쪽 정렬 후 왼쪽 빈 공백에 특정문자로 채움
     
    - Rpad(문자열, 전체자리수, 특정문자) 
     => 왼쪽 정렬 후 오른쪽 빈 공백에 특정문자로 채움)
     
    - ltrim() => 왼쪽 공백제거
    - rtrim()=> 오른쪽 공백제거
 */
 

SELECT ENAME ,UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME), LENGTH(ENAME), LENGTHB(ENAME)
  FROM EMP;

SELECT '희정' , LENGTH('희정'),LENGTHB('희정') FROM DUAL; -- LENGTH는 CHAR  LENGTHB는 byte 수

-- SUBSTR(문자열, 시작, 개수) 문자열에서 시작부터 개수만큼 문자열 추출, 개수 생략하면 시작부터 끝까지 추출
SELECT JOB, SUBSTR(JOB, 1, 3) ,SUBSTR(JOB, 2, 3), SUBSTR(JOB, 3)
  FROM EMP;

  
-- SUBSTR(문자열, 시작, 개수): 시작을 0으로 하면 그냥 1로 본다. 음수를 주면 오른쪽 부터
SELECT JOB, SUBSTR(JOB, 0, 3), SUBSTR(JOB, -4, 3)
  FROM EMP;



-- INSTR(문자열, 문자, 시작, 몇번째 출현): 문자열에서 두번째인수문자가 몇 번째에 있는 지 찾아주는 함수
SELECT 'ABCDE ABCDE ABCDE ABCDE'
       ,INSTR('ABCDE ABCDE ABCDE ABCDE', 'C')
       ,INSTR('ABCDE ABCDE ABCDE ABCDE','C', 5)
       ,INSTR('ABCDE ABCDE ABCDE ABCDE','C', 5, 2)  --두번째에 오는 
  FROM DUAL;
  
  
  SELECT * FROM teacher;
  
-- ex) 이메일 주소에 @전까지 출력, @이후부터 출력 

SELECT TEACHER_EMAIL AS 이메일,SUBSTR( TEACHER_EMAIL, 1,(INSTR(TEACHER_EMAIL,'@')-1 )) AS 앞 ,SUBSTR( TEACHER_EMAIL, (INSTR(TEACHER_EMAIL,'@')+1 )) AS 뒤
FROM TEACHER;






 /*
   숫자 관련 함수
   - round(숫자, 자리수)=> 반올림
   
   - ceil(숫자) => 올림 한 후 정수반환 소수점 자리 X
   - floor(숫자)=>내림 한 후 정수 반환 소수점 자리 X
   
   - mod(숫자, 나눌수) => 나머지
   - trunc(숫자, 자리수)=> 버림
 */
  
-- ROUND
SELECT 231.45136, ROUND(231.45136,2), ROUND(231.45136 , -2), ROUND(231.45136, 0) 
FROM DUAL;
  
-- TRUNC
SELECT 231.45136, TRUNC(231.45136,2), TRUNC(231.45136 , -2), TRUNC(231.45136, 0)
  FROM DUAL;
  
-- CEIL, FLOOR
SELECT 231.45136, CEIL(231.45136), FLOOR(231.45136)
  FROM DUAL;
  
  
SELECT SAL, MOD(SAL, 2)
  FROM EMP;
  

/*
   날짜 함수
   - sysdate => 현재날짜와 시간
   - months_between(날짜, 날짜) => 두 날짜 사이의 개월 수를 구함
   - add_months(날짜, 숫자) => 날짜에서 숫자만큼 월을 더함.
   
   - next_day(날짜, 요일) => 날짜에서 가장 가까운 요일의 날짜구함
       (1 = 일요일 , 2 = 월요일,..... )
       
   - last_day(날짜) => 날짜 달의 마지막 날짜를 구함
*/

SELECT EMPNO, HIREDATE, trunc(SYSDATE-HIREDATE,0), HIREDATE+5
, TO_CHAR(HIREDATE + 1/24, 'YYYY-MM-DD HH:MI:SS')
, TO_CHAR(HIREDATE, 'YYYY-MM-DD HH:MI:SS')
FROM EMP;


SELECT 

 TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS'),
  TO_CHAR(sysdate + 4, 'YYYY-MM-DD HH:MI:SS'), 
   TO_CHAR(sysdate + 4/24, 'YYYY-MM-DD HH:MI:SS'),
    TO_CHAR(sysdate - 8/24, 'YYYY-MM-DD HH:MI:SS'),
        TO_CHAR(sysdate - 4/12, 'YYYY-MM-DD HH:MI:SS'),
        TO_CHAR(sysdate - 8/60, 'YYYY-MM-DD HH:MI:SS')

FROM dual;

SELECT SYSDATE ,TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS')
FROM DUAL;




SELECT SYSDATE, EXTRACT(DAY FROM SYSDATE) AS 일, 
EXTRACT(MONTH FROM SYSDATE)AS 월,
EXTRACT(YEAR FROM SYSDATE) AS 년
 FROM DUAL;
  
  
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD'), TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'YYYY')
  FROM DUAL;

-- 입사일 -> 2002년 10월 2일 
SELECT HIREDATE, TO_CHAR(HIREDATE, 'YYYY') || '년', CONCAT(TO_CHAR(HIREDATE, 'MM'), '월')
  FROM EMP;


SELECT HIREDATE, TO_CHAR(HIREDATE, 'YYYY"년"MM"월"DD"일"')
  FROM EMP;


-- 기간
SELECT TRUNC(SYSDATE - TO_DATE('2024-1-23')) AS 만난일수
  FROM DUAL;

-- 100일
SELECT TO_DATE('2023-3-2') + 100
  FROM DUAL;

SELECT TO_DATE(SYSDATE+7) FROM DUAL;

  /*데이터타입 변환

   TO_CHAR()
 TO_DATE()
 TO_NUMBER()
   - to_char(datetime, format형식)=> 날짜를 format형식으로 변환
   
     ex) to_char(sysdate , 'YYYY-MM-DD')
         to_char(sysdate , 'YYYY-MM-DD HH:MI:SS')
         to_char(sysdate , 'YYYY-MM-DD HH24:MI:SS')
         
    - to_char(number, format형식)=> 숫자를 format형식으로 변환
     ex) 3자로 콤마
     to_cahr(2000, '999,999') => 2,000
     to_cahr(2000, 'L999,999') => \2,000 => 지역에 따른 화페표시
     to_cahr(2000, '$999,999') => $2,000 
     
    - to_date(문자열) => 문자를 날짜로 변환
    
    - to_number(문자열)=> 문자를 숫자로 변환

 */

SELECT SAL,TO_CHAR(SAL,'999,999') FROM EMP;



------------------------------------------------
 /* NULL에 관련된 함수 : NVL(),NVL2(), NULLIF() , COALESCE()
    1) NVL(대상,변경값) : 대상에서 NULL있으면 변경값으로 대체
    2) NVL2(대상, NULL 아닌경우 , NULL 인경우 )
        EX) MGR이 NULL이 아니면 두번째 인수를 , NULL이면 세번째인수를 리턴
    3) NULLIF는 첫번째 인수와 두번째 인수를, NULL이면 세번재인수 리턴
    4) COALESCE 함수 : 가장 먼저 NULL이 아닌 것을 반환
    
 NVL2함수  ex) MGR이 NULL이 아니면 두번째 인수를, NULL이면 세번째인수 리턴
 
 */
 --NVL2함수 이용
SELECT EMPNO, ENAME, MGR  ,NVL2(MGR, MGR||'는 관리자','최고관리자')
  FROM EMP;

--NVL2함수 이용
SELECT EMPNO,COMM,NVL2(COMM,COMM*12,30), NVL(COMM,30) FROM EMP;

 --NULLIF는 첫번째 인수와 두번째 인수가 같다면 NULL 아니면 첫번째 인수의 값
SELECT EMPNO, JOB, NULLIF(JOB, 'MANAGER')  FROM EMP;


--COALESCE함수 ; 가장 먼저 NULL이 아닌 것을 반환
SELECT ENAME, COMM, SAL, COALESCE(COMM, SAL, 50) RESULT
  FROM EMP;

SELECT COALESCE(100, NULL,200,300) FROM DUAL;
SELECT COALESCE(NULL, 100,200,300) FROM DUAL;
SELECT COALESCE(NULL, NULL,200,300) FROM DUAL;
SELECT COALESCE(NULL, NULL,NULL,300) FROM DUAL;

-------------------------------------------------------------------------


 CREATE TABLE REPORT(
 NAME VARCHAR2(20) CONSTRAINT REPORT_NAME_PK PRIMARY KEY,
 BAN CHAR(1),
 KOR NUMBER(3) CHECK(KOR BETWEEN 0 AND 100),
 ENG NUMBER(3) CHECK(ENG BETWEEN 0 AND 100),
 MATH NUMBER(3) CHECK(MATH BETWEEN 0 AND 100)
);

SELECT * FROM REPORT;

--샘플레코드
INSERT INTO REPORT VALUES('희정', 1 , 80, 70,90);
INSERT INTO REPORT VALUES('효리', 1 , 90, 50,90);

INSERT INTO REPORT VALUES('나영', 2 , 100, 65,85);
INSERT INTO REPORT VALUES('재석', 2 , 80, 70, 95);
INSERT INTO REPORT VALUES('희선', 2 , 85, 45,80);

INSERT INTO REPORT VALUES('승기', 3 , 50, 70,70);
INSERT INTO REPORT VALUES('중기', 3 , 90, 75,80);
INSERT INTO REPORT VALUES('혜교', 3 , 70, 90,95);
INSERT INTO REPORT VALUES('미나', 3 , NULL, 80,80);

 /*
  SELECT절에서 조건에 따라 실행문장을 다르게 할수 있도록 하는 함수
   1) decode(대상, 값, 문장, 값, 문장, 값, 문장,,,,,)
        => 대상에 해당하는 값이 일치하는 경우 사용함
        
   2) case 
        when 조건1 then 문장
        when 조건2 then 문장
        when 조건3 then 문장
        ...
        else 문장
     end
 */
  --EX) 성적테이블에서 국어점수가 80이상이면 합격, 아니면 불합격  합격여부 필드를 만든다. - CASE END 로사용

SELECT *FROM REPORT;

SELECT NAME,BAN, KOR, 
CASE 
    WHEN KOR >= 80 THEN '합격'
    ELSE '불합격'
END AS 합격여부
FROM REPORT;



  /*EX)성적테이블에서 BAN이 1이면 'MAS과정', 2이면 'IOT과정', 
  3이면 'DESIGN과정' 이외는 'FULL STACK과정' 라는 과정명 필드를
 만든다.*/


SELECT BAN, NAME ,KOR, DECODE(BAN,1,'MSA과정',2,'IOT과정',3,'DESING과정','FULL STACK과정') AS  과정명
FROM REPORT;


SELECT BAN, NAME ,KOR ,
CASE 
    WHEN BAN= 1 THEN 'MSA과정'
      WHEN BAN= 2 THEN 'IOT과정'
        WHEN BAN= 3 THEN 'DESING과정'
            ELSE 'FULL STACK과정'
END AS 과정명
FROM REPORT;


SELECT BAN, NAME ,KOR ,
CASE BAN
    WHEN '1' THEN 'MSA과정'
      WHEN '2' THEN 'IOT과정'
        WHEN '3' THEN 'DESING과정'
            ELSE 'FULL STACK과정'
END AS 과정명
FROM REPORT;


/*
EX) EMP테이블에서 DEPNO가 10 이면 관리부, 20이면 총무부, 30이면 영업부 
     이외의 값은 기타부 로 출력하고 컬럼명은 부서명 으로 한다.
     (DECODE, CASE END)
     DECODE는 값이 정확하게 일치해야한다
*/

SELECT DECODE(DEPTNO,10,'관리부',20,'총무부',30,'영업부','기타부') AS 부서명
FROM EMP;

SELECT CASE 
    WHEN DEPTNO =10 THEN '관리부'
        WHEN DEPTNO =20 THEN '총무부'
            WHEN DEPTNO =30 THEN '영업부'
                ELSE '기타부'
END AS 부서명
FROM EMP;


SELECT *FROM EMP;

/*
ex)job이 manager인 경우 sal*0.1, ANALYST 인경우는   sal *0.2
     SALESMAN인 경우는 sal * 0.3을 구해서 성과급 필드를 만든다.
      (case end, decode 다 해본다) 
*/

SELECT EMPNO,ENAME,JOB,SAL, DECODE(UPPER(JOB),'MANAGER',SAL*0.1,'ANALYST',SAL*0.2,'SALESMAN',SAL*0.3,0) AS 성과급
FROM EMP ORDER BY 성과급; --LOWER(JOB) : JOB 데이터 값을 전부 소문자로 변경 UPPER(JOB)값을 전부 대문자

SELECT CASE 
    WHEN JOB='MANAGER' THEN SAL*0.1
        WHEN JOB='ANALYST' THEN SAL*0.2
            WHEN JOB='SALESMAN' THEN SAL*0.3
END AS 성과급
FROM EMP;

SELECT EMPNO,ENAME,JOB,SAL,
CASE LOWER(JOB)
    WHEN LOWER('MANAGER')THEN SAL*0.1
    WHEN LOWER('ANALYST')THEN SAL*0.2
    WHEN LOWER('SALESMAN')THEN SAL*0.3
END AS 성과급
FROM EMP ORDER BY 성과급;







/*
ex) sal이 2000이하이면 '저소득층'
      sal이 2001 ~ 4000사이면 '중산층'
      sal이 4001 이상이면 '고소득층'  구하여 등급 별칭 해준다.
      (case end) 
*/

SELECT EMPNO,ENAME,JOB,SAL,
CASE 
    WHEN SAL<=2000 THEN '저소득층'
    --WHEN SAL >=2001 AND SAL<=4000 THEN '중산층'
    WHEN SAL BETWEEN 2001 AND 4000 THEN '중산충'
    WHEN SAL>=4001 THEN '고소득층'
END AS 등급
FROM EMP;

SELECT *FROM EMP;



commit




