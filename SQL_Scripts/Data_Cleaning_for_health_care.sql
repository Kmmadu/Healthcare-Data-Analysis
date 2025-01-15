CREATE DATABASE IF NOT EXISTS healthcare_db;
USE healthcare_db;
-- Data Cleaning 
-- Creating a staging table, so as to keep the raw data
CREATE TABLE IF NOT EXISTS dup_healthcare_dataset LIKE healthcare_dataset;

INSERT INTO dup_healthcare_dataset
SELECT *
FROM healthcare_dataset;

SELECT *
FROM dup_healthcare_dataset;

ALTER TABLE dup_healthcare_dataset ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;


-- Checking and Removing Duplicates
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY Name, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results
           ORDER BY Age DESC
       ) AS dup_check
FROM dup_healthcare_dataset;

WITH ranked_duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Name, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results
               ORDER BY Age DESC
           ) AS dup_check
    FROM dup_healthcare_dataset
)
DELETE FROM dup_healthcare_dataset
WHERE id IN (
    SELECT id
    FROM ranked_duplicates
    WHERE dup_check > 1
);

-- Formating and Standardizing Data
UPDATE dup_healthcare_dataset
SET `Name` = CONCAT(UPPER(SUBSTRING(`Name`, 1, 1)), LOWER(SUBSTRING(`Name`, 2)));

UPDATE dup_healthcare_dataset
SET 
    Date_of_Admission = STR_TO_DATE(Date_of_Admission, '%m/%d/%Y'),
    Discharge_Date = STR_TO_DATE(Discharge_Date, '%m/%d/%Y');

SELECT * FROM dup_healthcare_dataset
WHERE Date_of_Admission > Discharge_Date;

-- Handling Null Values:
SELECT *
FROM dup_healthcare_dataset
WHERE Name IS NULL OR Name = ''
   OR Age IS NULL
   OR Gender IS NULL OR Gender = ''
   OR Billing_Amount IS NULL;

DELETE FROM dup_healthcare_dataset
WHERE Name IS NULL OR Name = ''
   OR Date_of_Admission IS NULL
   OR Discharge_Date IS NULL;


-- Removing Unnecessary Columns Or Rows

ALTER TABLE dup_healthcare_dataset
DROP COLUMN id;


SELECT *
FROM dup_healthcare_dataset;
