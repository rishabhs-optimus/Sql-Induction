CREATE DATABASE Assignment1;

--Assignment Table1

CREATE TABLE T_Product_Master
(
Product_Id VARCHAR(10) PRIMARY KEY,
Product_Name VARCHAR(20),
Cost_Per_Item INT
);

INSERT INTO T_Product_Master
VALUES('P1','Pen',10);
INSERT INTO T_Product_Master
VALUES('P2','Scale',15);
INSERT INTO T_Product_Master
VALUES('P3','NoteBook',25);

SELECT * FROM T_Product_Master;

--Assignment Table2

CREATE TABLE T_User_Master
(
User_Id VARCHAR(10) PRIMARY KEY,
User_Name VARCHAR(20),
);

INSERT INTO T_User_Master
VALUES('U1','Alfred Lawrence');
INSERT INTO T_User_Master
VALUES('U2','William Paul');
INSERT INTO T_User_Master
VALUES('U3','Edward Fillip');

SELECT * FROM T_User_Master;

--Assignment Table3

CREATE TABLE T_Transaction
(
User_Id VARCHAR(10) FOREIGN KEY REFERENCES T_User_Master(User_Id),
Product_Id VARCHAR(10) FOREIGN KEY REFERENCES T_Product_Master(Product_Id),
Transaction_Date DATE,
Transaction_Type VARCHAR(20),
Transaction_Amount INT
);

INSERT INTO T_Transaction
VALUES('U1','P1','2010-10-25','Order',150);
INSERT INTO T_Transaction
VALUES('U1','P1','2010-11-20','Payment',750);
INSERT INTO T_Transaction
VALUES('U1','P1','2010-11-20','Order',200);
INSERT INTO T_Transaction
VALUES('U1','P3','2010-11-25','Order',50);
INSERT INTO T_Transaction
VALUES('U3','P2','2010-11-26','Order',100);
INSERT INTO T_Transaction
VALUES('U2','P1','2010-12-15','Order',75);
INSERT INTO T_Transaction
VALUES('U3','P2','2011-01-15','Payment',250);


SELECT User_Id, Product_Id,CONVERT(VARCHAR(20), Transaction_Date, 105),
Transaction_Type, Transaction_Amount
FROM T_Transaction;

--Assignment Query

SELECT T_User_Master.User_Name, T_Product_Master.Product_Name,
OrderedQuantity, AmountPaid, LastTransactionDate, Balance 
FROM 
(SELECT T_Transaction.UserId,T_Transaction.Product_Id,
SUM(
CASE 
WHEN Transaction_Type='Order'
THEN Transaction_Amount
END) AS OrderedQuantity,

SUM(
CASE 
WHEN Transaction_Type='Payment'
THEN Transaction_Amount
ELSE 0
END) AS AmountPaid,

CONVERT(VARCHAR(20),MAX(Transaction_Date), 105) AS LastTransactionDate,

SUM(CASE WHEN Transaction_Type='Order' THEN Transaction_Amount*T_Product_Master.Cost_Per_Item
	ELSE -TransactionAmount
	END) AS Balance
FROM T_Transaction
JOIN T_Product_Master
ON T_Product_Master.Product_Id=T_Transaction.Product_Id
GROUP BY T_Transaction.User_Id,T_Transaction.Product_Id)
AS Subquery1
JOIN T_Product_Master
ON T_Product_Master.Product_Id=Subquery1.Product_Id
JOIN T_User_Master
ON T_User_Master.User_Id=Subquery1.User_Id;