-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
SELECT DISTINCT [Product].ProductName, [Category].CategoryName
FROM [Product]
    INNER JOIN [Category] ON [Product].CategoryId = [Category].Id;

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.
SELECT [Order].Id, [Shipper].CompanyName
FROM [Order]
    INNER JOIN [Shipper] ON [Order].ShipVia = [Shipper].Id
WHERE [Order].OrderDate < '2012-08-09';

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
SELECT [Product].ProductName, [OrderDetail].Quantity
FROM [OrderDetail]
    INNER JOIN [Product] ON [OrderDetail].ProductId = [Product].Id
WHERE [OrderDetail].OrderId = 10251
ORDER BY [Product].ProductName;

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
SELECT [Order].Id, [Customer].CompanyName, [Employee].LastName
FROM (([Order]
    INNER JOIN [Customer] ON [Order].CustomerId = [Customer].Id)
    INNER JOIN [Employee] ON [Order].EmployeeId = [Employee].Id);

-- ******************  Stretch  ******************
-- Displays CategoryName and a new column called Count that shows how many products are in each category.Shows 8 records.
SELECT
    CategoryName,
    Count(C.CategoryID) as "Count"
FROM Products as P
    JOIN Categories as C ON P.CategoryID = C.CategoryID
GROUP BY
  CategoryName;
-- or
SELECT CategoryName, Count([Categories].CategoryID) as "Count"
FROM Products
    JOIN [Categories] ON [Products].CategoryID = [Categories].CategoryID
GROUP BY CategoryName;
--Display OrderID and a column called ItemCount that shows the total number of products placed on the order.Shows 196 records.

SELECT OrderID, SUM([OrderDetails].Quantity) as "ItemCount"
FROM [OrderDetails] JOIN [Orders] ON [OrderDetails].OrderID = [Orders].OrderID
GROUP BY OrderID;