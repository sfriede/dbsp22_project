-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

DELIMITER //


DROP PROCEDURE IF EXISTS Query11 //

CREATE PROCEDURE Query11(IN factor VARCHAR(30))
BEGIN
    IF factor = "percentInPoverty" THEN
        SELECT E.stateName, E.percentInPoverty, H.suicideRate, H.teenPregnancyRate, H.drugOverdoses, R.cancerMortality, R.obesityPrevalence, R.STISPer100K
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName JOIN RiskFactors AS R ON E.stateName = R.stateName
        ORDER BY E.percentInPoverty DESC;
    ELSEIF factor = "unemploymentRate" THEN
        SELECT E.stateName, E.unemploymentRate, H.suicideRate, H.teenPregnancyRate,  H.drugOverdoses, R.cancerMortality, R.obesityPrevalence, R.STISPer100K
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName JOIN RiskFactors AS R ON E.stateName = R.stateName
        ORDER BY E.unemploymentRate DESC;
    ELSEIF factor = "realGDP" THEN
        SELECT E.stateName, E.realGDP, H.suicideRate, H.teenPregnancyRate, H.drugOverdoses, R.cancerMortality, R.obesityPrevalence, R.STISPer100K
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName JOIN RiskFactors AS R ON E.stateName = R.stateName
        ORDER BY E.realGDP DESC;
    ELSEIF factor = "percentUnhoused" THEN
        SELECT E.stateName, E.percentUnhoused, H.suicideRate, H.teenPregnancyRate,  H.drugOverdoses, R.cancerMortality, R.obesityPrevalence, R.STISPer100K
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName JOIN RiskFactors AS R ON E.stateName = R.stateName
        ORDER BY E.percentUnhoused DESC;
    ELSEIF factor = "homelessnessRatePer10000" THEN
        SELECT E.stateName, E.homelessnessRatePer10000, H.suicideRate, H.teenPregnancyRate, H.drugOverdoses, R.cancerMortality, R.obesityPrevalence, R.STISPer100K
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName  JOIN RiskFactors AS R ON E.stateName = R.stateName
        ORDER BY E.homelessnessRatePer10000 DESC;
    ELSEIF factor = "medianIncome" THEN
        SELECT E.stateName, E.medianIncome, H.suicideRate, H.teenPregnancyRate, H.drugOverdoses, R.cancerMortality, R.obesityPrevalence, R.STISPer100K 
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName  JOIN RiskFactors AS R ON E.stateName = R.stateName
        ORDER BY E.medianIncome DESC;
    ELSEIF factor = "foreignBornMedianIncome" THEN
        SELECT E.stateName, E.foreignBornMedianIncome, H.suicideRate, H.teenPregnancyRate, H.drugOverdoses, R.cancerMortality, R.obesityPrevalence, R.STISPer100K
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName  JOIN RiskFactors AS R ON E.stateName = R.stateName
        ORDER BY E.foreignBornMedianIncome DESC;
    ELSEIF factor = "USBornMedianIncome" THEN
        SELECT E.stateName, E.USBornMedianIncome, H.suicideRate, H.teenPregnancyRate, H.drugOverdoses, R.cancerMortality, R.obesityPrevalence, R.STISPer100K 
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName  JOIN RiskFactors AS R ON E.stateName = R.stateName
        ORDER BY E.USBornMedianIncome DESC;
    END IF;

END; //

DELIMITER ;
