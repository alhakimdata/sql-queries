-- Show first name, last name, and gender of patients whose gender is 'M'.

SELECT
	first_name,
    last_name,
    gender
FROM patients
WHERE gender = 'M';

-- Show first name and last name of patients who does not have allergies. (null)

SELECT
	first_name,
    last_name
FROM patients
WHERE allergies IS null;

-- Show first name of patients that start with the letter 'C'

SELECT
	first_name
FROM patients
WHERE first_name LIKE 'C%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

SELECT
	first_name,
    last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS null;

-- Show first name and last name concatinated into one column to show their full name.

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- Show first name, last name, and the full province name of each patient.
-- Example: 'Ontario' instead of 'ON'

SELECT
	first_name,
    last_name,
    province_name
FROM patients p 
JOIN province_names pn
ON p.province_id = pn.province_id;

-- Show how many patients have a birth_date with 2010 as the birth year.

SELECT
	COUNT(birth_date) AS total_birth_year
FROM patients
WHERE YEAR(birth_date) = 2010;

-- Show the first_name, last_name, and height of the patient with the greatest height.

SELECT
	first_name,
    last_name,
    MAX(height) AS greatest_height
FROM patients;

-- Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000

SELECT
	*
FROM patients
WHERE patient_id IN (1,45,534,879,1000);

-- Show the total number of admissions

SELECT
	COUNT(*) AS total_admissions
FROM admissions;

-- Show all the columns from admissions where the patient was admitted and discharged on the same day.

SELECT
	*
FROM admissions
WHERE admission_date = discharge_date;

-- Show the patient id and the total number of admissions for patient_id 579.

SELECT
	patient_id,
    COUNT(patient_id) AS total_admissions
FROM admissions
WHERE patient_id = 579;

-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

SELECT
	DISTINCT(city)
FROM patients
WHERE province_id = 'NS';

-- Alternative query is using the GROUP BY and HAVING

SELECT
	city
FROM patients
GROUP BY city
HAVING province_id = 'NS';

-- Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

SELECT
	first_name,
    last_name,
    birth_date
FROM patients
WHERE height > 160 AND weight > 70;

-- Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null

SELECT
	first_name,
    last_name,
    allergies
FROM patients
WHERE city = 'Hamilton' AND allergies IS NOT null;

-- Show unique birth years from patients and order them by ascending.

SELECT
	DISTINCT(YEAR(birth_date)) AS birth_year
FROM patients
ORDER BY birth_year ASC;

-- Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then do not include their name in the output list. If only 1 person is named 'Leo' then include them in the output.

SELECT
	first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

SELECT
	patient_id,
    first_name
FROM patients
WHERE first_name LIKE 's____%s';

-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
-- Primary diagnosis is stored in the admissions table.

SELECT
	p.patient_id,
    first_name,
    last_name
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
WHERE diagnosis = 'Dementia';

-- Display every patient's first_name.
-- Order the list by the length of each name and then by alphbetically

SELECT
	first_name
FROM patients
ORDER BY LEN(first_name), first_name ASC;

-- Show the total amount of male patients and the total amount of female patients in the patients table.
-- Display the two results in the same row.

--Show the total amount of male patients and the total amount of female patients in the patients table.
--Display the two results in the same row.

SELECT
	SUM(gender = 'M') AS male_count,
	SUM(gender = 'F') AS female_count
FROM patients;

-- Alternatively

SELECT
	SELECT
     	COUNT(*)
     FROM patients
     WHERE gender = 'M') AS male_count,
    SELECT
     	COUNT(*)
     FROM patients
     WHERE gender = 'F') AS female_count;

-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

SELECT
	first_name,
    last_name,
    allergies
FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies , first_name, last_name;

-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT
	patient_id,
    diagnosis
FROM admissions
GROUP BY patient_id,
	diagnosis
HAVING COUNT(diagnosis) > 1;

-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.

SELECT
	city,
    COUNT(*) as total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;

-- Show first name, last name and role of every person that is either patient or doctor.
-- The roles are either "Patient" or "Doctor"

