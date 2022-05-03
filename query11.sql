-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 6 (modified to take user input): For states with the highest and lowest median incomes, what is the difference between the US-born and foreign-born median incomes, and how racially diverse is this state? what does this look like for a state of the user's choice? 

DELIMITER //

-- get median income for states where teen pregnancy rate is higher than average

DROP PROCEDURE IF EXISTS Query11 //

CREATE PROCEDURE Query11(IN factor VARCHAR(30))
BEGIN
    IF STRCMP(factor, 'realGDP') THEN
	    WITH HighestStates AS (SELECT stateName
        FROM Economy
        ORDER BY realGDP DESC
        LIMIT 10),
        LowestStates AS (SELECT stateName
        FROM Economy
        ORDER BY realGDP ASC
        LIMIT 10)
        SELECT E.stateName, E.realGDP, H.suicideRate, H.teenPregnancyRate 
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName
        WHERE E.stateName IN (SELECT * FROM HighestStates) OR E.stateName IN (SELECT * FROM LowestStates)
        ORDER BY E.realGDP DESC;
    END IF;

END; //

DELIMITER ;
