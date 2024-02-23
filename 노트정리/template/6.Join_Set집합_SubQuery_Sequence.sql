/*
  JOIN
   : 한번의 SELECT문장으로 2개 이상의 테이블에 있는 컬럼의 정보를 검색하고 싶을 때 사용한다.
   : JOIN의 종류
     1) INNER JOIN
         - EQUI JOIN = 동등조인 = NATURAL JOIN
         - NON EQUI JOIN : 조인 대상 테이블의 어떤 컬럼의 값도 일치하지 않을 때 사용
                          EX) BETWEEN AND , IS NULL, IS NOT NULL, IN, > , < 등의  조건문을 사용할때 쓴다.
        
      2) OUTER JOIN
           : 기본 EQUI JOIN을 하면서 별도의 테이블의 모든 정보를 검색하고 싶을때 사용한다.
              - LEFT OUTER JOIN
              - RIGHT OUTER JOIN
              - FULL OUTER JOIN
    
      3) SELF JOIN
           : 자기 자신테이블을 조인하는 것(하나의 테이블을 2개처럼 사용하는 것)
           : 주로 재귀적관계일 때 많이 사용한다. (재귀적관계란 자신자신테이블의 PK를 FK로 참조하는 것)
           
    : JOIN 코딩 방법
      1) SQL JOIN  - FULL OUTER JOIN은 제공하지 않는다. 
      2) ANSI JOIN : 미국국립표준연구소에서 정한 미국의 표준을 기본으로 한다. - 권장
*/

CREATE TABLE TEST1(
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30),
    ADDR VARCHAR2(50)
);

INSERT INTO TEST1 VALUES('JANG', '희정', '서울');
INSERT INTO TEST1 VALUES('KIM', '나용', '대구');
INSERT INTO TEST1 VALUES('GYEEB', '미나', '부산');
INSERT INTO TEST1 VALUES('HEE', '미영', '서울');
INSERT INTO TEST1 VALUES('KING', '소현', '제주도');

SELECT * FROM TEST1;

-- TEST1을 참조하는 테이블 생성(ID에 해당하는 사람이 갖고 있는 JOB, SAL의 정보 제공)
CREATE TABLE TEST2(
    CODE CHAR(3) PRIMARY KEY,
    ID VARCHAR2(10) REFERENCES TEST1(ID),  ---FK
    JOB VARCHAR2(30),
    SAL NUMBER(3)
);


INSERT INTO TEST2 VALUES('A01', 'JANG','강사',200);
INSERT INTO TEST2 VALUES('A02', 'JANG','개발자',300);
INSERT INTO TEST2 VALUES('A03', 'HEE','디자이너',250);
INSERT INTO TEST2 VALUES('A04', 'KING','기획자',400);
INSERT INTO TEST2 VALUES('A05', NULL,'백조',500);

SELECT * FROM TEST1;
SELECT * FROM TEST2;

--EX) ID,NAME,ADDR ,JOB ,SAL 한번에 검색하고 싶다 -->JOIN
-- 동등 조인 = INNER JOIN = NATURAL JOIN

--1) 코딩방식 -> SQL JOIN
SELECT TEST1.ID,NAME,ADDR ,JOB,SAL
FROM TEST1, TEST2 --CROSS JOIN 5*5=25
WHERE TEST1.ID = TEST2.ID;

SELECT T1.ID,NAME,ADDR ,JOB,SAL
FROM TEST1 T1, TEST2 T2 --테이블에 별칭주기
WHERE T1.ID = T2.ID;


--2) ANSI JOIN


SELECT T1.ID,NAME,ADDR ,JOB,SAL
FROM TEST1 T1 INNER JOIN TEST2 T2
ON T1.ID = T2.ID;

--USING 사용하기 (양쪽테이블의 조건대상 컬럼이 이름과 타입이 일치할때 ..사용) 테이블 별칭 사용 불가

SELECT ID,NAME,JOB
FROM TEST1 INNER JOIN TEST2
USING(ID);


--NATURAL JOIN 양쪽 테이블의 같은 컬럼명 , 같은 타입을 갖는 컬럼을 기준으로 모두 조인한다
SELECT *
FROM TEST1 NATURAL JOIN TEST2; 

--OUTER JOIN방식 (LEFT | RIGHT | FULL)
--1) SQL 코딩방법
SELECT *
FROM TEST1 T1 , TEST2 T2
WHERE T1.ID = T2.ID(+);


SELECT *
FROM TEST1 T1 , TEST2 T2
WHERE T1.ID(+) = T2.ID;

