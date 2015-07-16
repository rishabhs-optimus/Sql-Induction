/* trigger on employees table*/
create table employees
(
empid int primary key,
basicsalary int,
hr int,
da int,
grosssalary int
);
/*truncate table*/
truncate table employees;
insert into employees values(1,10000,2000,3000,0);
insert into employees values(2,12000,3000,4000,0);
insert into employees values(3,40000,7000,5000,0);
insert into employees values(4,30000,10000,15000,0);
create trigger yes
on employees
after insert 
as
begin
update employees
set grosssalary=hr+basicsalary+da;
end;
select * from employees;

declare 
@cBasicsalary int,
@cHR int,
@cDA int;

declare 
cemployeesalary cursor 
for select Basicsalary,HR,DA from employees where empid>4 ;

open cemployeesalary;

fetch next from cemployeesalary
into @cBasicsalary, @cHR, @cDA;

begin
update employees
set Grosssalary=(Basicsalary+HR+DA)*12;
end;

// a function for checking leap year//
DECLARE @Num INT;
	CREATE FUNCTION Leapyear(@Num INT)
	RETURNS NVARCHAR(MAX)
	AS
	BEGIN
	DECLARE @Temp NVARCHAR(MAX);
	IF(@Num%400=0 )
	SET @Temp='LEAP YEAR';
	ELSE IF(@Num%100=0)
	SET @Temp= 'NOT A LEAP YEAR';
	ELSE IF(@Num%4=0)
	SET @Temp='LEAP YEAR'; 
	ELSE
	SET @Temp='NOT A LEAP YEAR';
	RETURN @Temp;
	END;
	GO
SELECT dbo.Leapyear(2000) as Result;

//procedure made for displaying details//
declare @variable int;
	create procedure getnumber(@variable int)
		As
		Begin
		select * from employees
		where empid=@variable;
	end;
execute getnumber 1;

CREATE PROCEDURE DivideByZero(@FirstNumber INT,@SecondNumber INT)
 AS
 BEGIN
BEGIN TRY
SELECT @FirstNumber%@SecondNumber
END TRY
BEGIN CATCH
SELECT
		ERROR_NUMBER() AS ErrorNumber
		,ERROR_SEVERITY() AS ErrorSeverity
		,ERROR_STATE() AS ErrorState
		,ERROR_PROCEDURE() AS ErrorProcedure
		,ERROR_LINE() AS ErrorLine
		,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
END
GO
EXECUTE DivideByZero 100,0;//parameters paased to the function//
