-- Exploring the healthcare_dataset
-- 1. Patient Demographics
-- Age Group Distribution
SELECT 
    CASE 
        WHEN Age BETWEEN 0 AND 18 THEN 'Children'
        WHEN Age BETWEEN 19 AND 35 THEN 'Young Adults'
        WHEN Age BETWEEN 36 AND 50 THEN 'Middle-Aged Adults'
        WHEN Age BETWEEN 51 AND 65 THEN 'Older Adults'
        ELSE 'Elderly'
    END AS Age_Group,
    COUNT(*) AS Patient_Count
FROM dup_healthcare_dataset
GROUP BY Age_Group
ORDER BY FIELD(Age_Group, 'Children', 'Young Adults', 'Middle-Aged Adults', 'Older Adults', 'Elderly');


-- Correlation Between Blood Type and Specific Medical Conditions
SELECT 
    Blood_Type, 
    Medical_Condition, 
    COUNT(*) AS Occurrence
FROM dup_healthcare_dataset
GROUP BY Blood_Type, Medical_Condition
ORDER BY Occurrence DESC;

-- 2. Health Outcomes
-- Most Common Medical Conditions
SELECT 
    Medical_Condition, 
    COUNT(*) AS Occurrence
FROM dup_healthcare_dataset
GROUP BY Medical_Condition;

-- 3. Financial Metrics
-- Total Revenue by Insurance Provider
SELECT 
    Insurance_Provider, 
    SUM(Billing_Amount) AS Total_Revenue
FROM dup_healthcare_dataset
GROUP BY Insurance_Provider
ORDER BY Total_Revenue DESC;

-- Total Revenue from Billing Amounts
SELECT 
    SUM(Billing_Amount) AS Total_Revenue
FROM dup_healthcare_dataset;

-- 5. Medication Insights
-- Most Prescribed Medications
SELECT 
    Medication, 
    COUNT(*) AS Prescription_Count
FROM dup_healthcare_dataset
GROUP BY Medication;

-- Medication by Condition
SELECT 
    Medical_Condition, 
    Medication, 
    COUNT(*) AS Count
FROM dup_healthcare_dataset
GROUP BY Medical_Condition, Medication;


