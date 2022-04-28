-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

DELIMITER //

DROP PROCEDURE IF EXISTS Query16 //

CREATE PROCEDURE Query16() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('SELECT Ed.avgTeacherStartingSalary, Ed.stateName, Ec.medianIncome
                        FROM Education AS Ed JOIN Economy AS Ec ON Ed.stateName = Ec.stateName
                        ORDER BY Ed.avgTeacherStartingSalary DESC;');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

DELIMITER ;