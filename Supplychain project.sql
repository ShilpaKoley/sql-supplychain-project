CREATE DATABASE shilpa_sc_db;
USE shilpa_sc_db;
CREATE TABLE Suppliers (
    SupplierID INT,
    SupplierName VARCHAR(50),
    Country VARCHAR(50)
);
CREATE TABLE Materials (
    MaterialID INT,
    MaterialName VARCHAR(50)
);
CREATE TABLE PurchaseOrders (
    POID INT,
    SupplierID INT,
    MaterialID INT,
    OrderDate DATE,
    ExpectedDeliveryDate DATE,
    ActualDeliveryDate DATE,
    Quantity INT
);
INSERT INTO Suppliers VALUES
(1, 'Supplier A', 'China'),
(2, 'Supplier B', 'India'),
(3, 'Supplier C', 'Germany');
INSERT INTO Materials VALUES
(1, 'Component X'),
(2, 'Component Y'),
(3, 'Component Z');
INSERT INTO PurchaseOrders VALUES
(101, 1, 1, '2025-01-01', '2025-01-12', '2025-01-14', 100),
(102, 2, 3, '2025-01-05', '2025-01-20', '2025-01-19', 200),
(103, 3, 2, '2025-01-10', '2025-01-25', '2025-02-01', 150),
(104, 1, 3, '2025-01-20', '2025-02-05', '2025-02-04', 300),
(105, 2, 1, '2025-02-01', '2025-02-15', '2025-02-14', 180),
(106, 3, 3, '2025-02-05', '2025-02-25', '2025-02-28', 220),
(107, 1, 2, '2025-02-10', '2025-02-22', '2025-02-23', 130);
SELECT * FROM Suppliers;
SELECT * FROM Materials;
SELECT * FROM PurchaseOrders;


SELECT POID,
       SupplierID,
       DATEDIFF(ActualDeliveryDate, OrderDate) AS ActualLeadTime_Days
FROM PurchaseOrders;

SELECT POID,
       SupplierID,
       ExpectedDeliveryDate,
       ActualDeliveryDate,
       DATEDIFF(ActualDeliveryDate, ExpectedDeliveryDate) AS Delay_Days
FROM PurchaseOrders;

SELECT SupplierID,
       COUNT(*) AS TotalOrders,
       SUM(CASE WHEN ActualDeliveryDate <= ExpectedDeliveryDate THEN 1 ELSE 0 END)
           AS OnTimeOrders,
       ROUND(
         100.0 * SUM(CASE WHEN ActualDeliveryDate <= ExpectedDeliveryDate THEN 1 ELSE 0 END) 
         / COUNT(*),
         2
       ) AS OnTimeDeliveryPercentage
FROM PurchaseOrders
GROUP BY SupplierID;


SELECT SupplierID,
       ROUND(AVG(DATEDIFF(ActualDeliveryDate, ExpectedDeliveryDate)), 2) AS AvgDelayDays
FROM PurchaseOrders
GROUP BY SupplierID
HAVING AvgDelayDays > 0;