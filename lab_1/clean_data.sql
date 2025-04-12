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

-- Diagnose issues
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(Description) AS Description_nulls,
    COUNT(*) - COUNT(CustomerID) AS CustomerID_nulls,
    SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity_rows,
    SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS invalid_unitprice_rows
FROM Online_Retail;

-- Imputation for NULLs
UPDATE Online_Retail SET CustomerID = -1 WHERE CustomerID IS NULL;
UPDATE Online_Retail SET Description = 'unknown product' WHERE Description IS NULL;

-- Remove inconsistent transactions
DELETE FROM Online_Retail WHERE Quantity <= 0 OR UnitPrice <= 0;

-- Add calculated feature (TotalValue)
ALTER TABLE Online_Retail ADD COLUMN TotalValue FLOAT;
UPDATE Online_Retail SET TotalValue = Quantity * UnitPrice;

-- Final check after cleaning
SELECT
    COUNT(*) AS total_cleaned_rows,
    COUNT(*) - COUNT(Description) AS Description_nulls,
    COUNT(*) - COUNT(CustomerID) AS CustomerID_nulls,
    SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity_rows,
    SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS invalid_unitprice_rows
FROM Online_Retail;