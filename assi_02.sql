
create database assi_02

create table dept(   
  deptno  int primary key,   
  dname      varchar(14),   
  loc        varchar(13)   
);

create table emp(   
  empno    int primary key,   
  ename    varchar(10),   
  job      varchar(9),   
  mgr      int,   
  hiredate date,   
  sal      int,   
  comm     int,   
  deptno   int,   
  constraint fk_deptno foreign key (deptno) references dept (deptno)   
);

insert into DEPT  
values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept   
values(20, 'RESEARCH', 'DALLAS');
insert into dept   
values(30, 'SALES', 'CHICAGO');
insert into dept  
values(40, 'OPERATIONS', 'BOSTON');

------------------------------------------------------------------------

INSERT INTO emp 
VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);

INSERT INTO emp 
VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);

INSERT INTO emp 
VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);

INSERT INTO emp 
VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20);

INSERT INTO emp 
VALUES (7788, 'SCOTT', 'ANALYST', 7566, DATEADD(DAY, -85, '1987-07-13'), 3000, NULL, 20);

INSERT INTO emp 
VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);

INSERT INTO emp 
VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);

INSERT INTO emp 
VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);

INSERT INTO emp 
VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);

INSERT INTO emp 
VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);

INSERT INTO emp 
VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);

INSERT INTO emp 
VALUES (7876, 'ADAMS', 'CLERK', 7788, DATEADD(DAY, -51, '1987-07-13'), 1100, NULL, 20);

INSERT INTO emp 
VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);

INSERT INTO emp 
VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);


---------------------------------------------------------------------------------------------------------------------------------
--01...list the emp who are working as salesman;

 select * from emp where job = 'SALESMAN'

 ---------------------------------------------------------------------------------------------------------------------------------
 --02...Display all the colums from dept 20 and 30

  select * from dept  where deptno = 10  or deptno = 30

---------------------------------------------------------------------------------------------------------------------------------
--03...display all the salesman and analyst from the emp table

select * from emp where job = 'SALESMAN' or job = 'ANALYST'

---------------------------------------------------------------------------------------------------------------------------------
--04...display ename,sal,deptno where deptno should not be 10 and 30

select ename,sal, deptno from emp where deptno not in (10,30)

---------------------------------------------------------------------------------------------------------------------------------
--05...List the emp's who are not eligible to get any commission

 select * from emp  where comm is null or comm = 0

---------------------------------------------------------------------------------------------------------------------------------
--06...list the emp who dont have any MGR
 select * from emp  where mgr is null

---------------------------------------------------------------------------------------------------------------------------------
--07...List the emp who get some commission
select * from emp where comm is not null or comm = 0

---------------------------------------------------------------------------------------------------------------------------------
--08...List the emp who have MGR:

 select * from emp where job = 'MANAGER'

---------------------------------------------------------------------------------------------------------------------------------
--09...List the emp whose name start with S

select * from emp where ename like 'S%'

---------------------------------------------------------------------------------------------------------------------------------
--10...List the employee's who is having letter L as their second character

select * from emp where ename like '_L%'

---------------------------------------------------------------------------------------------------------------------------------
--11...List the employee's who is having letter L as their second character OR letter A as their 2 character

select * from emp where ename like '_L%' or ename like '_A%'

---------------------------------------------------------------------------------------------------------------------------------
--12...List the employee's who is not having letter L as their second character

select * from emp where ename not like '_L%'

---------------------------------------------------------------------------------------------------------------------------------
--13...list the emp whose job as last 3 letter has MAN
 select * from emp  where job like '%MAN'

 ---------------------------------------------------------------------------------------------------------------------------------
 --14...List the emp whose HIREdate is on any date in   '%-FEB-81
  select * from emp  where  DATENAME(month,hiredate) = 'February' and  YEAR(hiredate) = 1981

 ---------------------------------------------------------------------------------------------------------------------------------
 --15...List all the emp who are earning sal between 2000 and 3000

  select * from emp  where sal between 2000 and 3000

