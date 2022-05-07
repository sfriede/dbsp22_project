-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4


DELIMITER //

DROP PROCEDURE IF EXISTS Query3 //

CREATE PROCEDURE Query3() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('CREATE OR REPLACE VIEW HealthiestStates AS 
                    (SELECT stateName FROM Health ORDER BY drugOverdoses ASC LIMIT 20) INTERSECT (SELECT stateName FROM RiskFactors ORDER BY cancerMortality ASC LIMIT 20)
                    INTERSECT
                    (SELECT stateName FROM RiskFactors ORDER BY STIsPer100K ASC LIMIT 20)
                    INTERSECT
                    (SELECT stateName FROM RiskFactors ORDER BY obesityPrevalence ASC LIMIT 20);

                    CREATE OR REPLACE VIEW HighestEconStates AS 
                    (SELECT stateName FROM Economy ORDER BY realGDP DESC LIMIT 20)
                    INTERSECT
                    (SELECT stateName FROM Economy ORDER BY medianIncome DESC LIMIT 20);

                    SELECT * FROM HealthiestStates;
                    SELECT * FROM HighestEconStates;
                    SELECT stateName FROM States WHERE stateName IN (SELECT * FROM HealthiestStates) AND stateName IN (SELECT * FROM HighestEconStates);');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

DELIMITER ;