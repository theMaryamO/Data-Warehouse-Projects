----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--CREATE TABLE
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

CREATE TABLE maryamsales
(
rollno int,
firstname varchar (50),
lastname varchar (50)
)

/* how to select items in the table */
select * from maryamsales


/* INSERT: PUT VALUES*/ 
insert into maryamsales (rollno, firstname, lastname)
values	(1, 'maryam', 'olaniyan')

select * from maryamsales



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--SELECT DATA ITEMS
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

select * from HumanResources.Department;

--see only the department names 
select name from HumanResources.Department;
select GroupName from HumanResources.Department;
select distinct GroupName from HumanResources.Department




----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
/* deep dive: FILTERING */
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

 --filtering: where = 
 select * from HumanResources.Department
 where GroupName like 'Manufacturing'

 select * from HumanResources.Employee
 where OrganizationLevel like 2 

 --filtering: numeric 
 select * from HumanResources.Employee
 where OrganizationLevel = 2 

  select * from HumanResources.Department
 where GroupName = 'Manufacturing'

 --filtering: in 
 select * from HumanResources.Employee
 where OrganizationLevel in ( 2 , 3) 

 select * from HumanResources.Department
 where GroupName in ('Manufacturing'  , 'Sales and Marketing') 


 -- Is SQL case sensitive? 
 select * from HumanResources.Department
 where GroupName in ('MANUFACTURING'  , 'Sales and Marketing') 
 --Answer= No 

 --Note SQL does exact matching so wildcards/ Regex might be suitbale in some scenarios 

 select * from HumanResources.Employee
 where JobTitle like 'FACILITIES  MANAGER'

 /* Note: this query returns no values because there are double spaces in the item FACILITY  MANAGER: 
 so how do we find values for manager? we use Regex
 Note 'abc%' finds any text starting with abc
 '%abc' finds any text ending with abc
 '%abc% finds any text with abc in the middle */

 select * from	HumanResources.Employee
 where JobTitle like '%Control%'
 -- 6 rows

 select * from	HumanResources.Employee
 where JobTitle like 'Control%'
 -- 2 rows 

  select * from	HumanResources.Employee
 where JobTitle like '%Control'
 --0 rows

 -- How do we filter date information 
 select * from	HumanResources.Employee
 where BirthDate > '1/1/1980'
 --order by BirthDate
  
 -- select employees born within a certain time range
 select * from HumanResources.Employee
 where BirthDate > '1/1/1980' and BirthDate < '1/1/1989'
 --108 rows

 --similar result using BETWEEN 
 select * from HumanResources.Employee
 where BirthDate Between '1/1/1980' and  '1/1/1989'
 --108 rows



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
 --DEEP DIVE: CALCULATED COLUM
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

 --calculated column : Introduction of virtual column that's not part of the original data. E.g Unit Price* Quantity 
select * from Production.Product

 select Name, ListPrice
 , ListPrice + 10 as AdjustedListPrice 
	from Production.Product

-- create delete and update 
--creating a permanent table
 select Name, ListPrice
 , ListPrice + 10 as AdjustedListPrice 
	into  Production.Product_2
from Production.Product

select * from Production.Product_2
 --create a temporary table 
select Name, ListPrice
 , ListPrice + 10 as AdjustedListPrice 
	into #maryamtemp 
from Production.Product

select * from #maryamtemp

-- delete data from the table 
delete from Production.Product_2
where Name like '%Ball%'
 select * from Production.Product_2

 --update statement 
 update Production.Product_2
 set Name = 'Blade New'
 where name like 'Blade'
 select * from Production.Product_2



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
 --JOINS 
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

/* join two or more tables in multiple scenarios
*inner join
*create employee table */

create table maryamemployee 
(employee int
, firstname varchar(20)
, lastname varchar (20))

insert into	maryamemployee values (1, 'Michael', 'Scott')
insert into	maryamemployee values (2, 'Maryam', 'Pam')
insert into	maryamemployee values (3, 'Munirat', 'Beesly')

create table maryamsalary 
(employee int
, salary float)

insert into maryamsalary values (1, 20000)
insert into maryamsalary values (2, 60000)
insert into maryamsalary values (3, 20000)

select * from maryamsalary
select * from maryamemployee

