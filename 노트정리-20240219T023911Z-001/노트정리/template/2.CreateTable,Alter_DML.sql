-- 각자의 계정으로 접속한다. conn 계정명/비번

/*
  Datatype의 종류
  1) 문자열   
      CHAR(BYTE수) : 고정길이 - 최대 2000 BYTE
      VARCHAR2(BYTE수) : 가변길이 -최대 4000 BYTE
      
      *유니코드를 지원!!
      NCHAR(BYTE수)
      NVARCHAR2(BYTE수)
      
      * 반드시 문자는 '값'  형식으로 사용한다.
      * ORACLE에서 요즘 UTF-8 인코딩으로 한글자는 3BYTE이다!!
      
        EX) CHAR(6) : 한글 2자, 영문은 6글자
            VARCHAR2(6) : 한글 2자, 영문은 6글자
            
      * CHAR(6 CHAR) : BYTE와 관계없이 6글자까지
        VARCHAR2(6 CHAR) : BYTE와 관계없이 6글자까지
        
      * 대용량의 데이터을 저장해야하는경우 
       LOB : LARGE OBJECT 약자로 대용량의 데이터를 저장할수 있는 데이터 타입 
         1) CLOB : 가변길의 아주 긴 문자열을 저장할때 4GB
         2) BLOB :  가변길의 2진수 형태를 저장할때 4GB
        - LOB타입은 권장하지는 않는다
        
    
  2) 숫자
     : NUMBER
       SMALLINT
       INT
       
       * SMALLINT 또는 INT를 선언해도 결국 내부적으로  NUMBER 타입으로 된다. 
         - 정수형, 실수형 표현
         EX) NUMBER(1) : 정수 -9 ~ 9 표현
             NUMBER(2) : -99 ~ 99 
             NUMBER(3) : -999 ~ 999
             NUMBER(4) : -9999 ~ 9999
             NUMBER(5,3) : 전체 5자리에서 3자리가 소수점자리. -> 99999.999
  
  
  3) 날짜
     : DATE : 년월일 시분초 설정
       TIMESTAMP : 년월일 시분초 + MILS 단위까지 더 정밀하게 표현!!!
      
      *날짜는 반드시 '년-월-일' 형식으로 묶어서 사용한다.
      * 현재 날짜와시간을 구하는 함수 SYSDATE 사용한다.
        EX) SELECT SYSDATE FROM DUAL;
*/


/*
  -테이블 생성
  create table 테이블이름(
    컬럼명 datatype [default 기본값] [ null | not null ] [ constraint 별칭 제약조건 ] ,
    컬럼명 datatype [default 기본값] [ null | not null ] [ constraint 별칭 제약조건 ] ,
    .....
)

  - 제약조건의 종류
   1) PRIMARY KEY : 대표키, 중복X, NOT NULL
   2) FOREIGN KEY :다른 테이블의 컬럼을 참조
   3) UNIQUE : PK유사(테이블에서 대표키는 될수 없는 그렇지만 유일해야하는 속성에 설정) 
   4) CHECK : DOMAIN에 들어갈수 있는 값을 범위를 체크
   
   5) DEFAULT  : 기본값 설정

*/
/*
   1) PRIMARY KEY - PK, 기본키, 대표키
      : PK를 설정하면 중복안됨, NOT NULL , 자동의로 INDEX설정 - EX) 학번, 군번, 주민번호, 상품코드,...아이디...
      : PK는 하나의 테이블에 반드시 한개만 존재
      : 2개의 이상의 컬럼을 하나로 묶어서 PK설정 가능 
          - 복합키설정 : 사용할때 불편해서 모델링 과정속에서 복합키를 대리키로 변환하는 경우 많다!!!
*/

--ex) 테이블 생성

CREATE TABLE MEMBER(
    ID VARCHAR2 (20) CONSTRAINT MEMBER_ID_PK PRIMARY KEY ,--NOT NULL 중복 불가
    NAME VARCHAR2(10) NOT NULL,
    JUMIN CHAR(13), --NULL 허용
    AGE NUMBER(2), --  -99~99까지 가능
    ADDR VARCHAR2(10 CHAR),
    REG_DATE DATE
    
    
);

DROP TABLE MEMBER;


SELECT *FROM MEMBER;

