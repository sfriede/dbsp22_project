-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- stored procedures for query 5


DELIMITER //


DROP PROCEDURE IF EXISTS Query5 //

CREATE PROCEDURE Query5(IN factor VARCHAR(30))
BEGIN
    IF factor = "abortionRate" THEN
        WITH AggregateStats AS
                    (SELECT AVG(abortionRate) AS avgRate, STD(abortionRate) AS stddev FROM Health)
                    SELECT E.stateName, H.abortionRate, E.medianIncome
                    FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
                    WHERE H.abortionRate >= (SELECT avgRate FROM AggregateStats)
		    ORDER BY H.abortionRate DESC;
    ELSEIF factor = "homicideRate" THEN
        WITH AggregateStats AS
                    (SELECT AVG(homicideRate) AS avgRate, STD(homicideRate) AS stddev FROM Health)
                    SELECT E.stateName, H.homicideRate, E.medianIncome
                    FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
                    WHERE H.homicideRate >= (SELECT avgRate FROM AggregateStats)
		    ORDER BY H.homicideRate DESC;
    ELSEIF factor = "drugOverdoses" THEN
        WITH AggregateStats AS
                    (SELECT AVG(drugOverdoses) AS avgRate, STD(drugOverdoses) AS stddev FROM Health)
                    SELECT E.stateName, H.drugOverdoses, E.medianIncome
                    FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
                    WHERE H.drugOverdoses >= (SELECT avgRate FROM AggregateStats)
		    ORDER BY H.drugOverdoses DESC;
    ELSEIF factor = "suicideRate" THEN
        WITH AggregateStats AS
                    (SELECT AVG(suicideRate) AS avgRate, STD(suicideRate) AS stddev FROM Health)
                    SELECT E.stateName, H.suicideRate, E.medianIncome
                    FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
                    WHERE H.suicideRate >= (SELECT avgRate FROM AggregateStats)
		    ORDER BY H.suicideRate DESC;
    ELSEIF factor = "teenPregnancyRate" THEN
        WITH AggregateStats AS
                    (SELECT AVG(teenPregnancyRate) AS avgRate, STD(teenPregnancyRate) AS stddev FROM Health)
                    SELECT E.stateName, H.teenPregnancyRate, E.medianIncome
                    FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
                    WHERE H.teenPregnancyRate >= (SELECT avgRate FROM AggregateStats)
		    ORDER BY H.teenPregnancyRate DESC;
    END IF;

END; //

DELIMITER ;
