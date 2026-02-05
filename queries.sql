-- *******************************************************************
-- SQL Queries to extract various data      
-- Database: hospitals                    
--  ********************************************************************

-- ----------------------------------------------------------------------------------------
-- 1. Print a list of all doctors based at a particular hospital.
-- ---------------------------------------------------------------------------------------
/* 
Example query using a specific HospitalID (HosptalID = 34) to demonstrate the approach

Option A: Using WHERE
uses only the doctors table
Hospital name is not available */

SELECT DoctorName, Role, HospitalID
FROM doctors
WHERE HospitalID = 34;

/*
Option B: Using INNER JOIN
to display the Hospital name */

SELECT DoctorName, Role, HospitalName
FROM doctors
INNER JOIN hospitals
ON doctors.HospitalID=hospitals.HospitalID
WHERE hospitals.HospitalID = 34 AND doctors.Role = 'Doctor'
ORDER BY DoctorName;

-- ----------------------------------------------------------------------------------------
-- 2. Print a list of all prescriptions for a particular patient, ordered by the prescription date.
-- ---------------------------------------------------------------------------------------
/*
Option A: Using WHERE (PatientID only)
uses the wildcard (*) to return all columns from the prescriptions table for a specific patient (PatientID = 312) */

SELECT *
FROM prescriptions
WHERE PatientID = 312
ORDER BY PrescriptionDate;

/*
Option B: Using INNER JOIN to also display the patient name.
Orders prescriptions by date in descending order */

SELECT PatientName, PrescriptionDate
FROM prescriptions
INNER JOIN patients
ON prescriptions.PatientID=patients.PatientID
WHERE patients.PatientID=312
ORDER BY PrescriptionDate DESC;

-- ----------------------------------------------------------------------------------------
-- 3. Print a list of all prescriptions that a particular doctor has prescribed.
-- ---------------------------------------------------------------------------------------

/*
Option A: Using WHERE
Returns all prescriptions for a specific doctor (DoktorID = 13) based only on the prescriptions table.
*/

SELECT DoctorID, Medication
FROM prescriptions
WHERE DoctorID = 13;

/*
Option B: Using INNER JOIN
Joins prescriptions with doctors to display the doctor's name (DoctorID = 13) along with the prescribed medication.
*/

SELECT DoctorName, Medication
FROM prescriptions
INNER JOIN doctors
ON prescriptions.DoctorID = doctors.DoctorID
WHERE prescriptions.DoctorID = 13;

-- ----------------------------------------------------------------------------------------
-- 4. Add a new patient to the database, including being registered with on of the doctors.
-- ---------------------------------------------------------------------------------------

/*
During the initial table creation, AUTO_INCREMENT was intentionally not used.

In the patients CSV file, PatientID values start at 100, so AUTO_INCREMENT was omitted 
to preserve the original IDs during data import.

The other tables (doctors, hospitals, prescriptions) start with ID values at 1, but AUTO_INCREMENT 
was also omitted to keep all IDs exactly as provided in the CSV files.

Reviewing the imported ID values for table patients

SELECT *
FROM patients
ORDER BY PatientID DESC
LIMIT 20;


After reviewing the imported ID values, AUTO_INCREMENT was added
to allow inserting new records without manually specifying the primary key.
This enables adding a new patient without providing a PatientID explicitly.


ALTER TABLE hospitals
MODIFY HospitalID INT unsigned NOT NULL AUTO_INCREMENT;

ALTER TABLE patients
MODIFY PatientID INT unsigned NOT NULL AUTO_INCREMENT;

ALTER TABLE prescriptions
MODIFY PrescriptionID INT unsigned NOT NULL AUTO_INCREMENT;

ALTER TABLE doctors
MODIFY DoctorID INT unsigned NOT NULL AUTO_INCREMENT;
*/



-- Inserts a new patient into the patients table.
-- Because PatientID is AUTO_INCREMENT, no primary key value is provided.
-- The patient is linked to an existing doctor via DoctorID = 59.


INSERT INTO patients (PatientName, DateOfBirth, Address, Role, DoctorID)
VALUES ('Tim Cook', '1960-11-01', 'One Apple Park Way, Cupertino, CA 95014', 'Patient', 59);

/*
If AUTO_INCREMENT had not been added, the primary key (PatientID) would have to be provided manually 
during INSERT operations. The second INSERT shows this alternative by explicitly specifying PatientID = 701.


INSERT INTO patients (PatientID, PatientName, DateOfBirth, Address, Role, DoctorID)
VALUES (701, 'Tim Cook', '1960-11-01', 'One Apple Park Way, Cupertino, CA 95014', 'Patient', 59);
*/

-- ----------------------------------------------------------------------------------------
-- 5. Intify which doctor has made the most prescriptions.
-- ---------------------------------------------------------------------------------------

-- Counts prescriptions per doctor and identifies the doctor with the highest number of prescriptions.

-- Option A: The query returns only the DoctorID.

SELECT DoctorID, COUNT(*) AS number_of_prescriptions
FROM prescriptions
GROUP BY DoctorID
ORDER BY number_of_prescriptions  DESC LIMIT 1;

-- Option B: Query joins the doctors table to display the doctor name.

SELECT DoctorName, prescriptions.DoctorID, COUNT(*) AS number_of_prescriptions
FROM prescriptions
INNER JOIN doctors
ON prescriptions.DoctorID = doctors.DoctorID
GROUP BY DoctorID
ORDER BY number_of_prescriptions  DESC LIMIT 1;

-- ----------------------------------------------------------------------------------------
-- 6. Print a list of all doctors at the hospital with biggest size (number of beds).
-- ---------------------------------------------------------------------------------------

/*
Selects all doctors working at the hospital with the largest size (number of beds),
using a subquery with MAX(Size).
*/

SELECT DoctorID, DoctorName, HospitalName
FROM hospitals  INNER JOIN doctors
ON hospitals.HospitalID = doctors.HospitalID
WHERE hospitals.Size = (SELECT MAX(Size) FROM hospitals)
ORDER BY DoctorID;

/*
Alternative approach using ORDER BY and LIMIT to identify the largest hospital 
before selecting its doctors.
*/

SELECT DoctorID, DoctorName, HospitalName, Size
FROM hospitals
INNER JOIN doctors
ON hospitals.HospitalID = doctors.HospitalID
WHERE hospitals.HospitalID = (
SELECT HospitalID
FROM hospitals
ORDER BY Size DESC
LIMIT 1);


