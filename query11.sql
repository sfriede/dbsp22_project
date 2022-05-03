-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

DELIMITER //

DROP PROCEDURE IF EXISTS Query11 //

CREATE PROCEDURE Query11(IN factor VARCHAR(20))
BEGIN    
    
        --  MODIFIED CODE FROM 4/19 CLASS
        SET @sql = NULL;
   
        SET @sql = CONCAT('SELECT E.stateName, H.suicideRate, H.teenPregnancyRate 
                            FROM Economy AS E JOIN Health AS H ON E.stateName = H.stateName
                            ORDER BY ', '?');
        
        /* WITH HighestStates AS (SELECT stateName
                            FROM Economy
                            ORDER BY ', '?',' DESC
                            LIMIT 10),
                            LowestStates AS (SELECT stateName
                            FROM Economy
                            ORDER BY ', '?',' ASC
                            LIMIT 10)
                            
                            WHERE E.stateName IN (SELECT * FROM HighestStates) OR E.stateName IN (SELECT * FROM LowestStates)*/

        -- alert the server we have a statement shell to set up
        PREPARE stmt FROM @sql;

         -- now execute the statement shell with a value plugged in for the ?
        EXECUTE stmt USING factor;

        -- tear down the prepared shell since no longer needed (we won't requery it)
        DEALLOCATE PREPARE stmt;
   
END; //

DELIMITER ;