SELECT
	first_name,
    last_name,
    'Patient' as role
FROM patients
UNION ALL 
SELECT
	first_name,
    last_name,
    'Doctor'
FROM doctors;

-- Show all allergies ordered by popularity. Remove NULL values from query.

SELECT
	allergies,
    COUNT(*) AS total_diagnosis
FROM patients
WHERE allergies IS NOT null
GROUP BY allergies
ORDER BY total_diagnosis DESC;

-- Alternatively

SELECT
  allergies,
  COUNT(allergies) AS total_diagnosis
FROM patients
GROUP BY allergies
HAVING allergies IS NOT NULL
ORDER BY total_diagnosis DESC;

-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

SELECT
	first_name,
    last_name,
    birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date;

-- Alternatively

SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;

-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
-- EX: SMITH,jane

SELECT
	CONCAT(UPPER(last_name),', ', LOWER(first_name)) AS new_format    
FROM patients
ORDER BY first_name DESC;

-- Alternatively

SELECT
  UPPER(last_name) || ',' || LOWER(first_name) AS new_name_format
FROM patients
ORDER BY first_name DESC;

-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

SELECT
  province_id,
  SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

SELECT
  (MAX(weight) - MIN(weight)) AS weight_delta
FROM patients
WHERE last_name = 'Maroni';

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

SELECT
	DAY(admission_date) AS day_number,
    COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC;

-- Show all columns for patient_id 542's most recent admission_date.

SELECT
	*
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING MAX(admission_date);

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

SELECT
	patient_id,
    attending_doctor_id,
    diagnosis
FROM admissions
WHERE (attending_doctor_id IN (1, 5, 19) AND patient_id % 2 != 0)
	OR
    (attending_doctor_id LIKE'%2%' AND LEN(patient_id) = 3);

-- Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.

SELECT
	first_name,
    last_name,
    COUNT(*) AS admissions_total
FROM admissions a 
JOIN doctors d 
ON a.attending_doctor_id = d.doctor_id
GROUP BY attending_doctor_id;

-- For each doctor, display their id, full name, and the first and last admission date they attended.

SELECT
	attending_doctor_id,
    first_name || ' ' || last_name AS full_name,
    MAX(admission_date) AS last_admission,
    MIN(admission_date) AS first_admission    
FROM admissions
JOIN doctors
ON admissions.attending_doctor_id = doctors.doctor_id
GROUP BY attending_doctor_id;

-- Display the total amount of patients for each province. Order by descending.

SELECT
	COUNT(*) AS total_patients,
    province_name
FROM patients
JOIN province_names
ON patients.province_id = province_names.province_id
GROUP BY province_name
ORDER BY total_patients DESC;

-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

SELECT
	p.first_name || ' ' || p.last_name AS full_name,
    diagnosis,
    d.first_name || ' ' || d.last_name AS doctor_full_name
FROM patients p 
JOIN admissions a 
ON p.patient_id = a.patient_id
JOIN doctors d 
ON a.attending_doctor_id = d.doctor_id;

-- display the number of duplicate patients based on their first_name and last_name.

SELECT
	first_name,
    last_name,
    COUNT(*) as number_of_duplicate
FROM patients
GROUP BY first_name, last_name
HAVING number_of_duplicate > 1;

-- Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,
-- birth_date, gender non abbreviated.

-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.

SELECT
	CONCAT(first_name, ' ' , last_name) AS full_name,
    ROUND(height/30.48, 1) AS unit_feet,
    ROUND(weight*2.205, 0) AS unit_pounds,
    birth_date,
	
CASE
	WHEN gender = 'M' THEN 'male'
    ELSE 'female'
    END AS gender_type
    
FROM patients;

-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)

SELECT
	p.patient_id,
    first_name,
    last_name
FROM patients p 
LEFT JOIN admissions a 
ON p.patient_id = a.patient_id
WHERE a.patient_id IS NULL;

-- These queries above demonstrate of how well I know the SQL. 
-- Up until now, I always make sure to put to use of my SQL	skill as part of being a new data analyst.