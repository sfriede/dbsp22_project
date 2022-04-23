
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
           SELECT avgSATScore / 1600 + avgACTScore / 36 + NAEPScoreMath / 500 + NAEPScoreReading / 500
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

