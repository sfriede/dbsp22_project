-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 15:  Of states with the highest rates of suicide, what is their average annual education funding and teacher starting salary? How does this compare
-- to states with the lowest rates of suicide?

DELIMITER //

DROP PROCEDURE IF EXISTS Query15 //

CREATE PROCEDURE Query15()
BEGIN

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
SELECT E.stateName, E.eduSpendingPerPupil, E.avgTeacherStartingSalary, H.suicideRate
FROM Education AS E JOIN Health AS H ON E.stateName = H.stateName
WHERE E.eduSpendingPerPupil IS NOT NULL AND (E.stateName IN (SELECT * FROM HighestSuicideStates) OR E.stateName IN (SELECT * FROM LowestSuicideStates))
ORDER BY H.suicideRate DESC;


END; //

DELIMITER ;
