-- ������ �������� �����Ѵ�. conn ������/���

/*
  Datatype�� ����
  1) ���ڿ�   
      CHAR(BYTE��) : �������� - �ִ� 2000 BYTE
      VARCHAR2(BYTE��) : �������� -�ִ� 4000 BYTE
      
      *�����ڵ带 ����!!
      NCHAR(BYTE��)
      NVARCHAR2(BYTE��)
      
      * �ݵ�� ���ڴ� '��'  �������� ����Ѵ�.
      * ORACLE���� ���� UTF-8 ���ڵ����� �ѱ��ڴ� 3BYTE�̴�!!
      
        EX) CHAR(6) : �ѱ� 2��, ������ 6����
            VARCHAR2(6) : �ѱ� 2��, ������ 6����
            
      * CHAR(6 CHAR) : BYTE�� ������� 6���ڱ���
        VARCHAR2(6 CHAR) : BYTE�� ������� 6���ڱ���
        
      * ��뷮�� �������� �����ؾ��ϴ°�� 
       LOB : LARGE OBJECT ���ڷ� ��뷮�� �����͸� �����Ҽ� �ִ� ������ Ÿ�� 
         1) CLOB : �������� ���� �� ���ڿ��� �����Ҷ� 4GB
         2) BLOB :  �������� 2���� ���¸� �����Ҷ� 4GB
        - LOBŸ���� ���������� �ʴ´�
        
    
  2) ����
     : NUMBER
       SMALLINT
       INT
       
       * SMALLINT �Ǵ� INT�� �����ص� �ᱹ ����������  NUMBER Ÿ������ �ȴ�. 
         - ������, �Ǽ��� ǥ��
         EX) NUMBER(1) : ���� -9 ~ 9 ǥ��
             NUMBER(2) : -99 ~ 99 
             NUMBER(3) : -999 ~ 999
             NUMBER(4) : -9999 ~ 9999
             NUMBER(5,3) : ��ü 5�ڸ����� 3�ڸ��� �Ҽ����ڸ�. -> 99999.999
  
  
  3) ��¥
     : DATE : ����� �ú��� ����
       TIMESTAMP : ����� �ú��� + MILS �������� �� �����ϰ� ǥ��!!!
      
      *��¥�� �ݵ�� '��-��-��' �������� ��� ����Ѵ�.
      * ���� ��¥�ͽð��� ���ϴ� �Լ� SYSDATE ����Ѵ�.
        EX) SELECT SYSDATE FROM DUAL;
*/


/*
  -���̺� ����
  create table ���̺��̸�(
    �÷��� datatype [default �⺻��] [ null | not null ] [ constraint ��Ī �������� ] ,
    �÷��� datatype [default �⺻��] [ null | not null ] [ constraint ��Ī �������� ] ,
    .....
)

  - ���������� ����
   1) PRIMARY KEY : ��ǥŰ, �ߺ�X, NOT NULL
   2) FOREIGN KEY :�ٸ� ���̺��� �÷��� ����
   3) UNIQUE : PK����(���̺��� ��ǥŰ�� �ɼ� ���� �׷����� �����ؾ��ϴ� �Ӽ��� ����) 
   4) CHECK : DOMAIN�� ���� �ִ� ���� ������ üũ
   
   5) DEFAULT  : �⺻�� ����

*/
/*
   1) PRIMARY KEY - PK, �⺻Ű, ��ǥŰ
      : PK�� �����ϸ� �ߺ��ȵ�, NOT NULL , �ڵ��Ƿ� INDEX���� - EX) �й�, ����, �ֹι�ȣ, ��ǰ�ڵ�,...���̵�...
      : PK�� �ϳ��� ���̺� �ݵ�� �Ѱ��� ����
      : 2���� �̻��� �÷��� �ϳ��� ��� PK���� ���� 
          - ����Ű���� : ����Ҷ� �����ؼ� �𵨸� �����ӿ��� ����Ű�� �븮Ű�� ��ȯ�ϴ� ��� ����!!!
*/

--ex) ���̺� ����

CREATE TABLE MEMBER(
    ID VARCHAR2 (20) CONSTRAINT MEMBER_ID_PK PRIMARY KEY ,--NOT NULL �ߺ� �Ұ�
    NAME VARCHAR2(10) NOT NULL,
    JUMIN CHAR(13), --NULL ���
    AGE NUMBER(2), --  -99~99���� ����
    ADDR VARCHAR2(10 CHAR),
    REG_DATE DATE
    
    
);

DROP TABLE MEMBER;


SELECT *FROM MEMBER;

