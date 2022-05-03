-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

DELIMITER //


DROP PROCEDURE IF EXISTS Query11 //

CREATE PROCEDURE Query11(IN factor VARCHAR(30))
BEGIN
    IF factor = "percentInPoverty" THEN
        SELECT E.stateName, E.percentInPoverty, H.suicideRate, H.teenPregnancyRate 
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName
        ORDER BY E.repercentInPovertyalGDP DESC;
    ELSEIF factor = "realGDP" THEN
        SELECT E.stateName, E.realGDP, H.suicideRate, H.teenPregnancyRate 
        FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName
        ORDER BY E.realGDP DESC;
    END IF;

END; //

DELIMITER ;
