
-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- DB Project Phase D: queries.sql

-- 1. In order of best to worst-scored public education system (in terms of NAEP and standardized test scores),
-- list the unemployment rate, percent of population that is homeless, and the average starting salary of teachers for each state. 

DELIMITER //

DROP FUNCTION IF EXISTS GetEduScore //

CREATE FUNCTION GetEduScore(stateName_param VARCHAR(15))
RETURNS DECIMAL(5,3)
BEGIN
        IF EXISTS (SELECT * FROM Education WHERE stateName = stateName_param) THEN
           SELECT FORMAT(avgSATScore / 1600 + avgACTScore / 36 + NAEPScoreMath / 500 + NAEPScoreReading / 500,3)
           INTO @eduScore
           FROM Education
	   WHERE stateName = stateName_param;
           RETURN @eduScore;
        ELSE
           RETURN 0;
        END IF;
END; //

DELIMITER ;

SELECT GetEduScore(Ec.stateName), Ec.stateName, Ed.avgTeacherStartingSalary, Ec.percentUnhoused, Ec.unemploymentRate
FROM Education AS Ed JOIN Economy AS Ec ON Ec.stateName = Ed.stateName
ORDER BY GetEduScore(stateName) DESC;

-- 2. What is the average household income for states where the teen pregnancy rate is higher than the average rate for all states?

SELECT E.stateName, E.medianIncome
FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
WHERE H.teenPregnancyRate > (SELECT AVG(teenPregnancyRate) FROM Health);

-- 3. Do states with the healthiest states (in terms of cancer mortality, obesity, drug overdoses, etc.) have the highest average incomes and GDP?

CREATE OR REPLACE VIEW HealthiestStates AS 
(SELECT stateName FROM Health ORDER BY drugOverdoses ASC LIMIT 20) INTERSECT (SELECT stateName FROM RiskFactors ORDER BY cancerMortality ASC LIMIT 20)
INTERSECT
(SELECT stateName FROM RiskFactors ORDER BY STIsPer100K ASC LIMIT 20)
INTERSECT
(SELECT stateName FROM RiskFactors ORDER BY obesityPrevalence ASC LIMIT 20);

CREATE OR REPLACE VIEW HighestEconStates AS 
(SELECT stateName FROM Economy ORDER BY realGDP DESC LIMIT 20)
INTERSECT
(SELECT stateName FROM Economy ORDER BY medianIncome DESC LIMIT 20);

SELECT * FROM HealthiestStates;
SELECT * FROM HighestEconStates;
SELECT stateName FROM States WHERE stateName IN (SELECT * FROM HealthiestStates) AND stateName IN (SELECT * FROM HighestEconStates);

--4. What is the average income for adults in the five states with the highest high school graduation rate? Lowest high school graduation rate?
-- Does this change when using college graduation rates?

-- using highschool graduation rates

WITH HighestGradRateStates AS
(SELECT stateName FROM Education ORDER BY highschoolGradRate DESC LIMIT 5),
LowestGradRateStates AS
(SELECT stateName FROM Education ORDER BY highschoolGradRate ASC LIMIT 5)
SELECT Ec.stateName, Ec.medianIncome, Ed.highschoolGradRate
FROM Economy AS Ec JOIN Education AS Ed ON Ec.stateName = Ed.stateName
WHERE Ec.stateName IN (SELECT * FROM HighestGradRateStates) OR Ec.stateName IN (SELECT * FROM LowestGradRateStates)
ORDER BY Ed.highschoolGradRate DESC;

-- using percent completing college

WITH HighestPercentCompleteStates AS
(SELECT stateName FROM Education ORDER BY percentCompletingCollege DESC LIMIT 5),
LowestPercentCompleteStates AS
(SELECT stateName FROM Education ORDER BY percentCompletingCollege ASC LIMIT 5)
SELECT Ec.stateName, Ec.medianIncome, Ed.percentCompletingCollege
FROM Economy AS Ec JOIN Education AS Ed ON Ec.stateName = Ed.stateName
WHERE Ec.stateName IN (SELECT * FROM HighestPercentCompleteStates) OR Ec.stateName IN (SELECT * FROM LowestPercentCompleteStates)
ORDER BY Ed.percentCompletingCollege DESC;

-- 5. Of the states in which abortion rate is significantly higher than the average rate for all states, what was the average household income
-- for that state that year? What percent of the state's population was at or under the poverty line?

WITH AggregateStats AS
(SELECT AVG(abortionRate) AS 'avgRate', STD(abortionRate) AS 'stddev' FROM Health)
SELECT E.stateName, E.medianIncome, E.percentInPoverty
FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
WHERE H.abortionRate >= (SELECT avgRate FROM AggregateStats) + 2*(SELECT stddev FROM AggregateStats);

-- 6. For states with the highest and lowest median incomes, what is the difference between the US-born and foreign-born median incomes,
-- and how racially diverse is this state?