---------------------------------------------------------------------------------------------------------------------------------
--16...Diplay the job between manager and salesman
 select * from emp  where job between 'MANAGER' and 'SALESMAN'

---------------------------------------------------------------------------------------------------------------------------------
--17...List the emp who dont have a range of sal which starts from 1000 to 1500
 select * from emp  where sal between 1000 and 1500

 ---------------------------------------------------------------------------------------------------------------------------------
 --18...List the emp who have a hiredate from 1981---1983
  select * from emp where   YEAR(hiredate) between (1981) and (1983)

 ---------------------------------------------------------------------------------------------------------------------------------
--19...List the emp who dont have a hiredate from 1981---1983
  select * from emp where   YEAR(hiredate) not between (1981) and (1983)
 ---------------------------------------------------------------------------------------------------------------------------------
--20...LIST the analyst working in deptno 20
 select * from emp where deptno = 20
---------------------------------------------------------------------------------------------------------------------------------
--21...list all the emp whose name is having atleast 4 characters in dept 20 and 30 with a sal of min 2000 with COMM is null

select * from emp where len(ename) >= 4 and deptno in (20,30) and sal >=2000
and comm is null;

---------------------------------------------------------------------------------------------------------------------------------
--22...List all the ename whose sal is in the range of 2500 to 5000  OR working in deptno 10 as clerk and manager

select * from emp where sal between 2500 and 5000 or deptno in (10) and job in ('CLERK','MANAGER')

---------------------------------------------------------------------------------------------------------------------------------
--23...List all the emp who are working in 10 and 20 dept but salaries are not in the range of 2000 to 3000
 select * from emp where deptno in (10,20) and sal not between 2000 and 3000

 ---------------------------------------------------------------------------------------------------------------------------------
--24...List all the emp whose name does not start with S
 select * from emp  where ename not like 's%'

 ---------------------------------------------------------------------------------------------------------------------------------
--25...LIST all the emp who are eligible to get some comm
 select * from emp where comm is not null

---------------------------------------------------------------------------------------------------------------------------------
--26...List all the emp except in deptno 20 and 30
select * from emp where deptno not in (20,30)

---------------------------------------------------------------------------------------------------------------------------------
--27...LIST the emp who are not eligible to get any comm except in dept 20 and 30 and whose name does not end with S

select * from emp where comm is null and deptno not in (20,30) and ename not like '%S'

---------------------------------------------------------------------------------------------------------------------------------
--28...create a backup table dept_new from dept table
select * into dept_new from dept

---------------------------------------------------------------------------------------------------------------------------------
--29...add a new column region to dept_new table
alter table dept_new
add region varchar(30);

---------------------------------------------------------------------------------------------------------------------------------
--30...rename the region column to new_region columns
exec sp_rename 'dept_new.region','new_region'

---------------------------------------------------------------------------------------------------------------------------------
--31...drop the column new_region
alter table dept_new
drop column new_region

---------------------------------------------------------------------------------------------------------------------------------
--32...change the datatype of deptno to number to string
alter table dept_new
alter column deptno varchar(30);

alter table dept_new
alter column deptno int;

---------------------------------------------------------------------------------------------------------------------------------
--33...total sal in deptno 20

select SUM(sal) as sum_sal from emp where deptno in (20)

---------------------------------------------------------------------------------------------------------------------------------
--34...Display the avg sal of all the salesman

select avg(sal) as avg_sal from emp where job = 'SALESMAN'

---------------------------------------------------------------------------------------------------------------------------------
--35...List the no of emp in dept 20 and 30 only
select * from emp where deptno in (20,30)

---------------------------------------------------------------------------------------------------------------------------------
--36...List the no of clerks in deptno 20
select * from emp where job ='CLERK' and deptno in (20)

---------------------------------------------------------------------------------------------------------------------------------
--37...Display dept wise total sal

select deptno,SUM(sal) as total_sal from emp group by  deptno

