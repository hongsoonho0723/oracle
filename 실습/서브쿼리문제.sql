--각자 계정접속한다.

DROP TABLE subemp;
--emp 테이블 생성
Create Table subemp(
	emp_id 	   int, --사원번호
	emp_name	   Varchar2(20) Not Null,  --사원이름
	job      	               Varchar2(20) Not Null,  --직업
	dept_id  	  int, --부서번호
	sal 	              int Not Null,--급여
	bonus	              int,--보너스
	mgr_id	              int,--관리자번호
	hiredate             date  Not Null, --입사일
	constraint emp_id_pk22 Primary Key(emp_id) --제약조건
);

--데이터삽입

INSERT INTO subEMP VALUES (6200,'박철수','대표',200,  5000,NULL,NULL, '1997-12-17');

INSERT INTO subEMP VALUES (6311,'김대정','부장',100, 3500,Null,6200, '1998-12-17');

INSERT INTO subEMP VALUES (7489,'민동규','세일즈',400,  1850,200,6321, '1999-02-27') ;

INSERT INTO subEMP VALUES (7522,'정종철','세일즈',400, 1850,300,6321,'1998-02-28') ;

INSERT INTO subEMP VALUES (6321,'이종길','부장',400, 3800,500,6200,'1999-04-20') ;

INSERT INTO subEMP VALUES (6351,'진대준','부장',300,   2850,NULL,6200,'2000-05-31');

INSERT INTO subEMP VALUES (7910,'이영희','경리',300, 1000,NULL,6351,'2001-05-01');

INSERT INTO subEMP VALUES (6361,'김철수','부장',200, 3200,NULL,6200,'2000-06-09') ;

INSERT INTO subEMP VALUES (7878,'백기수','연구직',200, 3000,NULL,6361,'2001-06-05') ;

INSERT INTO subEMP VALUES (7854,'진영진','세일즈',400, 1500,0,6321,'2001-09-08') ;

INSERT INTO subEMP VALUES (7872,'이문정','사무직',100, 1500,NULL,6311,'2001-02-12') ;

INSERT INTO subEMP VALUES (7920,'마리아','사무직',300, 1050,NULL,6351,'2001-03-18');

INSERT INTO subEMP VALUES (7901,'정동길','연구직',NULL, 3000,NULL,NULL,'2001-12-03');

INSERT INTO subEMP VALUES (7933,'김철수','사무직',200,  1050,NULL,6361,'2002-01-02');
--emp테이블 생성 / 레코드 추가

DROP TABLE subdept;

SELECT * FROM subdept;
CREATE TABLE subdept(dept_id int, dname VARCHAR(20) );
INSERT INTO subdept VALUES(100,'관리부');
INSERT INTO subdept VALUES(200,'경리부');
INSERT INTO subdept VALUES(300,'생산부');
INSERT INTO subdept VALUES(400,'영업부');

SELECT *FROM subemp;
SELECT *FROM subdept;

------------------------------------------------------

--ex1) 이종길 사원의 부서명(dname)을 검색하시오.

SELECT DNAME FROM SUBDEPT WHERE  DEPT_ID = (SELECT DEPT_ID FROM SUBEMP WHERE EMP_NAME = '이종길');

select emp_name, dname
from subemp join subdept
using (dept_id)
where emp_name='이종길';

--ex2) dept_id가 100인 사원급여의 최대값보다 많이 받는 사원을 검색하시오.

SELECT * FROM SUBEMP WHERE SAL >(SELECT MAX(SAL) FROM SUBEMP WHERE DEPT_ID=100  );


--ex3)급여를 3000이상 받는 사원이 소속된 부서와 
 --  동일한 부서에서 근무하는 사원들의 정보
SELECT *FROM SUBEMP WHERE DEPT_ID IN (SELECT DISTINCT DEPT_ID FROM SUBEMP WHERE SAL> 3000) 
order by dept_id;



  --ex4) 부서번호가 300인 사원들중에서 급여를 가장 많이 받는 사원보다
      더 많은 급여를 받는 사람의 정보를 검색.
SELECT *FROM SUBEMP WHERE SAL > ANY(SELECT MAX(SAL) FROM SUBEMP WHERE DEPT_ID =300);




   
-- ex5) 부서번호가 300인 사원들중에서 급여를 가장 적게 받는 사원보다
--     더 많은 급여를 받는 사람의 정보를 검색

SELECT *FROM SUBEMP WHERE SAL > ANY(SELECT MIN(SAL) FROM SUBEMP WHERE DEPT_ID =300) order by dept_id;

   
--ex6)정동길의 급여와 동일 하거나 더 많이 받는 사원의 정보검색
 
 SELECT *FROM SUBEMP WHERE SAL >= (SELECT SAL FROM SUBEMP WHERE EMP_NAME = '정동길');
  
 
--ex7)직급이 사무직인 사원의 부서번호와 부서명 출력

SELECT *FROM SUBDEPT WHERE DEPT_ID =ANY(SELECT DEPT_ID FROM SUBEMP WHERE JOB = '사무직');


SELECT *FROM SUBDEPT WHERE DEPT_ID in (SELECT DEPT_ID FROM SUBEMP WHERE JOB = '사무직');



--ex8) 부서가 경리부인 모든 사원의 정보출력
SELECT *FROM SUBEMP WHERE DEPT_ID = (SELECT DEPT_ID FROM SUBDEPT WHERE DNAME='경리부');


--ex9)대표 에게 보고를 하는 모든 사원의 정보출력

SELECT * FROM SUBEMP WHERE MGR_ID =(SELECT EMP_ID FROM SUBEMP WHERE JOB = '대표');


--ex10) 이름에 '정'이 들어가면서 평균급여보다 높은 급여를 받는
--     사원과 동일한 부서에서 근무하는 사원의 정보 검색.
--      (단, 부서번호 null은 제외함)
SELECT *FROM SUBEMP WHERE DEPT_ID =
(SELECT DEPT_ID FROM SUBEMP WHERE EMP_NAME LIKE '%정%' AND DEPT_ID IS NOT NULL AND SAL>(SELECT AVG(SAL) FROM SUBEMP));

--ex11) 각 부서의 어떤 평균 급여보다 급여를 많이 
--      받는 사원의 정보를 검색

SELECT *FROM SUBEMP 
WHERE SAL >ALL (SELECT AVG(SAL) FROM SUBEMP where dept_id is not null GROUP BY DEPT_ID );

select *from subemp
where sal >(select avg(sal) from subemp where dept_id is not null 
group by dept_id);

















SELECT *FROM subemp;
SELECT *FROM subdept;


--ex12)  모든 사무직 사원보다 급여가 적으면서 사무직이
-- 아닌 모든 사원의 정보검색

SELECT *FROM SUBEMP WHERE SAL < ANY (SELECT SAL FROM SUBEMP WHERE JOB='사무직') AND JOB != '사무직';









