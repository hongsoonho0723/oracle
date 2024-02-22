  /*���ڿ� �Լ�
    - upper(���ڿ�) => ��� �빮��
    - lower(���ڿ�) => ��� �ҹ���
    - initcap(���ڿ�)=> �ܾ��� ù ���� �빮�ڷ� ǥ��
    
    - length(���ڿ�) => ���ڿ��� ����
    
    - substr(���ڿ�, ����, ����) => ������ �Ϻκ� ����
       EX) substr(���ڿ�, INDEX) : ���ڿ����� INDEX ���� ������ ����
           substr(���ڿ�, INDEX, ����) : ���ڿ����� INDEX ���� ���� ���� ����
           
           * INDEX�� 1 ���� �����Ѵ�.
           
           
    - instr(���ڿ�, ã�����ڿ�) => ã�� ���ڿ��� ���� ��ġ(INDEX) �˷���
    - instr(���ڿ�, ã�����ڿ�, ���۹�����, ���° ����)
       ex)instr(job,'A') => JOB���� ���ʺ��� A �� ó�� �����ϴ� ��ġ�� �˷��ش�.
          instr(job,'A' , ���۹�����) => JOB���� ���ʿ��� ���۹����� ���� A �� ó�� �����ϴ� ��ġ�� �˷��ش�.
          instr(job,'A' , -1) => JOB���� �����ʺ��� A �� ó�� �����ϴ� ��ġ�� �˷��ش�.
          
          instr(job,'A' ,3,  2) =>���ʺ��� A�� ã�µ� 3°���� �����ؼ� 2��°�� ������ A�� ã�ƶ�
          
          * ����, ã�� ���ڿ��� ������ 0 �̴�. 
          
    - lpad(���ڿ�, ��ü�ڸ���, Ư������) 
     => ������ ���� �� ���� �� ���鿡 Ư�����ڷ� ä��
     
    - Rpad(���ڿ�, ��ü�ڸ���, Ư������) 
     => ���� ���� �� ������ �� ���鿡 Ư�����ڷ� ä��)
     
    - ltrim() => ���� ��������
    - rtrim()=> ������ ��������
 */
 

SELECT ENAME ,UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME), LENGTH(ENAME), LENGTHB(ENAME)
  FROM EMP;

SELECT '����' , LENGTH('����'),LENGTHB('����') FROM DUAL; -- LENGTH�� CHAR  LENGTHB�� byte ��

-- SUBSTR(���ڿ�, ����, ����) ���ڿ����� ���ۺ��� ������ŭ ���ڿ� ����, ���� �����ϸ� ���ۺ��� ������ ����
SELECT JOB, SUBSTR(JOB, 1, 3) ,SUBSTR(JOB, 2, 3), SUBSTR(JOB, 3)
  FROM EMP;

  
-- SUBSTR(���ڿ�, ����, ����): ������ 0���� �ϸ� �׳� 1�� ����. ������ �ָ� ������ ����
SELECT JOB, SUBSTR(JOB, 0, 3), SUBSTR(JOB, -4, 3)
  FROM EMP;



-- INSTR(���ڿ�, ����, ����, ���° ����): ���ڿ����� �ι�°�μ����ڰ� �� ��°�� �ִ� �� ã���ִ� �Լ�
SELECT 'ABCDE ABCDE ABCDE ABCDE'
       ,INSTR('ABCDE ABCDE ABCDE ABCDE', 'C')
       ,INSTR('ABCDE ABCDE ABCDE ABCDE','C', 5)
       ,INSTR('ABCDE ABCDE ABCDE ABCDE','C', 5, 2)  --�ι�°�� ���� 
  FROM DUAL;
  
  
  SELECT * FROM teacher;
  
-- ex) �̸��� �ּҿ� @������ ���, @���ĺ��� ��� 

SELECT TEACHER_EMAIL AS �̸���,SUBSTR( TEACHER_EMAIL, 1,(INSTR(TEACHER_EMAIL,'@')-1 )) AS �� ,SUBSTR( TEACHER_EMAIL, (INSTR(TEACHER_EMAIL,'@')+1 )) AS ��
FROM TEACHER;






 /*
   ���� ���� �Լ�
   - round(����, �ڸ���)=> �ݿø�
   
   - ceil(����) => �ø� �� �� ������ȯ �Ҽ��� �ڸ� X
   - floor(����)=>���� �� �� ���� ��ȯ �Ҽ��� �ڸ� X
   
   - mod(����, ������) => ������
   - trunc(����, �ڸ���)=> ����
 */
  
