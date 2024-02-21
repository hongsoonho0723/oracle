/*
  �����Լ�
     - sum(�÷���) => �հ�
     - avg(�÷���) => ���(null���� �����ϰ� ����)
     - max(�÷���) => �ִ밪
     - min(�÷���) => �ּҰ�
     
     - count(�÷���) => �� ���ڵ��(null���� ������)
     - count(*) => null�� ������ �� ���ڵ��
     
     - rank(expr) within group(order by �÷��� asc | desc )
        => ��ü ���� ������� �� ���� ������ ����.
     ex) --�޿��� 3000�� ��� ���ϱ�
        SELECT RANK(3000) within GROUP(ORDER BY sal desc) FROM EMP
*/

-----------------------------------------------------
--�����Լ�

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


-- ���κ� ��������, ��������� �˻��غ���.



-- ���������� �ִ�, �ּ�, ��ü�л����� �˻��غ���.

  

--�������� �ִ�, �ּ�, �л��� 



--���������� ����, ���, NULL�� 0���� �����ؼ� ��� �˻��غ��� - AVG()�Լ��� NULL�� ������ ���ڵ���� ����� ���Ѵ�. 



--�ݺ� ���� �ִ�, �ּ� ���� ��� �ο��� - GROUP BY���� ���� �÷��� SELECT���� �����Լ��� �԰� ��밡��




-- KOR�� ������ 70�̻��� �л����� �ݺ� ���� �ִ�, �ּ� ���� ��� �ο���

 

-- KOR�� ����� 80 �̻��� �л����� �ݺ� ���� �ִ�, �ּ� ���� ��� �ο��� 



/*
  �߿�!!
 SELECT   5)
 FROM     1)
 WHERE    2)
 GROUP BY 3)
 HAVING   4)
 ORDER BY 6)

*/




-----------------------------------------------
SELECT BAN , SUM(KOR) ����
FROM REPORT
WHERE KOR >=70
GROUP BY rollup(BAN); -- �Ұ� + �Ѱ�


SELECT BAN , SUM(KOR) ����
FROM REPORT
WHERE KOR >=70
GROUP BY CUBE(BAN);

SELECT BAN , SUM(KOR) ����
FROM REPORT
WHERE KOR >=70
GROUP BY GROUPING SETS(BAN);


---------------------------------------
/*
 ROLLUP VS CUBE VS GROUPING SETS
*/
CREATE TABLE MONTHLY_SALES( --��������
  GOODS_ID VARCHAR2(5), --��ǰ���̵�
  MONTH VARCHAR2(10), -- ��
  COMPANY VARCHAR2(20), --ȸ��
  SALES_AMOUNT NUMBER -- ����ݾ�
);

INSERT INTO MONTHLY_SALES VALUES('P01','2023-01', '�Ե�', 15000);
INSERT INTO MONTHLY_SALES VALUES('P01','2023-02', '�Ե�', 25000);

INSERT INTO MONTHLY_SALES VALUES('P02','2023-01', '�Ｚ', 8000);
INSERT INTO MONTHLY_SALES VALUES('P02','2023-02', '�Ｚ', 12000);


INSERT INTO MONTHLY_SALES VALUES('P03','2023-01', 'LG', 8500);
INSERT INTO MONTHLY_SALES VALUES('P03','2023-02', 'LG', 13000);

SELECT * FROM MONTHLY_SALES;

SELECT GOODS_ID , SUM(SALES_AMOUNT)
FROM MONTHLY_SALES
GROUP BY ROLLUP(GOODS_ID); -- �Ѱ� �Բ� ��� 

SELECT MONTH , SUM(SALES_AMOUNT)
FROM MONTHLY_SALES
GROUP BY ROLLUP(MONTH);


SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY ROLLUP(GOODS_iD,MONTH); -- ROLLUP ù��° ���� �÷��� �������� �Ұ�, ��ü (�μ��� ������ �߿�)

SELECT MONTH , GOODS_iD  , SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY ROLLUP(MONTH , GOODS_iD);

--CUBE
SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY CUBE(GOODS_iD,MONTH); -- CUBE �Ұ�κ��� �� �÷��� �������� �����⶧������ �μ��� ������ �������. 

SELECT  MONTH , GOODS_ID, SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY CUBE(MONTH , GOODS_ID);


--GROUPING SETS
SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY GROUPING SETS(GOODS_iD,MONTH);

SELECT  MONTH , GOODS_ID, SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY GROUPING SETS(MONTH ,GOODS_iD);
