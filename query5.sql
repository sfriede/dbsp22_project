-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4


DELIMITER //

DROP PROCEDURE IF EXISTS Query5 //

CREATE PROCEDURE Query5() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('WITH AggregateStats AS
                    (SELECT AVG(abortionRate) AS avgRate, STD(abortionRate) AS stddev FROM Health)
                    SELECT E.stateName, E.medianIncome, E.percentInPoverty
                    FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
                    WHERE H.abortionRate >= (SELECT avgRate FROM AggregateStats);');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

DELIMITER ;