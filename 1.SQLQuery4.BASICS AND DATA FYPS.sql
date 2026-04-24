create database db_list --create a database
use db_list
GO --execute the branch

select db_name() --shows which database I am using
select @@SERVERNAME --shows the server name

alter database db_list --rename a database
modify name = db_ist
 
 drop database db_ist

 ------------------------------------------------

 --standard SELECT queries

 select * --/col1, col2..., what to retrieve 
 from table_name --from where to retrieve
 where condition --filter rows(single cells)
 group by col1 --grouping for aggregation(min, max, count, sum, avg)
 having aggregate_function --filter groups
 order by col1 asc, col2 desc --sort the results

 --logical order: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY

 -----------------------------------------------------------------------------

 --CREATING A SCHEMA
 --schema helps organize tabels by department / module (groups database objects together)

 create schema hr
 go

 ---------------------------------------------------------------------------

  --TABLE CREATION:-

 create table table_name(
	col1 datatype,
	col2 datatype
	)

create table dept2(
	dept2id int,
	dept2name varchar(50)
)

select * from dept2

sp_help 'dept2' --shows the metadata of the table

--------------------------------------------------------------------

--DATA TYPES
--1. Numeric (Tinyint(1 Byte), Smallint, Int(4 Bytes), Bigint(8 Bytes), Decimal(p,s), Money)
--Decimal(p,s) --Decimal(5,2) --99.99
select 7/2
select 7/2.0
select cast(7 as float)/2

--2. Char & Strings(Char, Varchar, Varchar(Max), Varchar(n), NChar...)
declare @b char(10) = 'Hello'
select datalength(@b) --length of the datatype mentioned
select len(@b) --to find the length of the attribute
select @b

--3. Date and Time(Date, Time, DateTime)
--date-> yyyy-mm-dd, hr-min-sec

select cast('2024-01-15' as date)
select cast('2024-01-15 09:20:00' as datetime)
--current date/time functions

select getdate() --shows system date & time( commonly used)
select sysdatetime() --more precise
select getutcdate() --universal time

--data arithmetic
select dateadd(day, 30,'2026-05-01') --adds 30 days
select dateadd(month, -3, getdate()) --(doesnot reset time)

select datediff(day, '2026-01-01', getdate()) --days between dates
select datediff(day, '2024-01-01', getdate())

--4. Boolean(Bit values) (no true/false... only o,1, NULL)

--insert some values inside the table
--Syntax->insert into table_name values--insert some values inside the table
--Syntax->insert into table_name values

create table emp1(
	EmployeeID int primary key,
	IsActive	bit not null default 1, --1 is true
	IsManager	bit not null default 0, --0 is false
	IsOnLeave	bit null                --no value assigned
	)
insert into emp1 values
    (3,1,1,0),
    (4,0,0,2)

select * from emp1


--querying bit values

select * from emp1 where IsActive = 1
select * from emp1 where IsActive = 2
select * from emp1 where IsOnLeave is null

--Alter tables
create table Students_Alter(
	RollNo	int,
	Name	varchar(100),
	Grade	char(1)
)

insert into Students_Alter values
(1, 'AA', 'A'),
(2, 'BB', 'B'),
(3, 'CC', 'C')

select * from Students_Alter

--add column named Age

alter table Students_Alter
add Age int

--update column values

update Students_Alter
set Age = 20
where RollNo = 1

update Students_Alter
set Age = 21
where RollNo = 2

update Students_Alter
set Age = 22
where RollNo = 3

select RollNo from Students_Alter

sp_help 'Students_Alter' --metadata of the table

--alter column (change datatype)
alter table Students_Alter
alter column Name varchar(200)

--delete column age
alter table Students_Alter
drop column Age

------------------------------------------------------------------
drop table Students_Alter --delete the table and its entire property

truncate table Students_Alter --delete the values inside table but keeps the columns

select * from Students_Alter

--------------------------------------------------------------

--TOP(limit rows)

create table Employees_Top(
	EmpID	int,
	FirstName	varchar(100),
	Salary int
)

insert into Employees_Top values
(1, 'AA', 40000),
(2, 'BB', 60000),
(3, 'CC', 55000),
(4, 'DD', 70000),
(5, 'EE', 45000),
(6, 'FF', 65000)

select * from Employees_Top

--to check top n rows
select top 3 * from Employees_Top

--top 3 highest salary

select top 3 * 
from Employees_Top 
order by Salary desc

select top 3 FirstName, Salary 
from Employees_Top
order by Salary desc

--top 50% employees on basis of salary
select top 50 percent *
from Employees_Top
order by Salary desc

--top with ties -> mean (if 2 employees have same salary they appear twice) 
select top 2 with ties *
from Employees_Top
order by Salary desc

--DISTINCT(remove duplicates)

create table Employees_Distinct(
	EmpID int,
	Name varchar(100),
	Department varchar(100)
)

insert into Employees_Distinct values
(1, 'AA', 'HR'),
(2, 'BB', 'IT'),
(3, 'CC', 'IT'),
(4, 'DD', 'Finance'),
(5, 'EE', 'HR')

select * from Employees_Distinct
sp_help 'Employees_Distinct'
--select distinct values (unique department from table)
select distinct Department from Employees_Distinct

--count the distinct department from the table
select count(distinct Department) as distinct_dept_count
from Employees_Distinct

--CONSTRATINTS( these are rules to limit the type stored inside the table)

create table Employee_Constraints(
	EmpID int primary key,
	Name varchar(100) not null,
	Email varchar(100) unique,
	Age int check(Age>18),
	Salary int default Salary = 25000,
	DeptID int not null,
	foreign key(DeptID) references Department_Constraints(DeptID)
)

create table Department_Constraints(
	DeptID int primary key
)

create table Employee_Constraints( 
	EmpID int,
	Name varchar(100),
	Email varchar(100),
	Age int,
	Salary int,
	DeptID int
)

sp_help 'Employee_Constraints'

alter table Employee_Constraints
alter column EmpID int not null

alter table Employee_Constraints
add constraint PK_EmpID primary key(EmpID) --primary key

alter table Employee_Constraints
add constraint UQ_Email unique(Email) --unique key

alter table Employee_Constraints
add constraint FQ_DeptID foreign key(DeptID) references Department_Constraints(DeptID) --foreign key

alter table Employee_Constraints
add constraint CK_Age check(Age>18) --check key

alter table Employee_Constraints
add constraint DF_Salary default 25000 for Salary --default key

alter table Employee_Constraints
drop constraint DF_Salary --drop constraint

SQLQuery2.sql
Displaying SQL-operators.sql. 