SELECT *
FROM TEST1 T1 , TEST2 T2
WHERE T1.ID(+) = T2.ID(+); --X FULL조인 지원 안된다

--2) ANSI 코딩방법

SELECT *FROM TEST1;
SELECT *FROM TEST2;
SELECT * 
FROM TEST1 LEFT OUTER JOIN TEST2
USING (ID);

SELECT * 
FROM TEST1 RIGHT OUTER JOIN TEST2
USING (ID);


SELECT * 
FROM TEST1 FULL OUTER JOIN TEST2
USING (ID);

--------------------------------------------------------------------

-- 3개의 테이블 조인하기
CREATE TABLE TEST3(
    CODE CHAR(3) PRIMARY KEY REFERENCES TEST2(CODE),  -- PK, FK (식별관계)
    MANAGER_NAME VARCHAR2(30),
    PHONE VARCHAR2(30)
);


INSERT INTO TEST3 VALUES('A01', '유재석','111-1111');
INSERT INTO TEST3 VALUES('A02', '송중기','222-2222');
INSERT INTO TEST3 VALUES('A03', '이효리','333-3333');

SELECT * FROM TEST1;
SELECT * FROM TEST2;
SELECT * FROM TEST3;

-- EX) ID, NAME, ADDR, JOB, SAL, MANAGER_NAME, PHONE 검색

-- SQL 조인방식
SELECT *
FROM TEST1 T1, TEST2 T2,TEST3 T3
WHERE T1.ID=T2.ID AND T2.CODE = T3.CODE;

   
-- ANSI 조인방식

SELECT *
FROM TEST1 JOIN TEST2
USING(ID) JOIN TEST3 USING(CODE);



-- 조인에 조건 넣기 -- SAL가 300이상인 레코드 조인하기

--SQL조인
SELECT *FROM TEST1,TEST2,TEST3
WHERE TEST1.ID = TEST2.ID AND TEST2.CODE = TEST3.CODE AND SAL >=300;

--ANSI
SELECT *
FROM TEST1 JOIN TEST2
USING(ID) JOIN TEST3 USING(CODE) AND SAL>=300;

SELECT *
FROM TEST1 JOIN TEST2
USING(ID) JOIN TEST3 USING(CODE)
WHERE SAL>=300; --X USING 절에 일반 조건을 사용할수 없다


SELECT *
FROM TEST1 JOIN TEST2
ON TEST1.ID = TEST2.ID JOIN TEST3 ON TEST2.CODE = TEST3.CODE AND SAL>=300;

--NON-EQUI JOIN --SCOTT 계정접속
-- EMP테이블에서 사원의 정보 + 급여등급을 함께 검색하고 싶다
SELECT *FROM SALGRADE; --급여등급 정보
SELECT *FROM EMP; --사원정보

SELECT EMPNO,ENAME,JOB,SAL,GRADE,LOSAL,HISAL
FROM EMP JOIN SALGRADE
ON SAL BETWEEN LOSAL AND HISAL;
 
 
 
 
-- SELF JOIN - 자기자신 테이블을 2개로 만들어서 조인(재귀적관계)
-- EX) SMITH사원의 관리자는 FORD입니다. 출력

SELECT E1.EMPNO 사원번호,E1.ENAME 사원이름 , E2.EMPNO 관리자_사원번호,E2.ENAME 관리자_이름
FROM EMP E1 JOIN EMP E2 --왼쪽이 사원테이블 오른쪽이 관리자 테이블 사용자가 정해야함
ON E1.MGR =E2.EMPNO
where E1.ENAME='SMITH';


SELECT E1.ENAME || '의 관리자는 ' || E2.ENAME || '입니다'
FROM EMP E1 LEFT JOIN EMP E2 --왼쪽이 사원테이블 오른쪽이 관리자 테이블 사용자가 정해야함
ON E1.MGR =E2.EMPNO
where E1.ENAME='SMITH';
--------------------------------------------------------------
/*
  SET 집합  1
   1) 합집합
        UNION ALL - 중복레코드를포함
        UNION - 중복레코드 제외
        
   2) 교집합 
       INSERSECT : A와 B 테이블의 공통된 레코드 검색
       
   3) 차집합 
        MINUS : A테이블에서 B테이블이 레코드를 뺀 나머지 레코드 검색
*/

CREATE TABLE SET_COPY
AS SELECT EMPNO , ENAME, JOB ,SAL FROM EMP WHERE SAL > 2000;

