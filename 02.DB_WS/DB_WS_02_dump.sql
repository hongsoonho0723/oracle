select * from users;

insert into users (user_seq, name, email, phone) values (444, '사길동', 'sa@gildong@com', '010-4444-4444');
insert into users (user_seq, name, email, phone) values (555, '오길동', 'o@gildong@com', '010-5555-5555');

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
--1. 고객번호 ( user_seq ) 가 111 인 계좌 ( account ) 테이블을 조회한다.

SELECT *FROM ACCOUNT
WHERE USER_SEQ =111;

--2. 잔고 ( balance ) 가 5000 미만인 계좌 ( account ) 테이블을 조회한다.

SELECT *FROM ACCOUNT
WHERE BALANCE <5000;

--3. 잔고 ( balance ) 가 5000 이상 10000 이하인 계좌 ( account ) 테이블을 조회한다.

SELECT *FROM ACCOUNT
WHERE BALANCE BETWEEN 5000 AND 10000;

--4. 계좌번호 ( accountNumber ) 중 ‘4’ 를 포함하는 계좌 ( account ) 테이블을 조회한다.

SELECT *FROM ACCOUNT
WHERE ACCOUNT_NUMBER LIKE '%4%';

--5. 고객명 ( name ) 이 ‘삼‘ 을 시작하는 고객 ( users ) 테이블을 조회한다.

SELECT *FROM USERS 
WHERE NAME LIKE '삼%';

--6. 계좌 ( account ) 테이블에 있는 고객 번호 ( user_seq ) 를 중복없이 조회한다.

SELECT distinct USER_SEQ FROM ACCOUNT;

--7. 잔고 ( balance ) 가 없는 ( null ) 계좌 ( account ) 테이블을 조회한다.

SELECT *FROM ACCOUNT
WHERE BALANCE IS NULL;

--8. 고객번호 ( user_seq ) 가 있는 계좌 ( account ) 테이블을 조회한다.

SELECT *FROM ACCOUNT
WHERE USER_SEQ IS NOT NULL;

--9. 고객번호 ( user_seq ) 가 있고, 잔고가 4000 이하인 계좌 ( account ) 테이블을 조회한다.

SELECT *FROM ACCOUNT
WHERE USER_SEQ IS NOT NULL AND BALANCE <=4000;

--10. 계좌 ( account ) 테이블을 고객번호 ( user_seq ) 기준으로 오름차순으로 정렬하여 조회한다

SELECT *FROM ACCOUNT
ORDER BY USER_SEQ ASC;

--11. 계좌 ( account ) 테이블을 고객번호 ( user_seq ) 기준으로 오름차순으로, 그리고 그 안에서 잔 고( balance ) 기준으로 내림차순으로 정렬하여 조회한다.

SELECT *FROM ACCOUNT
ORDER BY USER_SEQ ASC , BALANCE DESC;

--12. 계좌 ( account ) 테이블을 조회하되, balance 값이 없으면 0 으로 표시한다.

SELECT NVL(BALANCE,0) FROM ACCOUNT;


--13. 고객 ( users ) 테이블을 조회하되, email은 @포함 뒷 부분은 빼고 앞 아이디만 표시한다. 컬럼 명도 email 대신 email_id 로 변경한다.
--STR INSTR SUBSTR
SELECT SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS EMAIL_ID FROM USERS;

--14. 고객 ( users ) 테이블을 조회하되, phone 의 ‘-’ 를 제외하고 표시한다. 컬럼명도 phone_short 로 변경한다.


SELECT replace(PHONE,'-','') AS PHONE_SHORT FROM USERS;




SELECT *FROM ACCOUNT;

15. 계좌 ( account ) 테이블에서 고객번호 ( user_seq ) 가 222 인 건 수를 조회한다.

SELECT  COUNT(user_seq )
FROM ACCOUNT
WHERE USER_SEQ =222;


SELECT USER_SEQ,  COUNT(user_seq )
FROM ACCOUNT
GROUP BY USER_SEQ
HAVING USER_SEQ =222;

16. 계좌 ( account ) 테이블의 전체 잔고 ( balance ) 의 합을 조회하고 balance_sum 으로 표시한다

SELECT SUM(BALANCE) AS BALANCE_SUM
FROM ACCOUNT;

17. 계좌 ( account ) 테이블의 잔고 중 최소갑과 최대값을 조회하고 각각 balance_min, 
balance_max 로 표시한다.

SELECT MIN(BALANCE) AS balance_min, MAX(BALANCE) AS balance_max FROM ACCOUNT;

18. 계좌 ( account ) 테이블에서 고객번호와 고객번호 ( user_seq ) 별 계좌 건수를 조회하고
user_account_cnt 로 표시한다. 단, 고객번호 ( user_seq ) 가 없는 건은 제외한다.

SELECT USER_SEQ,COUNT(USER_SEQ) 
FROM ACCOUNT 
WHERE USER_SEQ IS NOT NULL
GROUP BY (USER_SEQ);



SELECT USER_SEQ,COUNT(*) 
FROM ACCOUNT 
GROUP BY (USER_SEQ)
HAVING USER_SEQ IS NOT NULL;


19. 계좌 ( account ) 테이블에서 고객번호와 고객번호 ( user_seq ) 별 잔고의 합을 조회하고
user_balance_sum 로 표시한다. 단, 고객번호 ( user_seq ) 가 없는 건은 제외한다.

SELECT USER_SEQ,COUNT(*) ,SUM(BALANCE) AS user_balance_sum
FROM ACCOUNT 
GROUP BY (USER_SEQ)
HAVING USER_SEQ IS NOT NULL;

20. 위 19번의 결과 중 user_balance_sum 이 10000 이하인 건만을 조회한다.

SELECT USER_SEQ,COUNT(*) ,SUM(BALANCE) AS user_balance_sum
FROM ACCOUNT 
GROUP BY (USER_SEQ)
HAVING USER_SEQ IS NOT NULL AND SUM(BALANCE)<=10000;

COMMIT;


SELECT *FROM ACCOUNT;

























DESC USERS;




