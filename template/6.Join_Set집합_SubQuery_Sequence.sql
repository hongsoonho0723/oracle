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

SELECT * FROM TEST2;





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

   
   
-- ANSI 조인방식



-- 조인에 조건 넣기 -- SAL가 300이상인 레코드 조인하기





--NON-EQUI JOIN
-- EMP테이블에서 사원의 정보 + 급여등급을 함께 검색하고 싶다

 
 
-- SELF JOIN - 자기자신 테이블을 2개로 만들어서 조인(재귀적관계)
-- EX) SMITH사원의 관리자는 FORD입니다. 출력




--------------------------------------------------------------
/*
  SET 집합
   1) 합집합
        UNION ALL - 중복레코드를포함
        UNION - 중복레코드 제외
        
   2) 교집합 
       INSERSECT : A와 B 테이블의 공통된 레코드 검색
       
   3) 차집합 
        MINUS : A테이블에서 B테이블이 레코드를 뺀 나머지 레코드 검색






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

                  
      
-- JOB에 'A'문자열이 들어간 사원의 부서와 같은 곳에서 근무하는 사원의 부서이름 검색하고 싶다. 

  
  
 -- 부서번호가 30인 사원들이 급여중에서 가장 많이 받는 사원보다 더 많이 받는 사원정보를 검색하고 싶다. 


-- SUBQUERY를 INSERT


--특정한 칼럼만 다른테이블로부터 가져와서 INSERT


--SUBQUERY를 UPDATE
--EX) EMP테이블에서 EMPNO 7900인 사원의 JOB, MGR, DEPTNO로 SUB_EMP테이블의 7566의 사원의 정보로 수정해보자.


--SUBQUERY를 DELETE
  --EX) EMP테이블이 평균 급여를 조건으로 사용해서 평균급여보다 많이 받는 사원들을 삭제한다. 

 

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