--레코드 3개 추가
INSERT INTO SET_COPY VALUES(9001,'희정','TEACHER',2500);
INSERT INTO SET_COPY VALUES(9002,'희정2','STUDENT',1500);
INSERT INTO SET_COPY VALUES(9003,'희정3','INSTRU',2000);

SELECT * FROM SET_COPY; --9레코드

--1) 합집합 -UNION
SELECT EMPNO,ENAME,JOB FROM EMP --14개
UNION ALL
SELECT EMPNO,ENAME,JOB FROM SET_COPY; --9개

SELECT EMPNO,ENAME,JOB FROM EMP --14개
INTERSECT--교집합
SELECT EMPNO,ENAME,JOB FROM SET_COPY; --9개



SELECT EMPNO,ENAME,JOB FROM SET_COPY --9개
MINUS --차집합
SELECT EMPNO,ENAME,JOB FROM EMP --14개;


SELECT EMPNO,ENAME,JOB FROM EMP --14개
MINUS
SELECT EMPNO,ENAME,JOB FROM SET_COPY --9개;

commit;
 -------------------------------------------------------------
 /*
   SUBQUERY - 부질의
    : 메인쿼리안에 또 다른 쿼리가 존재하는것
    : ()괄호로 묶는다. 괄호안에 실행문장이 먼저 실행된후 그 결과를 메인쿼리의 조건으로 주로 사용한다. 
    : 서브쿼리의 결과 행이 한개 일때  비교연산자 사용.
    : 서브쿼리의 결과 행이 여러개 일때는 ANY, ALL, IN 연산자를 사용한다. 
    : 주로 SELECT에서 많이 사용하지만 CREATE, INSERT, UPDATE ,DELTE, 
           HAVING, WHERE , FROM ,ORDER 에서도 사용가능하다.
 */
 
 --EMP테이블에서 평균 급여보다 더 많이 받는 사원 검색

--1)평균 급여를 알아야한다
    SELECT AVG(SAL) FROM EMP;

--2) 1에서 나온 결과를 조건으로 사용한다
    SELECT * FROM EMP WHERE SAL > (SELECT AVG(SAL) FROM EMP);
    
      
-- JOB에 'A'문자열이 들어간 사원의 부서와 같은 곳에서 근무하는 사원의 부서이름 검색하고 싶다. 

    SELECT DISTINCT DEPTNO FROM EMP WHERE JOB LIKE '%A%';

    SELECT DNAME FROM DEPT WHERE DEPTNO  IN(SELECT DEPTNO FROM EMP WHERE JOB LIKE '%A%');
  
    SELECT DNAME FROM DEPT WHERE DEPTNO  = ANY(SELECT DEPTNO FROM EMP WHERE JOB LIKE '%A%');
  
  SELECT *FROM DEPT;
  SELECT *FROM EMP;
  
  
 -- 부서번호가 30인 사원들이 급여중에서 가장 많이 받는 사원보다 더 많이 받는 사원정보를 검색하고 싶다. 


 
  SELECT *FROM EMP WHERE SAL > ALL (  SELECT SAL FROM EMP WHERE DEPTNO =30);
  
  --집계함수를 이용해서 풀어보자
    SELECT *FROM EMP WHERE SAL > (  SELECT MAX(SAL) FROM EMP WHERE DEPTNO =30);
  
    
 -- 부서번호가 30인 사원들이 급여중에서 가장 적게 받는 사원보다 더 적게 받는 사원정보를 검색하고 싶다. 
  
    SELECT *FROM EMP WHERE SAL < (SELECT MIN(SAL)FROM EMP WHERE DEPTNO=30 ); 

   SELECT *FROM EMP WHERE SAL <ALL (  SELECT SAL FROM EMP WHERE DEPTNO =30);
-- 부서번호가 30인 사원들이 급여중에서 가장 적게 받는 사원보다 더 많이 받는 사원정보를 검색하고 싶다. 
 
    SELECT *FROM EMP WHERE SAL > (SELECT MIN(SAL)FROM EMP WHERE DEPTNO=30 ); 

    
   SELECT *FROM EMP WHERE SAL >ANY (  SELECT SAL FROM EMP WHERE DEPTNO =30) AND DEPTNO!=30;


--테이블 구조만 복사
CREATE TABLE SUB_EMP
AS SELECT * FROM EMP WHERE 1=0;


SELECT *FROM SUB_EMP;


--    INSERT INTO SUB_EMP VALUES(값....)
        
-- SUBQUERY를 INSERT

