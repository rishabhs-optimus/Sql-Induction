select salary from Employee
where salary< (select AVG(salary) from Employee);


select FirstName from Employee
where salary < (select MIN(salary) from Employee);

select FirstName from Employee
where salary <(select MAX(salary) from Employee);

select SUM(salary) from Employee;

select FirstName,Salary From Employee
UPDATE Employee
SET Salary=Salary+2000;

select FirstName,Salary From Employee
UPDATE Employee
SET Salary=Salary+2000;
/*Drop Department Table*/
Drop Table Departments;
SELECT COUNT(EmployeeId) AS Employeee FROM Employee
WHERE EmployeeId=2;
SELECT COUNT(EmployeeId) AS Employeee FROM Employee
WHERE EmployeeId=1;

select FirstName,LastName From Employee
Select UPPER(LastName) From Employee;

select FirstName,LastName From Employee
Select Lower(FirstName) From Employee;

SELECT LEN(FirstName) FROM Employee;


/*use of Null and Not Null*/
select * from rishabhss;
SELECT Last,First,Address FROM rishabhss
WHERE Address IS NOT NULL;
SELECT Last,First,Address FROM rishabhss
WHERE Address IS NULL;

/*view*/
create View view2 as
select FirstName,LastName from Employee
where salary > 30000;

select * from view2;

/*query top 5 highest salaries*/
SELECT * FROM Employee
WHERE 
(
  salary IN 
  (
    SELECT TOP (5) Salary FROM Employee
    GROUP BY salary
    ORDER BY salary DESC
  )
)

/*convert*/
SELECT FirstName,LastName,Salary CONVERT(VARCHAR(10),GETDATE(),110) from Employee;

/*getdate*/
SELECT *  GETDATE() AS CurrentDateTime from Employee;

/*Cast*/
select CAST(EmployeeId as decimal(10,3)) from Employee;

/*case statements*/
SELECT CASE
         WHEN Salary > 15000 and age< 35 THEN
          'YES'
            ELSE
          'NO'
       END as Type
FROM Employee;

/*cube*/
SELECT FirstName,LastName, SUM(Salary) AS QtySum
FROM Employee
GROUP BY FirstName, LastName WITH CUBE;

/*rollup*/

SELECT FirstName,LastName, SUM(Salary) AS QtySum
FROM Employee
GROUP BY FirstName, LastName WITH Rollup;

/*cluster index is created as soon as primary key is generated
the indexes put them in binary tree form
which makes it easier for searching
and hence searching is fast*/

/*group by commands*/
create table rishabh(
  empid int,
  depname varchar(20),
  depid varchar(20)
  );
  insert into rishabh values(1,'ui',201);
    insert into rishabh values(2,'ui',201);
      insert into rishabh values(3,'java',202);
        insert into rishabh values(4,'net',203);
        insert into rishabh values(5,'net',203);
  
select depname, depid, count(empid)
from rishabh
group by depname,depid
order by depname;
/*intersect*/
select * from Employee
Intersect
Select * from Employee
where Salary > 10000;

/*except*/
select * from Employee
Except
Select * from Employee
where Salary > 10000;

/*Corelated Subquery*/
SELECT CASE
         WHEN Salary > 15000 and age< 35 THEN
          'YES'
            ELSE
          'NO'
       END as Type
FROM Employee;
