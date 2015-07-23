--database created
CREATE DATABASE Test1;

USE Test1;

GO;

--table created with name 
CREATE TABLE Vendor
(
VendorId INT PRIMARY KEY,
Name Varchar(25)
);

INSERT INTO Vendor Values
('101','Sai Travels');



INSERT INTO Vendor Values
('102','Meru Cabs');


INSERT INTO Vendor Values
('103','Miracle Cabs');

SELECT * FROM Vendor;


CREATE TABLE Cab
(
CabId INT PRIMARY KEY,
VendorId INT CONSTRAINT Vfkey
FOREIGN KEY REFERENCES Vendor(VendorId),
Number INT,
BrandName varchar(25)
);

INSERT INTO Cab Values
('201', '101', '8529', 'Mercedes'); 


INSERT INTO Cab Values
('202', '103', '5764', 'Jaguar'); 


INSERT INTO Cab Values
('203', '101', '1967', 'Lambhorgini'); 


INSERT INTO Cab Values
('204', '102', '7359', 'Mercedes');


INSERT INTO Cab Values
('205', '103', '1992', 'Audi'); 


INSERT INTO Cab Values
('206', '103', '0786', 'BMW'); 


INSERT INTO Cab Values
('207', '101', '0007', 'Audi'); 


INSERT INTO Cab Values
('208', '102', '8541', 'Fiat'); 

SELECT * FROM Cab;

CREATE TABLE User1
(
UserId INT PRIMARY KEY IDENTITY(301,1),
Name1 Varchar(250),
Gender Varchar(2)
);

INSERT INTO User1 VALUES
('Ravi', 'M');

INSERT INTO User1 VALUES
('Kavi', 'F');

INSERT INTO User1 VALUES
('Abhi', 'M');

INSERT INTO User1 VALUES
('Savita', 'F');

INSERT INTO User1 VALUES
('Gopal', 'M');

INSERT INTO User1 VALUES
('Bhopal', 'M');

INSERT INTO User1 VALUES
('Dolly', 'F');

INSERT INTO User1 VALUES
('Tanu', 'F');

INSERT INTO User1 VALUES
('Prince', 'M');

INSERT INTO User1 VALUES
('Raj Kishore', 'M');

SELECT * FROM User1;
drop table Tbookings;
CREATE TABLE TBookings
(
BookingId INT PRIMARY KEY IDENTITY(401,1),
CabId INT CONSTRAINT FKeyCab
FOREIGN KEY REFERENCES Cab(CabId),
UserId INT CONSTRAINT FKeyUser
FOREIGN KEY REFERENCES User1(UserId),
Fare INT,
Distance Float,
PickupTime DATETIME,
DropTime DATETIME,
Rating INT
);

INSERT INTO TBookings VALUES
('204', '309', '101', '13', '2015-04-07 19:00:00', '2015-04-07 19:30:00', '5');


INSERT INTO TBookings VALUES
('205', '301', '105', '15.2', '2015-05-11 09:15:00', '2015-05-11 10:00:00', '3');


INSERT INTO TBookings VALUES
('204', '309', '2000', '190', '2015-03-19 20:45:00', '2015-03-20 01:00:00', '2');
 


INSERT INTO TBookings VALUES
('201', '302', '1995', '150', '2015-07-07 11:00:00', '2015-07-07 15:00:00', '5');


INSERT INTO TBookings VALUES
('204', '303', '553', '50', '2014-09-12 19:00:00', '2014-09-12 22:15:00', '2');


INSERT INTO TBookings VALUES
('202', '302', '465', '45', '2015-01-07 9:00:00', '2015-01-07 9:40:00', '1');


INSERT INTO TBookings VALUES
('205', '304', '258', '20', '2015-07-02 3:00:00', '2015-07-02 3:15:00', '4');


INSERT INTO TBookings VALUES
('202', '309', '125', '15', '2015-06-23 9:00:00', '2015-06-23 10:00:00', '5');


INSERT INTO TBookings VALUES
('204', '310', '1462', '30', '2015-02-05 6:00:00', '2015-02-05 8:00:00', '4');


INSERT INTO TBookings VALUES
('207', '306', '1876', '60', '2015-01-29 15:00:00', '2015-01-29 18:00:00', '1');


INSERT INTO TBookings VALUES
('203', '308', '1145', '100', '2015-06-04 20:00:00', '2015-06-05 6:00:00', '0');


