-- Backstory : 
-- QuantumTech, Miami’s leading technology corporation, was about to unveil its groundbreaking microprocessor called “QuantaX.”
--   Just hours before the reveal, the prototype was destroyed, and all research data was erased. Detectives suspect corporate espionage.
-- Notes/Comments : To find more information about the incident, I decided to look at the incident_reports schema
-- Then I wrote the following query :
-- Query #1
SELECT * 
FROM incident_reports
WHERE location LIKE '%QuantumTech%' ;
-- The above query gives the following results :
-- id	date	    location	            description
-- 74	19890421	QuantumTech HQ	Prototype destroyed; data erased from servers.
-- Notes/Comments : My next step was to look at the witness_statements schema
-- Then I wrote the following query :
-- Query #2
SELECT *
FROM witness_statements
WHERE incident_id = 74;
-- The above query gives the following results :
-- id	incident_id	employee_id	  statement
-- 40	74	        145	          I heard someone mention a server in Helsinki.
-- 59	74	        134	          I saw someone holding a keycard marked QX- succeeded by a two-digit odd number.
-- Notes/Comments : I then started to look into Helsinki and the key_card_access_logs
-- Then I wrote the following query :
-- Query #3
WITH results AS (SELECT *
FROM keycard_access_logs 
RIGHT JOIN employee_records
ON keycard_access_logs.employee_id = employee_records.id
WHERE keycard_code LIKE 'QX%'
AND access_date= 19890421)
SELECT distinct results.employee_name, results.employee_id
FROM results
JOIN computer_access_logs
ON results.employee_id = computer_access_logs.employee_id
WHERE
server_location LIKE '%Helsinki%';
-- The above query gave me the following results :
-- employee_name	employee_id
-- Margie Weber	178
-- Ann Peterson	56
-- Paul Adams	23
-- Elizabeth Gordon	99
-- Notes/ Comments : Next I am going to look at the email conversation of the above employees

