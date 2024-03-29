----------------------------------------------
--1번 문제
drop table room;
drop table student;
drop table teacher;
drop table subject;
drop table sugagn;

CREATE TABLE SUBJECT(
    SUBJECT_CODE VARCHAR2(5) PRIMARY KEY,
    SUBJECT VARCHAR2(20) NOT NULL
);

CREATE TABLE ROOM(
    ROOM_NUMBER NUMBER PRIMARY KEY,
    ROOM_PERSONNEL NUMBER NOT NULL
);
DROP TABLE TEACHER;
CREATE TABLE TEACHER(
    TEACHER_NUMBER NUMBER PRIMARY KEY,
    TEACHER_NAME VARCHAR2(12) NOT NULL,
    TEACHER_PHONE VARCHAR2(14) NOT NULL,
    TEACHER_JUMIN VARCHAR2(14) NOT NULL,
    TEACHER_ADDR VARCHAR2(50),
    TEACHER_EMAIL VARCHAR2(20),
    SUBJECT_CODE VARCHAR2(5) NOT NULL CONSTRAINT TEACHER_SUBJCET_CODE_FK  REFERENCES SUBJECT(SUBJECT_CODE)

);

CREATE TABLE STUDENT(
    STUDENT_NUMBER NUMBER PRIMARY KEY,
    STUDENT_NAME VARCHAR2(12) NOT NULL,
    STUDENT_JUMIN VARCHAR2(14) NOT NULL,
    STUDENT_PHONE VARCHAR2(14) NOT NULL,
    STUDENT_ADDR VARCHAR2(50),
    STUDENT_EMAIL VARCHAR2(20)

);

CREATE TABLE SUGAGN(
    STUDENT_NUMBER NUMBER PRIMARY KEY  CONSTRAINT SUGAGN_STUDENT_NUMBER_FK REFERENCES STUDENT(STUDENT_NUMBER),
    SUBJECT_CODE VARCHAR2(5) CONSTRAINT SUGAGN_SUBJECT_CODE_FK REFERENCES SUBJECT(SUBJECT_CODE)

);

CREATE TABLE SUGANGTB(
    SUBJECT_CODE VARCHAR2(5) PRIMARY KEY CONSTRAINT SUGANGTB_SUBJECT_CODE_FK REFERENCES SUBJECT(SUBJECT_CODE),
    ROOM_NUMBER NUMBER CONSTRAINT SUGANGTB_ROOM_NUMBER_FK REFERENCES ROOM(ROOM_NUMBER),
    SUGANGTB_TIME NUMBER NOT NULL,
    TEACHER_NUMBER NUMBER CONSTRAINT SUGANGTB_TEACHER_NUMBER_FK REFERENCES TEACHER(TEACHER_NUMBER)
);


INSERT INTO SUBJECT VALUES ('j1001','sql');

INSERT INTO SUBJECT VALUES ('j1002','Win2000');

INSERT INTO SUBJECT VALUES ('j1003','ASP');

INSERT INTO SUBJECT VALUES ('j1004','Php');

INSERT INTO SUBJECT VALUES ('j1005','java');

INSERT INTO SUBJECT VALUES ('j1006','javascript');

select *from subject;

insert into room values(901,34);
insert into room values(902,35);
insert into room values(903,25);
insert into room values(904,32);
insert into room values(905,30);
insert into room values(906,35);

select *from room;

INSERT INTO TEACHER VALUES(1,'홍길동','700918-1622011','031-295-1234','성남시 중원구 신흥동','kkk@jok.or.kr','j1001');
INSERT INTO TEACHER VALUES(2,'유관순','710419-2018916','02-345-2345','서울 강남구 개포동','kkk@jok.or.kr','j1002');
INSERT INTO TEACHER VALUES(3,'이승복','730112-1344911','031-1234-6789','서울시 강남구 논현동','sss@jok.or.kr','j1003');
INSERT INTO TEACHER VALUES(4,'모택동','730301-1167623','031-567-5678','서울시 서초구 서초동','mmm@jok.or.kr','j1004');
INSERT INTO TEACHER VALUES(5,'주롱지','730322-2037921','031-789-3456','서울시 강서구 가양동','xxx@jok.or.kr','j1005');
INSERT INTO TEACHER VALUES(6,'이순신','731122-1646213','031-234-8901','서울시 강북구 미아동','ppp@jok.or.kr','j1006');

select *from teacher;

INSERT INTO STUDENT VALUES(1,'김현진','771212-2346111','017-888-8888','부산','aaa@hanmail.net');
INSERT INTO STUDENT VALUES(2,'김석주','720112-1234812','016-999-9999','경기','bbb@hanmail.net');
INSERT INTO STUDENT VALUES(3,'고훈기','730102-1555555','017-555-5555','서울','ccc@hanmail.net');
INSERT INTO STUDENT VALUES(4,'유민경','801111-2222222','017-222-2222','전남','ddd@hanmail.net');
INSERT INTO STUDENT VALUES(5,'김영수','811231-1777777','017-777-7777','충주','eee@hanmail.net');
INSERT INTO STUDENT VALUES(6,'박상원','790915-1333333','017-333-3333','강원','fff@hanmail.net');

select *from student;

insert into sugagn values(1,'j1001');
insert into sugagn values(2,'j1002');
insert into sugagn values(3,'j1003');
insert into sugagn values(4,'j1004');
insert into sugagn values(5,'j1005');
insert into sugagn values(6,'j1006');

select *from sugagn;