INSERT INTO TBookings VALUES
('206', '309', '1358', '90', '2015-01-19 02:00:00', '2015-01-19 08:00:00', '1');


INSERT INTO TBookings VALUES
('208', '301', '102', '5', '2015-03-21 11:00:00', '2015-03-21 11:15:00', '5');


INSERT INTO TBookings VALUES
('206', '309', '503', '50', '2015-02-28 08:00:00', '2015-02-28 10:00:00', '4');


INSERT INTO TBookings VALUES
('204', '304', '786', '62', '2015-03-09 16:00:00', '2015-03-09 19:00:00', '3');


INSERT INTO TBookings VALUES
('208', '306', '143', '3', '2015-04-09 11:30:00', '2015-04-09 11:45:00', '2');


INSERT INTO TBookings VALUES
('203', '309', '658', '12', '2015-05-04 01:00:00', '2015-05-04 01:45:00', '0');


INSERT INTO TBookings VALUES
('206', '308', '852', '17', '2015-02-18 15:00:00', '2015-02-18 16:00:00', '1');



INSERT INTO TBookings VALUES
('208', '301', '450', '22', '2015-03-11 18:00:00', '2015-03-12 10:00:00', '4');


INSERT INTO TBookings VALUES
('204', '309', '420', '29', '2015-02-17 11:00:00', '2015-02-17 21:00:00', '1');

SELECT * FROM TBookings;



--query3
SELECT Name1 From User1 JOIN(
Select TOP 3 UserId, COUNT(UserId) as NumberOfTimes
From TBookings  
Group by UserId 
order by NumberOfTimes desc)as
Tempvariable
on User1.UserId = Tempvariable.UserId;


--query2
select Number, BrandName from Cab JOIN(
Select TOP 1 CabId,COUNT(CabId) as NumberOfTimesBooked
from TBookings
group by CabId
order by NumberOfTimesBooked desc)as T
on Cab.CabId=T.CabId;

--query9
Select Number, BrandName from Cab JOIN(
SELECT TOP 1 CabId,AVG(Fare) as AverageFare
FROM TBookings
GROUP BY CabId
order By AverageFare)
As Subquery1 on Subquery1.CabId=Cab.CabId;





--query4
Select Vendor.Name As VendorsName,subquery3.Name1
As UserName,NumberOfBookings From(
Select Name1,VendorId,NumberOfBookings From(
Select VendorId,NumberOfBookings,UserId From
(
SELECT CabId,UserId,COUNT(CabId) As NumberOfBookings
from TBookings
Group By CabId,UserId) as Subquery
JOIN
Cab on Subquery.CabId=Cab.CabId) As subquery2
JOIN
User1 On
subquery2.UserId=User1.UserId)
As Subquery3
Join
Vendor on Vendor.VendorId=Subquery3.VendorId 
order by Vendor.Name;




--query6
Select VendorId,SUM(AverageRating)/COUNT(Subquery1.CabId)
As Rating 
From Cab Join
(Select CabId,AVG(Rating) as AverageRating
From TBookings
group by CabId)as Subquery1
on Cab.CabId=Subquery1.CabId
Group by VendorId;





--query5
Select Gender,BrandName,Number From
(Select UserId, BrandName, Number, Subquery1.CabId From
(Select UserId, CabId, RANK()over(partition by UserId
order by CabId) 
As RankOfCabId from TBookings)
As Subquery1
Join Cab on
Subquery1.CabId = Cab.CabId)
As Subquery2
Join User1 on Subquery2.UserId = User1.UserId;


--query1
select Name1, BrandName, Number, TravelTime
from
(select BrandName,Number,Cab.CabId,UserId,DATEDIFF(MI,PickupTime,DropTime)As
TravelTime
From
TBookings join Cab
on 
TBookings.CabId=Cab.CabId
where Fare Between 500 And 1000) As Subquery1 Join User1
on User1.UserId=Subquery1.UserId;


--query8
SELECT VendorId ,COUNT(Temp.CabId)AS NumOfCabs FROM Cab JOIN(
SELECT CabId ,CONVERT(DATE,PickupTime)as BookingDate FROM TBookings WHERE 
CONVERT(DATE,PickupTime)='2015-02-28')AS Temp ON Cab.CabId=Temp.CabId GROUP BY VendorId