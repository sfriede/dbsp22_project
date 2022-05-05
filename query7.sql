-- Sydney Friedel (sfriede5) and Shelby Coe (scoe4)
-- query 7:  What is the average salary of teachers in the best performing states in terms of standardized test scores and highschool graduation rates?


DELIMITER //

DROP PROCEDURE IF EXISTS Query7 //
CREATE PROCEDURE Query7()
BEGIN
	
WITH BestEduPerformance AS
((SELECT stateName FROM Education ORDER BY highschoolGradRate DESC LIMIT 20)
INTERSECT
(SELECT stateName FROM Education ORDER BY avgSATScore DESC LIMIT 20)
INTERSECT
(SELECT stateName FROM Education ORDER BY avgACTScore DESC LIMIT 20))
SELECT avgTeacherStartingSalary, stateName
FROM Education
WHERE stateName IN (SELECT * FROM BestEduPerformance);


END; //

DROP PROCEDURE IF EXISTS Query7UI //

CREATE PROCEDURE Query7UI(IN stateName_param VARCHAR(20))
BEGIN
        IF (EXISTS(SELECT * FROM Education WHERE stateName = stateName_param)) THEN
	   WITH avgStats AS
	   (SELECT AVG(highschoolGradRate) AS 'avgHS', AVG(percentCompletingCollege) AS 'avgCollege'
	   FROM Education)
	   SELECT avgTeacherStartingSalary, (avgStats.avgHS - highschoolGradRate) AS 'hsDeviation', (avgStats.avgCollege - percentCompletingCollege) AS 'collegeDeviation'
	   FROM Education JOIN avgStats
	   WHERE stateName = stateName_param;
	END IF;

END; //

DELIMITER ;

