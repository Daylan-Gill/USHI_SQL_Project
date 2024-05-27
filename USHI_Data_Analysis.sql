-- US Household Income Project (Exploratory Data Analysis)
SELECT *
FROM USHouseholdIncome;


SELECT *
FROM ushouseholdincome_statistics;


-- Identify the top ten states with the largest land area
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM USHouseholdIncome
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;


-- Identify the top ten states with the largest water area
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM USHouseholdIncome
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10;


-- 
SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM USHouseholdIncome AS u
INNER JOIN ushouseholdincome_statistics AS us
	ON u.id = us.id
WHERE Mean != 0;


-- Identify top ten states with the lowest average mean income
SELECT u.State_Name, ROUND(AVG(Mean), 0) AS avg_mean, ROUND(AVG(Median), 0) AS avg_median
FROM USHouseholdIncome AS u
INNER JOIN ushouseholdincome_statistics AS us
	ON u.id = us.id
WHERE Mean != 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 10;


-- Identify top ten states with the highest average median income
SELECT u.State_Name, 
ROUND(AVG(Mean), 0) AS avg_mean, 
ROUND(AVG(Median), 0) AS avg_median
FROM USHouseholdIncome AS u
INNER JOIN ushouseholdincome_statistics AS us
	ON u.id = us.id
WHERE Mean != 0
GROUP BY u.State_Name
ORDER BY 3 DESC
LIMIT 10;


-- Identify average median income by Type
SELECT Type, 
ROUND(AVG(Mean), 0) AS avg_mean, 
ROUND(AVG(Median), 0) AS avg_median
FROM USHouseholdIncome AS u
INNER JOIN ushouseholdincome_statistics AS us
	ON u.id = us.id
WHERE Mean != 0
GROUP BY Type
ORDER BY 2 DESC;


-- Reduce outliers, identify average median income by Type
SELECT Type, 
COUNT(Type),
ROUND(AVG(Mean), 0) AS avg_mean, 
ROUND(AVG(Median), 0) AS avg_median
FROM USHouseholdIncome AS u
INNER JOIN ushouseholdincome_statistics AS us
	ON u.id = us.id
WHERE Mean != 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 3 DESC;


-- Identify top cities with the highest average mean income
SELECT u.State_Name, 
City,
ROUND(AVG(Mean), 0) AS avg_mean,
ROUND(AVG(Median), 0) AS avg_median
FROM USHouseholdIncome AS u
JOIN ushouseholdincome_statistics AS us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY 3 DESC;