INSERT INTO MEMBER VALUES('SOON','ȫ��ȣ','111111-111111',20,'����',SYSDATE);


INSERT INTO MEMBER VALUES ('SOON','���','123456-123456',30,'�д�',SYSDATE); --X PK�� �ߺ��ȵ�

INSERT INTO MEMBER(NAME,AGE) VALUES('���',27);--X ID�� NOT NULL
INSERT INTO MEMBER(ID,NAME,AGE) VALUES('KING','���',100); --x ���̴� 2�ڸ���

INSERT INTO MEMBER ( ID,NAME,AGE)VALUES('soon','���',99); --�����Ͱ��� ��ҹ��� ������

INSERT INTO MEMBER(ID,NAME,ADDR,REG_DATE) VALUES('AA','�ɼ�','����','2023-10-10');


--10byte vs 10 char����
INSERT INTO MEMBER(ID,NAME,ADDR) VALUES('BB','�⳪�ٶ�','�����'); --X �ѱ��� �ѱ��ڴ� 3byte

INSERT INTO MEMBER(ID,NAME,ADDR) VALUES('BB','�⳪��','����� ������'); -- addr 10 char �̹Ƿ� ����

--char vs varchar2��

INSERT INTO MEMBER(ID,NAME,JUMIN) VALUES('FF','A','B');

INSERT INTO MEMBER(ID,NAME,JUMIN) VALUES('GG','A ','B ');


--VARCHAR2 �˻�
SELECT * FROM MEMBER WHERE NAME='A';
SELECT * FROM MEMBER WHERE NAME='A ';

SELECT * FROM MEMBER WHERE NAME LIKE 'A%';

--CHAR �˻�
SELECT *FROM MEMBER WHERE JUMIN ='B';

SELECT *FROM MEMBER WHERE JUMIN ='B ';

SELECT NAME,JUMIN,LENGTH(NAME),LENGTH(JUMIN) FROM MEMBER WHERE ID='FF';

SELECT NAME,JUMIN,LENGTH(NAME),LENGTH(JUMIN) FROM MEMBER WHERE ID='GG';


--���̺� ���� 
DROP TABLE MEMBER;

-- �ϳ��� ���̺� �ΰ��� �÷��� �ϳ��� ��� pk�����ϱ� 
CREATE TABLE MEMBER(
    ID VARCHAR2(20),
    NAME VARCHAR2(30) NOT NULL,
    JUMIN CHAR(13),
    AGE NUMBER(3),
    REG_DATE DATE,
    CONSTRAINT MEMBER_ID_JUMIN_PK PRIMARY KEY(ID,JUMIN) -- ID�ϳ��� ������ ID�� PK ,JUMIN�� ���� �־��ָ� ����Ű�� ������
    

);
--���̺� ����Ȯ��
DESC MEMBER;

--���ڵ� �߰��ؼ� PK TEST�غ���
INSERT INTO MEMBER VALUES('HONG','��ȣ','123456-123456',20,SYSDATE);

INSERT INTO MEMBER VALUES('HONG','��ȣ2','123456-234567',20,SYSDATE);

INSERT INTO MEMBER VALUES('SOON','��ȣ1','123456-123456',20,SYSDATE);

INSERT INTO MEMBER VALUES(NULL,'��ȣ','123456-123456',20,SYSDATE);--X

--���̺� �˻�
SELECT *FROM MEMBER;











/*
  ���ڵ� ���
  INSERT INTO ���̺��̸�(�÷���, �÷���,....) VALUES(��, ��,��,....);
  INSERT INTO ���̺��̸� VALUES(��, ��,��,....); -- ��� �÷��� ������� ���� ������!!!
*/



----------------------------------------------------------------------------
/*
  2) FOREIGN KEY - FK = �ܷ�Ű
      : �ٸ� ���̺��� PK�� �����ϴ� ��.
      : ���̺� ���ڵ带 �߰��Ҷ� �����Ǵ� ����� ���̿ܿ��� ��� �Ҽ� ����.
          - �������Ἲ��Ģ!!!
      : NULL���, �ߺ�����!!
      : �ϳ��� ���̺� �������� �÷��� FK���������ϴ�.
      
      : ��������� ���� - �ڱ��ڽ����̺��� PK�� �����ϴ°�!!!
      
      *���ǻ���
        INSERT �Ҷ� : �θ�Ű�� INSERT -> �ڽ� INSERT 
        DELETE�Ҷ� :  �����ϰ� �ִ� �ڽ� DELETE -> �θ� DELETE �ؾ��Ѵ�.
      
             * �̷��� ���ǻ��׿� ���� �������� �ذ��ϱ� ���ؼ�.
               FK�� �����Ҷ� ON DELETE CASCADE �� �߰��ϸ� �θ��ڵ带 �����ϸ�
              �� �θ�Ű�� �����ϴ� ��� ���̺��� ���ڵ带 �Բ� �����Ѵ�.
	      �Ǵ� FK�����Ҷ� on delete set null �� �߰��ϸ�
	      �θ��ڵ� �����ɶ� �����Ǵ� �ڽķ��ڵ��� ���� null�̵ȴ�.
      
     
*/

