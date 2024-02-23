/*
  JOIN
   : �ѹ��� SELECT�������� 2�� �̻��� ���̺� �ִ� �÷��� ������ �˻��ϰ� ���� �� ����Ѵ�.
   : JOIN�� ����
     1) INNER JOIN
         - EQUI JOIN = �������� = NATURAL JOIN
         - NON EQUI JOIN : ���� ��� ���̺��� � �÷��� ���� ��ġ���� ���� �� ���
                          EX) BETWEEN AND , IS NULL, IS NOT NULL, IN, > , < ����  ���ǹ��� ����Ҷ� ����.
        
      2) OUTER JOIN
           : �⺻ EQUI JOIN�� �ϸ鼭 ������ ���̺��� ��� ������ �˻��ϰ� ������ ����Ѵ�.
              - LEFT OUTER JOIN
              - RIGHT OUTER JOIN
              - FULL OUTER JOIN
    
      3) SELF JOIN
           : �ڱ� �ڽ����̺��� �����ϴ� ��(�ϳ��� ���̺��� 2��ó�� ����ϴ� ��)
           : �ַ� ����������� �� ���� ����Ѵ�. (���������� �ڽ��ڽ����̺��� PK�� FK�� �����ϴ� ��)
           
    : JOIN �ڵ� ���
      1) SQL JOIN  - FULL OUTER JOIN�� �������� �ʴ´�. 
      2) ANSI JOIN : �̱�����ǥ�ؿ����ҿ��� ���� �̱��� ǥ���� �⺻���� �Ѵ�. - ����
*/

CREATE TABLE TEST1(
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30),
    ADDR VARCHAR2(50)
);

INSERT INTO TEST1 VALUES('JANG', '����', '����');
INSERT INTO TEST1 VALUES('KIM', '����', '�뱸');
INSERT INTO TEST1 VALUES('GYEEB', '�̳�', '�λ�');
INSERT INTO TEST1 VALUES('HEE', '�̿�', '����');
INSERT INTO TEST1 VALUES('KING', '����', '���ֵ�');

SELECT * FROM TEST1;

-- TEST1�� �����ϴ� ���̺� ����(ID�� �ش��ϴ� ����� ���� �ִ� JOB, SAL�� ���� ����)
CREATE TABLE TEST2(
    CODE CHAR(3) PRIMARY KEY,
    ID VARCHAR2(10) REFERENCES TEST1(ID),  ---FK
    JOB VARCHAR2(30),
    SAL NUMBER(3)
);


INSERT INTO TEST2 VALUES('A01', 'JANG','����',200);
INSERT INTO TEST2 VALUES('A02', 'JANG','������',300);
INSERT INTO TEST2 VALUES('A03', 'HEE','�����̳�',250);
INSERT INTO TEST2 VALUES('A04', 'KING','��ȹ��',400);
INSERT INTO TEST2 VALUES('A05', NULL,'����',500);

SELECT * FROM TEST1;
SELECT * FROM TEST2;

--EX) ID,NAME,ADDR ,JOB ,SAL �ѹ��� �˻��ϰ� �ʹ� -->JOIN
-- ���� ���� = INNER JOIN = NATURAL JOIN

--1) �ڵ���� -> SQL JOIN
SELECT TEST1.ID,NAME,ADDR ,JOB,SAL
FROM TEST1, TEST2 --CROSS JOIN 5*5=25
WHERE TEST1.ID = TEST2.ID;

SELECT T1.ID,NAME,ADDR ,JOB,SAL
FROM TEST1 T1, TEST2 T2 --���̺� ��Ī�ֱ�
WHERE T1.ID = T2.ID;


--2) ANSI JOIN


SELECT T1.ID,NAME,ADDR ,JOB,SAL
FROM TEST1 T1 INNER JOIN TEST2 T2
ON T1.ID = T2.ID;

--USING ����ϱ� (�������̺��� ���Ǵ�� �÷��� �̸��� Ÿ���� ��ġ�Ҷ� ..���) ���̺� ��Ī ��� �Ұ�

SELECT ID,NAME,JOB
FROM TEST1 INNER JOIN TEST2
USING(ID);


--NATURAL JOIN ���� ���̺��� ���� �÷��� , ���� Ÿ���� ���� �÷��� �������� ��� �����Ѵ�
SELECT *
FROM TEST1 NATURAL JOIN TEST2; 

--OUTER JOIN��� (LEFT | RIGHT | FULL)
--1) SQL �ڵ����
SELECT *
FROM TEST1 T1 , TEST2 T2
WHERE T1.ID = T2.ID(+);


