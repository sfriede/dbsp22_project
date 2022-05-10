-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 9:  For states in which the rate of drug overdoses or sucide are significantly lower than other states, what was the highschool graduation rate? 
-- SAT/ACT scores?

DELIMITER //


DROP PROCEDURE IF EXISTS Query9High //

CREATE PROCEDURE Query9High()
BEGIN

WITH AggregateStats AS (SELECT AVG(drugOverdoses) AS 'avgRateDrugs',
AVG(suicideRate) AS 'avgRateSuicide', STD(drugOverdoses) AS 'stddevDrugs', STD(suicideRate) AS 'stddevSuicides'
FROM Health)
SELECT E.stateName, E.highschoolGradRate, E.avgSATScore, E.avgACTScore
FROM Health AS H JOIN Education AS E ON H.stateName = E.stateName
WHERE H.drugOverdoses >= (SELECT avgRateDrugs FROM AggregateStats) + 1.5* (SELECT stddevDrugs FROM AggregateStats) OR H.suicideRate >= (SELECT avgRateSuicide FROM AggregateStats) + 1.5*(SELECT stddevSuicides FROM AggregateStats)
ORDER BY E.highschoolGradRate DESC, E.avgSATScore DESC, E.avgACTScore DESC ;

END; //

DROP PROCEDURE IF EXISTS Query9Low //

CREATE PROCEDURE Query9Low()
BEGIN

WITH AggregateStats AS (SELECT AVG(drugOverdoses) AS 'avgRateDrugs',
AVG(suicideRate) AS 'avgRateSuicide', STD(drugOverdoses) AS 'stddevDrugs', STD(suicideRate) AS 'stddevSuicides'
FROM Health)
SELECT E.stateName, E.highschoolGradRate, E.avgSATScore, E.avgACTScore
FROM Health AS H JOIN Education AS E ON H.stateName = E.stateName
WHERE H.drugOverdoses <= (SELECT avgRateDrugs FROM AggregateStats) - 1.5* (SELECT stddevDrugs FROM AggregateStats) OR H.suicideRate <= (SELECT avgRateSuicide FROM AggregateStats) - 1.5*(SELECT stddevSuicides FROM AggregateStats)
ORDER BY E.highschoolGradRate DESC, E.avgSATScore DESC, E.avgACTScore DESC ;

END; //


DELIMITER ;
