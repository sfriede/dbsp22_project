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

DELIMITER ;
