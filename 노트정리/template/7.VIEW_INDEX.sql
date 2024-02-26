/*
   VIEW : �������̺�
     - ���� �������� ������ ���� ���̺�� �Ȱ��� ����� : (select , insert , delete, update ����)
       : �����Ҷ� �ɼ��� ��� �����ϴ��Ŀ� ���� DML ���ΰ� �޶�����.
       : JOIN�� ��� ����������� DML �ȵ�
       
     -����ϴ� ����?? 
        :  ������ ��������(����, ��������)�̸� ��� ����� ����� �����ϰ� �˻� ������.(��,insert , delete, update �ȵ�)
        
        :  ������ ���� �����(������ ������ ���� Ư�� �÷� �� �����Ͽ� ������)
           - ���̺��� Ư���� �÷��� ���ڵ带 �����ؼ� �並 ����� ���ѿ� ������ �ִ� DBA���� �������̺��� �ƴ� ���� �̸���
              �˷������ν� DBA�� �丸 ���� �Ҽ� �ֵ��� ������ �д�. 

    -�� �������
     CREATE VIEW ���̸�
     AS ���ǳ���;
     
     --�� ���� + ����
     CREATE OR REPLACE VIEW ���̸�
     AS ���� ����;
     
     --�����
     DROP VIEW ���̸�;
     
     *�並 �����ϸ� �ɼ� ����
      1) WITH CHECK OPTION : �並 �����Ҷ� ������ �̿��ؼ� ����� �Ǹ� INSERT, UPDATE, DELETE�� �Ҷ� ���ǿ� �������� �ʴ�
                              ������ DML�� �Ҽ� ������ �ϴ°�!!
                              
      2) WITH READ ONLY : �б�����(DML �ȵ�)
*/
--SCOTT�������� ����

select *from emp;

drop table copy_emp;
--���̺� ����

create table copy_emp
as select *from emp;

--COPY_EMP �������� ����ϴ� VIEW ������.

SELECT *FROM COPY_EMP; --���� ���̺�

CREATE OR REPLACE VIEW V_EMP
AS SELECT *FROM COPY_EMP;



--��� ���̺�ó�� ���Ǳ� ������ SELECT, INSERT, UPDATE, DELETE �⺻������ �����ϴ�.

SELECT *FROM V_EMP;

DELETE FROM COPY_EMP WHERE SAL =800;

--�信 INSERT �غ���.

INSERT INTO V_EMP(EMPNO,ENAME,JOB,SAL) VALUES(9000,'HEEJUNG','STUDENT',3000);

--COPY_EMP �˻�
SELECT *FROM V_EMP;
SELECT *FROM COPY_EMP;

--COPY_EMP�� DELETE �غ���
DELETE FROM COPY_EMP WHERE DEPTNO=30;

--�並 �˻��غ���
SELECT *FROM V_EMP;
SELECT *FROM COPY_EMP;

--�信�� �����غ���.
DROP VIEW V_EMP;

-----------------------------------------------------------
-- �������� �������� VIEW�� ������ (���ǿ� �ش��ϴ� ���ڵ�� �÷��� �����ؼ� ���� ������)
SELECT * FROM COPY_EMP;
--EX) �μ���ȣ 20 �� ����� ������ VIEW ������

CREATE OR REPLACE VIEW V_EMP
AS SELECT *FROM COPY_EMP WHERE DEPTNO=20;

SELECT *FROM V_EMP;
SELECT *FROM COPY_EMP;

--VIEW , TABLE �� ���� INSERT�غ��� (DEPTNO�� 20�ΰ�� 20�� �ƴѰ��)


--VIEW�� INSERT
INSERT INTO V_EMP (EMPNO,ENAME,DEPTNO) VALUES(7998,'HONGSOONHO',20);

-- TABLE�� INSERT
INSERT INTO COPY_EMP (EMPNO,ENAME,DEPTNO) VALUES(7999,'HONGSOONHO',20);

--VIEW�� INSERT
INSERT INTO V_EMP (EMPNO,ENAME,DEPTNO) VALUES(8000,'KING',40); --��� 20�� �μ���

/*
    ���� ������ ������ �ϰ� V_EMP �� �˻��غ��� V_EMP�� VIEW�� ������ 20�� �μ��� �˻��� VIEW�̱� ������
    ���(COPY_EMP�� �߰�)�� �Ǿ����� �˻������� ������ �ʴ´� �並 ����ϴ� ���忡�� ��Ȳ
    �׷��� VIEW�� �����Ҷ� WITH CHECK OPTION OR WITH READ ONLY�� ������ ����
    ���ǿ� �������� �ʴ� ���ڵ� ������ �Ҽ� ������ ������ �ʿ��ϴ�
*/

-- TABLE�� INSERT
INSERT INTO COPY_EMP (EMPNO,ENAME,DEPTNO) VALUES(8001,'HONGSOONHO',40);

