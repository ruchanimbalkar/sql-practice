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

