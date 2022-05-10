-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 10: in descending order of education spending per pupil, see each states highschool grad rate and percent completing college


DELIMITER //
DROP PROCEDURE IF EXISTS Query10 //

CREATE PROCEDURE Query10()
BEGIN

SELECT stateName, eduSpendingPerPupil, highschoolGradRate, Education.percentCompletingCollege
FROM Education
WHERE eduSpendingPerPupil IS NOT NULL
ORDER BY eduSpendingPerPupil DESC;


END; //

DELIMITER ;
