-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

DELIMITER //

DROP PROCEDURE IF EXISTS Query15 //

CREATE PROCEDURE Query15() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('WITH HighestSuicideStates AS
                    (SELECT stateName
                    FROM Health
                    ORDER BY suicideRate DESC
                    LIMIT 10),
                    LowestSuicideStates AS
                    (SELECT stateName
                    FROM Health
                    ORDER BY suicideRate ASC
                    LIMIT 10)
                    SELECT E.eduSpendingPerPupil, E.avgTeacherStartingSalary, H.suicideRate, E.stateName
                    FROM Education AS E JOIN Health AS H ON E.stateName = H.stateName
                    WHERE E.stateName IN (SELECT * FROM HighestSuicideStates) OR E.stateName IN (SELECT * FROM LowestSuicideStates)
                    ORDER BY H.suicideRate DESC;');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

DELIMITER ;