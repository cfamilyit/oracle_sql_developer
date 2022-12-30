-- DCL
alter session set "_ORACLE_SCRIPT"=true; 
create user swathi identified by swathi;

conn swathi/swathi;

conn cfamily/cfamily;
grant create session to swathi;
conn swathi/swathi;

desc role_sys_privs;
select ROLE,PRIVILEGE from role_sys_privs;


-- DDL -- Data Definition Language
create table first(empno number(10),ename VARCHAR2(15));
desc first;
alter table first add(sal number(10),address varchar(50));
desc first;

alter table first modify ename varchar2(30);
alter table first modify sal number(12,2);

desc first;
alter table first drop column empno;

desc first;
alter table first drop(sal,address);
desc first;

alter table first drop column ename;

desc first;
drop table first;
desc first;

flashback table first to before drop;
desc first;


desc first;
drop table first purge;
desc first;
flashback table first to before drop;

desc employee;
alter table employee rename column empno to sno;
desc employee;

create table emp(empno number(10),ename VARCHAR2(15),sal number(10,2),gender varchar(5),dno number);

-- DML -- Data Manipulation Language
select * from emp;
insert into emp(empno,ename,sal,gender,dno) values(101,'sreenivas',25000.50,'m',11);
select * from emp;

insert into emp values(102,'swathi',20000.50,'f',11);
insert into emp values(103,'badri',35000.50,'m',12);
select * from emp;

insert into emp values(&empno,'&ename',&sal,'&gender',&dno);
select * from emp;
update emp set sal=30000.75 where ename='sreenivas';
select * from emp;

alter table emp add address varchar2(30);
desc emp;
select * from emp;

update emp set address='hyderabad';
select * from emp;
update emp set address=null where ename='badri';
select * from emp;
delete from emp;
rollback;
select * from emp;

delete from emp where sal>30000;
select * from emp;

select * from emp where sal>30000;

select * from emp where gender='f';

select ename,sal from emp;
select ename,dno from emp;
select empno,dno,sal from emp;


select ename,sal from emp where gender='m';
select ename,dno from emp where gender='m';
select empno,dno,sal from emp where gender='m';

create table staff as select * from emp;
select * from staff;

create table staff2 as select * from emp where 1=2;
select * from staff2;

desc staff2;

-- Operators used in Select Statement
-------------------------------------
-- 1. Arithmetic Operators(*,+,/,-)
select ename,sal,sal*12 annual_salary from emp;

select ename,sal,sal*12 annual_salary,(sal*12)*0.3 hra,(sal*12)*0.2 tax,(sal*12)+(sal*12)*0.30-(sal*12)*0.2 netsal from emp;

-- Preparing Sample Data --
DROP TABLE dept;
DROP TABLE salgrade;
DROP TABLE emp;

CREATE TABLE salgrade(
grade number(4) not null primary key,
losal number(10,2),
hisal number(10,2));

CREATE TABLE dept(
deptno number(2) not null primary key,
dname varchar2(50) not null,
location varchar2(50) not null);

CREATE TABLE emp(
empno number(4) not null primary key,
ename varchar2(50) not null,
job varchar2(50) not null,
mgr number(4),
hiredate date,
sal number(10,2),
comm number(10,2),
deptno number(2) not null);

insert into dept values (10,'Accounting','New York');
insert into dept values (20,'Research','Dallas');
insert into dept values (30,'Sales','Chicago');
insert into dept values (40,'Operations','Boston');
insert into salgrade values (1,700,1200);
insert into salgrade values (2,1201,1400);
insert into salgrade values (3,1401,2000);
insert into salgrade values (4,2001,3000);
insert into salgrade values (5,3001,99999);
insert into emp values (7369,'SMITH','CLERK',7902,'13-JUN-93',800,0.00,20);
insert into emp values (7499,'ALLEN','SALESMAN',7698,'15-AUG-98',1600,300,30);
insert into emp values (7521,'WARD','SALESMAN',7698,'26-MAR-96',1250,500,30);
insert into emp values (7566,'JONES','MANAGER',7839,'31-OCT-95',2975,null,20);
insert into emp values (7698,'BLAKE','MANAGER',7839,'11-JUN-92',2850,null,30);
insert into emp values (7782,'CLARK','MANAGER',7839,'14-MAY-93',2450,null,10);
insert into emp values (7788,'SCOTT','ANALYST',7566,'5-MAR-96',3000,null,20);
insert into emp values (7839,'KING','PRESIDENT',null,'9-JUN-90',5000,0,10);
insert into emp values (7844,'TURNER','SALESMAN',7698,'4-JUN-95',1500,0,30);
insert into emp values (7876,'ADAMS','CLERK',7788,'4-JUN-99',1100,null,20);
insert into emp values (7900,'JAMES','CLERK',7698,'23-JUN-00',950,null,30);
insert into emp values (7934,'MILLER','CLERK',7782,'21-JAN-00',1300,null,10);
insert into emp values (7902,'FORD','ANALYST',7566,'5-DEC-97',3000,null,20);
insert into emp values (7654,'MARTIN','SALESMAN',7698,'5-DEC-98',1250,1400,30);


