/* creating a table */
create table student(
	student_id int primary key,
    student_name varchar (20),
    student_birth date,
    major varchar(20) 

);


describe student;          /* shows how the table look alike*/
alter table student add column gpa decimal(3,2);     /* to edit the table using alter*/
alter table student drop column gpa;     /* to  delete the table using alter delete*/
insert into student value (5,'tarun','1998-1-23','english');  /* inserting the values into the table*/
insert into student (student_id, student_name, student_birth, major) values  (5,'vijay','1998-12-20','telugu');  /* inserting the specific values into the table*/


select * from student;                    /* selecting or it shows the entire table*/
select student_name from student;         /*selecting specific columns form the table*/
select * from student limit 3;			  /* selcting the table with specific rows*/
select * from student order by student_name ;			  /* selcting the table with specific rows in ascending order*/
select * from student order by student_name desc ;			  /* selcting the table with specific rows in descending order*/


drop table student;						  -- deleting the table


/* constraints*/
/* creating a table with some constraints */

create table student(
	student_id int unique primary key auto_increment,     -- unique = it will receive only unique values and id increments automatically
    student_name varchar (20) not null, 				 /* not null = it should be filled or inserted*/
    student_birth date,
    major varchar(20) default ('undecided') unique		/* default displays specified attribute instead of null*/
);

update student set major ='tel' where major = 'telugu'; 					  /* updates the table with soe specifications*/
update student set major ='tel' where major = 'telugu' or  major='hindi';     /* updates the table with soe specifications*/
delete from student where student_id >4 ; 									  /* deleting the specific rows*/

INSERT into employee values(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
select * from employee;
describe branch;

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

update employee 
set branch_id = 1
where emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);
select * from employee;
select * from branch;
select * from client;
select * from works_with;
select * from branch_supplier;

-- Find a list of employee and branch names
SELECT employee.first_name AS Employee_Branch_Names
FROM employee
UNION
SELECT branch.branch_name
FROM branch;

-- Find a list of all clients & branch suppliers' names
SELECT client.client_name AS Non_Employee_Entities, client.branch_id AS Branch_ID
FROM client
UNION
SELECT branch_supplier.supplier_name, branch_supplier.branch_id
FROM branch_supplier;



SELECT *
FROM employee
WHERE (birth_day >= '1970-01-01' AND sex = 'F') OR salary > 80000;

SELECT count(emp_id) from employee where sex ="F" and birth_day > '1971-01-01';

select * from client where branch_id =2;