INSERT INTO MEMBER VALUES('SOON','홍순호','111111-111111',20,'서울',SYSDATE);


INSERT INTO MEMBER VALUES ('SOON','삼식','123456-123456',30,'분당',SYSDATE); --X PK는 중복안됨

INSERT INTO MEMBER(NAME,AGE) VALUES('삼식',27);--X ID는 NOT NULL
INSERT INTO MEMBER(ID,NAME,AGE) VALUES('KING','삼식',100); --x 나이는 2자리만

INSERT INTO MEMBER ( ID,NAME,AGE)VALUES('soon','삼식',99); --데이터값은 대소문자 가린다

INSERT INTO MEMBER(ID,NAME,ADDR,REG_DATE) VALUES('AA','심순','서울','2023-10-10');


--10byte vs 10 char차이
INSERT INTO MEMBER(ID,NAME,ADDR) VALUES('BB','기나다라','서울시'); --X 한글은 한글자당 3byte

INSERT INTO MEMBER(ID,NAME,ADDR) VALUES('BB','기나다','서울시 강남구'); -- addr 10 char 이므로 가능

--char vs varchar2비교

INSERT INTO MEMBER(ID,NAME,JUMIN) VALUES('FF','A','B');

INSERT INTO MEMBER(ID,NAME,JUMIN) VALUES('GG','A ','B ');


--VARCHAR2 검색
SELECT * FROM MEMBER WHERE NAME='A';
SELECT * FROM MEMBER WHERE NAME='A ';

SELECT * FROM MEMBER WHERE NAME LIKE 'A%';

--CHAR 검색
SELECT *FROM MEMBER WHERE JUMIN ='B';

SELECT *FROM MEMBER WHERE JUMIN ='B ';

SELECT NAME,JUMIN,LENGTH(NAME),LENGTH(JUMIN) FROM MEMBER WHERE ID='FF';

SELECT NAME,JUMIN,LENGTH(NAME),LENGTH(JUMIN) FROM MEMBER WHERE ID='GG';


--테이블 삭제 
DROP TABLE MEMBER;

-- 하나의 테이블에 두개의 컬럼을 하나로 묶어서 pk설정하기 
CREATE TABLE MEMBER(
    ID VARCHAR2(20),
    NAME VARCHAR2(30) NOT NULL,
    JUMIN CHAR(13),
    AGE NUMBER(3),
    REG_DATE DATE,
    CONSTRAINT MEMBER_ID_JUMIN_PK PRIMARY KEY(ID,JUMIN) -- ID하나만 넣으면 ID가 PK ,JUMIN도 같이 넣어주면 복합키로 설정됨
    

);
--테이블 구조확인
DESC MEMBER;

--레코드 추가해서 PK TEST해보기
INSERT INTO MEMBER VALUES('HONG','순호','123456-123456',20,SYSDATE);

INSERT INTO MEMBER VALUES('HONG','순호2','123456-234567',20,SYSDATE);

INSERT INTO MEMBER VALUES('SOON','순호1','123456-123456',20,SYSDATE);

INSERT INTO MEMBER VALUES(NULL,'순호','123456-123456',20,SYSDATE);--X

--테이블 검색
SELECT *FROM MEMBER;











/*
  레코드 등록
  INSERT INTO 테이블이름(컬럼명, 컬럼명,....) VALUES(값, 값,값,....);
  INSERT INTO 테이블이름 VALUES(값, 값,값,....); -- 모든 컬럼에 순서대로 값을 넣을때!!!
*/



----------------------------------------------------------------------------
/*
  2) FOREIGN KEY - FK = 외래키
      : 다른 테이블의 PK를 참조하는 것.
      : 테이블에 레코드를 추가할때 참조되는 대상의 값이외에는 등록 할수 없다.
          - 참조무결성원칙!!!
      : NULL허용, 중복가능!!
      : 하나의 테이블에 여러개의 컬럼이 FK설정가능하다.
      
      : 재귀적관계 설계 - 자기자신테이블의 PK를 참조하는것!!!
      
      *주의사항
        INSERT 할때 : 부모키가 INSERT -> 자식 INSERT 
        DELETE할때 :  참조하고 있는 자식 DELETE -> 부모 DELETE 해야한다.
      
             * 이러한 주의사항에 대한 불편함을 해결하기 위해서.
               FK를 설정할때 ON DELETE CASCADE 를 추가하면 부모레코드를 삭제하를
              그 부모키를 참조하는 모든 테이블의 레코드를 함께 삭제한다.
	      또는 FK설정할때 on delete set null 를 추가하면
	      부모레코드 삭제될때 참조되는 자식레코드의 값이 null이된다.
      
     
*/

