-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

DELIMITER //

DROP PROCEDURE IF EXISTS Query13 //

CREATE PROCEDURE Query13() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('WITH BestStates AS (SELECT stateName
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
                      ORDER BY E.NAEPScoreReading + E.NAEPScoreMath  DESC;');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

DELIMITER ;