-- ROUND
SELECT 231.45136, ROUND(231.45136,2), ROUND(231.45136 , -2), ROUND(231.45136, 0) 
FROM DUAL;
  
-- TRUNC
SELECT 231.45136, TRUNC(231.45136,2), TRUNC(231.45136 , -2), TRUNC(231.45136, 0)
  FROM DUAL;
  
-- CEIL, FLOOR
SELECT 231.45136, CEIL(231.45136), FLOOR(231.45136)
  FROM DUAL;
  
  
SELECT SAL, MOD(SAL, 2)
  FROM EMP;
  

/*
   ��¥ �Լ�
   - sysdate => ���糯¥�� �ð�
   - months_between(��¥, ��¥) => �� ��¥ ������ ���� ���� ����
   - add_months(��¥, ����) => ��¥���� ���ڸ�ŭ ���� ����.
   
   - next_day(��¥, ����) => ��¥���� ���� ����� ������ ��¥����
       (1 = �Ͽ��� , 2 = ������,..... )
       
   - last_day(��¥) => ��¥ ���� ������ ��¥�� ����
*/

SELECT EMPNO, HIREDATE, trunc(SYSDATE-HIREDATE,0), HIREDATE+5
, TO_CHAR(HIREDATE + 1/24, 'YYYY-MM-DD HH:MI:SS')
, TO_CHAR(HIREDATE, 'YYYY-MM-DD HH:MI:SS')
FROM EMP;


SELECT 

 TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS'),
  TO_CHAR(sysdate + 4, 'YYYY-MM-DD HH:MI:SS'), 
   TO_CHAR(sysdate + 4/24, 'YYYY-MM-DD HH:MI:SS'),
    TO_CHAR(sysdate - 8/24, 'YYYY-MM-DD HH:MI:SS'),
        TO_CHAR(sysdate - 4/12, 'YYYY-MM-DD HH:MI:SS'),
        TO_CHAR(sysdate - 8/60, 'YYYY-MM-DD HH:MI:SS')

FROM dual;

SELECT SYSDATE ,TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS')
FROM DUAL;




SELECT SYSDATE, EXTRACT(DAY FROM SYSDATE) AS ��, 
EXTRACT(MONTH FROM SYSDATE)AS ��,
EXTRACT(YEAR FROM SYSDATE) AS ��
 FROM DUAL;
  
  
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD'), TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'YYYY')
  FROM DUAL;

-- �Ի��� -> 2002�� 10�� 2�� 
SELECT HIREDATE, TO_CHAR(HIREDATE, 'YYYY') || '��', CONCAT(TO_CHAR(HIREDATE, 'MM'), '��')
  FROM EMP;


SELECT HIREDATE, TO_CHAR(HIREDATE, 'YYYY"��"MM"��"DD"��"')
  FROM EMP;


-- �Ⱓ
SELECT TRUNC(SYSDATE - TO_DATE('2024-1-23')) AS �����ϼ�
  FROM DUAL;

-- 100��
SELECT TO_DATE('2023-3-2') + 100
  FROM DUAL;

SELECT TO_DATE(SYSDATE+7) FROM DUAL;

  /*������Ÿ�� ��ȯ

   TO_CHAR()
 TO_DATE()
 TO_NUMBER()
   - to_char(datetime, format����)=> ��¥�� format�������� ��ȯ
   
     ex) to_char(sysdate , 'YYYY-MM-DD')
         to_char(sysdate , 'YYYY-MM-DD HH:MI:SS')
         to_char(sysdate , 'YYYY-MM-DD HH24:MI:SS')
         
    - to_char(number, format����)=> ���ڸ� format�������� ��ȯ
     ex) 3�ڷ� �޸�
     to_cahr(2000, '999,999') => 2,000
     to_cahr(2000, 'L999,999') => \2,000 => ������ ���� ȭ��ǥ��
     to_cahr(2000, '$999,999') => $2,000 
     
    - to_date(���ڿ�) => ���ڸ� ��¥�� ��ȯ
    
    - to_number(���ڿ�)=> ���ڸ� ���ڷ� ��ȯ

 */