--SCOTT 계정 접속
SELECT *FROM EMP;
SELECT *FROM DEPT;

--각자 계정으로 접속해서 FK실습

--부서 테이블

CREATE TABLE DEPT(
    DEPT_CODE CHAR(3) CONSTRAINT DEPT_CODE_PK PRIMARY KEY,
    DNAME VARCHAR2(30) NOT NULL,
    LOC VARCHAR2(30)

);
DESC DEPT;


--샘플레코드 추가

INSERT INTO DEPT VALUES('A01','경리부','서울');
INSERT INTO DEPT VALUES('A02','교육부','대구');
INSERT INTO DEPT VALUES('A03','인사부','서울');

--레코드 검색

SELECT *FROM DEPT;

CREATE TABLE EMP(
    EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL, --한글은 5글자까지 가능 3byte
    SAL NUMBER(5),
    DEPT_CODE CHAR(3) CONSTRAINT EMP_DEPT_CODE_FK REFERENCES DEPT(DEPT_CODE),
    HIRE_DATE DATE DEFAULT SYSDATE
    
);
DROP TABLE EMP;
DESC EMP;
SELECT *FROM EMP;
COMMIT;
--사원 등록
INSERT INTO EMP(EMP_NO , ENAME,SAL , DEPT_CODE , HIRE_DATE) VALUES(1,'희정',300,'A01');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(8,'희정',300,'A01',DEFAULT);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(2,'희정',300,'A02','2024-01-20');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(3,'희정',300,'A01',NULL);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(4,'희정',300,'A01');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(6,'희정',300,'A01');
INSERT INTO EMP VALUES(5,'희정',300,'A01',DEFAULT);

DROP TABLE EMP;

DELETE EMP;

ROLLBACK;

--부모의 참조되고 있지않는 레코드를 삭제해본다
DELETE FROM DEPT WHERE DEPT_CODE ='A03';
--부모테이블의 참조되고 있는 레코드를 삭제해본다
DELETE FROM DEPT WHERE DEPT_CODE='A02';

--참조되고 있는 자식레코드를 먼저 삭제한후에 부모레코드를 삭제해야한다
DELETE FROM EMP WHERE DEPT_CODE='A02';
DELETE FROM DEPT WHERE DEPT_CODE='A02';

SELECT *FROM DEPT;
SELECT *FROM EMP;


--ON DELETE CASCADE VS ON DELETE SET NULL 옵션 설정해서 비교해보자
DROP TABLE EMP;
--사원 테이블 생성
CREATE TABLE EMP(
    EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL, --한글은 5글자까지 가능 3byte
    SAL NUMBER(5),
    DEPT_CODE CHAR(3) CONSTRAINT EMP_DEPT_CODE_FK REFERENCES DEPT(DEPT_CODE) ON DELETE CASCADE,
    HIRE_DATE DATE DEFAULT SYSDATE
    
);
SELECT *FROM DEPT;
--레코드 추가
INSERT INTO DEPT VALUES('A02','경리부','대구');

--EMP 레코드 추가
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(1,'희정',300,'A01',DEFAULT);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(2,'희정',300,'A02','2024-01-20');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(3,'희정',300,NULL);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(4,'희정',300,'A01');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(5,'희정',300,'A01');
INSERT INTO EMP VALUES(6,'희정',300,'A01',DEFAULT);

SELECT *FROM EMP;
SELECT *FROM DEPT;
--보모테이블의 참조되고 있는 레코드를 삭제해본다(DEPT)
DELETE DEPT WHERE DEPT_CODE ='A01'; --ON DELETE CASCADE

--테이블 삭제하고
DROP TABLE EMP;
--옵션을 설정해서 FK생성
CREATE TABLE EMP(
    EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL, --한글은 5글자까지 가능 3byte
    SAL NUMBER(5),
    DEPT_CODE CHAR(3) CONSTRAINT EMP_DEPT_CODE_FK REFERENCES DEPT(DEPT_CODE) ON DELETE CASCADE,
    HIRE_DATE DATE DEFAULT SYSDATE
    
);
INSERT INTO DEPT VALUES ('A01','경리부','대구');

