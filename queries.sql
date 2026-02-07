-- *******************************************************************
-- SQL queries to retrieve and analyse data from the hospitals database                    
--  ********************************************************************

-- ----------------------------------------------------------------------------------------
-- 1. Print a list of all doctors based at a particular hospital.
-- ---------------------------------------------------------------------------------------

-- HospitalID (HosptalID = 34)

-- Option A: WHERE-based query (single table)
-- Uses the doctors table only.
-- The hospital name is not included because no join is performed.

SELECT DoctorName, Role, HospitalID
FROM doctors
WHERE HospitalID = 34;


-- Option B: Uses an INNER JOIN to include the hospital name.
-- Filters doctors by HospitalID and restricts the result to records where the role is Doctor (even if 
-- the doctors table currently contains only doctors).

SELECT DoctorName, Role, HospitalName, doctors.HospitalID
FROM doctors
INNER JOIN hospitals
ON doctors.HospitalID=hospitals.HospitalID
WHERE hospitals.HospitalID = 34 AND doctors.Role = 'Doctor'
ORDER BY DoctorName;

-- This query works without filtering by Role, because the doctors table contains only doctors.
-- The INNER JOIN is used only to include the hospital name.

SELECT DoctorName, Role, HospitalName, doctors.HospitalID
FROM doctors
INNER JOIN hospitals
ON doctors.HospitalID=hospitals.HospitalID
WHERE hospitals.HospitalID = 34
ORDER BY DoctorName;

-- ----------------------------------------------------------------------------------------
-- 2. Print a list of all prescriptions for a particular patient, ordered by the prescription date.
-- ---------------------------------------------------------------------------------------

-- Patient (PatientID = 312)

-- Option A: WHERE-based query (single table).
-- Uses the prescriptions table only.
-- The wildcard (*) selects all columns from the prescriptions table for the specified patient.
-- Results are ordered by PrescriptionDate in ascending order.

SELECT *
FROM prescriptions
WHERE PatientID = 312
ORDER BY PrescriptionDate;


-- Option B: JOIN-based query.
-- Uses an INNER JOIN between prescriptions and patients.
-- Returns only the selected columns (PatientName and PrescriptionDate),
-- adding the patient's name to the result.
-- Results are ordered by PrescriptionDate in descending order.

SELECT PatientName, prescriptions.PatientID, PrescriptionDate
FROM prescriptions
INNER JOIN patients
ON prescriptions.PatientID=patients.PatientID
WHERE patients.PatientID=312
ORDER BY PrescriptionDate DESC;

-- ----------------------------------------------------------------------------------------
-- 3. Print a list of all prescriptions that a particular doctor has prescribed.
-- ---------------------------------------------------------------------------------------

-- Option A: WHERE-based query (single table)
-- Uses the prescriptions table only and filters rows where DoctorID = 13,
-- returning all medications prescribed by this doctor.

SELECT DoctorID, Medication
FROM prescriptions
WHERE DoctorID = 13;


-- Option B: JOIN-based query.
-- Uses an INNER JOIN between prescriptions and doctors (on DoctorsI).
-- Returns the doctor's name together with the prescribed medication for the specified doctor (DoctorID = 13).

SELECT DoctorName, prescriptions.DoctorID, Medication
FROM prescriptions
INNER JOIN doctors
ON prescriptions.DoctorID = doctors.DoctorID
WHERE prescriptions.DoctorID = 13;


-- ----------------------------------------------------------------------------------------
-- 4. Add a new patient to the database, including being registered with on of the doctors.
-- ---------------------------------------------------------------------------------------

-- Inserts a new record into the patients table.
-- The primary key (PatientID) is generated automatically by AUTO_INCREMENT, so it is not included in the INSERT statement.
-- The patient is linked to an existing doctor via DoctorID = 59.

INSERT INTO patients (PatientName, DateOfBirth, Address, Role, DoctorID)
VALUES ('Tim Cook', '1960-11-01', 'One Apple Park Way, Cupertino, CA 95014', 'Patient', 59);


-- ----------------------------------------------------------------------------------------
-- 5. Intify which doctor has made the most prescriptions.
-- ---------------------------------------------------------------------------------------

-- Option A: Aggregation-based query.
-- Groups prescriptions by DoctorID and counts how often each DoctorID appears,
-- orders the result by this count in descending order, and returns only the first row.

SELECT DoctorID, COUNT(*) AS number_of_prescriptions
FROM prescriptions
GROUP BY DoctorID
ORDER BY number_of_prescriptions DESC LIMIT 1;


-- Option B: JOIN-based query.
-- Uses an INNER JOIN between prescriptions and doctors.
-- Groups rows by DoctorID and uses COUNT(*) to calculate how many times each DoctorID appears in the prescriptions table.
-- Includes the doctor's name, orders by this count in descending order, and returns only the first row (the DoctorID with the
-- highest number of prescriptions).

SELECT DoctorName, prescriptions.DoctorID, COUNT(*) AS number_of_prescriptions
FROM prescriptions
INNER JOIN doctors
ON prescriptions.DoctorID = doctors.DoctorID
GROUP BY DoctorID
ORDER BY number_of_prescriptions DESC LIMIT 1;

-- ----------------------------------------------------------------------------------------
-- 6. Print a list of all doctors at the hospital with biggest size (number of beds).
-- ---------------------------------------------------------------------------------------

-- Uses a subquery to identify the hospital with the maximum size.
-- Selects all doctors working at that hospital.
-- Joins hospitals and doctors using HospitalID.

SELECT DoctorID, DoctorName, HospitalName, Size
FROM hospitals
INNER JOIN doctors
ON hospitals.HospitalID = doctors.HospitalID
WHERE hospitals.Size = (SELECT MAX(Size) FROM hospitals)
ORDER BY DoctorID;

-- Alternative approach using ORDER BY DESC and LIMIT.
-- The subquery selects the HospitalID from hospitals, ordered by Size in descending order and limited to one row (the largest hospital).
-- The outer query joins hospitals and doctors via HospitalID and returns all doctors at the hospital with the largest size.

SELECT DoctorID, DoctorName, HospitalName, Size
FROM hospitals
INNER JOIN doctors
ON hospitals.HospitalID = doctors.HospitalID
WHERE hospitals.HospitalID = (SELECT HospitalID FROM hospitals
ORDER BY Size DESC
LIMIT 1);