SELECT *
FROM TEST1 T1 , TEST2 T2
WHERE T1.ID(+) = T2.ID;

SELECT *
FROM TEST1 T1 , TEST2 T2
WHERE T1.ID(+) = T2.ID(+); --X FULL���� ���� �ȵȴ�

--2) ANSI �ڵ����

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

-- 3���� ���̺� �����ϱ�
CREATE TABLE TEST3(
    CODE CHAR(3) PRIMARY KEY REFERENCES TEST2(CODE),  -- PK, FK (�ĺ�����)
    MANAGER_NAME VARCHAR2(30),
    PHONE VARCHAR2(30)
);


INSERT INTO TEST3 VALUES('A01', '���缮','111-1111');
INSERT INTO TEST3 VALUES('A02', '���߱�','222-2222');
INSERT INTO TEST3 VALUES('A03', '��ȿ��','333-3333');

SELECT * FROM TEST1;
SELECT * FROM TEST2;
SELECT * FROM TEST3;

-- EX) ID, NAME, ADDR, JOB, SAL, MANAGER_NAME, PHONE �˻�

-- SQL ���ι��
SELECT *
FROM TEST1 T1, TEST2 T2,TEST3 T3
WHERE T1.ID=T2.ID AND T2.CODE = T3.CODE;

   
-- ANSI ���ι��

SELECT *
FROM TEST1 JOIN TEST2
USING(ID) JOIN TEST3 USING(CODE);



-- ���ο� ���� �ֱ� -- SAL�� 300�̻��� ���ڵ� �����ϱ�

--SQL����
SELECT *FROM TEST1,TEST2,TEST3
WHERE TEST1.ID = TEST2.ID AND TEST2.CODE = TEST3.CODE AND SAL >=300;

--ANSI
SELECT *
FROM TEST1 JOIN TEST2
USING(ID) JOIN TEST3 USING(CODE) AND SAL>=300;

SELECT *
FROM TEST1 JOIN TEST2
USING(ID) JOIN TEST3 USING(CODE)
WHERE SAL>=300; --X USING ���� �Ϲ� ������ ����Ҽ� ����


SELECT *
FROM TEST1 JOIN TEST2
ON TEST1.ID = TEST2.ID JOIN TEST3 ON TEST2.CODE = TEST3.CODE AND SAL>=300;

--NON-EQUI JOIN --SCOTT ��������
-- EMP���̺��� ����� ���� + �޿������ �Բ� �˻��ϰ� �ʹ�
SELECT *FROM SALGRADE; --�޿���� ����
SELECT *FROM EMP; --�������

SELECT EMPNO,ENAME,JOB,SAL,GRADE,LOSAL,HISAL
FROM EMP JOIN SALGRADE
ON SAL BETWEEN LOSAL AND HISAL;
 
 
 
 
-- SELF JOIN - �ڱ��ڽ� ���̺��� 2���� ���� ����(���������)
-- EX) SMITH����� �����ڴ� FORD�Դϴ�. ���

SELECT E1.EMPNO �����ȣ,E1.ENAME ����̸� , E2.EMPNO ������_�����ȣ,E2.ENAME ������_�̸�
FROM EMP E1 JOIN EMP E2 --������ ������̺� �������� ������ ���̺� ����ڰ� ���ؾ���
ON E1.MGR =E2.EMPNO
where E1.ENAME='SMITH';


SELECT E1.ENAME || '�� �����ڴ� ' || E2.ENAME || '�Դϴ�'
FROM EMP E1 LEFT JOIN EMP E2 --������ ������̺� �������� ������ ���̺� ����ڰ� ���ؾ���
ON E1.MGR =E2.EMPNO
where E1.ENAME='SMITH';
--------------------------------------------------------------
/*
  SET ����  1
   1) ������
        UNION ALL - �ߺ����ڵ带����
        UNION - �ߺ����ڵ� ����
        
   2) ������ 
       INSERSECT : A�� B ���̺��� ����� ���ڵ� �˻�
       
   3) ������ 
        MINUS : A���̺��� B���̺��� ���ڵ带 �� ������ ���ڵ� �˻�
*/

CREATE TABLE SET_COPY
AS SELECT EMPNO , ENAME, JOB ,SAL FROM EMP WHERE SAL > 2000;

--���ڵ� 3�� �߰�
INSERT INTO SET_COPY VALUES(9001,'����','TEACHER',2500);
INSERT INTO SET_COPY VALUES(9002,'����2','STUDENT',1500);
INSERT INTO SET_COPY VALUES(9003,'����3','INSTRU',2000);

