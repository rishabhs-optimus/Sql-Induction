/*Select*/
select * from Employee;

select Distinct(FirstName) from Employee;

select Distinct(Designation) from Employee;

select EmployeeId,FirstName,LastName From Employee
where Salary < 20000;

select  EmployeeId,FirstName,LastName From Employee
where Salary > 50000 And Age < 35;

select  EmployeeId,FirstName,LastName From Employee
where Salary > 50000 And (Designation='Managers' Or Designation='Techleads');

select EmployeeId,FirstName,LastName,Salary From Employee
Order By FirstName;

Select EmployeeId,Salary,Designation From Employee
Update Employee
SET Designation='Manager', Salary=50000
WHERE Salary >40000 AND Age > 35;

select Top 3 Salary From Employee;

select FirstName From Employee
where FirstName LIKE'R%';

select FirstName From Employee
where FirstName LIKE'K%';

select Salary From Employee
where EmployeeId In(1,2);

select Salary From Employee
where Salary BETWEEN 10000 AND 55000;

select Salary As SalaryofEmployee From Employee;

SELECT Employee.FirstName, Orders.OrderId
FROM Employee
INNER JOIN Orders
ON Employee.EmployeeId=Orders.EmployeeId
ORDER BY Employee.FirstName;

SELECT Employee.FirstName, Orders.OrderId
FROM Employee
FULL OUTER JOIN Orders
ON Employee.EmployeeId=Orders.EmployeeId
ORDER BY Employee.FirstName;

SELECT Employee.FirstName, Orders.OrderId
FROM Employee
LEFT JOIN Orders
ON Employee.EmployeeId=Orders.EmployeeId
ORDER BY Employee.FirstName;

SELECT Employee.FirstName, Orders.OrderId
FROM Employee
RIGHT JOIN Orders
ON Employee.EmployeeId=Orders.EmployeeId
ORDER BY Employee.FirstName;

ALTER TABLE Customer
ADD PRIMARY KEY (CustomerId);


CREATE UNIQUE INDEX indexc
ON Employee(FirstName);

CREATE UNIQUE INDEX indexv
ON Employee(LastName);

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