INSERT INTO SUGANGTB VALUES('j1001',901,2,1);
INSERT INTO SUGANGTB VALUES('j1002',902,2,2);
INSERT INTO SUGANGTB VALUES('j1003',903,2,3);
INSERT INTO SUGANGTB VALUES('j1004',904,2,4);
INSERT INTO SUGANGTB VALUES('j1005',905,2,5);
INSERT INTO SUGANGTB VALUES('j1006',906,2,6);

select*from sugangtb;


-------------------------------------
--2번 문제

/*
    private int userSeq;
	private String name;
	private String email;
	private String phone;
	private boolean isSleep;


		userList.add( new UserDto(111, "홍길동", "hong@gildong@com", "010-1111-1111", false) );
		userList.add( new UserDto(222, "이길동", "lee@gildong@com", "010-2222-2222", true) );
		userList.add( new UserDto(333, "삼길동", "sam@gildong@com", "010-3333-3333", false) );
*/


CREATE TABLE USERS(
    USER_SEQ NUMBER PRIMARY KEY,
    NAME VARCHAR2(15),
    EMAIL VARCHAR2(20) NOT NULL UNIQUE,
    PHONE VARCHAR2(13),
    IS_SLEEP CHAR(1) DEFAULT 'N'

);
DROP TABLE USERS;
INSERT INTO USERS (USER_SEQ,NAME,EMAIL,PHONE) VALUES(111,'홍길동','hong@gildong@com','010-1111-1111');
INSERT INTO USERS (USER_SEQ,NAME,EMAIL,PHONE)VALUES(222,'이길동','lee@gildong@com','010-2222-2222');
INSERT INTO USERS (USER_SEQ,NAME,EMAIL,PHONE)VALUES(333,'삼길동','sam@gildong@com','010-3333-3333');

SELECT *FROM USERS;

UPDATE USERS SET IS_SLEEP='Y' WHERE USER_SEQ=222;

SELECT *FROM USERS;

INSERT INTO USERS (USER_SEQ,NAME,EMAIL,PHONE) VALUES(222,'이길동2','lee2@gildong.com','010-2222-2222');

INSERT INTO USERS (USER_SEQ,NAME,EMAIL,PHONE) VALUES(2222,'이길동2','lee@gildong.com','010-2222-2222');
INSERT INTO USERS (USER_SEQ,NAME,PHONE) VALUES(2222,'이길동2','010-2222-2222');
INSERT INTO USERS (USER_SEQ,NAME,EMAIL,PHONE) VALUES(2222,'이길동2','lee2@gildong.com','010-2222-2222');
select *from users;

drop table users;


commit;




select *from student;

1. 성별이 여자인 학생의 정보 검색

SELECT* FROM STUDENT
where SUBSTR(STUDENT_JUMIN,(select distinct instr(STUDENT_JUMIN,'-') FROM STUDENT)+1,1) = 2;

select*from student where student_jumin like '%-2%'; 
select*from student where student_jumin like '______-2______';

2.생년월일이 1973년인 수강생 정보를 검색 (substr이용)

SELECT *FROM STUDENT 
WHERE SUBSTR(STUDENT_JUMIN,1,2) =73;

select *from student where student_jumin like '73%';

select *from student where '19' || substr(student_jumin,1,2) ||'년'='1973년';

3.성이 홍이 아닌 강사의 정보검색

SELECT *FROM TEACHER
WHERE SUBSTR (TEACHER_NAME,1,1) !='홍';

select *from teacher where teacher_name not like '홍%';

4.강남구에 거주하는 강사의 정보 검색

SELECT *FROM TEACHER
WHERE SUBSTR(TEACHER_ADDR,4,3) ='강남구' OR SUBSTR(TEACHER_ADDR,5,3) ='강남구' ;

select *from teacher 
where teacher_addr like '%강남구%';

5.JAVA를 강의하는 강사 정보 검색(서브쿼리 이용)

SELECT *FROM TEACHER 
WHERE SUBJECT_CODE =(SELECT SUBJECT_CODE FROM SUBJECT WHERE SUBJECT='java' );

6 주소가 null이 아닌 강사의 정보검색
SELECT *FROM TEACHER 
WHERE TEACHER_ADDR IS NOT NULL;

7. SQL수업을 수강하고 있는 학생의 정보를 검색하는 뷰 작성

SELECT *FROM STUDENT WHERE STUDENT_NUMBER=
(SELECT STUDENT_NUMBER FROM SUGAGN WHERE SUBJECT_CODE =
(SELECT SUBJECT_CODE FROM SUBJECT WHERE upper(SUBJECT) = upper('sql')));




SELECT STUDENT_NUMBER FROM SUGAGN WHERE SUBJECT_CODE = (SELECT SUBJECT_CODE FROM SUBJECT WHERE SUBJECT = 'sql');

SELECT SUBJECT_CODE FROM SUBJECT WHERE SUBJECT = 'sql';

select *from student;
select *from TEACHER;
SELECT *FROM SUBJECT;
select *from room;
8.

9.아래 그림을 보고 만드세요

SELECT STUDENT_NAME,STUDENT_JUMIN,
case
when substr(student_jumin,8,1) = 1 then '남자'
when substr(student_jumin,8,1) = 2 then '여자'
end as 성별
from student;



10. TEAACHER 강사이름을 기준으로 올리차순으로 정렬하여 정열된 순서대로 ROWNUM이 출력되도록 하세요

SELECT ROWNUM,TEACHER_NAME,TEACHER_PHONE,TEACHER_ADDR
FROM (SELECT *FROM TEACHER ORDER BY TEACHER_NAME ASC);



SELECT*from (select ROWNUM no,TEACHER_NAME,TEACHER_PHONE,TEACHER_ADDR
FROM (SELECT *FROM TEACHER ORDER BY TEACHER_NAME ASC)) where  no >3;



























