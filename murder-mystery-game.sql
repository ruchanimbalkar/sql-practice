--Background : Experienced SQL sleuths start here
  --A crime has taken place and the detective needs your help. 
  --The detective gave you the crime scene report, but you somehow lost it. 
  --You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. 
  --Start by retrieving the corresponding crime scene report from the police department’s database.
-- Record your SQL detective process here!  Write down: 

-- Run this query to see sqlite_master.
SELECT * FROM sqlite_master;

-- Run this query to find the names of the tables in this database(sqlite_master).
SELECT name FROM sqlite_master
 WHERE TYPE = 'table';


-- Run this query to find the structure of the `crime_scene_report` table
SELECT sql FROM sqlite_master
 where name = 'crime_scene_report';
 
-- Run this query to find the structure of the 'facebook_event_checkin' table
SELECT sql FROM sqlite_master
 where name = 'facebook_event_checkin';

SELECT * FROM sqlite_master
ORDER BY rootpage;

--SELECT * FROM crime_scene_report;
--My first step is to find details of the crime and for that I need to find the crime report.
--A murder occurred on Jan. 15 2018 (20180115) at SQL city so my query to find the report from the table crime_scene_report will be :
--SELECT * FROM crime_scene_report WHERE city='SQL City' AND date = 20180115 AND type='murder';
--date	type	description	city
----20180115	murder	Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".	SQL City
-- My second step will be to find interviews of the two witnesses. 
	--I will start with Annabel who lives somewhere on "Franklin Ave"
--SELECT * FROM person WHERE name LIKE 'Annabel%' AND address_street_name ='Franklin Ave';
	--The above query gives me result :
	--id	name	license_id	address_number	address_street_name	ssn
	--16371	Annabel Miller	490173	103	Franklin Ave	31877114
--I will use the --id to find her interview
	--The above query gives me result :
    --person_id	transcript
	--16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
-- My next step is to find gym information for Jan. 9th 2018 (20180109)
--SELECT * FROM get_fit_now_check_in where check_in_date = 20180109;
	--The above query gives me result :
    --membership_id	check_in_date	check_in_time	check_out_time
	--X0643			20180109	957	1164
	--UK1F2			20180109	344	518
	--XTE42			20180109	486	1124
	--1AE2H			20180109	461	944
	--6LSTG			20180109	399	515
	--7MWHJ			20180109	273	885
	--GE5Q8			20180109	367	959
	--48Z7A			20180109	1600	1730
	--48Z55			20180109	1530	1700
	--90081			20180109	1600	1700
-- I am going to take a detour here and follow the other witness who lives at the last house on "Northwestern Dr"
-- SELECT * FROM person WHERE address_street_name = 'Northwestern Dr';
--There are lot of people living on Northwestern Dr. I will use the ORDER BY clause in secending order to find the occupant of the last house
--SELECT * FROM person WHERE address_street_name = 'Northwestern Dr' ORDER BY address_number DESC;
 --The above query result shows that Morty is the first witness assuming the largest address number is the last house on Northwestern Dr
 
--SELECT * FROM interview WHERE person_id=14887;
--The above query gives me the result :
	--person_id	transcript
	------14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
--My next step is to find a license plate that includes "H42W" and membership that starts with 48Z.
--Members whose membership id starts with 48Z:
--	--48Z7A			20180109	1600	1730
	--48Z55			20180109	1530	1700
--SELECT * FROM get_fit_now_member WHERE id LIKE '48Z%';
--The above query gives me three names :
-- id	person_id	name	membership_start_date	membership_status
--48Z38	49550	Tomas Baisley	20170203	silver
--48Z7A	28819	Joe Germuska	20160305	gold
--48Z55	67318	Jeremy Bowers	20160101	gold
    
 --SELECT * FROM drivers_license WHERE plate_number LIKE '%H42W%';
 --id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
--183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius
--423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS
--664760	21	71	black	black	male	4H42WR	Nissan	Altima

-- Next step is to find the person using license id in the person table
--SELECT * FROM person WHERE license_id = 183779 OR license_id = 423327 OR license_id = 664760;
--The above query gives ne following results :
--id	name	license_id	address_number	address_street_name	ssn
--51739	Tushar Chandra	664760	312	Phi St	137882671
--67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279
--78193	Maxine Whitely	183779	110	Fisk Rd	137882671

--Jeremy Bowers is member of the Gym with memebership id starting from 48Z, and his plate number includes H42W.
--Jeremy Bowers is the murderes based on the above queries
--INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        
        --SELECT value FROM solution;
        --The above guery gives me following result:
        -- Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.
 
 --Next step is to find the transcript and look for the real villain.


    

--   1. The SQL queries you ran
--   2. Any notes or insights as SQL comments
--   3. Your final conclusion: who did it?

-- Using these SQL clauses will help you solve the mystery: 
--    SELECT, FROM, WHERE, AND, OR, ORDER BY, LIMIT, LIKE, DISTINCT, BETWEEN, AS
