-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 13: For states with the best and worst public school systems, how do the number of homicides, suicides, and drug overdose statistics compare?

DELIMITER //

DROP PROCEDURE IF EXISTS Query13 //

CREATE PROCEDURE Query13()
BEGIN

WITH BestStates AS (SELECT stateName
FROM Education
ORDER BY NAEPScoreReading + NAEPScoreMath DESC
LIMIT 10),
WorstStates AS (SELECT stateName
FROM Education
WHERE NAEPScoreReading IS NOT NULL AND NAEPScoreMath IS NOT NULL
ORDER BY NAEPScoreReading + NAEPScoreMath  ASC
LIMIT 10)
SELECT E.stateName, H.homicideRate, H.suicideRate, H.drugOverdoses, (E.NAEPScoreReading + E.NAEPScoreMath) AS 'NAEPScore'
FROM Education AS E JOIN Health AS H ON E.stateName = H.stateName
WHERE E.stateName IN (SELECT * FROM BestStates) OR E.stateName IN (SELECT * FROM WorstStates)
ORDER BY E.NAEPScoreReading + E.NAEPScoreMath  DESC;


END; //

DELIMITER ;
