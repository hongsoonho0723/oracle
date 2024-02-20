--SCOTT접속 
SELECT * FROM emp;
SELECT * FROM dept; --부서정보
SELECT * FROM salgrade; --급여등급


-- 1. SMITH 에 대한  정보 검색(ename, emp.deptno, loc .)

--2. NEW YORK에 근무하는 사원의 이름과 급여를 출력

-- 3. ACCOUNTING 부서 소속 사원의 이름과 입사일 출력

-- 4. 직급이 MANAGER인 사원의 이름, 부서명 출력

-- 5. 사원의 급여가 몇 등급인지를 검색
-- between A and B
select * from salgrade;
select * from emp;

SELECT EMPNO, ENAME, SAL, GRADE, LOSAL, HISAL
 FROM EMP JOIN salgrade
 ON SAL BETWEEN LOSAL AND HISAL;
 


--6. 사원 테이블의 부서 번호로 부서 테이블을 참조해서 부서명, 급여 등급도 검색

--7. SMITH의 메니저(mgr) 이름(ename) 검색

--8. 관리자가 KING인 사원들의 이름과 직급(job) 검색

--9. SMITH 와 동일한 부서번호(DEPTNO)에서 근무하는 사원의 이름 출력
-- 단, SMITH 데이터 절대 출력 불가


10. SMITH 와 동일한 근무지(LOC)에서 근무하는 사원의 이름 출력
-- 단, SMITH 데이터 절대 출력 불가

-- 11, 사원명, 해당 하는 메니저명 검색
-- 반드시 모든 사원들(CEO포함) 정보 검색
-- CEO인 경우 메니저 정보 null










