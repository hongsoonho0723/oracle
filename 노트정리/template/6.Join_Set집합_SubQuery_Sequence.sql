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

SELECT * FROM TEST2;





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

   
   
-- ANSI ���ι��



-- ���ο� ���� �ֱ� -- SAL�� 300�̻��� ���ڵ� �����ϱ�





--NON-EQUI JOIN
-- EMP���̺��� ����� ���� + �޿������ �Բ� �˻��ϰ� �ʹ�

 
 
-- SELF JOIN - �ڱ��ڽ� ���̺��� 2���� ���� ����(���������)
-- EX) SMITH����� �����ڴ� FORD�Դϴ�. ���




--------------------------------------------------------------
/*
  SET ����
   1) ������
        UNION ALL - �ߺ����ڵ带����
        UNION - �ߺ����ڵ� ����
        
   2) ������ 
       INSERSECT : A�� B ���̺��� ����� ���ڵ� �˻�
       
   3) ������ 
        MINUS : A���̺��� B���̺��� ���ڵ带 �� ������ ���ڵ� �˻�






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

                  
      
-- JOB�� 'A'���ڿ��� �� ����� �μ��� ���� ������ �ٹ��ϴ� ����� �μ��̸� �˻��ϰ� �ʹ�. 

  
  
 -- �μ���ȣ�� 30�� ������� �޿��߿��� ���� ���� �޴� ������� �� ���� �޴� ��������� �˻��ϰ� �ʹ�. 


-- SUBQUERY�� INSERT


--Ư���� Į���� �ٸ����̺�κ��� �����ͼ� INSERT


--SUBQUERY�� UPDATE
--EX) EMP���̺��� EMPNO 7900�� ����� JOB, MGR, DEPTNO�� SUB_EMP���̺��� 7566�� ����� ������ �����غ���.


--SUBQUERY�� DELETE
  --EX) EMP���̺��� ��� �޿��� �������� ����ؼ� ��ձ޿����� ���� �޴� ������� �����Ѵ�. 

 

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



