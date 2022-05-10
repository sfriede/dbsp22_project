-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 2 (modified to take user input): what is the average household income for states where the teen pregnancy rate is higher than XXX?

DELIMITER //

-- get median income for states where teen pregnancy rate is higher than average

DROP PROCEDURE IF EXISTS Query2HigherAvg //

CREATE PROCEDURE Query2HigherAvg()
BEGIN
	SELECT E.stateName, E.medianIncome
	FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
	WHERE H.teenPregnancyRate > (SELECT AVG(teenPregnancyRate) FROM Health);


END; //

-- get median income for states where teen pregnancy rate is higher than user defined value

DROP PROCEDURE IF EXISTS Query2HigherUserInput //

CREATE PROCEDURE Query2HigherUserInput(IN rate_param DOUBLE(5,2))
BEGIN
        SELECT E.stateName, E.medianIncome
        FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
        WHERE H.teenPregnancyRate > rate_param;


END; //

-- (for plot) get median income for states where teen pregnancy rate is lower than user defined value

DROP PROCEDURE IF EXISTS Query2LowerUserInput //

CREATE PROCEDURE Query2LowerUserInput(IN rate_param DOUBLE(5,2))
BEGIN
        SELECT E.stateName, E.medianIncome
        FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
        WHERE H.teenPregnancyRate < rate_param;


END; //

-- (for plot) get median income for states where teen pregnancy rate is higher than average

DROP PROCEDURE IF EXISTS Query2LowerAvg //

CREATE PROCEDURE Query2LowerAvg()
BEGIN
        SELECT E.stateName, E.medianIncome
        FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
        WHERE H.teenPregnancyRate < (SELECT AVG(teenPregnancyRate) FROM Health);


END; //

DELIMITER ;
