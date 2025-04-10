-- SQLite
SELECT count(*)
FROM Online_Retail;

PRAGMA table_info(Online_Retail);

SELECT
  COUNT(*) - COUNT(InvoiceNo) AS InvoiceNo_nulls,
  COUNT(*) - COUNT(StockCode) AS StockCode_nulls,
  COUNT(*) - COUNT(Description) AS Description_nulls,
  COUNT(*) - COUNT(Quantity) AS Quantity_nulls,
  COUNT(*) - COUNT(InvoiceDate) AS InvoiceDate_nulls,
  COUNT(*) - COUNT(UnitPrice) AS UnitPrice_nulls,
  COUNT(*) - COUNT(CustomerID) AS CustomerID_nulls,
  COUNT(*) - COUNT(Country) AS Country_nulls
FROM Online_Retail;
--135080 null values in customer ID
--1454 null values in Description

-- Count null values and invalid rows
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(Description) AS Description_nulls,
    COUNT(*) - COUNT(CustomerID) AS CustomerID_nulls,
    SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity_rows,
    SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS invalid_unitprice_rows
FROM Online_Retail;
