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


-- 1. Retrieve all patients treated in a specific department.
SELECT Department, SUM(Patients_Count) AS Total_patients
FROM hospital_analysis
GROUP BY Department
ORDER BY Total_patients DESC;

-- 2. Find total number of patients treated in each Location.
SELECT Location, SUM(Patients_Count) As Total_patients
FROM hospital_analysis
GROUP BY Location
ORDER BY Total_patients DESC;

-- 3. Calculate average patient stay duration.
SELECT AVG(DATEDIFF(Discharge_Date, Admission_Date)) As Avg_stay
FROM hospital_analysis;

-- 4. Highest medical expenses patient.
SELECT MAX(Medical_Expenses) AS Highest 
FROM hospital_analysis;

-- 5. Patients per department analysis.
SELECT Department, Patients_Count FROM hospital_analysis
ORDER BY Patients_Count DESC;

-- 6. For each group of Doctors, find one  treating maximum patients.
SELECT Doctors_Count, MAX(Patients_Count) As Maximum
FROM hospital_analysis
GROUP BY Doctors_Count 
ORDER BY Maximum DESC
LIMIT 1;

-- 7. Find the total medical expenses per department
SELECT Department, SUM(Medical_Expenses) As Total_expenses 
FROM hospital_analysis
GROUP BY Department
ORDER BY Total_expenses DESC;

-- 8. Find theLocation, Department and  average number of patients treated in each location.
SELECT 
    Location, 
    Department, 
    AVG(Patients_Count) AS avg_patients
FROM hospital_analysis
GROUP BY Location, Department
ORDER BY Location, avg_patients DESC;

-- 9. Group medical expenses by month of Admission_Date and calculate the total per month.
SELECT 
    DATE_FORMAT(Admission_Date, '%Y-%m') AS month,
    SUM(Medical_Expenses) AS total_expenses
FROM hospital_analysis
GROUP BY DATE_FORMAT(Admission_date, '%Y-%m')
ORDER BY month;

-- 10. Find the hospital with the longest admission duration
SELECT Hospital_Name, 
DATEDIFF(Discharge_Date, Admission_Date) AS Duration FROM hospital_analysis
ORDER BY Duration DESC;

-- 11. For each hospital, calculate the ratio of patients to doctors.
SELECT 
    Hospital_Name,
    CAST(Doctors_Count AS DECIMAL(10,2)) / 
    CAST(Patients_Count AS DECIMAL(10,2)) AS Ratio
FROM hospital_analysis
GROUP BY Hospital_Name, Doctors_Count, Patients_Count
ORDER BY Ratio DESC;

-- 12. Identify the hospital with the highest expenses
SELECT Hospital_Name, SUM(Medical_Expenses) As Expenses FROM hospital_analysis
GROUP BY Hospital_Name
ORDER BY Expenses DESC;

-- 13. FIND the AVG Medical expenses per derpartment
SELECT Department, AVG(Medical_Expenses) AS Avg_medical_expenses
FROM hospital_analysis
GROUP BY Department;

-- End of Project!










