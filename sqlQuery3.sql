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
for select Basicsalary,HR,DA from employees where empid>2 ;

open cemployeesalary;

fetch next from cemployeesalary
into @cBasicsalary, @cHR, @cDA;

begin
update employees
set Grosssalary=(Basicsalary+HR+DA)*12;
end;

/*function*/
DECLARE @Num INT;
	CREATE FUNCTION Leap(@Num INT)
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
SELECT dbo.Leap(2000) as Result;

/*procedure*/
declare @variable int;
	create procedure getnumber(@variable int)
		As
		Begin
		select * from employees
		where empid=@variable;
	end;
execute getnumber 1;