select count(*) from emp;
select count(*) from dept;
select count(*) from salgrade;

-- Relational operators
select * from emp;
-- E.g1:- Write a Query to display employees except Job as 'CLERK' from emp table
select * 
       from emp
       where job<>'CLERK';
-- E.g2:- W.A.Q to dispaly the employees who are getting more than 2000 salary from emp table?
select * 
       from emp
       where sal>2000;
       
-- E.g3:- WAQ whose CLERK having more than 2000 Salary from emp table
select * 
       from emp
       where job='CLERK' and sal>2000;
       
-- E.g:- WAQ to display employees whose job role is 'CLARK' or sal>2000 
select * 
       from emp
       where job='CLERK' or sal>2000;
-- E.g:- WAQ to display employees except manager role      
select * 
       from emp
       where NOT job='MANAGER';       

select * 
       from emp
       where job<>'MANAGER'; 

-- Special Operators 
   -----------------
--IN   
select * from emp where deptno in (20,30,50,70,80);

select * from emp where deptno not in (20,30,50,70,80);

select * from emp where deptno not in (20,30,50,70,80,null);

select * from emp;

-- null value
select ename,sal,comm,sal+comm from emp where ename='JONES';
select ename,sal,comm,sal+nvl(comm,0) from emp;
update emp set comm=nvl2(comm,comm+500,500);
select * from emp;

--between
select *
       from emp 
       where sal between 2000 and 5000;
select *
       from emp 
       where sal >=2000 and sal<=5000;       
       
--not between
select *
       from emp 
       where sal not between 2000 and 5000;
select *
       from emp 
       where sal <=2000 or sal>5000;       

-- is null, is not null
select * from emp;

select * from emp where mgr is null;
select * from emp where mgr is not null;

-- like 
--E.g1:- WAQ to display the employee's whose ename starts with 'M' from employee table?
select * 
       from emp
       where ename like 'M%';
       
-- E.g2:- WAQ to display the employees whose ename having 'M' in any position within ename 
-- column from emp table?
select * 
       from emp
       where ename like '%M%';
       
-- E.g3:-	WAQ to display the employees whose ename second leter is "L" from emp table?
select * 
       from emp
       where ename like '_L%';
       
-- E.g4:-	WAQ to display the employees whose ename 4th leter is "M" from emp table?  
select * 
       from emp
       where ename like '____M%';
       
select * from emp;     

-- E.g5:- WAQ to display the employees who are joining in the month of DEC? 
select * 
       from emp
       where hiredate like '%DEC%';
-- E.g6:-WAQ to display the employees who are joining in the year 98? 
select * 
       from emp
       where hiredate like '%98';

-- Problem of Like Operator
insert into emp(empno,ename,job,deptno) values(1,'S_MITH','PROGRAMMER',40);

-- WAQ to display the employee whose name starts with 'S_' from emp table?
select * 
       from emp
       where ename like 'S_%';

select * 
       from emp
       where ename like 'S?_%' escape '?';
       
select * 
       from emp
       where ename like 'S1_%' escape '1';       
       
-- Not Like Operator
select * 
       from emp
       where ename like 'S_%';
select * 
       from emp
       where ename not like 'S_%';       

-- Concatination Operator
select 'my employee name is:' || ename from emp;

-- Dual 
desc dual;
select * from dual;
select 10*2 from dual;


-- Predefined Functions 