---------------------------------------------------------------------------------------------------------------------------------
--38...Display job-wise total sal, only if the total sal is more than 5000
select job, SUM(sal) as total_sal from emp group by  job having SUM(sal) > 5000

---------------------------------------------------------------------------------------------------------------------------------
--39...Display the job-wise total sal, only if the total sal>5000 , except the deptno 20 employess
select job, SUM(sal) as total_sal from emp where deptno not in (20)
group by  job having SUM(sal) > 5000

---------------------------------------------------------------------------------------------------------------------------------
--40...display the deptno which is having more than 5 employee's in it
 select deptno,COUNT(deptno) as emp_count from emp group by deptno having COUNT(deptno) >= 5

 ---------------------------------------------------------------------------------------------------------------------------------
 --41...Display the deptno which is having 3 employees in it
  select deptno,COUNT(deptno) as emp_count from emp group by deptno having COUNT(deptno) = 3

---------------------------------------------------------------------------------------------------------------------------------
--42...ist the job-wise max sal excluding all the manager's and deptno should not be present in 20,30

select job,MAX(sal) as max_sal from emp where job not in ('MANAGER') and deptno not in (20,30)
group by job

---------------------------------------------------------------------------------------------------------------------------------
--43...display sal wise , count of people
select sal,COUNT(sal) as sal_count from emp  group by sal

---------------------------------------------------------------------------------------------------------------------------------
--44...Display job and dep wise avg sal excluding analyst and clerk in deptno 20 and 30

select job,deptno,AVG(sal) as avg_sal from emp where job not in ('ANALYST','CLERK') and deptno in (20,30)
group by  job,deptno

---------------------------------------------------------------------------------------------------------------------------------
--45...SQL Query to return only duplicate rows and count

select * from 
(
select *,
ROW_NUMBER() over(partition by empno,ename,job,mgr,hiredate,sal,comm,deptno order by (select null)) as dup_record
from emp
) as A
where dup_record > 1

---------------------------------------------------------------------------------------------------------------------------------
--46...Display all the emp whose name is having atleast 5 character

select * from emp where len(ename) >=5

---------------------------------------------------------------------------------------------------------------------------------
--47...List all the ename whose name and job are of atleast 5 character

select * from emp where len(ename)>=5 and len(job)>=5

---------------------------------------------------------------------------------------------------------------------------------
--48...List all the emp whose name and job are having atleast 6 character

select * from emp where len(ename)>=6 and len(job)>=6

---------------------------------------------------------------------------------------------------------------------------------
--49...Display all the output as shown below:Also arrange the above data in the asc order of their name length

 select * from emp order by ename 

 ---------------------------------------------------------------------------------------------------------------------------------
 --50...Display all the emp name's whose job is having first 3 character's as MAN using substring

 select * from emp where SUBSTRING(job,1,3) = 'MAN'
 select * from emp where job like 'MAN%'

---------------------------------------------------------------------------------------------------------------------------------
--51...Write a query to display the emp name and last four character of the name using substring
select ename, right(ename,4) from emp  ;

select ename, SUBSTRING(ename, LEN(ename) - 3, 4) from emp 

---------------------------------------------------------------------------------------------------------------------------------
--52...List the emp whose job is having last 3 character as MAN as substring

select * from emp where SUBSTRING(job,LEN(job) - 2, 3) = 'MAN'
select * from emp where job like '%MAN'
 
---------------------------------------------------------------------------------------------------------------------------------
--53...Display all the emp who are earning odd no of salaries

 select * from emp where sal%2 <> 0
---------------------------------------------------------------------------------------------------------------------------------
--54...Display the year wise count of ppl

select YEAR(hiredate) as year_c ,count(*) as full_count from emp 
group by YEAR(hiredate) order by full_count

---------------------------------------------------------------------------------------------------------------------------------
--55...Display the year in which atleast 5 employees have joned

select YEAR(hiredate) as year_c ,count(YEAR(hiredate)) as full_count from emp group by YEAR(hiredate)
having count(YEAR(hiredate)) >=5