--레코드 추가하고 
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(1,'희정',300,'A01',DEFAULT);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(2,'희정',300,'A02','2024-01-20');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(3,'희정',300,NULL);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(4,'희정',300,'A01');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(5,'희정',300,'A01');
INSERT INTO EMP VALUES(6,'희정',300,'A01',DEFAULT);

SELECT *FROM EMP;
SELECT *FROM DEPT;
--삭제해본다
DELETE DEPT WHERE DEPT_CODE = 'A01'; 
 
DROP TABLE EMP;

--FK설정을 SQL문장 맨뒤에서 작성하는 경우
CREATE TABLE EMP(
    EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL, --한글은 5글자까지 가능 3byte
    SAL NUMBER(5),
    DEPT_CODE CHAR(3),
    HIRE_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT EMP_DEPT_CODE_FK FOREING KEY(DEPT_CODE) REFERENCES DEPT(DEPT_CODE) ON DELETE SET NULL
    
);
COMMIT;

/*
  3) UNIQUE
      : 중복안됨, NULL허용(NOT NULL을 설정하면 PK와 동일) 
      : 후보키중에 대표키가 될수 없는 키를 UNIQUE 설정한다. 
      :  한테이블에 여러개의 컬럼에 설정가능
      
  4) CHECK
      : 조건을 설정하여 조건에 만족하지 않는 정보는 INSERT 할수 없다!
    
  
  5) DEFAULT
      : 기본값 설정(자주사용되는 값을 미리 설정해놓고 자동으로 값이 들어갈수 있또록 하는것)
      : EX) 등록일, 조회수....
      : DEFAULT를 설정할때는 CONSTRAINT 별칭은 안쓴다!!!
      : NOT NULL을 설정하면 DEFALUT를 함께 사용할때는 반드시 DEFAULT를 먼저 작성한다.
*/



--UNIQUE, DEFAULT , CHECK , TEST 해보자

CREATE TABLE TEST (
    ID VARCHAR2(10) PRIMARY KEY,--벌칭 생략
    JUMIN CHAR(13) NOT NULL UNIQUE,
    NAME VARCHAR2(10) UNIQUE,
    AGE NUMBER(2) CHECK (AGE>=20 AND AGE<=30), --CHECK 조건식 
    GENDER CHAR(3) CHECK (GENDER ='남' OR GENDER = '여'),
    GEG_DATE DATE DEFAULT SYSDATE  NOT NULL


);


DROP TABLE TEST;

DESC TEST;


INSERT INTO TEST (ID,JUMIN,NAME) VALUES ('JANG','111','희정');

INSERT INTO TEST (ID,JUMIN,NAME) VALUES ('HEE','222',NULL);
INSERT INTO TEST (ID,JUMIN,NAME) VALUES ('HONG','333',NULL);

INSERT INTO TEST (ID,JUMIN,NAME) VALUES ('SOON','444','순호');
INSERT INTO TEST (ID,JUMIN,NAME,AGE ,GENDER) VALUES ('AAA','555','순호1',22,'남');

INSERT INTO TEST (ID,JUMIN,NAME,AGE ,GENDER) VALUES ('BBB','666','순호2',25,'여');


INSERT INTO TEST (ID,JUMIN,NAME,AGE ,GENDER) VALUES ('CCC','777','순호3',23,'여');

SELECT *FROM TEST;






/*
   레코드 삭제방법
    1) ROLLBACK 처리가능 - DML
      DELETE [FROM] 테이블이름
      [WHERE 조건식]
      
        * FROM 생략가능, WHERE절이 없으면 모든 레코드가 삭제된다.
          
    2) ROLLBACK 안된다. - DDL
     TRUNCATE TABLE 테이블이름; --모든레코드를 삭제
      
*/
--현재 상황을 모두 저장완료



