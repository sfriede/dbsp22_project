-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

DELIMITER //

DROP PROCEDURE IF EXISTS Query9 //

CREATE PROCEDURE Query9 AS
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('WITH AggregateStats AS (SELECT AVG(drugOverdoses) AS 'avgRateDrugs', 
                     AVG(suicideRate) AS 'avgRateSuicides', STD(drugOverdoses) AS 'stddevDrugs', STD(suicideRate) AS 'stddevSuicides'
                     FROM Health)
                     SELECT E.stateName, E.highschoolGradRate, E.avgSATScore, E.avgACTScore
                     FROM Health AS H JOIN Education AS E ON H.stateName = E.stateName
                     WHERE H.drugOverdoses >= (SELECT avgRateDrugs FROM AggregateStats) + 2* (SELECT stddevDrugs FROM AggregateStats) 
                     OR H.suicideRate >= (SELECT avgRateSuicides FROM AggregateStats) + 2*(SELECT stddevSuicides FROM AggregateStats);');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

DELIMITER ;