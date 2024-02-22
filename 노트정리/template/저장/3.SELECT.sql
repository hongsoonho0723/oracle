/*
   SELECT���� - DQL����
    : ����
    select distinct | * | �÷��� as ��Ī, �÷��� ��Ī,....   : ���� ���� :PROJECTION
    from ���̺��̸�     
    [where ���ǽ� ]  : ���ڵ�(Ʃ��)����  - SELECTION
    [order by �÷��� desc | asc , .. ] -����
    
    
    * distinct �� �ߺ����ڵ带 ����
    * AS �� �÷��� ��Ī ����� 
    * �������
      SELECT   3) 
      FROM     1)
      WHERE    2) 
      ORDER BY 4) 
    
*/

--EX) SCOTT���� ���� 

SELECT * FROM EMP; --������̺�
SELECT * FROM DEPT;--�μ��������̺�

--1) EMP���̺��� ���ϴ� �÷�(��Ī)
SELECT EMPNO AS "�����ȣ",ENAME AS �̸�,JOB ����,HIREDATE �Ի���,SAL �޿�
FROM EMP;

--2) �ߺ��� �����ϱ� - DISTINCT
 --EX) �츮ȸ�翡 � JOB�ִ��� JOB�� ������ �˰�ʹ�!!!
SELECT DISTINCT JOB FROM EMP;
SELECT DISTINCT JOB,ENAME FROM EMP; --�ߺ����� ���� �ٸ� ���� �ߺ��� ���� ��� ���� ������ش�


 
--3) ���� ����� 
 -- �޿��� 3000�̻��� ��� �˻�
SELECT *FROM EMP WHERE SAL>=3000;
 
 --4) ����
 -- �޿��� 2000�̻��� ����� �˻��ϰ� �޿��� �������� ����
SELECT ENAME,SAL
FROM EMP 
WHERE SAL>=2000 
ORDER BY SAL DESC;


 --JOB�� �������� �������������ϰ� JOB�� ������ �޿��� �������� ����
 SELECT EMPNO,ENAME,JOB,SAL
 FROM EMP
 ORDER BY JOB DESC ,SAL;

--���� + ����

SELECT EMPNO,ENAME,JOB,SAL
FROM EMP
WHERE SAL >= 2000
ORDER BY JOB DESC,SAL ASC;

 SELECT EMPNO,ENAME,JOB,SAL
 FROM EMP
 ORDER BY EMPNO DESC;

--��Ī�� ���Ǵ������ ����� ��������? ���� ������ WHERE �� ������ SELECT ���̹Ƿ� ��Ī�� �̸� �˼� �ִ�

/*
FROM
WHERE
SELECT
ORDER BY
*/

 SELECT EMPNO,ENAME,JOB ����,SAL �޿�
 FROM EMP
 WHERE SAL>=2000
 ORDER BY JOB DESC ,SAL;

- ���� ����� �÷��� INDEX�� �����ϴ� (INDEX�� 1����)
SELECT EMPNO,ENAME,JOB ���� ,SAL �޿�
FROM EMP
WHERE SAL >= 2000
ORDER BY 3 DESC , 1 ASC;

--Į���鳢�� ������ �����ϴ�

SELECT ENAME, SAL*12 FROM EMP;

--�޿��� Ŀ�̼��� ���ϰ� 12 ���ؼ� ���� �÷��� ����� �ʹ� --NULL���� NVL�� �̿��ؼ� 0���� �������ش� EX) NVL(Į����,���氪)
SELECT EMPNO,ENAME,SAL,COMM,SAL+COMM
FROM EMP;


SELECT EMPNO,ENAME,SAL,COMM,(SAL+NVL(COMM,0))*12 ����--NVL(Į����,���氪) 
FROM EMP
ORDER BY SAL DESC;


-- NULL���� �ٸ� ������ �����ؼ� ���� �� �� �ִ�  -->  NVL(Į����, ���氪
SELECT COMM ,NVL(COMM,20)
FROM EMP;
  
--�� ����� ~�Դϴ�. ��� ---  ���ڿ� ���� || �̿�
SELECT ENAME || '�� ������' || (SAL+ NVL(COMM,0))*12 ||'�Դϴ�'  AS ����
FROM EMP;

--||������ ��ſ� CONCAT() �Լ� �̿��غ��� CONCATE(A,B)
SELECT CONCAT(ENAME,'�� ������') , CONCAT((SAL+ NVL(COMM,0))*12,'�Դϴ�')
FROM EMP;
  
    
SELECT CONCAT( CONCAT(ENAME,'�� ������') ,(SAL+ NVL(COMM,0))*12) AS MESSAGE
FROM EMP;  
  
SELECT CONCAT( CONCAT(ENAME,'�� ������') , CONCAT((SAL+ NVL(COMM,0))*12,'�Դϴ�')) AS MESSAGE
FROM EMP;  
  
  
-----------------------------------------------------------------------------------
/*
  ������ ����
  1) ���������
     +, -, *, / 
     ������ : MOD(��, ������)
     
   2) ���迬����
       > , <, >= , <= , !=, <>
       ����  :  =
       
   3) �񱳿�����
    - AND
    - OR
    - IN :  �÷��� IN (��, ��, ��)  - �ϳ��� �÷��� ������� �Ǵ����� ���Ҷ� ����Ѵ�.
    
    - BETWEEN AND :  �÷��� BETWEEN �ּ� AND �ִ� - �ϳ��� �÷��� ������� �ּ� ~ �ִ븦 ���Ҷ�
    
    - LIKE  : ���ϵ�ī�� ���ڿ� �Բ� ����Ѵ�.
        1. % : 0���̻��� ����
        2. _ : �ѱ���  
        
        EX)  name like 'J%' ;   - NAME�� ù���ڰ� J�� �����ϴ� ��� ����
             name like '___' ;  - NAME�� 3���� 
             name like 'J_J%';  - NAME�� ù���ڰ� J�� �����ϰ� 3��° ���� A�� ���� �˻�
                       
    
    - NOT : ���� ��� �����ڵ� �տ� NOT�� ������ �ݴ� ����.
        
*/

--EX) ��������� : EMP���� ������ = (SAL + COMM) *12  �ؼ� ��� �÷� 
 
 
 -- * NVL(��, ��ġ��)  : NULL�� ã�� ��ġ������ �����Ѵ�. 