---------------------------------------------------------------------------------------------------
/*
  테이블 수정
  
 ① 컬럼추가
  alter table 테이블이름 add 
     (컬럼명 자료형 [제약조건] , 컬럼명 자료형 [제약조건] , ....)
 
 ② 컬럼삭제
 alter table 테이블이름 drop column 컬럼이름
 
 ③ datatype변경
    alter table 테이블이름 modify 컬럼이름 변경자료형
    
④ 컬럼이름 변경
 alter table 테이블이름 rename column 기존컬럼명 to 변경컬럼명
 
 ⑤ 제약조건 추가
  alter table 테이블이름 ADD CONSTRAINT 별칭 제약조건종류 ;
  
 -제약조건 삭제
  ALTER TABLE 테이블이름 DROP CONSTRAINT 별칭;
  
 
 - 테이블 삭제
 drop table 테이블이름

*/



SELECT *FROM TEST;
DESC TEST;
ALTER TABLE TEST ADD (ADDR CHAR (15));
ALTER TABLE TEST DROP COLUMN ADDR;
ALTER TABLE TEST ADD (ADDR CHAR (15));
ALTER TABLE TEST MODIFY ADDR CHAR(3);
ALTER TABLE TEST RENAME COLUMN ADDR TO ADDR;


--제약조건추가
ALTER TABLE TEST ADD CONSTRAINT TEST_ID_PK PRIMARY KEY(ID);

--NAME NOT NULL 설정
ALTER TABLE TEST MODIFY NAME NOT NULL;

--GENDER DEFAULT 설정
ALTER TABLE TEST MODIFY (GENDER DEFAULT '남');

SELECT REG_DATE,ID FROM MEMBER;


---------------------------------------------------------------------------
/*
SQL의 종류
 - DDL문장(CREATE, DROP, ALTER, TRUNCATE)
 - DML문장(INSERT ,UPDATE, DELETE)
 - DQL문장(SELECT)
 
*/

/*
  데이터 조작 : DML(INSERT , UPDATE, DELETE)
   - ROLLBACK OR COMMIT 가능
   
   1) INSERT문장
       -INSERT INTO 테이블이름(컬럼명, 컬럼명,....) VALUES(값, 값,값,....);
       -INSERT INTO 테이블이름 VALUES(값, 값,값,....); -- 모든 컬럼에 순서대로 값을 넣을때!!!
   
   2) DELETE문장
       DELETE [FROM] 테이블이름
       [WHERE 조건식]
   
   3) UPDATE문장
      UPDATE 테이블이름
      SET 컬럼명=변경값 , 컬럼명=변경값,....
      [WHERE 조건식] 

*/



/*
   --테이블 복사
   CREATE TABLE 테이블이름
   AS 복사할테이블정보;
   
   
    주의 : 테이블을 복사하면 제약조건은 복사 안된다!!! - 복사한후에 제약조건을 ALTER를 이용해서 추가한다.

*/

--테이블 복사해보기 -SCOTT 계정 접속

SELECT *FROM EMP;

--모든 레코드 , 모든 컬럼을 복사해보자

CREATE TABLE COPY_EMP AS SELECT *FROM EMP; --제약조건 복사 안됨

SELECT *FROM COPY_EMP;

ALTER TABLE COPY_EMP ADD CONSTRAINT COPY_EMP_NO_PK PRIMARY KEY(EMPNO); --제약조건 추가

DESC COPY_EMP;

--조건에 만족하는 특정 레코드와 컬럼의 정보만 복사하기
CREATE TABLE  COPY_EMP2 AS SELECT EMPNO,ENAME,JOB,HIREDATE FROM EMP WHERE SAL >2500;

DESC COPY_EMP2;
SELECT*FROM COPY_EMP2;

--3) 구조만 복사하고싶다
CREATE TABLE COPY_EMP3 AS SELECT *FROM EMP WHERE 1=0;
DROP TABLE COPY_EMP3;
DESC COPY_EMP3;
SELECT *FROM COPY_EMP3;

COMMIT;

--레코드 수정 (COPY_EMP)
SELECT *FROM COPY_EMP;

--EX) EMPNO가 7499인 사원의 JOB을 TEACHER, ENAME 을 HEEJUNG 변경해보자
UPDATE COPY_EMP 
SET JOB='TEACHER',ENAME='HEEJUNG'
WHERE EMPNO=7499;

SELECT *FROM COPY_EMP WHERE EMPNO =7499;

UPDATE COPY_EMP 
SET JOB='TEACHER',ENAME='HEEJUNG'
WHERE SAL >=2500;
SELECT *FROM COPY_EMP WHERE JOB='TEACHER';




