-- 1. Number Functions
select abs(-50) from dual;
select mod(10,2) from dual;
select round(1.23456,3) from dual;
select round(1475.789,-1) from dual;
select round(1295,-2) from dual;
select ename,sal,sal/7,round(sal/7,2), round(sal/7,3) from emp;
select trunc(1.8) from dual;
select trunc(1.23456,3) from dual;
select ceil(1.4) from dual;
select floor(1.4) from dual;
select greatest(5,3,7,9,6) from dual;
select least(5,3,7,9,6) from dual;

-- 2. Character Functions
select ename from emp;
select upper(ename) from emp;
select upper('sreenivas') from dual;
select upper('SreeNivas') from dual;

select lower(ename) from emp;
select lower('SREENIVAS') from dual;
select lower('SreeNivas') from dual;

select ename from emp;
update emp set ename=lower(ename);

select initcap(ename) from emp;
select initcap('cfamily_it_solutions') from dual;

select length('hi hi') from dual;
select ename,length(ename) from emp;

select substr('ABCDEFGH',2,3) from dual;
select substr('Sreenivas',5,5) from dual;
select substr('Sreenivas',7,3) from dual;

update emp set ename=upper(ename);
--E.g:- WAQ to dispaly the employees whose name Second Letter is 'LA' from emp table?
select ename from emp where substr(ename,2,2)='LA';

--E.g:- WAQ to display employees whose ename length is 5characters from emp using length()
select ename from emp where length(ename)=5;
select instr('sreenivas*123','*') from dual;
select instr('sreenivas*123','nivas') from dual;
select lpad('ABCD',10,'#') from dual;
select rpad('ABCD',10,'#') from dual;
select ltrim('sssreenivas','s') from dual;
select job,ltrim(job,'CSM') from emp;
select rtrim('sssreenivas','sa') from dual;
select job,rtrim(job,'TKRN') from emp;
select trim('s' from'sssreenivas') from dual;
select trim(leading 's' from'sssreenivas') from dual;
select ' sssreenivas ' from dual;
select trim(' ' from' sssreenivas ') from dual;
select translate('india','in','xy') from dual;
select replace('india','in','xy') from dual;
select job,replace(job,'SALESMAN','MARKETING') from emp;
select replace('sssreenivas','s') from dual;
select concat('wel','come') from dual;

-- Date functions
select sysdate from dual;
select add_months(sysdate,5) from dual;
select add_months(sysdate,-1) from dual;
select last_day(sysdate) from dual;
select last_day('01-FEB-21') from dual;
select next_day(sysdate,'monday') from dual;
select next_day(sysdate,'wednesday') from dual;
select next_day(sysdate,'friday') from dual;
select months_between(sysdate,'01-DEC-20') from dual;
select months_between(sysdate,'01-FEB-21') from dual;
select ename,round(months_between(sysdate,hiredate)) as no_of_months from emp;
select sysdate+10 from dual;
select sysdate-1 from dual;
select sysdate+sysdate from dual; -- invalid
select sysdate-sysdate from dual;
select last_day(add_months('26-JAN-21',-1))+1 from dual;
desc emp;
select sysdate from dual;
select to_char(sysdate,'dd/mm/yy') from dual;
select to_char(sysdate,'dd/mm/yyyy') from dual;
select to_char(sysdate,'day') from dual;
select to_char(to_date('20-MAR-79'),'day') from dual;
select to_char(to_date('20-MAR-79'),'dy') from dual;
select to_char(to_date('20-MAR-79'),'ddd') from dual;  -- year
select to_char(to_date('20-MAR-79'),'dd') from dual; -- day
select to_char(to_date('20-MAR-79'),'d') from dual; -- month
select to_char(sysdate,'ddth') from dual; -- 1st because today is 01-JAN-21
select to_char(to_date('20-MAR-79'),'ddth') from dual; -- 20th
select to_char(sysdate,'ddspth') from dual; -- first 
select to_char(to_date('20-MAR-79'),'ddspth') from dual; -- twentieth
select to_char(sysdate,'HH:MI:SS') from dual; -- 11:44:33
select to_char(sysdate,'HH24:MI:SS') from dual; -- 11:44:33
select to_char(systimestamp,'DD-MON-YYYY HH24:MI:SS.FF') from dual;
select to_date('02/jan/21') from dual;
select to_date('02/01/21') from dual;
select to_date('02/01/21','dd/mm/yy') from dual;
select to_date('02/01/2021','dd/mm/yy') from dual;
--E.g:- WAQ to add 5days to the given date?
select '02-JAN-21'+5 from dual;
select to_date('02-JAN-21')+5 from dual;
select to_date('02-01-21')+5 from dual;
select to_date('02-01-21','dd/mm/yy')+5 from dual;