SELECT E.foreignBornMedianIncome, E.USBornMedianIncome, E.stateName, D.white, D.black, D.asian, D.indigenous, D.other, D.hispanicOrLatino, D.notHispanicOrLatino
FROM Demographics AS D JOIN Economy AS E ON D.stateName = E.stateName
WHERE E.medianIncome = (SELECT MAX(medianIncome) FROM Economy) OR E.medianIncome = (SELECT MIN(medianIncome) FROM Economy)
ORDER BY E.medianIncome DESC;

-- 7. What is the average salary of teachers in the best performing states in terms of standardized test scores and highschool graduation rates?
 
WITH BestEduPerformance AS
((SELECT stateName FROM Education ORDER BY highschoolGradRate DESC LIMIT 20)
INTERSECT
(SELECT stateName FROM Education ORDER BY avgSATScore DESC LIMIT 20)
INTERSECT
(SELECT stateName FROM Education ORDER BY avgACTScore DESC LIMIT 20))
SELECT avgTeacherStartingSalary, stateName
FROM Education
WHERE stateName IN (SELECT * FROM BestEduPerformance);

-- 8. What is the mean average income in each state for U.S. born individuals across all 50 states? How does this compare to foreign born individuals? 
SELECT USBornMedianIncome, foreignBornMedianIncome, FORMAT(USBornMedianIncome - foreignBornMedianIncome, 2) AS difference
FROM Economy;

-- 9. For states in which the rate of drug overdoses or sucide are significantly lower than other states, what was the highschool graduation rate? Average SAT/ACT scores?
-- defined "significant" as more than 2 standard deviations away from the mean?
WITH AggregateStats AS (SELECT AVG(drugOverdoses) AS 'avgRateDrugs', 
AVG(suicideRate) AS 'avgRateSuicides', STD(drugOverdoses) AS 'stddevDrugs', STD(suicideRate) AS 'stddevSuicides'
FROM Health)
SELECT E.stateName, E.highschoolGradRate, E.avgSATScore, E.avgACTScore
FROM Health AS H JOIN Education AS E ON H.stateName = E.stateName
WHERE H.drugOverdoses >= (SELECT avgRateDrugs FROM AggregateStats) + 2* (SELECT stddevDrugs FROM AggregateStats) OR H.suicideRate >= (SELECT avgRateSuicides FROM AggregateStats) + 2*(SELECT stddevSuicides FROM AggregateStats);

-- 10. In descending order of education spending per pupil, list each state's percentage of adults who have completed college and the highschool graduation rate.
SELECT Education.percentCompletingCollege, Education.highschoolGradRate
FROM Education
ORDER BY eduSpendingPerPupil DESC;

-- 11. What is the difference in overall health for states with very different rates of unhoused people?
-- For this we were thinking we could add a variable to compare health based on the difference economic attributes
WITH HighestStates AS (SELECT stateName
FROM Economy
ORDER BY homelessnessRatePer10000 DESC
LIMIT 10),
LowestStates AS (SELECT stateName
FROM Economy
ORDER BY homelessnessRatePer10000 ASC
LIMIT 10)
SELECT E.stateName, H.suicideRate, H.teenPregnancyRate 
FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName
WHERE E.stateName IN (SELECT * FROM HighestStates) OR E.stateName IN (SELECT * FROM LowestStates)
ORDER BY E.homelessnessRatePer10000 DESC;

-- 12. For states with a relatively high unemployment rate compared to the average of all states, list the risk factor and health statistics.
WITH AggregateStats AS
(SELECT AVG(unemploymentRate) AS 'avgUnemploymentRate', STD(unemploymentRate) AS 'stddevUnemploymentRate'
FROM Economy)
SELECT E.stateName, H.abortionRate, H.homicideRate, H.drugOverdoses, H.suicideRate, H.teenPregnancyRate
FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
WHERE E.unemploymentRate >= (SELECT avgUnemploymentRate FROM AggregateStats) + 2*(SELECT stddevUnemploymentRate FROM AggregateStats);
-- how do these values compare to the average values for all states?
SELECT AVG(abortionRate), AVG(homicideRate), AVG(drugOverdoses), AVG(suicideRate), AVG(teenPregnancyRate)
FROM Health;

-- 13. For states with the best and worst public school systems, how do the number of homicides, suicides, and drug overdose statistics compare?
WITH BestStates AS (SELECT stateName
FROM Education
ORDER BY NAEPScoreReading + NAEPScoreMath DESC
LIMIT 10),
WorstStates AS (SELECT stateName
FROM Education
ORDER BY NAEPScoreReading + NAEPScoreMath  ASC
LIMIT 10)
SELECT E.stateName, H.suicideRate, H.homicideRate, H.drugOverdoses 
FROM Education AS E JOIN Health AS H ON E.stateName = H.stateName
WHERE E.stateName IN (SELECT * FROM BestStates) OR E.stateName IN (SELECT * FROM WorstStates)
ORDER BY E.NAEPScoreReading + E.NAEPScoreMath  DESC;

