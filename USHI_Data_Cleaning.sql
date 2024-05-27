-- US Household Income Project (Data Cleaning)
SELECT *
FROM USHouseholdIncome;


-- Identify duplicate entries
SELECT id, COUNT(id)
FROM USHouseholdIncome
GROUP BY id
HAVING COUNT(id) > 1;


-- Delete duplicate entries
DELETE FROM USHouseholdIncome
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM USHouseholdIncome) AS duplicates
	WHERE row_num > 1);


-- Identify duplicate entries (None)
SELECT id, COUNT(id)
FROM USHouseholdIncome_Statistics
GROUP BY id
HAVING COUNT(id) > 1;


-- Identify non-uniform State_Name
SELECT State_Name, COUNT(State_Name)
FROM USHouseholdIncome
GROUP BY State_Name;


-- Update incorrect State_Name
UPDATE USHouseholdIncome
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';


-- Identify non-uniform State_ab (None)
SELECT State_ab, COUNT(State_ab)
FROM USHouseholdIncome
GROUP BY State_ab;


-- Identify non-uniform Type
SELECT Type, COUNT(Type)
FROM USHouseholdIncome
GROUP BY Type;


-- Update incorrect Type
UPDATE USHouseholdIncome
SET Type = 'Borough'
WHERE Type = 'Boroughs';


-- Update incorrect Type
UPDATE USHouseholdIncome
SET Type = 'CDP'
WHERE Type = 'CPD';


-- Verify values for ALand and AWater
SELECT ALand, AWater
FROM USHouseholdIncome
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL);