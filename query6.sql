-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- query 6 (modified to take user input): For states with the highest and lowest median incomes, what is the difference between the US-born and foreign-born median incomes, and how racially diverse is this state? what does this look like for a state of the user's choice? 

DELIMITER //

-- get median income for states where teen pregnancy rate is higher than average

DROP PROCEDURE IF EXISTS Query6 //

CREATE PROCEDURE Query6(IN stateName_param VARCHAR(15))
BEGIN
	IF (EXISTS(SELECT * FROM Demographics WHERE stateName = stateName_param) AND EXISTS(SELECT * FROM Economoy WHERE stateName = stateName_param)) THEN
	SELECT * FROM (
	
        SELECT AVG(E.foreignBornMedianIncome) AS 'maxForeign', AVG(E.USBornMedianIncome) AS 'maxUS', AVG(D.white) AS 'maxWhite', AVG(D.black) AS 'maxBlack', AVG(D.asian) AS 'maxAsian', AVG(D.indigenous) AS 'maxIndigenous', AVG(D.other) AS 'maxOther', AVG(D.hispanicOrLatino) AS 'maxHispanic', AVG(D.notHispanicOrLatino) AS 'maxNonHispanic'
	FROM Demographics AS D JOIN Economy AS E ON D.stateName = E.stateName
	WHERE E.medianIncome = (SELECT MAX(medianIncome) FROM Economy)
	
	UNION ALL
	
	SELECT AVG(E.foreignBornMedianIncome) AS 'minForeign', AVG(E.USBornMedianIncome) AS 'minUS', AVG(D.white) AS 'minWhite', AVG(D.black) AS 'minBlack', AVG(D.asian) AS 'minAsian', AVG(D.indigenous) AS 'minIndigenous', AVG(D.other) AS 'minOther', AVG(D.hispanicOrLatino) AS 'minHispanic', AVG(D.notHispanicOrLatino) AS 'minNonHispanic'
        FROM Demographics AS D JOIN Economy AS E ON D.stateName = E.stateName
        WHERE E.medianIncome = (SELECT MIN(medianIncome) FROM Economy)
	
	UNION ALL
	
	SELECT E.foreignBornMedianIncome, E.USBornMedianIncome, D.white, D.black, D.asian, D.indigenous, D.other, D.hispanicOrLatino, D.notHispanicOrLatino
	FROM Demographics AS D JOIN Economy AS E ON D.stateName = E.stateName 
	WHERE D.stateName = stateName_param) AS AllStats;
	ELSE
	SELECT 'no such state';	
	END IF;

END; //

DELIMITER ;
