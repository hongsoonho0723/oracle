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
             
             NUMBER(5,3) : 전체 5자리에서 3자리가 소수점자리.
  
  
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






--삭제
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



---------------------------------------------------------------
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

---------------------------------------------------------------------------
/*
SQL의 종류
 - DDL문장(CREATE, DROP, ALTER, TRUNCATE)
 - DML문장(INSERT ,UPDATE, DELETE)
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
