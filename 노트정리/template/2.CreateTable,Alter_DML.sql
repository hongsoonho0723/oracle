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

--DESC TABLE MEMBER;
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






--����
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



---------------------------------------------------------------
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

---------------------------------------------------------------------------
/*
SQL�� ����
 - DDL����(CREATE, DROP, ALTER, TRUNCATE)
 - DML����(INSERT ,UPDATE, DELETE)
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