--EX) ����� ����ϱ� ���ؼ� COMM�� NULL�� ã�� 0���� �������� �����Ѵ�. - NVL�Լ� ���


--EX) ~���� ����� ~ �Դϴ�. ���  : ���ڿ��� �����Ҷ� || ����Ѵ�.



--EX) SAL �� 2000 ~ 4000��� �˻�(AND, BETWEEN AND )

SELECT *
FROM EMP
WHERE (SAL >=2000 AND SAL<=4000)
ORDER BY SAL;
 
SELECT *
FROM EMP
WHERE not (SAL >=2000 AND SAL<=4000)
ORDER BY SAL;

--EX) SAL �� 2000 ~ 4000����ƴ� ���ڵ� �˻� -  NOT

SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 4000
ORDER BY SAL;

SELECT *
FROM EMP
WHERE SAL not BETWEEN 2000 AND 4000
ORDER BY SAL;

--EX) EMPNO �� 7566, 7782,7844�� ����˻� ( OR, IN)

SELECT *
FROM EMP
WHERE EMPNO = 7566 OR EMPNO = 7782 OR EMPNO=7844;


SELECT *
FROM EMP
WHERE EMPNO IN(7566,7782,7844);


--EX) EMPNO �� 7566, 7782,7844�� ����� �ƴ� �˻� ( NOT)
SELECT *
FROM EMP
WHERE EMPNO != 7566 OR EMPNO != 7782 OR EMPNO !=7844;

SELECT *
FROM EMP
WHERE NOT (EMPNO =7566 OR EMPNO = 7782 OR EMPNO=7844);

SELECT *
FROM EMP
WHERE EMPNO NOT IN(7566,7782,7844);

---------------------------------------------------------------------------
--1) JOB�� 'A' ���ڷν����ϴ� ���ڵ� �˻�
SELECT *
FROM EMP
WHERE JOB LIKE 'A%';

--2) JOB�� �� ���ڰ� 'N'���� ������ ���ڵ� �˻�
SELECT *
FROM EMP
WHERE JOB LIKE '%A';

--3) ENAME�� 4������ ���ڵ� �˻�
SELECT *
FROM EMP
WHERE ENAME LIKE '____';

--4) ENAME�� A���ڰ� ���Ե� ���ڵ� �˻�
SELECT *
FROM EMP
WHERE ENAME LIKE '%A%';

--5) ENAME��ü ���ڰ� 5�����̰� �ι�° ���ڰ� m�̸鼭�����ڰ� h�� ���ڵ� �˻�
SELECT * 
FROM EMP
WHERE ENAME LIKE '_M__H';

SELECT * 
FROM EMP
WHERE lower(ENAME) LIKE lower('_m__h');


SELECT *FROM EMP;

SELECT 'Hee JUnG' ,UPPER('HEE jung'),LOWER('HEE JUNG')
FROM DUAL;

--���ڿ����� % �ܾ ������ ���ڵ� �˻��ϰ� �ʹ�
select *from copy_emp;

insert into copy_emp(empno,ename,job)  values(8000,'HEE%JUNG','TEACHER');

SELECT *
FROM COPY_EMP
WHERE ENAME LIKE '%%%';-- ��� ���ڵ尡 �˻��ȴ�

SELECT * FROM COPY_EMP WHERE ENAME LIKE '%#%%' escape '#';


SELECT * FROM COPY_EMP WHERE ENAME LIKE '%$%%' escape '$';

COMMIT;









-------------------------------------------------------------------------------------------------


/*
    NULL ã��
    1) IS NULL
    2) IS NOT NULL
*/

-- COMM�� NULL�� ���ڵ� �˻�

SELECT * FROM EMP WHERE COMM = NULL;

SELECT * FROM EMP WHERE COMM IS NULL;

SELECT * FROM EMP WHERE COMM IS NOT NULL;

--COPY_EMP ���̺��� COMM�� NULL���ڵ带 COMM�� ���� 100���� ����

SELECT COMM, NVL(COMM,100) FROM COPY_EMP;

UPDATE COPY_EMP 
SET COMM =100
WHERE COMM IS NULL;


UPDATE COPY_EMP 
SET COMM =NULL
WHERE COMM =100;


SELECT *
FROM COPY_EMP
WHERE COMM = 100;


SELECT *FROM COPY_EMP;

/*
FROM 1
WHERE 2
SELECT 3
ORDER BY 4

*/


-- NULL�� �ִ� �÷��� ������� ������ �غ���
SELECT * FROM EMP ORDER BY COMM; -- ���������϶��� NULL�� �������� ��ȸ�ȴ�
SELECT * FROM EMP ORDER BY COMM DESC; -- ���������϶��� NULL�� ó���� ��ȸ�ȴ� 
SELECT * FROM EMP ORDER BY COMM ASC NULLS FIRST; --NULL�� �켱������ ���
SELECT * FROM EMP ORDER BY COMM DESC NULLS FIRST;



                    
                    
                    
 
 

------------------------------------------------------------------