---------------------------------------------------------------------------------------------------------------------------------
--56...Display all the emp who have completed 28 years of service

select * from  emp where DATEdiff(YEAR,hiredate,GETDATE()) >= 28
select * from emp where YEAR(GETDATE()) - YEAR(hiredate) >=28

---------------------------------------------------------------------------------------------------------------------------------
--57...List all the employees working in research dept

select * from dept where dname = 'RESEARCH'

---------------------------------------------------------------------------------------------------------------------------------
--58...List the emp in research and accounting dept

select * from dept
where dname = 'RESEARCH' or dname = 'ACCOUNTING'

---------------------------------------------------------------------------------------------------------------------------------
--59...Diplay the dname in which atleast 5 employees are working in it

select dname,COUNT(dname) as emp_count from emp as a inner join dept as b on a.deptno = b.deptno
group by dname having COUNT(dname) >=5

---------------------------------------------------------------------------------------------------------------------------------
--60...Display the dname and their locations for all the managers earning more than 2800
select  b.dname, 
    b.loc, 
    a.ename AS ManagerName, 
    a.sal from emp as a inner join dept as b on a.deptno = b.deptno
where job = 'MANAGER' and sal > 2800

---------------------------------------------------------------------------------------------------------------------------------
--61...List the dname which is having salesman
	
select  b.dname
    from emp as a inner join dept as b on a.deptno = b.deptno
	where a.job = 'SALESMAN'

---------------------------------------------------------------------------------------------------------------------------------
--62...List the emp who are living in a loc which is having letter O in it

select * from emp as a inner join dept as b on a.deptno = b.deptno
where b.loc like '%O%'

---------------------------------------------------------------------------------------------------------------------------------
--63...List the Dname which is having no employees in it

select * from emp as a inner join dept as b on a.deptno = b.deptno
where a.empno is null

---------------------------------------------------------------------------------------------------------------------------------
--64...write a query to display 3rd max sal

select * from
(
select *,
DENSE_RANK() over(order by sal desc) as sal_rank
from emp
) as a
where sal_rank = 3;

---------------------------------------------------------------------------------------------------------------------------------
--65...write a query to display 5 max sal

select * from
(
select *,
DENSE_RANK() over(order by sal desc) as sal_rank
from emp
) as a
where sal_rank = 5;

---------------------------------------------------------------------------------------------------------------------------------
--66...write a query to diplay 4th least sal

select * from
(
select *,
DENSE_RANK() over(order by sal) as sal_rank
from emp
) as a
where sal_rank = 4;

SELECT *
FROM emp AS a
WHERE 4 = (
    SELECT COUNT(DISTINCT sal)
    FROM emp AS b
    WHERE a.sal >= b.sal
);
---------------------------------------------------------------------------------------------------------------------------------
--67...Display the ename who is getting 2 max sal

select * from
(
select *,
DENSE_RANK() over(order by sal desc) as sal_rank
from emp
) as a
where sal_rank = 2;

SELECT *
FROM emp AS a
WHERE 2 = (
    SELECT COUNT(DISTINCT sal)
    FROM emp AS b
    WHERE a.sal <= b.sal
);


---------------------------------------------------------------------------------------------------------------------------------
--68...display the deptno and sal who is earning 3rd least sal
select * from
(
select *,
DENSE_RANK() over(order by sal) as sal_rank
from emp
) as a
where sal_rank = 3;

select * from emp a where 3 = 
(select COUNT(distinct sal) from emp b where a.sal>=b.sal )
---------------------------------------------------------------------------------------------------------------------------------
--69...List the employes who are reporting to ford's  manager
SELECT *
FROM emp
WHERE mgr = (
    SELECT mgr
    FROM emp
    WHERE ename = 'FORD'
)
AND ename != 'FORD';

---------------------------------------------------------------------------------------------------------------------------------
--70...List the dname of blake's reportee's

select * from emp as a inner join dept as b on a.deptno = b.deptno
where a.mgr=(
select empno from emp
where ename = 'BLAKE'
);