SELECT SAL,TO_CHAR(SAL,'999,999') FROM EMP;



------------------------------------------------
 /* NULL�� ���õ� �Լ� : NVL(),NVL2(), NULLIF() , COALESCE()
    1) NVL(���,���氪) : ��󿡼� NULL������ ���氪���� ��ü
    2) NVL2(���, NULL �ƴѰ�� , NULL �ΰ�� )
        EX) MGR�� NULL�� �ƴϸ� �ι�° �μ��� , NULL�̸� ����°�μ��� ����
    3) NULLIF�� ù��° �μ��� �ι�° �μ���, NULL�̸� �������μ� ����
    4) COALESCE �Լ� : ���� ���� NULL�� �ƴ� ���� ��ȯ
    
 NVL2�Լ�  ex) MGR�� NULL�� �ƴϸ� �ι�° �μ���, NULL�̸� ����°�μ� ����
 
 */
 --NVL2�Լ� �̿�
SELECT EMPNO, ENAME, MGR  ,NVL2(MGR, MGR||'�� ������','�ְ������')
  FROM EMP;

--NVL2�Լ� �̿�
SELECT EMPNO,COMM,NVL2(COMM,COMM*12,30), NVL(COMM,30) FROM EMP;

 --NULLIF�� ù��° �μ��� �ι�° �μ��� ���ٸ� NULL �ƴϸ� ù��° �μ��� ��
SELECT EMPNO, JOB, NULLIF(JOB, 'MANAGER')  FROM EMP;


--COALESCE�Լ� ; ���� ���� NULL�� �ƴ� ���� ��ȯ
SELECT ENAME, COMM, SAL, COALESCE(COMM, SAL, 50) RESULT
  FROM EMP;

SELECT COALESCE(100, NULL,200,300) FROM DUAL;
SELECT COALESCE(NULL, 100,200,300) FROM DUAL;
SELECT COALESCE(NULL, NULL,200,300) FROM DUAL;
SELECT COALESCE(NULL, NULL,NULL,300) FROM DUAL;

-------------------------------------------------------------------------


 CREATE TABLE REPORT(
 NAME VARCHAR2(20) CONSTRAINT REPORT_NAME_PK PRIMARY KEY,
 BAN CHAR(1),
 KOR NUMBER(3) CHECK(KOR BETWEEN 0 AND 100),
 ENG NUMBER(3) CHECK(ENG BETWEEN 0 AND 100),
 MATH NUMBER(3) CHECK(MATH BETWEEN 0 AND 100)
);

SELECT * FROM REPORT;

--���÷��ڵ�
INSERT INTO REPORT VALUES('����', 1 , 80, 70,90);
INSERT INTO REPORT VALUES('ȿ��', 1 , 90, 50,90);

INSERT INTO REPORT VALUES('����', 2 , 100, 65,85);
INSERT INTO REPORT VALUES('�缮', 2 , 80, 70, 95);
INSERT INTO REPORT VALUES('��', 2 , 85, 45,80);

INSERT INTO REPORT VALUES('�±�', 3 , 50, 70,70);
INSERT INTO REPORT VALUES('�߱�', 3 , 90, 75,80);
INSERT INTO REPORT VALUES('����', 3 , 70, 90,95);
INSERT INTO REPORT VALUES('�̳�', 3 , NULL, 80,80);

 /*
  SELECT������ ���ǿ� ���� ���๮���� �ٸ��� �Ҽ� �ֵ��� �ϴ� �Լ�
   1) decode(���, ��, ����, ��, ����, ��, ����,,,,,)
        => ��� �ش��ϴ� ���� ��ġ�ϴ� ��� �����
        
   2) case 
        when ����1 then ����
        when ����2 then ����
        when ����3 then ����
        ...
        else ����
     end
 */
  --EX) �������̺��� ���������� 80�̻��̸� �հ�, �ƴϸ� ���հ�  �հݿ��� �ʵ带 �����. - CASE END �λ��

SELECT *FROM REPORT;

SELECT NAME,BAN, KOR, 
CASE 
    WHEN KOR >= 80 THEN '�հ�'
    ELSE '���հ�'
END AS �հݿ���
FROM REPORT;



  /*EX)�������̺��� BAN�� 1�̸� 'MAS����', 2�̸� 'IOT����', 
  3�̸� 'DESIGN����' �ܴ̿� 'FULL STACK����' ��� ������ �ʵ带
 �����.*/


SELECT BAN, NAME ,KOR, DECODE(BAN,1,'MSA����',2,'IOT����',3,'DESING����','FULL STACK����') AS  ������
FROM REPORT;


SELECT BAN, NAME ,KOR ,
CASE 
    WHEN BAN= 1 THEN 'MSA����'
      WHEN BAN= 2 THEN 'IOT����'
        WHEN BAN= 3 THEN 'DESING����'
            ELSE 'FULL STACK����'
END AS ������
FROM REPORT;


SELECT BAN, NAME ,KOR ,
CASE BAN
    WHEN '1' THEN 'MSA����'
      WHEN '2' THEN 'IOT����'
        WHEN '3' THEN 'DESING����'
            ELSE 'FULL STACK����'
END AS ������
FROM REPORT;


/*
EX) EMP���̺��� DEPNO�� 10 �̸� ������, 20�̸� �ѹ���, 30�̸� ������ 
     �̿��� ���� ��Ÿ�� �� ����ϰ� �÷����� �μ��� ���� �Ѵ�.
     (DECODE, CASE END)
     DECODE�� ���� ��Ȯ�ϰ� ��ġ�ؾ��Ѵ�
*/

SELECT DECODE(DEPTNO,10,'������',20,'�ѹ���',30,'������','��Ÿ��') AS �μ���
FROM EMP;

SELECT CASE 
    WHEN DEPTNO =10 THEN '������'
        WHEN DEPTNO =20 THEN '�ѹ���'
            WHEN DEPTNO =30 THEN '������'
                ELSE '��Ÿ��'
END AS �μ���
FROM EMP;


SELECT *FROM EMP;

/*
ex)job�� manager�� ��� sal*0.1, ANALYST �ΰ���   sal *0.2
     SALESMAN�� ���� sal * 0.3�� ���ؼ� ������ �ʵ带 �����.
      (case end, decode �� �غ���) 
*/

SELECT EMPNO,ENAME,JOB,SAL, DECODE(UPPER(JOB),'MANAGER',SAL*0.1,'ANALYST',SAL*0.2,'SALESMAN',SAL*0.3,0) AS ������
FROM EMP ORDER BY ������; --LOWER(JOB) : JOB ������ ���� ���� �ҹ��ڷ� ���� UPPER(JOB)���� ���� �빮��

SELECT CASE 
    WHEN JOB='MANAGER' THEN SAL*0.1
        WHEN JOB='ANALYST' THEN SAL*0.2
            WHEN JOB='SALESMAN' THEN SAL*0.3
END AS ������
FROM EMP;

SELECT EMPNO,ENAME,JOB,SAL,
CASE LOWER(JOB)
    WHEN LOWER('MANAGER')THEN SAL*0.1
    WHEN LOWER('ANALYST')THEN SAL*0.2
    WHEN LOWER('SALESMAN')THEN SAL*0.3
END AS ������
FROM EMP ORDER BY ������;







/*
ex) sal�� 2000�����̸� '���ҵ���'
      sal�� 2001 ~ 4000���̸� '�߻���'
      sal�� 4001 �̻��̸� '��ҵ���'  ���Ͽ� ��� ��Ī ���ش�.
      (case end) 
*/

SELECT EMPNO,ENAME,JOB,SAL,
CASE 
    WHEN SAL<=2000 THEN '���ҵ���'
    --WHEN SAL >=2001 AND SAL<=4000 THEN '�߻���'
    WHEN SAL BETWEEN 2001 AND 4000 THEN '�߻���'
    WHEN SAL>=4001 THEN '��ҵ���'
END AS ���
FROM EMP;

SELECT *FROM EMP;



commit




