-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- stored procedures for query 12, one taking user input and one not

DELIMITER //

DROP PROCEDURE IF EXISTS Query12 //

CREATE PROCEDURE Query12() 
BEGIN  
   -- concatenate the assignment name list and associated expressions
   -- into a larger query string so we can execute it, but leave ?
   -- in place so we can plug in the specific sid value in a careful way
   

   SET @sql = CONCAT('WITH AggregateStats AS
                    (SELECT AVG(unemploymentRate) AS avgUnemploymentRate, STD(unemploymentRate) AS stddevUnemploymentRate
                    FROM Economy)
                    SELECT E.stateName, H.abortionRate, H.homicideRate, H.drugOverdoses, H.suicideRate, H.teenPregnancyRate
                    FROM Health AS H JOIN Economy AS E ON H.stateName = E.stateName
                    WHERE E.unemploymentRate >= (SELECT avgUnemploymentRate FROM AggregateStats) + 1.5*(SELECT stddevUnemploymentRate FROM AggregateStats);');
   -- alert the server we have a statement shell to set up
   PREPARE stmt FROM @sql;

   -- now execute the statement shell
   EXECUTE stmt;

   -- tear down the prepared shell since no longer needed (we won't requery it)
   DEALLOCATE PREPARE stmt;
END; 
//

-- version of query 12 that takes UI

DROP PROCEDURE IF EXISTS Query12UI //

CREATE PROCEDURE Query12UI(IN stddev FLOAT(10,2))
BEGIN
	SELECT Economy.stateName, unemploymentRate, abortionRate, homicideRate, drugOverdoses, suicideRate, teenPregnancyRate, cancerMortality, STIsPer100k, obesityPrevalence
	FROM Economy JOIN Health ON Economy.stateName = Health.stateName JOIN RiskFactors ON Health.stateName = RiskFactors.stateName
	WHERE unemploymentRate >= (SELECT AVG(unemploymentRate) + stddev*STD(unemploymentRate) FROM Economy);

END;
//

-- version of query 12 that computes average statistics for all data

DROP PROCEDURE IF EXISTS Query12Avg //
CREATE PROCEDURE Query12Avg()
BEGIN
        SELECT FORMAT(AVG(unemploymentRate), 3), FORMAT(AVG(abortionRate), 5), FORMAT(AVG(homicideRate), 3), FORMAT(AVG(drugOverdoses), 3), FORMAT(AVG(suicideRate), 3), FORMAT(AVG(teenPregnancyRate), 3), FORMAT(AVG(cancerMortality), 3), FORMAT(AVG(STIsPer100k),3), FORMAT(AVG(obesityPrevalence),3)
        FROM Economy JOIN Health ON Economy.stateName = Health.stateName JOIN RiskFactors ON Health.stateName = RiskFactors.stateName;

END;//

DELIMITER ;