---------------------------------------------------------------------------------------------------------------------------------
--71...List the employees who are having atleast 3 person reporting to them

SELECT e.ename, e.empno, e.job, e.mgr, COUNT(*) AS ReporteeCount
FROM emp AS e
GROUP BY e.mgr, e.ename, e.empno, e.job
HAVING COUNT(*) >= 3;

---------------------------------------------------------------------------------------------------------------------------------
--72...List the employees who dont have any reportees

SELECT e1.ename, e1.empno, e1.job, e1.mgr
FROM emp AS e1
LEFT JOIN emp AS e2 ON e1.empno = e2.mgr
WHERE e2.empno IS NULL;

---------------------------------------------------------------------------------------------------------------------------------
--73...List all the employees who is having atleast one person reporting to them:

SELECT e.ename, e.empno, e.job, e.mgr
FROM emp AS e
WHERE e.empno IN (
    SELECT DISTINCT mgr
    FROM emp
    WHERE mgr IS NOT NULL
)

---------------------------------------------------------------------------------------------------------------------------------
--74...Display location wise count of ppl

SELECT d.loc AS Location, COUNT(e.empno) AS EmployeeCount
FROM emp AS e
INNER JOIN dept AS d ON e.deptno = d.deptno
GROUP BY d.loc
ORDER BY EmployeeCount DESC;

---------------------------------------------------------------------------------------------------------------------------------
--75...Diplay deptno wise total sal

select deptno,SUM(sal) as full_sal from emp group by deptno

---------------------------------------------------------------------------------------------------------------------------------
--76...List the dname,ename,job and total sal who are living in chicago and new_york and sal more than 1500:

select b.dname,a.ename,a.job, SUM(a.sal) as full_sal from emp as a inner join dept as b on a.deptno = b.deptno
where b.loc in ('CHICAGO','NEW YORK') and sal > 1500 group by b.dname,a.ename,a.job 

---------------------------------------------------------------------------------------------------------------------------------
--77...List  the dname,no of emp working under dept only if the dep is having more than 4 employees in it

SELECT d.dname AS DepartmentName, COUNT(e.empno) AS EmployeeCount
FROM emp AS e
INNER JOIN dept AS d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) > 4;

---------------------------------------------------------------------------------------------------------------------------------
--78...get the deptno ,dname and loc which is not present in emp table

SELECT d.deptno, d.dname, d.loc
FROM dept AS d
LEFT JOIN emp AS e ON d.deptno = e.deptno
WHERE e.deptno IS NULL;
    ---------------------------------------------------
select deptno from dept
except
select deptno from emp

---------------------------------------------------------------------------------------------------------------------------------
--79...Display ename along with manager name

SELECT e.ename AS EmployeeName, m.ename AS ManagerName
FROM emp AS e
LEFT JOIN emp AS m ON e.mgr = m.empno;

SELECT ename,job FROM EMP WHERE job='MANAGER';

---------------------------------------------------------------------------------------------------------------------------------
--80...List all the emp who are earning same sal

SELECT DISTINCT a.ename AS EmployeeName, a.sal AS Salary
FROM emp AS a
JOIN emp AS b ON a.sal = b.sal 

SELECT * FROM EMP WHERE Sal IN (SELECT Sal FROM EMP GROUP BY Sal HAVING COUNT(*) > 1)

---------------------------------------------------------------------------------------------------------------------------------
--81...Display the unique deptno from emp table and dept table:

select deptno from emp
union
select deptno from dept

---------------------------------------------------------------------------------------------------------------------------------
--82...Display the deptno in dept table which is not present in emp table:

select deptno from dept
except
select deptno from emp

---------------------------------------------------------------------------------------------------------------------------------
--83...83)Display all the deptno from emp table and dept table:

select deptno from dept
union all
select deptno from emp

---------------------------------------------------------------------------------------------------------------------------------

select* from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'emp' 

 select * from dept 
 select * from emp 
 select * from dept_new

 select * from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME ='job'