-- E.g:- WAQ to display given date into character format.
select to_char(to_date('02-JAN-21')) from dual;
select to_char(to_date('02-01-2021','dd/mm/yyyy')) from dual;
select to_char(to_date('02-JAN-2021'),'day/month/yyyy') from dual;
select * from  emp;
-- E.g:- WAQ to display the employees who are joining Dec month from emp table using 
-- to_char 
select * from emp where to_char(hiredate,'mm')='12';
     -- or 
select * from emp where to_char(hiredate,'MON')='DEC';     
     -- or 
select * from emp where to_char(hiredate,'MONTH')='DECEMBER'; 
-- O/P:- Now rows matched
select * from emp where to_char(hiredate,'FMMONTH')='DECEMBER'; 
-- O/P: two records matched

-- E.g:- WAQ to display employees who are joining in the year 81 from emp using to_char()
select * from emp;
select * from emp where to_char(hiredate,'yy')='96';
-- or 
select * from emp where to_char(hiredate,'yyyy')='1996';
-- E.g:- automatic convertion
select last_day('02-JAN-21') from dual; -- here we passed string form oracle applied automatic conversion

-- E.g:- Explicit type casting
select last_day('02-01-21') from dual;
select last_day(to_date('02-01-21','dd/mm/yy')) from dual;

-- Inserting date data into tables
create table test(col1 date);
desc test;
insert into test(col1) values(sysdate);
select * from test;
insert into test(col1) values('02-02-21'); -- date is not oracle format
insert into test(col1) values('02-FEB-21');
select * from test;
insert into test(col1) values(to_date('02-02-21','dd/mm/yy'));
select * from test;

select to_char(sysdate,'dd-mm-yy HH24:MI:SS') from dual;
select to_char(round(sysdate),'dd-mm-yy HH24:MI:SS') from dual;
select to_char(trunc(sysdate),'dd-mm-yy HH24:MI:SS') from dual;

select round(sysdate,'year') from dual;
select round(sysdate,'month') from dual;
select trunc(sysdate,'year') from dual;
select trunc(sysdate,'month') from dual;
select * from emp;

-- Group Functions
select max(sal) from emp;
select max(hiredate) from emp;
select max(ename) from emp;

select * from emp;
select min(sal) from emp;
select min(hiredate) from emp;
select min(ename) from emp;

select sum(sal) from emp;
select sum(comm) from emp;
select sum(hiredate) from emp; -- error -- invalid 
select sum(ename) from emp; -- error -- invalid 

select * from emp;
select count(*) from emp;
select count(empno) from emp;
select count(mgr) from emp;

select avg(sal) from emp;
select avg(comm) from emp;
select avg(hiredate) from emp; -- error -- inconsistent datatype
select avg(ename) from emp; -- error - invalid number

-- E.g:- WAQ to display employee whose salary max of all employees?
--select * from emp where max(sal);
--select *,max(sal) from emp;
-- group by
select * from emp;
select deptno,count(*) from emp;
select deptno,count(*) from emp group by deptno;

--E.g:- WAQ to display no.of employees in each Job?
select * from emp;
select job,count(*) from emp group by job;
-- without group function
select job from emp group by job;
select deptno from emp group by deptno;
select deptno,sum(sal),job from emp group by deptno; -- error 'not a GROUP BY expression'
select deptno,sum(sal),job from emp group by deptno,job;
select deptno,sum(sal) from emp group by deptno,job;

select max(sal) from emp;
select deptno,max(sal) from emp;
select deptno,max(sal) from emp group by deptno;
select * from emp;

select deptno,count(*) from emp group by deptno;
select deptno,count(*) from emp group by deptno where count(*)>3;

-- having
select deptno,count(*) from emp group by deptno having count(*)>3;
--E.g:- WAQ to display the departments sum of salary more than 6000?
select deptno,sum(sal) from emp group by deptno having sum(sal)>6000;
-- E.g:-WAQ to display year,no.of employees per year in which more than 1 employee 
-- was hired?
select * from emp;
select to_char(hiredate,'yyyy') "YEAR",count(*) from emp group by to_char(hiredate,'yyyy') having count(*)>1;

