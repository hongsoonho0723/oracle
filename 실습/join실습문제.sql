--SCOTT���� 
SELECT * FROM emp;
SELECT * FROM dept; --�μ�����
SELECT * FROM salgrade; --�޿����


-- 1. SMITH �� ����  ���� �˻�(ename, emp.deptno, loc .)

--2. NEW YORK�� �ٹ��ϴ� ����� �̸��� �޿��� ���

-- 3. ACCOUNTING �μ� �Ҽ� ����� �̸��� �Ի��� ���

-- 4. ������ MANAGER�� ����� �̸�, �μ��� ���

-- 5. ����� �޿��� �� ��������� �˻�
-- between A and B
select * from salgrade;
select * from emp;

SELECT EMPNO, ENAME, SAL, GRADE, LOSAL, HISAL
 FROM EMP JOIN salgrade
 ON SAL BETWEEN LOSAL AND HISAL;
 


--6. ��� ���̺��� �μ� ��ȣ�� �μ� ���̺��� �����ؼ� �μ���, �޿� ��޵� �˻�

--7. SMITH�� �޴���(mgr) �̸�(ename) �˻�

--8. �����ڰ� KING�� ������� �̸��� ����(job) �˻�

--9. SMITH �� ������ �μ���ȣ(DEPTNO)���� �ٹ��ϴ� ����� �̸� ���
-- ��, SMITH ������ ���� ��� �Ұ�


10. SMITH �� ������ �ٹ���(LOC)���� �ٹ��ϴ� ����� �̸� ���
-- ��, SMITH ������ ���� ��� �Ұ�

-- 11, �����, �ش� �ϴ� �޴����� �˻�
-- �ݵ�� ��� �����(CEO����) ���� �˻�
-- CEO�� ��� �޴��� ���� null










