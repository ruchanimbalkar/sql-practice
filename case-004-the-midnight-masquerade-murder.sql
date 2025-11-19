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
-- 67	  Earl Patterson	Police Officer	 797 Redwood Road
-- 134	Amy Evans	      Carpenter	       223 Redwood Road
-- 156	Kathy Fisher	  Pharmacist	     667 Sycamorewood Drive
-- Comments: Next I thought of finding more details about the victim so I wrote the following query:
-- Query #7
SELECT * 
FROM person
WHERE name = 'Leonard Pierce';
-- The above query gives me following result :
-- id	name	        occupation	       address
-- 4	Leonard Pierce	Business Magnate	101 Elite Ave
-- Comments: Next I thought of looking at the final_interviews schema so I wrote the following query:
-- Query #8
SELECT person.name, final_interviews.confession
FROM final_interviews
JOIN person
ON final_interviews.person_id = person.id
WHERE person_id = 67
OR person_id = 134
OR person_id = 156;
-- The above query gives me following result :
--   name	            confession
-- Earl Patterson	    I have proof of my whereabouts. Im not someone who would kill.
-- Amy Evans	        Check my internet service logs. Im not the murderer youre looking for.
-- Kathy Fisher	      My bus pass shows I was traveling. I would never take someones life.
-- Comments : After being dissappointed with the above result/confessions, I decided to look at the phone records
-- Query #9
SELECT person.name, phone_records.note
FROM phone_records
JOIN person
ON person.id = caller_id OR person.id= recipient_id
WHERE note like '%kill%';
-- The above query gave me the following result:
-- name	            note
-- Antonio Rossi	Why did you kill him, bro? You should have left the carpenter do it himself!
-- Victor DiMarco	Why did you kill him, bro? You should have left the carpenter do it himself!
-- Note : Then I remembered Amy Evans is a carpenter who was at the Regency Hotel.
-- Comments : I tried entering the above names 
-- (Antonio Rossi, Victor DiMarco, Amy Evans, Earl Patterson and Kathy Fisher	)
-- in the submit tab but they were all wrong answers so I realized my answers were and was on the wrong trail.
-- Looking back at the results of first query,  I decide to start again with the witness statements.
-- I backtracked and I wrote the following query :
-- Query #10
SELECT person.name, witness_statements.clue
FROM witness_statements
JOIN person
ON person.id = witness_statements.witness_id
WHERE crime_scene_id = 75;
-- The above query gave me the following result:
-- name	             clue
-- Steven Nelson	  I overheard a booking at The Grand Regency.
-- Sharon Phillips	I noticed someone at the front desk discussing Room 707 for a reservation made yesterday.
-- Notes/comments : I then started to think about phone_records and reservations made for room 707 at The Grand Regency.
