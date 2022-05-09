-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- stored procedures for query 16, some taking user input and some not

DELIMITER //

DROP PROCEDURE IF EXISTS Query16 //

CREATE PROCEDURE Query16() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('SELECT Ed.stateName, Ed.avgTeacherStartingSalary, Ec.medianIncome
                        FROM Education AS Ed JOIN Economy AS Ec ON Ed.stateName = Ec.stateName
                        ORDER BY Ed.avgTeacherStartingSalary DESC;');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; //


-- version of query 16 taking user input

DROP PROCEDURE IF EXISTS Query16UI //

CREATE PROCEDURE Query16UI(IN state1 VARCHAR(20), IN state2 VARCHAR(20))
BEGIN

	IF (EXISTS(SELECT * FROM Education WHERE stateName = state1) AND EXISTS(SELECT * FROM Education WHERE stateName = state2) AND EXISTS(SELECT * FROM Economy WHERE stateName = state1) AND EXISTS(SELECT * FROM Economy WHERE stateName = state2)) THEN

	   WITH AvgStats AS
	   (SELECT AVG(Ec.medianIncome - Ed.avgTeacherStartingSalary) AS 'avgDiff'
	   FROM Economy AS Ec JOIN Education AS Ed ON Ec.stateName = Ed.stateName)
	   SELECT Education.stateName, (medianIncome - avgTeacherStartingSalary) AS 'diffPay', (AvgStats.avgDiff - medianIncome + avgTeacherStartingSalary) AS 'diff between avg and state', avgSATScore, avgACTScore, NAEPScoreReading, NAEPScoreMath
	   FROM (Education JOIN Economy ON Education.stateName = Economy.stateName) JOIN AvgStats
	   WHERE Education.stateName = state1 OR Education.stateName = state2;

	END IF;

END; //

DELIMITER ;