-- E.g:- WAQ to display deptno,sum(sal) from emp those departments having more 
-- than 3 employees?
select deptno,sum(sal) from emp group by deptno having count(*)>3;

--Order by
select * from emp;
select ename from emp;
select empno from emp;

select * from emp order by sal;
select * from emp order by sal desc;

delete from emp where empno=1;
select * from emp order by ename;
select * from emp order by ename desc;
select * from emp order by deptno,sal desc;

-- Combination different clasues
select deptno,count(*) from emp
       where sal>1000
       group by deptno
       having count(*)>3
       order by deptno desc;
       
-- rollup, cube
select deptno,job,sum(sal)
       from emp
       group by rollup(deptno,job);
       
select deptno,job,sum(sal)
       from emp
       group by cube(deptno,job);      
-- Set Operators
select job from emp where deptno=10;
select job from emp where deptno=20;

select job from emp where deptno=10
     union
select job from emp where deptno=20;

select job from emp where deptno=10
     union all
select job from emp where deptno=20;

select job from emp where deptno=10
     intersect
select job from emp where deptno=20;

select job from emp where deptno=10
     minus
select job from emp where deptno=20;

select 10+20 from dual;

select deptno,to_char(null) "DEPTNAMES" from emp;
select to_number(null),dname from dept;
select deptno,to_char(null) "DEPTNAMES" from emp
   union
select to_number(null),dname from dept;   

                            -- Key COnstraints
-- Not Null
-- E.g:- column level 
create table f1(sno number(10) not null,name varchar2(20));
insert into f1 values(1,'sreenivas');
insert into f1 values(null,'sreenivas'); -- cannot insert NULL into ("SCOTT"."S1"."SNO")

insert into f1 values(2,null);

-- Unique Key
--E.g:- column level 
create table f2(sno number(10) unique,name varchar2(20));
insert into f2 values(1,'sreenivas');
insert into f2 values(1,'swathi'); -- unique constraint (SCOTT.SYS_C0010861) violated
insert into f2 values(null,'meena');
insert into f2 values(null,'badri');

--E.g:- table level 
create table f3(sno number(10),name varchar2(20),unique(sno,name));
insert into f3 values(1,'sreenivas');
insert into f3 values(2,'sreenivas'); -- unique constraint (SCOTT.SYS_C0010861) violated

select * from f3;

-- Primary Key
-- column level.
create table f4(sno number(10) Primary Key, name varchar(20));

-- table level
create table f5(sno number(10),name varchar(20), primary key(sno,name));

-- foreign key
-- column level
create table f6(sno number(10) references f4, fee number(10));
insert into f6 values(1,10000);

insert into f4 values(1,'sreenivas');
insert into f4 values(2,'swathi');
insert into f4 values(3,'badri');
insert into f4 values(4,'meena');

insert into f6 values(1,10000);

-- table level
create table f7(sno number(10),course varchar2(20),
                foreign key(sno) references f4);
insert into f7 values(1,'python');
insert into f7 values(1,'Hadoop');
insert into f7 values(1,'AWS');
insert into f7 values(2,'python');
insert into f7 values(5,'python');

-- a) deletion in master table 
delete from f4 where sno = 1;

create table f8(sno number(10),name varchar2(20),foreign key(sno,name) references f5 
on delete cascade);
insert into f5 values(1,'sreenivas');
insert into f5 values(2,'swathi');
insert into f5 values(3,'badri');
insert into f5 values(4,'meena');

insert into f8 values(1,'sreenivas');

select * from f5;
select * from f8;
delete from f5 where sno=1;
select * from f5;
select * from f8;

--b) insertion in child table
select * from f5;
select * from f8;
insert into f8 values(1,'sreenivas');

-- 5. Check Constraint
--column level
create table test_sal(sal number(10) check(sal>20000));
insert into test_sal values(30000);
insert into test_sal values(3000);

--table level
create table test2(name varchar2(20),
                   sal number(10),
                   check(sal>2000 and name = upper(name))
                   );
                   
insert into test2 values('SREENIVAS',3000);
insert into test2 values('swathi',3000);

-- Assign Userdefined names to Constraints:-
    --or 
-- Constraints Names:-
Create table test3(sno number(10) primary key);
insert into test3 values(1);
insert into test3 values(1);

Create table test4(sno number(10) constraint p_sno primary key);
desc test4;
insert into test4 values(1);
insert into test4 values(1);