SELECT * FROM SET_COPY; --9���ڵ�

--1) ������ -UNION
SELECT EMPNO,ENAME,JOB FROM EMP --14��
UNION ALL
SELECT EMPNO,ENAME,JOB FROM SET_COPY; --9��

SELECT EMPNO,ENAME,JOB FROM EMP --14��
INTERSECT--������
SELECT EMPNO,ENAME,JOB FROM SET_COPY; --9��



SELECT EMPNO,ENAME,JOB FROM SET_COPY --9��
MINUS --������
SELECT EMPNO,ENAME,JOB FROM EMP --14��;


SELECT EMPNO,ENAME,JOB FROM EMP --14��
MINUS
SELECT EMPNO,ENAME,JOB FROM SET_COPY --9��;

commit;
 -------------------------------------------------------------
 /*
   SUBQUERY - ������
    : ���������ȿ� �� �ٸ� ������ �����ϴ°�
    : ()��ȣ�� ���´�. ��ȣ�ȿ� ���๮���� ���� ������� �� ����� ���������� �������� �ַ� ����Ѵ�. 
    : ���������� ��� ���� �Ѱ� �϶�  �񱳿����� ���.
    : ���������� ��� ���� ������ �϶��� ANY, ALL, IN �����ڸ� ����Ѵ�. 
    : �ַ� SELECT���� ���� ��������� CREATE, INSERT, UPDATE ,DELTE, 
           HAVING, WHERE , FROM ,ORDER ������ ��밡���ϴ�.
 */
 
 --EMP���̺��� ��� �޿����� �� ���� �޴� ��� �˻�

--1)��� �޿��� �˾ƾ��Ѵ�
    SELECT AVG(SAL) FROM EMP;

--2) 1���� ���� ����� �������� ����Ѵ�
    SELECT * FROM EMP WHERE SAL > (SELECT AVG(SAL) FROM EMP);
    
      
-- JOB�� 'A'���ڿ��� �� ����� �μ��� ���� ������ �ٹ��ϴ� ����� �μ��̸� �˻��ϰ� �ʹ�. 

    SELECT DISTINCT DEPTNO FROM EMP WHERE JOB LIKE '%A%';

    SELECT DNAME FROM DEPT WHERE DEPTNO  IN(SELECT DEPTNO FROM EMP WHERE JOB LIKE '%A%');
  
    SELECT DNAME FROM DEPT WHERE DEPTNO  = ANY(SELECT DEPTNO FROM EMP WHERE JOB LIKE '%A%');
  
  SELECT *FROM DEPT;
  SELECT *FROM EMP;
  
  
 -- �μ���ȣ�� 30�� ������� �޿��߿��� ���� ���� �޴� ������� �� ���� �޴� ��������� �˻��ϰ� �ʹ�. 


 
  SELECT *FROM EMP WHERE SAL > ALL (  SELECT SAL FROM EMP WHERE DEPTNO =30);
  
  --�����Լ��� �̿��ؼ� Ǯ���
    SELECT *FROM EMP WHERE SAL > (  SELECT MAX(SAL) FROM EMP WHERE DEPTNO =30);
  
    
 -- �μ���ȣ�� 30�� ������� �޿��߿��� ���� ���� �޴� ������� �� ���� �޴� ��������� �˻��ϰ� �ʹ�. 
  
    SELECT *FROM EMP WHERE SAL < (SELECT MIN(SAL)FROM EMP WHERE DEPTNO=30 ); 

   SELECT *FROM EMP WHERE SAL <ALL (  SELECT SAL FROM EMP WHERE DEPTNO =30);
-- �μ���ȣ�� 30�� ������� �޿��߿��� ���� ���� �޴� ������� �� ���� �޴� ��������� �˻��ϰ� �ʹ�. 
 
    SELECT *FROM EMP WHERE SAL > (SELECT MIN(SAL)FROM EMP WHERE DEPTNO=30 ); 

    
   SELECT *FROM EMP WHERE SAL >ANY (  SELECT SAL FROM EMP WHERE DEPTNO =30) AND DEPTNO!=30;


--���̺� ������ ����
CREATE TABLE SUB_EMP
AS SELECT * FROM EMP WHERE 1=0;


SELECT *FROM SUB_EMP;


--    INSERT INTO SUB_EMP VALUES(��....)
        
-- SUBQUERY�� INSERT

