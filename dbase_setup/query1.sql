-- Sydney Friedel (sfriede5) and Shelby Coe (scoe4)
-- query 1: In order of best to worst-scored public education system (in terms of NAEP and standardized test scores),
-- list the unemployment rate, percent of population that is homeless, and the average starting salary of teachers for each state

DELIMITER //

DROP FUNCTION IF EXISTS GetEduScore //

CREATE FUNCTION GetEduScore(stateName_param VARCHAR(15))
RETURNS DECIMAL(5,3)
BEGIN
        IF EXISTS (SELECT * FROM Education WHERE stateName = stateName_param) THEN
           SELECT FORMAT(avgSATScore / 1600 + avgACTScore / 36 + NAEPScoreMath / 300 + NAEPScoreReading / 300,3)
           INTO @eduScore
           FROM Education
           WHERE stateName = stateName_param;
           RETURN @eduScore;
        ELSE
           RETURN 0;
        END IF;
END; //

DROP PROCEDURE IF EXISTS Query1 //
CREATE PROCEDURE Query1()
BEGIN
	SELECT GetEduScore(Ec.stateName), Ec.stateName, Ed.avgTeacherStartingSalary, Ec.percentUnhoused, Ec.unemploymentRate
	FROM Education AS Ed JOIN Economy AS Ec ON Ec.stateName = Ed.stateName
	ORDER BY GetEduScore(stateName) DESC;


END; //

DELIMITER ;
