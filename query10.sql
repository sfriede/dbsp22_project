-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 10: in descending order of education spending per pupil, see each states highschool grad rate and percent completing college
DELIMITER //

-- get median income for states where teen pregnancy rate is higher than average

DROP PROCEDURE IF EXISTS Query10 //

CREATE PROCEDURE Query10()
BEGIN

SELECT stateName, eduSpendingPerPupil, highschoolGradRate, Education.percentCompletingCollege
FROM Education
ORDER BY eduSpendingPerPupil DESC;


END; //

DELIMITER ;