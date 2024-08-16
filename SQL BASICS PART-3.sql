
-- Table 1 Query:
Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

-- Table 2 Query:
Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)



-- Table 1 Insert:
Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

-- Table 2 Insert:
Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)
;

select* from employeedemographics;
select* from employeesalary;


-- JOINS: 
select* from employeedemographics;
select* from employeesalary;
-- to join two tables
-- innerjoin (join by default automatically considered as innerjoin) (it returns the rows with common coulumn )
select* 
from employeedemographics
 join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID  	-- to join there should be common column in the both tables
    
    
-- full outer join (it return the full table with null values)
select * 
from employeedemographics
full outer join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID ;

-- left outer join (it returns the full table with null values)
select * 
from employeedemographics
left outer join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID ;

-- right outer join (it returns the full table with null values)
select * 
from employeedemographics
right outer join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID ;

-- selecting particular columns (it returns the full table with null valueds)
select employeedemographics.EmployeeID,FirstName,LastName,JobTitle,Salary
from employeedemographics
join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID ;

-- joins using where and orderby 
select employeedemographics.EmployeeID,FirstName,LastName,Salary
from employeedemographics
join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID 
where firstname <> 'michael'
order by salary desc

-- 

select  avg(salary)
from employeedemographics
join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID 
where jobtitle = 'salesman'
group by jobtitle
    
-- UNIONS (in this case the columns should be same in both the tables)

select* from employeedemographics
UNION 
select* from WareHouseEmployeeDemographics;  -- it will removes duplicates and returns
    
    
select* from employeedemographics
UNION all
select* from WareHouseEmployeeDemographics 
order by EmployeeID							   -- it returns all the columns with the duplicates
    
    
    
-- CASE STATEMENTS: (first we need to write select statements then case will be written)

select Firstname, lastname, age,
case 
	when age>30 then 'old'
    else 'young'
end
from employeedemographics
where age is not null
order by age;
	  

select Firstname, lastname, age,
	case 
		when age>30 then 'old'
        when age between 20 and 30 then 'young'
		else 'teens'
	end                      -- after end we can wirte as if we want to name the column
from employeedemographics
where age is not null
order by age;

select firstname, lastname,jobtitle,salary,
case 
	when jobtitle = 'salesman' then salary+ (salary* .10)
    when jobtitle = 'accountant' then salary+ (salary* .05)
    when jobtitle = 'HR' then salary+ (salary* .0001)
    else salary + (salary* .03)
end as salary_after_raise
from employeedemographics
 join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID


-- Having clause  AGGREGATE FUNCTIONS [COUNT,AVG,SUM,ETC.,]
select jobtitle,count(jobtitle)
from employeedemographics
 join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID
group by jobtitle					-- we cannot write group by after having clause it won't return we we did like that
having count(jobtitle) >1			-- here we write having instead of where bcz aggregate functions won't support where
order by count(jobtitle)

select jobtitle,avg(salary)
from employeedemographics
 join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID
group by jobtitle
having avg(salary) >45000
order by avg(salary)

-- ALIASING
select Firstname as fname
from employeedemographics

select Firstname + ' ' + LastName as fname    -- it will be useful when two columns are added  
from employeedemographics

  select avg(age)as Avgage
from employeedemographics

    select *
from employeedemographics
    
-- ALIASING THE TABLE NAME
select demo.employeeid 
from employeedemographics as demo
    
-- partition by  [partition by is used to return performed aggregate funtions in the column also used instead of group by]
select  firstname, lastname, gender,salary,
count(gender) over (partition by gender) as totalgender
from employeedemographics
join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID 



-- CTEs(Common Table Expression) -- it will place the table in the temporary place if we delete the query it will also delete the table

with CTE_Employee as
(select  firstname, lastname, gender,salary,
count(gender) over (partition by gender) as totalgender
from employeedemographics
join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID 
where salary > '45000'
)
select* from CTE_Employee 	-- this select statement should be right after the paranthesis we we write somewhere else it wont return



-- TEMP TABLES  [these are also like CTEs for the temporary purposes]
-- A temporary SQL table, also known as a temp table, is a table that is created and used within the context of a specific session or transaction in a database management system. 
-- It is designed to store temporary data that is needed for a short duration and does not require a permanent storage solution.


create table temp_employee (
employeeid int,
jobtitle varchar(50),
salary int
);

select* from temp_employee;

insert into temp_employee values ('1001','HR','45000')
insert into temp_employee select * from employeesalary  	-- we can insert one table info into another table like this

drop table if exists temp_employee2						 -- it's for the drop after the table created otherwise we can't run this bcz already created
create table temp_employee2(
jobtitle varchar(50),
employeesperjob int,
avgage int,
avgsalary int)

insert into temp_employee2 
select jobtitle,count(jobtitle),avg(age),avg(salary)
from employeedemographics
 join employeesalary
	on employeedemographics.EmployeeID = employeesalary.EmployeeID
group by jobtitle				

select* from temp_employee2




-- string functions

/*

Today's Topic: String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

*/

--Drop Table EmployeeErrors;
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors   		-- in this table there are some erros like extra spaces, unwanted capitals, name spell -mistakes

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 								-- by trim spaces will be cleared both sides

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 								 -- by trim spaces will be cleared on right side

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 								-- by trim spaces will be cleared on left side

	

-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors


-- Using Substring [extracts a substring from a string, starting at a specified position and with an optional length.]
-- with substrings we can perform fuzzy matching. Fuzzy matching, in essence, is the art of finding rows in a database that are similar to a query row but not exactly the same. 

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)



-- Using UPPER and lower 							-- used to convert the strings into upper and lower cases

Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors



-- STORED PROCEDURES
-- stored procedures is a group of sql statements that has been created and then stored in that database
-- A stored procedure is a group of SQL statements that are created and stored in a database management system, 
    -- allowing multiple users and programs to share and reuse the procedure

create procedure test
select * from employeedemographics



-- DROP TABLE IF EXISTS #temp_employee
CREATE PROCEDURE Temp_Employee
AS

Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee
GO;




CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100)
AS
DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
where JobTitle = @JobTitle --- make sure to change this in this script from original above
group by JobTitle

Select * 
From #temp_employee3
GO;


exec Temp_Employee2 @jobtitle = 'Salesman'
exec Temp_Employee2 @jobtitle = 'Accountant'



-- SUB-QUERIES:
/*
Subqueries (in the Select, From, and Where Statement)
*/

Select EmployeeID, JobTitle, Salary
From EmployeeSalary

-- Subquery in Select

Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

-- How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary

-- Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID


-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID


-- Subquery in Where


Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)
