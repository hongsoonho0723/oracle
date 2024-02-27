 * 계층형 쿼리
   
SELECT LEVEL , empno, mgr, LPAD(' ', 4*(LEVEL-1)) || ename 
 FROM emp
 START WITH mgr IS NULL --루트노트
CONNECT BY PRIOR empno = mgr; 


SELECT LEVEL , empno, mgr, LPAD(' ', 4*(LEVEL-1)) || ename 
 FROM emp
 START WITH mgr IS NULL --루트노트
CONNECT BY PRIOR empno = mgr
ORDER BY LEVEL;


SELECT LEVEL,empno, mgr, ename 
 FROM emp
 START WITH mgr IS NULL --루트노트
CONNECT BY PRIOR empno = mgr; 
---------------------
CREATE TABLE BOM (
            ITEM_ID     INTEGER NOT NULL,
            PARENT_ID   INTEGER references BOM(item_id),
            ITEM_NAME   VARCHAR2(20)  NOT NULL,
            ITEM_QTY    INTEGER, 
            PRIMARY KEY (ITEM_ID)
);
            

INSERT INTO BOM VALUES ( 1001, NULL, '컴퓨터', 1);
INSERT INTO BOM VALUES ( 1002, 1001, '본체', 1);
INSERT INTO BOM VALUES ( 1003, 1001, '모니터', 1);
INSERT INTO BOM VALUES ( 1004, 1001, '프린터', 1);

INSERT INTO BOM VALUES ( 1005, 1002, 'Mother Board', 1);
INSERT INTO BOM VALUES ( 1006, 1002, '랜카드', 1);
INSERT INTO BOM VALUES ( 1007, 1002, 'Power Supply', 1);

INSERT INTO BOM VALUES ( 1008, 1005, 'RAM', 1);
INSERT INTO BOM VALUES ( 1009, 1005, 'CPU', 1);
INSERT INTO BOM VALUES ( 1010, 1005, '그래픽장치', 1);
INSERT INTO BOM VALUES ( 1011, 1005, '기타장치', 1);

  
 select * from bom;
 
 SELECT  item_id, parent_id, LPAD(' ', 4*(LEVEL-1)) || item_name item_names
 FROM bom
 START WITH parent_id IS NULL -- 루트노드
CONNECT BY  parent_id = PRIOR item_id ;

--SCOTT 계정


--테이블생성
create table zipcode(
  zip varchar2(20) ,
  sido	varchar2(100),
  si	varchar2(100),
  dong	varchar2(200),
  ri	varchar2(100),
  doseo	 varchar2(100),
  bunji	varchar2(100),
  apt	varchar2(100),
  address varchar2(300)
);

DESC ZIPCODE;

select *from zipcode;
select *from zipcode where address like '%오리%';
--도스에서실행 ()CMD창
 sqlldr userid=scott/TIGER control='test.ctl'

--test.ctl 파일
LOAD DATA 
        INFILE 'zipcode.csv' 
        APPEND 
        INTO TABLE zipcode
        FIELDS TERMINATED BY ','
(zip,sido,si,dong,ri,doseo,bunji,apt,address)   





insert into emp(empno,ename,job,sal,hiredate) values(9000,'hee','teacher',200,sysdate);
commit;