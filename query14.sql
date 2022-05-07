-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

-- this is the top query, not the one with the example of one more interactive

DELIMITER //

DROP PROCEDURE IF EXISTS Query14 //

CREATE PROCEDURE Query14() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('WITH LowestPovertyStates AS (SELECT stateName, percentInPoverty
                        FROM Economy
                        ORDER BY percentInPoverty ASC
                        LIMIT 10)
                        SELECT E.stateName, E.highschoolGradRate
                        FROM Education AS E JOIN LowestPovertyStates
                        ON E.stateName = LowestPovertyStates.stateName
                        ORDER BY LowestPovertyStates.percentInPoverty DESC;');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

DELIMITER ;