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
