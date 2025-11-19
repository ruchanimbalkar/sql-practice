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
