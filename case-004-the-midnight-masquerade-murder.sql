-- Backstory : On October 31, 1987, at a Coconut Grove mansion masked ball, 
              -- Leonard Pierce was found dead in the garden.
              -- Can you piece together all the clues to expose the true murderer?
-- Query #1
SELECT * FROM crime_scene where date=19871031 AND location='Miami Mansion, Coconut Grove';
-- The above query gives the following result :
-- id	date	location	description
-- 75	19871031	Miami Mansion, Coconut Grove	During a masked ball, 
--   a body was found in the garden. Witnesses mentioned a hotel booking 
--   and suspicious phone activity.
-- Notes : This means that I need to find witness statements at crime scene id 75.
--  So, I wrote the next query as follows:
-- Query #2
SELECT * FROM witness_statements WHERE crime_scene_id = 75;
-- The above query gives the following result :
-- id	crime_scene_id	witness_id	clue
-- 83	75	37	I overheard a booking at The Grand Regency.
-- 89	75	42	I noticed someone at the front desk discussing Room 707 for a reservation made yesterday.
-- Notes/Comments : This implies that I should next check the hotel_checkins table for the hotel
  -- "The Grand Regency" and room number 707.
-- Query #3
SELECT * 
FROM hotel_checkins
WHERE hotel_name ='The Grand Regency'
AND room_number = 707;
-- The above query gives me multiple rows (> 5). If, I added the date of the murder to the query:
-- Query #4
SELECT * 
FROM hotel_checkins
WHERE hotel_name ='The Grand Regency'
AND room_number = 707
AND check_in_date = 19871031;
-- I get following results (only 3 rows) :
-- id	person_id	hotel_name	check_in_date	room_number
-- 88	134	The Grand Regency	19871031	    707
-- 98	67	The Grand Regency	19871031	    707
-- 104	156	The Grand Regency	19871031	  707
-- Notes : To find the survelliance records for the checkins, I wrote the following query 
--  using the checkin ids 88, 98, or 104
-- Query #5
SELECT * 
FROM surveillance_records
WHERE hotel_checkin_id = 88
OR hotel_checkin_id = 98
OR hotel_checkin_id = 104
-- The above query gives me following results :
-- id	hotel_checkin_id	note
-- 88	    88	             Subject used hotel notary services for business documents.
-- 98	    98	             Subject requested directions to nearest conference center location.
-- 104	   104	           Subject used hotel dry cleaning service.
-- Notes/Comments: Not satisfied with the above result, I decided to look up the person schema to see 
-- the names of the persons with ids 134, 67, and 156 obtained in query #4
-- Query #6
SELECT * 
FROM person
WHERE id = 134
OR id = 67
OR id = 156
-- The above query gives me following results :
-- id	name	            occupation	    address
-- 67	Earl Patterson	Police Officer	 797 Redwood Road
-- 134	Amy Evans	    Carpenter	       223 Redwood Road
-- 156	Kathy Fisher	Pharmacist	     667 Sycamorewood Drive
-- Comments: Next I thought of finding more details about the victim so I wrote the following query:
-- Query #7
-- SELECT * 
-- FROM person
-- WHERE name = 'Leonard Pierce';
-- The above query gives me following result :
-- id	name	        occupation	       address
-- 4	Leonard Pierce	Business Magnate	101 Elite Ave
