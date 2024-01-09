

Page
2
of 2
-- Q1
begin transaction
set identity_insert Products on
go
insert into Products (ProductID, ProductName, CategoryID, UnitPrice)
values (2050, 'Mountain Dew', 1, 10);
rollback transaction
-- Q2
begin transaction
set identity_insert Products on
go
insert into Products (ProductID, ProductName, CategoryID, UnitPrice)
values (2051, 'Tea',(select CategoryId from Categories where CategoryName =
'Beverages') , 10);
rollback transaction
-- Q3
begin transaction
set identity_insert Products on
go
UPDATE Products
SET UnitPrice = UnitPrice * 1.25
WHERE CategoryID IN (
SELECT CategoryID
FROM Categories
WHERE CategoryName = 'Beverages'
);
rollback transaction
-- Q4
begin transaction
set identity_insert Categories on
go
insert into Categories(CategoryName)
values('Drinks')
select CategoryName from Categories
rollback transaction
-- Q5
begin transaction
set identity_insert Products off
go
INSERT INTO Products (ProductName, CategoryID, UnitPrice)
SELECT ProductName, (select CategoryId from Categories where CategoryName =
'Drinks') as DrinksCategoryId, UnitPrice
FROM Products
WHERE CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName =
'Beverages');
rollback transaction
-- Q6
begin transaction
UPDATE Products
SET CategoryID = (
SELECT CategoryID
FROM Categories
WHERE CategoryName = 'Drinks'
)
WHERE CategoryID = (
SELECT CategoryID
FROM Categories
WHERE CategoryName = 'Beverages'
);
rollback transaction
-- Q7
-- Step 1: Delete existing territory assignments of 'Nancy Davolio'
begin transaction
DELETE FROM EmployeeTerritories
WHERE EmployeeId = (SELECT EmployeeID FROM Employees WHERE (FirstName = 'Nancy' and
LastName = 'Davolio'))
-- Step 2: Insert new assignments for 'Nancy Davolio' based on the territories of
'Robert King'
INSERT INTO EmployeeTerritories (EmployeeID, TerritoryID)
SELECT (SELECT EmployeeID FROM Employees WHERE FirstName = 'Nancy' and LastName =
'Davolio'), TerritoryID
FROM EmployeeTerritories
WHERE EmployeeID = (SELECT EmployeeId FROM Employees WHERE FirstName = 'Robert' and
LastName = 'King');
rollback transaction
-- Q8
begin transaction
delete from Products
where CategoryID = (select CategoryID from Categories where CategoryName =
'Seafood') and UnitsInStock < 5
rollback
-- Q9
begin transaction
delete from [Order Details]
where OrderID in (select OrderID from Orders where CustomerID = 'ALFKI')
delete from Orders
where CustomerID = 'ALFKI'
rollback transaction
-- Q10
begin transaction
delete from [Order Details]
where OrderID in (select OrderID from Orders where (month(ShippedDate) = 8 and
year(ShippedDate) = 1996))
delete from Orders where (month(ShippedDate) = 8 and year(ShippedDate) = 1996)
rollback transaction
