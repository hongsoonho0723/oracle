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
 --계정생성(관리자계정에서)
CREATE USER C##HR IDENTIFIED BY HR;
 
   --권한 부여(관리자계정에서)
    GRANT CONNECT, RESOURCE, DBA TO C##HR;