--�並 �����غ���(�ɼ� ����)
CREATE OR REPLACE VIEW V_EMP
AS SELECT *FROM COPY_EMP WHERE DEPTNO=20 WITH CHECK OPTION;

--�� ���̺� �˻� 
SELECT *FROM V_EMP;
SELECT *FROM COPY_EMP;

--VIEW�� INSERT
INSERT INTO V_EMP (EMPNO,ENAME,DEPTNO) VALUES(8005,'SOONHO',20);

-- TABLE�� INSERT
INSERT INTO COPY_EMP (EMPNO,ENAME,DEPTNO) VALUES(8006,'SOONHO',20);

--VIEW�� INSERT
INSERT INTO V_EMP (EMPNO,ENAME,DEPTNO) VALUES(8007,'KIM',40); --��� 20�� �μ���

INSERT INTO COPY_EMP (EMPNO,ENAME,DEPTNO) VALUES(8008,'KIM',40);



--�並 �б� ����
CREATE OR REPLACE VIEW V_EMP
AS SELECT *FROM COPY_EMP WHERE DEPTNO=20 WITH READ ONLY;

SELECT *FROM V_EMP;
SELECT *FROM COPY_EMP;

--�信 INSERT 
INSERT INTO V_EMP (EMPNO,ENAME,DEPTNO) VALUES(8009,'SOONHO',20);


INSERT INTO COPY_EMP (EMPNO,ENAME,DEPTNO) VALUES(8010,'SOONHO',20);

INSERT INTO V_EMP (EMPNO,ENAME,DEPTNO) VALUES(8015,'SOONHO',40);


INSERT INTO COPY_EMP (EMPNO,ENAME,DEPTNO) VALUES(8016,'SOONHO',40);

----------------------------------------------------------------
--2) ������ ����(JOIN, SUBQUERY)�� �̸� ��� ���� ��ȸ�Ҷ� ����ȭ �ϰ� ��ȸ �Ҽ� �ֵ��� �ϴ� �뵵
--EX) � ����� ������ �ٹ���(LOC)���� �ٹ��ϴ� ����� �̸� ��� �ϰ�ʹ�!!!


--Ư���� ������ �����ϰ� �ִ� �л��� ����
CREATE OR REPLACE VIEW V_SEARCH_STUDENT
AS 
SELECT ST.student_number,student_name,student_jumin ,student_phone ,student_addr,student_email, SUB.subject_code,subject
FROM STUDENT ST INNER JOIN SUGAGn SU
    ON ST.student_number=SU.student_number INNER JOIN SUBJECT SUB
    ON SU.subject_code=SUB.subject_code;
    
--Ư�� ���� �ش��ϴ�
SELECT *FROM  V_SEARCH_STUDENT WHERE SUBJECT ='sql';



 ---------------------------------------------------------
 /*
   CREATE���� : TABLE, VIEW, SEQUENCE , INDEX
        - OBJECT=��ü - ������������ ���� �����ϴ� ��....
 */
 --���� �������� ����Ҽ� �ִ� ��ü���� ���� ������ �˻��ϰ� �ʹ�!!!!
 SELECT * FROM USER_TABLES;
 SELECT * FROM USER_VIEWS;
 SELECT * FROM USER_SEQUENCES;
 SELECT * FROM USER_INDEXES;
 
 SELECT *FROM EMP;
 /*
   INDEX
     : �ε����� ������ ���� ��ȸ������ �ش�ȭ �ϱ� ���� ����� ��ü�̴�.
     : �ε����� ������ ����ٰ� �ؼ� �������� �ƴϰ� ��ü ���̺��� ������ �� ���� �����ؾ��Ѵ�.
     : �ֳ��ϸ�, �ε����� Ư�����̺��� ���ڵ�˻� �ӵ��� ������ �ϴµ� ������ ������ ��ü�ý��۳�����
       �ʹ� ���� �ε����� ������ ��ü ������ ���ϵɼ� �ִ�. ���� INSERT, UPDATE, DELETE�� �ϰ� �Ǹ�
      �׶����� INDEX������ ����Ǳ� ������ ��ü �����ȿ��� �ý��� ���ϰ� �����(��������)
      �˻��ӵ��� ���̱� ���ؼ� �ε����� ���� �����ϱ� ���ٴ� SQL������ ���� ȿ�������� ¥�� ����� �ϴ°� ��
      ����!!
      
      :�ַ� �ε��� ����� �Ǵ� �÷��� �˻��� �������� ���� Ȱ��Ǵ� �÷����� �����.
      
      : �ε��� ����
       CREATE INDEX �ε����� ON ���̺��̸�(�÷���, �÷���,....) ;
       
      : �ε��� ����
       DROP INDEX �ε�����;
 */
 

 CREATE INDEX INDEX_SAL ON EMP(SAL);
 
 DROP INDEX INDEX_SAL;
 
 
 
 
 
 
 
 
 
 
 
 
 
 