select a.firstname, a.lastname, b.salary 
from maryamemployee a inner join maryamsalary b 
on a.employee = b.employee

create table maryamphone (employee int
,phonenumber int)

insert into maryamphone values (1, 089845683)
insert into maryamphone values (2, 089845683)

select * from maryamemployee
select * from maryamphone

-- Left outer join

select a.firstname, a.lastname , b.phonenumber from maryamemployee a 
left join maryamphone b 
on a.employee = b.employee

--right outer join 
create table maryamparking (employee int
, parkingspot varchar (20))

insert into maryamparking values (1, 'a1')
insert into maryamparking values (2, 'a1')

select * from maryamparking

select a.parkingspot, b.firstname , b.lastname from maryamparking a 
right join maryamemployee b
on a.employee = b.employee

-- full outer join 
select * from maryamparking
select * from maryamemployee
select * from maryamphone
select * from maryamsalary

select a.firstname as 'First Name' , a.lastname as ' Last Name' , b.salary, c.phonenumber from maryamemployee a 
full outer join maryamsalary b on a.employee = b.employee
full outer join maryamphone c on  a.employee = c.employee

--cross join

select * from maryamsalary cross join maryamphone
select * from maryamemployee, maryamparking


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--Date Functions
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

select GETDATE()

select GETDATE() +1

--DatePart: Shows the current day by Day, Month, Year
select DATEPART(yyyy, getdate ()) as 'Year Number'

select DATEPART(MM, getdate ()) as 'Month'

select DATEPART(DD, getdate ()) as 'Day'

--Dateadd: adds a date to a specified date 
select DATEADD(day, 4, getdate())
select DATEADD(month, 4, getdate())
select DATEADD(YEAR, 4, getdate())

-- DateDiff: Finds the date difference between

select WorkOrderID, ProductID, StartDate, EndDate, 
DATEDIFF(day, startdate, enddate) as 'Day Difference' 
from Production.WorkOrder
order by 'Day Difference' desc -- returns the date difference in descending order 

-- This returns the first day of the month
select Dateadd(dd, -(Datepart (DD, GETDATE())-1), getdate()) 

select dateadd(day, -(DATEPART(day, GETDATE()) -1), GETDATE())
/* explanation: GETDATE ()return current date in full plus timestamp 
 * Datepart returns today as Day. In this case, -1 returns previous day 
 * Dateadd returns today - previous day so instead of "dateadd(day, 4, getdate())" the -(Datepart (DD, GETDATE())-1) replaces the 4 
 * Therefore: dateadd(day, -11, getdate()) 
 */
  
  --Example 2
 SELECT DATEADD(dd,-(DATEPART(day, '2017/08/25') -1), '2017/08/25')




----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--Aggregate Functions 
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

select * from maryamsalary
select  Round(AVG(salary), 1) as 'average salary' from maryamsalary --round the result to the tenth decimal place

select COUNT(salary) from maryamsalary

select count (*) from maryamsalary
 
select sum (salary) from maryamsalary

 select min (salary) from maryamsalary

 ---------------------------------
 -- concat (for strings) 
 print concat ( 'string 1' , ' string 2')

 select firstname, lastname, CONCAT(firstname, ' ', lastname , ' ', RAND()) as FullName from maryamemployee 

 --scenario: a database sorts emails, with subject line and body, the first line contains five characters. 
 -- we want to select the first five characters in the left side 

 select employee, lastname, left (Lastname, 5) from maryamemployee

 select employee, lastname, right (Lastname, 5) from maryamemployee

  --substring
 select employee, firstname, SUBSTRING(firstname,3,5) from maryamemployee

  --make everything lowercase
 select employee, firstname, LOWER(firstname) from maryamemployee

  --make everything uppercase 
 select employee, firstname, upper(firstname) from maryamemployee

  --check character length
 select employee, firstname, Len(firstname) from maryamemployee

 -- how do I get the rows in sentence case e.g Maryam instead of maryam or MARYAM
 select employee , firstname, 
 Concat( upper (left (firstname, 1)), lower(substring(firstname, 2, len(firstname)))) as 'First Name' 
 from maryamemployee

 --Trim
 Select len('     My test    ')
 --remove space from left or right 
 select LTRIM('     text    ')
 select RTRIM('     text    ')
 select RTRIM(LTRIM('     text    '))