
-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 17. Ordering the states from least to most racially diverse, list the state GDP and median household income.
-- https://archives.huduser.gov/healthycommunities/sites/default/files/public/Racial%20Diversity%20using%20Shannon-Wiener%20Index.pdf
-- link above used as a guide for calculating diversity index (we scaled by 10000 since our data is on a different scale than the source)
DELIMITER //

DROP FUNCTION IF EXISTS GetDiversityIndex //

CREATE FUNCTION GetDiversityIndex(stateName_param VARCHAR(15))
RETURNS DECIMAL(5,3)
BEGIN
        IF EXISTS (SELECT * FROM Demographics WHERE stateName = stateName_param) THEN
           WITH AggregateDiversity AS (SELECT AVG(white) AS white, AVG(black) AS black, AVG(asian) AS asian, AVG(indigenous) AS indigenous, AVG(other) AS other FROM Demographics)
           SELECT FORMAT(10000 / (D.white * A.white + D.black * A.black + D.asian * A.asian + D.indigenous * A.indigenous + D.other * A.other), 3)
           INTO @diversityIndex
           FROM Demographics AS D JOIN AggregateDiversity AS A
           WHERE D.stateName = stateName_param;
           RETURN @diversityIndex;
        ELSE
           RETURN 0;
        END IF;
END; //


DROP PROCEDURE IF EXISTS Query17 //
CREATE PROCEDURE Query17()
BEGIN
	SELECT stateName, GetDiversityIndex(stateName), realGDP, medianIncome
	FROM Economy
	ORDER BY GetDiversityIndex(stateName) ASC;
END; //

DELIMITER ;
                