--SCOTT ���� ����
SELECT *FROM EMP;
SELECT *FROM DEPT;

--���� �������� �����ؼ� FK�ǽ�

--�μ� ���̺�

CREATE TABLE DEPT(
    DEPT_CODE CHAR(3) CONSTRAINT DEPT_CODE_PK PRIMARY KEY,
    DNAME VARCHAR2(30) NOT NULL,
    LOC VARCHAR2(30)

);
DESC DEPT;


--���÷��ڵ� �߰�

INSERT INTO DEPT VALUES('A01','�渮��','����');
INSERT INTO DEPT VALUES('A02','������','�뱸');
INSERT INTO DEPT VALUES('A03','�λ��','����');

--���ڵ� �˻�

SELECT *FROM DEPT;

CREATE TABLE EMP(
    EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL, --�ѱ��� 5���ڱ��� ���� 3byte
    SAL NUMBER(5),
    DEPT_CODE CHAR(3) CONSTRAINT EMP_DEPT_CODE_FK REFERENCES DEPT(DEPT_CODE),
    HIRE_DATE DATE DEFAULT SYSDATE
    
);
DROP TABLE EMP;
DESC EMP;
SELECT *FROM EMP;
COMMIT;
--��� ���
INSERT INTO EMP(EMP_NO , ENAME,SAL , DEPT_CODE , HIRE_DATE) VALUES(1,'����',300,'A01');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(8,'����',300,'A01',DEFAULT);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(2,'����',300,'A02','2024-01-20');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(3,'����',300,'A01',NULL);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(4,'����',300,'A01');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(6,'����',300,'A01');
INSERT INTO EMP VALUES(5,'����',300,'A01',DEFAULT);

DROP TABLE EMP;

DELETE EMP;

ROLLBACK;

--�θ��� �����ǰ� �����ʴ� ���ڵ带 �����غ���
DELETE FROM DEPT WHERE DEPT_CODE ='A03';
--�θ����̺��� �����ǰ� �ִ� ���ڵ带 �����غ���
DELETE FROM DEPT WHERE DEPT_CODE='A02';

--�����ǰ� �ִ� �ڽķ��ڵ带 ���� �������Ŀ� �θ��ڵ带 �����ؾ��Ѵ�
DELETE FROM EMP WHERE DEPT_CODE='A02';
DELETE FROM DEPT WHERE DEPT_CODE='A02';

SELECT *FROM DEPT;
SELECT *FROM EMP;


--ON DELETE CASCADE VS ON DELETE SET NULL �ɼ� �����ؼ� ���غ���
DROP TABLE EMP;
--��� ���̺� ����
CREATE TABLE EMP(
    EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL, --�ѱ��� 5���ڱ��� ���� 3byte
    SAL NUMBER(5),
    DEPT_CODE CHAR(3) CONSTRAINT EMP_DEPT_CODE_FK REFERENCES DEPT(DEPT_CODE) ON DELETE CASCADE,
    HIRE_DATE DATE DEFAULT SYSDATE
    
);
SELECT *FROM DEPT;
--���ڵ� �߰�
INSERT INTO DEPT VALUES('A02','�渮��','�뱸');

--EMP ���ڵ� �߰�
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(1,'����',300,'A01',DEFAULT);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(2,'����',300,'A02','2024-01-20');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(3,'����',300,NULL);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(4,'����',300,'A01');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(5,'����',300,'A01');
INSERT INTO EMP VALUES(6,'����',300,'A01',DEFAULT);

SELECT *FROM EMP;
SELECT *FROM DEPT;
--�������̺��� �����ǰ� �ִ� ���ڵ带 �����غ���(DEPT)
DELETE DEPT WHERE DEPT_CODE ='A01'; --ON DELETE CASCADE

