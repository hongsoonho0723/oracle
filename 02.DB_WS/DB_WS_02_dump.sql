select * from users;

insert into users (user_seq, name, email, phone) values (444, '��浿', 'sa@gildong@com', '010-4444-4444');
insert into users (user_seq, name, email, phone) values (555, '���浿', 'o@gildong@com', '010-5555-5555');

CREATE TABLE account
( 
    account_seq   NUMBER,
    account_number VARCHAR2(50) not null,
    balance       NUMBER,
    user_seq      NUMBER,
	CONSTRAINT account_pk PRIMARY KEY (account_seq)
);

insert into account (account_seq, account_number, balance, user_seq) values (50, '00500505005005', 3000, 222);
insert into account (account_seq, account_number, balance, user_seq) values (10, '00100101001001', 1000, 111);
insert into account (account_seq, account_number, balance, user_seq) values (30, '00300303003003', 5000, 222);
insert into account (account_seq, account_number, balance, user_seq) values (70, '00700707007007', 7000, 444);
insert into account (account_seq, account_number, balance, user_seq) values (40, '00400404004004', 4000, 222);
insert into account (account_seq, account_number, balance, user_seq) values (60, '00600606006006', 2000, 222);
insert into account (account_seq, account_number) values (80, '00800808008008');
insert into account (account_seq, account_number, balance, user_seq) values (20, '00200202002002', 6000, 111);

SELECT * FROM USERS;
SELECT * FROM ACCOUNT;


----------------------------------------------
--1. ����ȣ ( user_seq ) �� 111 �� ���� ( account ) ���̺��� ��ȸ�Ѵ�.

SELECT *FROM ACCOUNT
WHERE USER_SEQ =111;

--2. �ܰ� ( balance ) �� 5000 �̸��� ���� ( account ) ���̺��� ��ȸ�Ѵ�.

SELECT *FROM ACCOUNT
WHERE BALANCE <5000;

--3. �ܰ� ( balance ) �� 5000 �̻� 10000 ������ ���� ( account ) ���̺��� ��ȸ�Ѵ�.

SELECT *FROM ACCOUNT
WHERE BALANCE BETWEEN 5000 AND 10000;

--4. ���¹�ȣ ( accountNumber ) �� ��4�� �� �����ϴ� ���� ( account ) ���̺��� ��ȸ�Ѵ�.

SELECT *FROM ACCOUNT
WHERE ACCOUNT_NUMBER LIKE '%4%';

--5. ���� ( name ) �� ��� �� �����ϴ� �� ( users ) ���̺��� ��ȸ�Ѵ�.

SELECT *FROM USERS 
WHERE NAME LIKE '��%';

--6. ���� ( account ) ���̺� �ִ� �� ��ȣ ( user_seq ) �� �ߺ����� ��ȸ�Ѵ�.

SELECT distinct USER_SEQ FROM ACCOUNT;

--7. �ܰ� ( balance ) �� ���� ( null ) ���� ( account ) ���̺��� ��ȸ�Ѵ�.

SELECT *FROM ACCOUNT
WHERE BALANCE IS NULL;

--8. ����ȣ ( user_seq ) �� �ִ� ���� ( account ) ���̺��� ��ȸ�Ѵ�.

SELECT *FROM ACCOUNT
WHERE USER_SEQ IS NOT NULL;

--9. ����ȣ ( user_seq ) �� �ְ�, �ܰ� 4000 ������ ���� ( account ) ���̺��� ��ȸ�Ѵ�.

SELECT *FROM ACCOUNT
WHERE USER_SEQ IS NOT NULL AND BALANCE <=4000;

--10. ���� ( account ) ���̺��� ����ȣ ( user_seq ) �������� ������������ �����Ͽ� ��ȸ�Ѵ�

SELECT *FROM ACCOUNT
ORDER BY USER_SEQ ASC;

--11. ���� ( account ) ���̺��� ����ȣ ( user_seq ) �������� ������������, �׸��� �� �ȿ��� �� ��( balance ) �������� ������������ �����Ͽ� ��ȸ�Ѵ�.

SELECT *FROM ACCOUNT
ORDER BY USER_SEQ ASC , BALANCE DESC;

--12. ���� ( account ) ���̺��� ��ȸ�ϵ�, balance ���� ������ 0 ���� ǥ���Ѵ�.

SELECT NVL(BALANCE,0) FROM ACCOUNT;


--13. �� ( users ) ���̺��� ��ȸ�ϵ�, email�� @���� �� �κ��� ���� �� ���̵� ǥ���Ѵ�. �÷� �� email ��� email_id �� �����Ѵ�.
--STR INSTR SUBSTR
SELECT SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS EMAIL_ID FROM USERS;

--14. �� ( users ) ���̺��� ��ȸ�ϵ�, phone �� ��-�� �� �����ϰ� ǥ���Ѵ�. �÷��� phone_short �� �����Ѵ�.


SELECT replace(PHONE,'-','') AS PHONE_SHORT FROM USERS;






DESC USERS;