-- 14. What is the average graduation rate of each state for the five states with the lowest poverty levels? 
WITH LowestPovertyStates AS (SELECT stateName, percentInPoverty
FROM Economy
ORDER BY percentInPoverty ASC
LIMIT 10)
SELECT E.highschoolGradRate
FROM Education AS E JOIN LowestPovertyStates
ON E.stateName = LowestPovertyStates.stateName
ORDER BY LowestPovertyStates.percentInPoverty DESC;

-- This is an idea we have for making queries like this more user-interactive for Phase E: we would allow the user to
-- select some cutoff value in the query parameter and display the information for that query result
-- This stored procedure would be called via a prepared statement in PHP with the user input poverty level cutoff
DELIMITER //

DROP PROCEDURE IF EXISTS GetStatesBelowPovLevel //

CREATE PROCEDURE GetStatesBelowPovLevel(percentPov_param FLOAT(5,2))
BEGIN

	SELECT Ed.stateName, Ed.highschoolGradRate
	FROM Education AS Ed JOIN Economy AS Ec ON Ed.stateName = Ec.stateName
	WHERE Ec.percentInPoverty <= percentPov_param;
END; //

DELIMITER ;


-- What is the poverty level of each state for the five states with the highest graduation rate? 
WITH HighestGraduationStates AS (SELECT stateName, highschoolGradRate
FROM Education
ORDER BY highschoolGradRate DESC
LIMIT 10)
SELECT E.percentInPoverty
FROM Economy AS E JOIN HighestGraduationStates
ON E.stateName = HighestGraduationStates.stateName
ORDER BY HighestGraduationStates.highschoolGradRate DESC;

-- Is there an overlap?
(SELECT stateName, percentInPoverty
FROM Economy
ORDER BY percentInPoverty ASC
LIMIT 10)
INTERSECT
(SELECT stateName, highschoolGradRate
FROM Education
ORDER BY highschoolGradRate DESC
LIMIT 10);

-- 15. Of states with the highest rates of suicide, what is their average annual education funding and teacher starting salary? How does this compare to states with the lowest rates of suicide?
WITH HighestSuicideStates AS
(SELECT stateName
FROM Health
ORDER BY suicideRate DESC
LIMIT 10),
LowestSuicideStates AS
(SELECT stateName
FROM Health
ORDER BY suicideRate ASC
LIMIT 10)
SELECT E.eduSpendingPerPupil, E.avgTeacherStartingSalary, H.suicideRate, E.stateName
FROM Education AS E JOIN Health AS H ON E.stateName = H.stateName
WHERE E.stateName IN (SELECT * FROM HighestSuicideStates) OR E.stateName IN (SELECT * FROM LowestSuicideStates)
ORDER BY H.suicideRate DESC;

-- 16. List the states and the average income of working adults for states ordered by the average teacher salary of the state.
SELECT Ed.avgTeacherStartingSalary, Ed.stateName, Ec.medianIncome
FROM Education AS Ed JOIN Economy AS Ec ON Ed.stateName = Ec.stateName
ORDER BY Ed.avgTeacherStartingSalary DESC;

-- 17. Ordering the states from least to most racially diverse, list the state GDP and median household income.
-- https://archives.huduser.gov/healthycommunities/sites/default/files/public/Racial%20Diversity%20using%20Shannon-Wiener%20Index.pdf
-- link above used as a guide for calculating diversity index (we scaled by 10000 since our data is on a different scale than the source)
DELIMITER // 

DROP FUNCTION IF EXISTS GetDiversityIndex //

CREATE FUNCTION GetDiversityIndex(stateName_param VARCHAR(15))
RETURNS DECIMAL(5,3)
BEGIN
	IF EXISTS (SELECT * FROM Demographics WHERE stateName = stateName_param) THEN
      	   WITH AggregateDiversity AS (SELECT AVG(white) AS white, AVG(black) AS black, AVG(asian) AS asian, AVG(indigenous) AS indigenous, AVG(other) AS other FROM Demographics)
           SELECT FORMAT(10000 / (D.white * A.white + D.black * A.black + D.asian * A.asian + D.indigenous * A.indigenous + D.other * A.other), 3)
           INTO @diversityIndex
           FROM Demographics AS D JOIN AggregateDiversity AS A
	   WHERE D.stateName = stateName_param;
           RETURN @diversityIndex;
      	ELSE
	   RETURN 0;
        END IF;
END; //

DELIMITER ;

SELECT stateName, GetDiversityIndex(stateName), realGDP, medianIncome
FROM Economy
ORDER BY GetDiversityIndex(stateName) ASC;