INSERT INTO SUB_EMP(SELECT * FROM EMP WHERE DEPTNO=20);


--특정한 칼럼만 다른테이블로부터 가져와서 INSERT
INSERT INTO SUB_EMP (EMPNO,ENAME,JOB,SAL)(SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=10);

SELECT *FROM SUB_EMP;

INSERT INTO SUB_EMP (EMPNO,ENAME,JOB,SAL,DEPTNO)(SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE DEPTNO=10);

--SUBQUERY를 UPDATE
--EX) EMP테이블에서 EMPNO 7900인 사원의 JOB, MGR, DEPTNO로 SUB_EMP테이블의 7566의 사원의 정보로 수정해보자.

UPDATE SUB_EMP 
SET JOB=(SELECT JOB FROM EMP WHERE EMPNO =7900) ,
        MGR= (SELECT MGR  FROM EMP WHERE EMPNO =7900),
        DEPTNO=(SELECT DEPTNO  FROM EMP WHERE EMPNO =7900)
 WHERE EMPNO = 7566;


UPDATE SUB_EMP 
SET (JOB,MGR,DEPTNO)=(SELECT JOB,MGR,DEPTNO  FROM EMP WHERE EMPNO =7900)
WHERE EMPNO = 7566;

SELECT *FROM SUB_EMP WHERE EMPNO=7566;


--SUBQUERY를 DELETE
  --EX) EMP테이블이 평균 급여를 조건으로 사용해서 평균급여보다 많이 받는 사원들을 삭제한다. 

DELETE SUB_EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);


DELETE SUB_EMP 
WHERE DEPTNO IS NULL;
--------------------------------------------------------------
/*
  SUBQUERY 종류중의 하나인 인라인뷰
   : FROM절 뒤에 서브쿼리가 오는 것.
*/

-- 급여를 기준으로 정렬해서 ROWNUM을 함께 출력하고 싶다.





-- ROWNUM을 대상으로 조건을 만들어보자 .
--1. ROWUM이 3보다 작은 레코드 검색


--2. ROWUM이 3보다 큰 레코드 검색


--3. ROWUM이 5 ~ 7 사이 레코드 검색


/*
  ROWNUM은 레코드가 만들어지면서 번호가 순차적으로 부여되는 것으로 ROWNUM 1 이 없으면 2를 실행할수 없다. 
  그래서 ROWNUM를 조건으로  ~ 크다  또는 중간범위를 직접 조건으로 사용할 수 없다. 
  ROWNUM이 모두 부여된 결과를 조건으로 사용해야한다. 
*/





----------------------------------------------------------
/*
  SEQUENCE : 자동 증가 값 설정
    :생성방법
      CREATE SEQUENCE 시퀀스이름
      [START WITH 초기값]
      [INCREMENT BY 증가값]
      [MAXVALUE 최댓값]
      [MINVALUE 최솟값]
      [CACHE | NOCACHE]
      [CYCLE | NOCYCLE]
      
    : 사용방법
      시퀀스이름.NEXTVAL : 시퀀스를 증가
      시퀀스이름.CURRVAL : 시퀀스의 현재값 가져오기
       
    : 시퀀스 수정
    ALTER SEQUENCE 시퀀스이름;
    
    : 시퀀스 삭제
    DROP SEQUENCE 시퀀스이름;
*/
--생성
CREATE SEQUENCE SEQ_NO;

--사용
SELECT SEQ_NO.NEXTVAL, SEQ_NO.CURRVAL
FROM DUAL;

--삭제
DROP SEQUENCE SEQ_NO;

--옵션 설정으로 시퀀스 생성
CREATE SEQUENCE SEQ_NO
START WITH 5
INCREMENT BY 10
MAXVALUE 100
NOCYCLE;


--게시판 테이블
CREATE TABLE BOARD(
    BNO NUMBER PRIMARY KEY,
    WRITER VARCHAR2(20),
    CONTENT VARCHAR2(100)

);

--BOARD에서 사용할 BNO의 SEQUENCE를 생성
CREATE SEQUENCE BOARD_BNO_SEQ;

--글 등록
INSERT INTO BOARD (BNO,WRITER,CONTENT) 
VALUES(BOARD_BNO_SEQ.NEXTVAL,'장희정','재미있다');

INSERT INTO BOARD (BNO,WRITER,CONTENT) 
VALUES(BOARD_BNO_SEQ.NEXTVAL,'장희정' || BOARD_BNO_SEQ.CURRVAL,'재미있다');

SELECT *FROM BOARD;


--save



