INSERT INTO SUB_EMP(SELECT * FROM EMP WHERE DEPTNO=20);


--Ư���� Į���� �ٸ����̺�κ��� �����ͼ� INSERT
INSERT INTO SUB_EMP (EMPNO,ENAME,JOB,SAL)(SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=10);

SELECT *FROM SUB_EMP;

INSERT INTO SUB_EMP (EMPNO,ENAME,JOB,SAL,DEPTNO)(SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE DEPTNO=10);

--SUBQUERY�� UPDATE
--EX) EMP���̺��� EMPNO 7900�� ����� JOB, MGR, DEPTNO�� SUB_EMP���̺��� 7566�� ����� ������ �����غ���.

UPDATE SUB_EMP 
SET JOB=(SELECT JOB FROM EMP WHERE EMPNO =7900) ,
        MGR= (SELECT MGR  FROM EMP WHERE EMPNO =7900),
        DEPTNO=(SELECT DEPTNO  FROM EMP WHERE EMPNO =7900)
 WHERE EMPNO = 7566;


UPDATE SUB_EMP 
SET (JOB,MGR,DEPTNO)=(SELECT JOB,MGR,DEPTNO  FROM EMP WHERE EMPNO =7900)
WHERE EMPNO = 7566;

SELECT *FROM SUB_EMP WHERE EMPNO=7566;


--SUBQUERY�� DELETE
  --EX) EMP���̺��� ��� �޿��� �������� ����ؼ� ��ձ޿����� ���� �޴� ������� �����Ѵ�. 

DELETE SUB_EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);


DELETE SUB_EMP 
WHERE DEPTNO IS NULL;
--------------------------------------------------------------
/*
  SUBQUERY �������� �ϳ��� �ζ��κ�
   : FROM�� �ڿ� ���������� ���� ��.
*/

-- �޿��� �������� �����ؼ� ROWNUM�� �Բ� ����ϰ� �ʹ�.





-- ROWNUM�� ������� ������ ������ .
--1. ROWUM�� 3���� ���� ���ڵ� �˻�


--2. ROWUM�� 3���� ū ���ڵ� �˻�


--3. ROWUM�� 5 ~ 7 ���� ���ڵ� �˻�


/*
  ROWNUM�� ���ڵ尡 ��������鼭 ��ȣ�� ���������� �ο��Ǵ� ������ ROWNUM 1 �� ������ 2�� �����Ҽ� ����. 
  �׷��� ROWNUM�� ��������  ~ ũ��  �Ǵ� �߰������� ���� �������� ����� �� ����. 
  ROWNUM�� ��� �ο��� ����� �������� ����ؾ��Ѵ�. 
*/





----------------------------------------------------------
/*
  SEQUENCE : �ڵ� ���� �� ����
    :�������
      CREATE SEQUENCE �������̸�
      [START WITH �ʱⰪ]
      [INCREMENT BY ������]
      [MAXVALUE �ִ�]
      [MINVALUE �ּڰ�]
      [CACHE | NOCACHE]
      [CYCLE | NOCYCLE]
      
    : �����
      �������̸�.NEXTVAL : �������� ����
      �������̸�.CURRVAL : �������� ���簪 ��������
       
    : ������ ����
    ALTER SEQUENCE �������̸�;
    
    : ������ ����
    DROP SEQUENCE �������̸�;
*/
--����
CREATE SEQUENCE SEQ_NO;

--���
SELECT SEQ_NO.NEXTVAL, SEQ_NO.CURRVAL
FROM DUAL;

--����
DROP SEQUENCE SEQ_NO;

--�ɼ� �������� ������ ����
CREATE SEQUENCE SEQ_NO
START WITH 5
INCREMENT BY 10
MAXVALUE 100
NOCYCLE;


--�Խ��� ���̺�
CREATE TABLE BOARD(
    BNO NUMBER PRIMARY KEY,
    WRITER VARCHAR2(20),
    CONTENT VARCHAR2(100)

);

--BOARD���� ����� BNO�� SEQUENCE�� ����
CREATE SEQUENCE BOARD_BNO_SEQ;

--�� ���
INSERT INTO BOARD (BNO,WRITER,CONTENT) 
VALUES(BOARD_BNO_SEQ.NEXTVAL,'������','����ִ�');

INSERT INTO BOARD (BNO,WRITER,CONTENT) 
VALUES(BOARD_BNO_SEQ.NEXTVAL,'������' || BOARD_BNO_SEQ.CURRVAL,'����ִ�');

SELECT *FROM BOARD;


--save



