--���̺� �����ϰ�
DROP TABLE EMP;
--�ɼ��� �����ؼ� FK����
CREATE TABLE EMP(
    EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL, --�ѱ��� 5���ڱ��� ���� 3byte
    SAL NUMBER(5),
    DEPT_CODE CHAR(3) CONSTRAINT EMP_DEPT_CODE_FK REFERENCES DEPT(DEPT_CODE) ON DELETE CASCADE,
    HIRE_DATE DATE DEFAULT SYSDATE
    
);
INSERT INTO DEPT VALUES ('A01','�渮��','�뱸');

--���ڵ� �߰��ϰ� 
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(1,'����',300,'A01',DEFAULT);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(2,'����',300,'A02','2024-01-20');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE,HIRE_DATE) VALUES(3,'����',300,NULL);
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(4,'����',300,'A01');
INSERT INTO EMP(EMP_NO,ENAME,SAL,DEPT_CODE) VALUES(5,'����',300,'A01');
INSERT INTO EMP VALUES(6,'����',300,'A01',DEFAULT);

SELECT *FROM EMP;
SELECT *FROM DEPT;
--�����غ���
DELETE DEPT WHERE DEPT_CODE = 'A01'; 
 
DROP TABLE EMP;

--FK������ SQL���� �ǵڿ��� �ۼ��ϴ� ���
CREATE TABLE EMP(
    EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL, --�ѱ��� 5���ڱ��� ���� 3byte
    SAL NUMBER(5),
    DEPT_CODE CHAR(3),
    HIRE_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT EMP_DEPT_CODE_FK FOREING KEY(DEPT_CODE) REFERENCES DEPT(DEPT_CODE) ON DELETE SET NULL
    
);
COMMIT;

/*
  3) UNIQUE
      : �ߺ��ȵ�, NULL���(NOT NULL�� �����ϸ� PK�� ����) 
      : �ĺ�Ű�߿� ��ǥŰ�� �ɼ� ���� Ű�� UNIQUE �����Ѵ�. 
      :  �����̺� �������� �÷��� ��������
      
  4) CHECK
      : ������ �����Ͽ� ���ǿ� �������� �ʴ� ������ INSERT �Ҽ� ����!
    
  
  5) DEFAULT
      : �⺻�� ����(���ֻ��Ǵ� ���� �̸� �����س��� �ڵ����� ���� ���� �ֶǷ� �ϴ°�)
      : EX) �����, ��ȸ��....
      : DEFAULT�� �����Ҷ��� CONSTRAINT ��Ī�� �Ⱦ���!!!
      : NOT NULL�� �����ϸ� DEFALUT�� �Բ� ����Ҷ��� �ݵ�� DEFAULT�� ���� �ۼ��Ѵ�.
*/



--UNIQUE, DEFAULT , CHECK , TEST �غ���

CREATE TABLE TEST (
    ID VARCHAR2(10) PRIMARY KEY,--��Ī ����
    JUMIN CHAR(13) NOT NULL UNIQUE,
    NAME VARCHAR2(10) UNIQUE,
    AGE NUMBER(2) CHECK (AGE>=20 AND AGE<=30), --CHECK ���ǽ� 
    GENDER CHAR(3) CHECK (GENDER ='��' OR GENDER = '��'),
    GEG_DATE DATE DEFAULT SYSDATE  NOT NULL


);


DROP TABLE TEST;

DESC TEST;


INSERT INTO TEST (ID,JUMIN,NAME) VALUES ('JANG','111','����');

INSERT INTO TEST (ID,JUMIN,NAME) VALUES ('HEE','222',NULL);
INSERT INTO TEST (ID,JUMIN,NAME) VALUES ('HONG','333',NULL);

INSERT INTO TEST (ID,JUMIN,NAME) VALUES ('SOON','444','��ȣ');
INSERT INTO TEST (ID,JUMIN,NAME,AGE ,GENDER) VALUES ('AAA','555','��ȣ1',22,'��');

INSERT INTO TEST (ID,JUMIN,NAME,AGE ,GENDER) VALUES ('BBB','666','��ȣ2',25,'��');


INSERT INTO TEST (ID,JUMIN,NAME,AGE ,GENDER) VALUES ('CCC','777','��ȣ3',23,'��');

SELECT *FROM TEST;






/*
   ���ڵ� �������
    1) ROLLBACK ó������ - DML
      DELETE [FROM] ���̺��̸�
      [WHERE ���ǽ�]
      
        * FROM ��������, WHERE���� ������ ��� ���ڵ尡 �����ȴ�.
          
    2) ROLLBACK �ȵȴ�. - DDL
     TRUNCATE TABLE ���̺��̸�; --��緹�ڵ带 ����
      
*/
--���� ��Ȳ�� ��� ����Ϸ�



---------------------------------------------------------------------------------------------------
/*
  ���̺� ����
  
 �� �÷��߰�
  alter table ���̺��̸� add 
     (�÷��� �ڷ��� [��������] , �÷��� �ڷ��� [��������] , ....)
 
 �� �÷�����
 alter table ���̺��̸� drop column �÷��̸�
 
 �� datatype����
    alter table ���̺��̸� modify �÷��̸� �����ڷ���
    
�� �÷��̸� ����
 alter table ���̺��̸� rename column �����÷��� to �����÷���
 
 �� �������� �߰�
  alter table ���̺��̸� ADD CONSTRAINT ��Ī ������������ ;
  
 -�������� ����
  ALTER TABLE ���̺��̸� DROP CONSTRAINT ��Ī;
  
 
 - ���̺� ����
 drop table ���̺��̸�

*/



SELECT *FROM TEST;
DESC TEST;
ALTER TABLE TEST ADD (ADDR CHAR (15));
ALTER TABLE TEST DROP COLUMN ADDR;
ALTER TABLE TEST ADD (ADDR CHAR (15));
ALTER TABLE TEST MODIFY ADDR CHAR(3);
ALTER TABLE TEST RENAME COLUMN ADDR TO ADDR;


--���������߰�
ALTER TABLE TEST ADD CONSTRAINT TEST_ID_PK PRIMARY KEY(ID);

--NAME NOT NULL ����
ALTER TABLE TEST MODIFY NAME NOT NULL;

--GENDER DEFAULT ����
ALTER TABLE TEST MODIFY (GENDER DEFAULT '��');

SELECT REG_DATE,ID FROM MEMBER;


---------------------------------------------------------------------------
/*
SQL�� ����
 - DDL����(CREATE, DROP, ALTER, TRUNCATE)
 - DML����(INSERT ,UPDATE, DELETE)
 - DQL����(SELECT)
 
*/

/*
  ������ ���� : DML(INSERT , UPDATE, DELETE)
   - ROLLBACK OR COMMIT ����
   
   1) INSERT����
       -INSERT INTO ���̺��̸�(�÷���, �÷���,....) VALUES(��, ��,��,....);
       -INSERT INTO ���̺��̸� VALUES(��, ��,��,....); -- ��� �÷��� ������� ���� ������!!!
   
   2) DELETE����
       DELETE [FROM] ���̺��̸�
       [WHERE ���ǽ�]
   
   3) UPDATE����
      UPDATE ���̺��̸�
      SET �÷���=���氪 , �÷���=���氪,....
      [WHERE ���ǽ�] 

*/



/*
   --���̺� ����
   CREATE TABLE ���̺��̸�
   AS ���������̺�����;
   
   
    ���� : ���̺��� �����ϸ� ���������� ���� �ȵȴ�!!! - �������Ŀ� ���������� ALTER�� �̿��ؼ� �߰��Ѵ�.

*/

--���̺� �����غ��� -SCOTT ���� ����

SELECT *FROM EMP;

--��� ���ڵ� , ��� �÷��� �����غ���

CREATE TABLE COPY_EMP AS SELECT *FROM EMP; --�������� ���� �ȵ�

SELECT *FROM COPY_EMP;

ALTER TABLE COPY_EMP ADD CONSTRAINT COPY_EMP_NO_PK PRIMARY KEY(EMPNO); --�������� �߰�

DESC COPY_EMP;

--���ǿ� �����ϴ� Ư�� ���ڵ�� �÷��� ������ �����ϱ�
CREATE TABLE  COPY_EMP2 AS SELECT EMPNO,ENAME,JOB,HIREDATE FROM EMP WHERE SAL >2500;

DESC COPY_EMP2;
SELECT*FROM COPY_EMP2;

--3) ������ �����ϰ�ʹ�
CREATE TABLE COPY_EMP3 AS SELECT *FROM EMP WHERE 1=0;
DROP TABLE COPY_EMP3;
DESC COPY_EMP3;
SELECT *FROM COPY_EMP3;

COMMIT;

--���ڵ� ���� (COPY_EMP)
SELECT *FROM COPY_EMP;

--EX) EMPNO�� 7499�� ����� JOB�� TEACHER, ENAME �� HEEJUNG �����غ���
UPDATE COPY_EMP 
SET JOB='TEACHER',ENAME='HEEJUNG'
WHERE EMPNO=7499;

SELECT *FROM COPY_EMP WHERE EMPNO =7499;

UPDATE COPY_EMP 
SET JOB='TEACHER',ENAME='HEEJUNG'
WHERE SAL >=2500;
SELECT *FROM COPY_EMP WHERE JOB='TEACHER';




































