CREATE DATABASE sql_project_2;

CREATE TABLE hospital_analysis(
    Hospital_Name VARCHAR(25),
    Location VARCHAR(25),
    Department VARCHAR(25),
    Doctors_Count INT,
    Patients_Count INT,
    Admission_Date DATE,
    Discharge_Date DATE,
    Medical_Expenses DECIMAL(12,2)
);

SELECT COUNT(*) FROM hospital_analysis;
-- Data Cleaning
SELECT * FROM hospital_analysis
WHERE Hospital_Name IS NULL
OR
Location IS NULL
OR
Department IS NULL
OR
Doctors_Count IS NULL
OR
Patients_Count IS NULL
OR 
Admission_Date IS NULL
OR 
Discharge_Date IS NULL
OR 
Medical_Expenses IS NULL;

-- Data Exploration
SELECT COUNT( DISTINCT Hospital_Name) AS total_hospital FROM hospital_analysis;

SELECT DISTINCT( Hospital_Name) FROM hospital_analysis;

SELECT * FROM hospital_analysis;

SELECT DISTINCT(Department) FROM hospital_analysis;

-- 1. Find the Total medical expenses
SELECT SUM(Medical_Expenses) As Total_expenses FROM hospital_analysis;

-- 2. FIND the AVG Medical expenses per derpartment
SELECT Department, AVG(Medical_Expenses) AS Avg_medical_expenses
FROM hospital_analysis
GROUP BY Department
ORDER BY Avg_medical_expenses DESC;

-- 3. Find the total medical expenses per department
SELECT Department, SUM(Medical_Expenses) As Total_expenses 
FROM hospital_analysis
GROUP BY Department
ORDER BY Total_expenses DESC;

-- 4. Identify the hospital with the highest expenses
SELECT Hospital_Name, SUM(Medical_Expenses) As Expenses FROM hospital_analysis
GROUP BY Hospital_Name
ORDER BY Expenses DESC;

-- 5. - For each hospital, calculate the ratio of patients to doctors.
SELECT 
    Hospital_Name,
    CAST(Doctors_Count AS DECIMAL(10,2)) / 
    CAST(Patients_Count AS DECIMAL(10,2)) AS Ratio
FROM hospital_analysis
GROUP BY Hospital_Name, Doctors_Count, Patients_Count
ORDER BY Ratio DESC;

-- 6 Find the hospital with the longest admission duration
SELECT Hospital_Name, 
DATEDIFF(Discharge_Date, Admission_Date) AS Duration FROM hospital_analysis
ORDER BY Duration DESC;

-- 7 Find top 5 Departments by Patient Count
SELECT Department, Patients_Count FROM hospital_analysis
ORDER BY Patients_Count DESC
LIMIT 5;

-- 8 Find the medical expenses above 40,000
SELECT * FROM hospital_analysis
WHERE Medical_Expenses >= 40000
ORDER BY Medical_Expenses DESC;

-- 9 - Group medical expenses by month of Admission_Date and calculate the total per month.
SELECT 
    DATE_FORMAT(Admission_Date, '%Y-%m') AS month,
    SUM(Medical_Expenses) AS total_expenses
FROM hospital_analysis
GROUP BY DATE_FORMAT(Admission_date, '%Y-%m')
ORDER BY month;

-- 10. Find theLocation, Department and  average number of patients treated in each location.
SELECT 
    Location, 
    Department, 
    AVG(Patients_Count) AS avg_patients
FROM hospital_analysis
GROUP BY Location, Department
ORDER BY Location, avg_patients DESC;

-- End of Project!




