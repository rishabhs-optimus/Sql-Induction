CREATE DATABASE Assignment2;

--AssignmentTable1

CREATE TABLE T_Emp
(
EmpId INT PRIMARY KEY IDENTITY(1001,2),
Emp_Code VARCHAR(20),
EmpFirstName VARCHAR(20) NOT NULL,
EmpMiddleName VARCHAR(20),
EmpLastName VARCHAR(20) NOT NULL,
EmpDOB DATE CHECK((YEAR(GETDATE())-YEAR(EmpDOB))>=18),
Emp_DateOfJoining date NOT NULL
);

INSERT INTO T_Emp(Emp_Code,EmpFirstName,EmpMiddleName,EmpLastName,EmpDOB,Emp_DateOfJoining)
VALUES('OPT20110105','Manmohan','','Singh','1983-02-10','2010-05-25');

INSERT INTO T_Emp(Emp_Code,EmpFirstName,EmpMiddleName,EmpLastName,EmpDOB,Emp_DateOfJoining)
VALUES('OPT20110105','Alfred','Joseph','Lawrence','1988-02-28','2011-06-24');


SELECT * FROM T_Emp;

--AssignmentTable2

CREATE TABLE  TableActivity
(
ActivityId INT PRIMARY KEY,
Activity_Description VARCHAR(20)
);

INSERT INTO TableActivity
VALUES('1','Code Analysis');
INSERT INTO  TableActivity
VALUES('2','Lunch');
INSERT INTO  TableActivity
VALUES('3','Coding');
INSERT INTO  TableActivity
VALUES('4','Knowledge Transition');
INSERT INTO  TableActivity
VALUES('5','Database');

SELECT * FROM  TableActivity;

--AssignmentTable3

CREATE TABLE TAtten
(
AttendanceId INT PRIMARY KEY IDENTITY(1001,1),
EmpId INT FOREIGN KEY REFERENCES T_Emp(EmpId) ,
ActivityId INT FOREIGN KEY REFERENCES TableActivity(ActivityId) ,
AttenStartTime DATETIME,
AttenEndHrs INT
);

INSERT INTO TAtten(EmpId,ActivityId,AttenStartTime,AttenEndHrs)
VALUES(1001,5,'2011/2/13 10:00:00',2);
INSERT INTO TAtten(EmpId,ActivityId,AttenStartTime,AttenEndHrs)
VALUES(1001,1,'2011/1/14 10:00:00',3);
INSERT INTO TAtten(EmpId,ActivityId,AttenStartTime,AttenEndHrs)
VALUES(1001,3,'2011/1/14 13:00:00',5);
INSERT INTO TAtten(EmpId,ActivityId,AttenStartTime,AttenEndHrs)
VALUES(1003,5,'2011/2/16 10:00:00',8);
INSERT INTO TAtten(EmpId,ActivityId,AttenStartTime,AttenEndHrs)
VALUES(1003,5,'2011/2/17 10:00:00',8);
INSERT INTO TAtten(EmpId,ActivityId,AttenStartTime,AttenEndHrs)
VALUES(1003,5,'2011/2/19 10:00:00',7);


SELECT * FROM TAtten;


--AssignmentTable 4

CREATE TABLE TSalary
(
Salary_Id INT PRIMARY KEY,
EmpId INT FOREIGN KEY REFERENCES T_Emp(EmpId),
ChangetheSalary date,
NewSalary FLOAT
);

INSERT INTO TSalary
VALUES(1001,1003,'2011-02-16',20000.00);
INSERT INTO TSalary
VALUES(1002,1003,'2011-01-05',25000.00);
INSERT INTO TSalary
VALUES(1003,1001,'2011-02-16',26000.00);

SELECT * FROM TSalary;

--Query1

SELECT * FROM(
SELECT EmpFirstName+' '+EmpMiddleName+' '+EmpLastName AS Name,
CASE
WHEN MONTH(EmpDOB)IN(1,3,5,7,8,10,12) AND DAY(EmpDOB)=31
THEN EmpDOB
WHEN MONTH(EmpDOB)IN(4,6,9,11) AND DAY(EmpDOB)=30
THEN EmpDOB
WHEN MONTH(EmpDOB)=2
AND DAY(EmpDOB)=28
THEN EmpDOB
END AS DateOfBirth
FROM T_Emp)AS S
WHERE S.DateOfBirth IS NOT NULL

--Query2

SELECT EmpFirstName+' '+EmpMiddleName+' '+EmpLastName AS Name,
Increment,PreviousSalary,CurrentSalary, TotalWorkedHours,
Sub2.ActivityId AS LastWorkedId, Sub2.AttenEndHrs AS LastHourWorked
FROM(
SELECT EmpId,
CASE
	WHEN COUNT(EmpId)>1 
	THEN 'Yes'
	ELSE 'No'
END AS Increment,
CASE
	WHEN COUNT(EmpId)>1 
	THEN MIN(NewSalary)
	ELSE 0
END AS PreviousSalary,
MAX(NewSalary) AS CurrentSalary
FROM TSalary
GROUP BY EmpId) AS Subquery1

JOIN T_Emp
ON T_Emp.EmpId=Subquery1.EmpId

JOIN
(
SELECT EmpId, SUM(AttenEndHrs)AS TotalWorkedHours
FROM TAtten
GROUP BY EmpId
) AS Subquery2
ON Subquery1.EmpId=Subquery2.EmpId


JOIN  (SELECT Sub1.EmpId,ActivityId,AttenEndHrs 
       FROM TAtten AS Sub1
	   JOIN (SELECT EmpId, MAX(AttenStartTime)m  
	   FROM TAtten GROUP BY EmpId)AS Sub
	   ON Sub.EmpId=Sub1.EmpId 
	   WHERE Sub1.AttenStartTime=Sub.m) AS Sub2
ON Sub2.EmpId=T_Emp.EmpId




