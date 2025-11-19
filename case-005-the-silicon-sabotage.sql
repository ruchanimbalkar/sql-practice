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
-- When I looked at the email conversations, I noticed one email that looked shady.
-- Query #4
SELECT * FROM email_logs
WHERE email_date = 19890421;
-- 140	NULL	263	19890421	Execute Phase Window	Unlock 18 quietly by 9. 
                      -- He’ll use his own credentials to access it shortly after L leaves.
                      -- No questions. Just ensure the timing lines up. The trail will lead exactly where it needs to.
-- Notes/Comments: I thought of email conversations happened on 19890421 and used the 
-- same subject line to see if there were more email conversations related to that subject (Execute Phase Window)
-- Query #5
SELECT * FROM email_logs
WHERE email_subject = 'Execute Phase Window'
AND email_date = 19890421;
-- The above query gave me the same one result :
-- id	sender_employee_id	recipient_employee_id	email_date	email_subject	email_content
-- 140	NULL	263	19890421	Execute Phase Window	Unlock 18 quietly by 9. He’ll use his own credentials to access it shortly after L leaves.
--   No questions. Just ensure the timing lines up. The trail will lead exactly where it needs to.
-- Notes/Comments : I decided to look up the recipient_employee_id 263 in the employee table.
-- I was surprised because the  employee id was different than the ones found in the results of query #3.
-- Query #6
SELECT * FROM employee_records
WHERE id = 263;
-- The above query gave me the following result :
-- id	employee_name	department	occupation	home_address
-- 263	Norman Owens	Quantum Computing	Quantum Systems Engineer	234 Quantum Waters Lane, Key Biscayne, FL
-- Notes/Comments : This means Norman Owens is the culprit. To confirm, I tried to look him up in the keycard_access_logs schema
-- using the employee_id 263
-- Query #7
SELECT * FROM keycard_access_logs
WHERE employee_id = 263;
-- The above query gave me no result. 
-- Notes/Comments : So I wondered if it was a fake employee created to do the espionage because I wanted to see if his keycard starte with QX and had two odd numbers.
-- I decided to look up key cards for:
-- -- Margie Weber	178
-- Ann Peterson	56
-- Paul Adams	23
-- Elizabeth Gordon	99
-- from query #3 and I wrote the following query
-- Query #8
SELECT *
FROM keycard_access_logs 
WHERE employee_id = 178
OR employee_id = 56
OR employee_id = 23
OR employee_id = 99;
-- The above query gave me the following results :
-- id	employee_id	keycard_code	access_date	access_time
-- 6	178	QX-314	19890421	13:50
-- 10	56	QX-024	19890421	17:20
-- 19	23	QX-219	19890421	02:15
-- 40	23	QX-184	19890421	23:20
-- 60	23	QX-072	19890421	19:50
-- 80	23	QX-112	19890421	15:30
-- 89	99	QX-035	19890421	08:30
-- 100	23	QX-208	19890421	11:20
-- 113	56	QX-241	19890421	09:30
-- 114	178	QX-188	19890421	11:15
-- 130	178	QX-070	19890421	16:30
-- 140	56	QX-288	19890421	09:30
-- 160	56	QX-006	19890421	13:20
-- Notes/Comments : I noticed that employee 23, 99 and 56 had keycard_codes with odd numbers QX-219, QX-035, and QX-241:
-- So I wondered if :
    -- Ann Peterson	56
    -- Paul Adams	23
    -- Elizabeth Gordon	99
-- were one of the culprits.
-- I entered their names in the submit tab but those were wrong answers.
-- Then I entered Norman Owens name in the submit tab but that was also wrong so I decided to backtrack.
-- I looked at Norman Owens email ("unlock 18 quietly by 9. He’ll use his own credentials to access it shortly after L leaves") 
-- and wrote the following query:
-- Query #9
SELECT *
FROM facility_access_logs
WHERE facility_name LIKE '%18'
AND access_time LIKE '09%';
-- The above query gave me the following result :
-- id	employee_id	facility_name	access_date	access_time
-- 81	297	Facility 18	19890421	09:01
-- Notes/Comments :



