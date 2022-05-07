-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4


DELIMITER //

DROP PROCEDURE IF EXISTS Query12 //

CREATE PROCEDURE Query12() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('WITH AggregateStats AS
                    (SELECT AVG(unemploymentRate) AS avgUnemploymentRate, STD(unemploymentRate) AS stddevUnemploymentRate
                    FROM Economy)
                    SELECT E.stateName, H.abortionRate, H.homicideRate, H.drugOverdoses, H.suicideRate, H.teenPregnancyRate
                    FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
                    WHERE E.unemploymentRate >= (SELECT avgUnemploymentRate FROM AggregateStats) + 2*(SELECT stddevUnemploymentRate FROM AggregateStats);');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

DELIMITER ;