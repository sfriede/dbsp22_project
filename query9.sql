-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 10:  For states in which the rate of drug overdoses or sucide are significantly lower than other states, what was the highschool graduation rate? 
-- SAT/ACT scores?

DELIMITER //


DROP PROCEDURE IF EXISTS Query9 //

CREATE PROCEDURE Query9()
BEGIN

WITH AggregateStats AS (SELECT AVG(drugOverdoses) AS 'avgRateDrugs',
AVG(suicideRate) AS 'avgRateSuicide', STD(drugOverdoses) AS 'stddevDrugs', STD(suicideRate) AS 'stddevSuicides'
FROM Health)
SELECT E.stateName, E.highschoolGradRate, E.avgSATScore, E.avgACTScore
FROM Health AS H JOIN Education AS E ON H.stateName = E.stateName
WHERE H.drugOverdoses >= (SELECT avgRateDrugs FROM AggregateStats) + 2* (SELECT stddevDrugs FROM AggregateStats) OR H.suicideRate >= (SELECT avgRateSuicide FROM AggregateStats) + 2*(SELECT stddevSuicides FROM AggregateStats);



END; //

DELIMITER ;
