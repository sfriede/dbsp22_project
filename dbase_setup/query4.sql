-- Sydney Friedel (sfriede5) and Shelby Coe (scoe4)
-- query 4: What is the average income for adults in the five states with the highest high school graduation rate? Lowest high school graduation rate?
-- Does this change when using college graduation rates?


DELIMITER //

DROP PROCEDURE IF EXISTS Query4Highschool //
CREATE PROCEDURE Query4Highschool()
BEGIN
	-- using highschool graduation rates

WITH HighestGradRateStates AS
(SELECT stateName FROM Education ORDER BY highschoolGradRate DESC LIMIT 5),
LowestGradRateStates AS
(SELECT stateName FROM Education ORDER BY highschoolGradRate ASC LIMIT 5)
SELECT Ec.stateName, Ec.medianIncome, Ed.highschoolGradRate
FROM Economy AS Ec JOIN Education AS Ed ON Ec.stateName = Ed.stateName
WHERE Ec.stateName IN (SELECT * FROM HighestGradRateStates) OR Ec.stateName IN (SELECT * FROM LowestGradRateStates)
ORDER BY Ed.highschoolGradRate DESC;

END ; //
-- using percent completing college

DROP PROCEDURE IF EXISTS Query4College //

CREATE PROCEDURE Query4College()
BEGIN
WITH HighestPercentCompleteStates AS
(SELECT stateName FROM Education ORDER BY percentCompletingCollege DESC LIMIT 5),
LowestPercentCompleteStates AS
(SELECT stateName FROM Education ORDER BY percentCompletingCollege ASC LIMIT 5)
SELECT Ec.stateName, Ec.medianIncome, Ed.percentCompletingCollege
FROM Economy AS Ec JOIN Education AS Ed ON Ec.stateName = Ed.stateName
WHERE Ec.stateName IN (SELECT * FROM HighestPercentCompleteStates) OR Ec.stateName IN (SELECT * FROM LowestPercentCompleteStates)
ORDER BY Ed.percentCompletingCollege DESC;


END; //

DELIMITER ;
