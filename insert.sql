-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- procedures for inderting into all tables except States
-- foreign key constraints and primary constraints are managed with error handling
-- integrity constraints (data types for each attribute) are handled via input validation on the PHP level


-- Statements for inserting a new tuple into the Health table
-- First checks if the state we're inserting a Health tuple for already exists in the States table.
-- If it does, foregin key constraints are satisfied, so we can just perform the insertion.
-- If it doesn't exist, we have to first insert into the States table for this new state to satisfy foreign key constraints
-- The procedure also does primary key constraint error checking in case the user is trying to insert a tuple for a state that
-- already has an associated Health tuple. This error will mostly be handled on the PHP level in Phase E.

DELIMITER //
DROP PROCEDURE IF EXISTS InsertHealth //

CREATE PROCEDURE InsertHealth(IN stateName_param VARCHAR(15), IN population_param INTEGER, IN abortRate_param FLOAT(10,7) , IN homRate_param FLOAT(5,2), IN suicideRate_param FLOAT(5,2),IN drugOver_param FLOAT(5,2), IN teenPregRate_param FLOAT(5,2))
BEGIN
        DECLARE CONTINUE HANDLER FOR 1062
	 BEGIN
        SELECT 'Error, a record for this state/territory already exists in the Health table';
	 END;
	
	DECLARE CONTINUE HANDLER FOR 1264
	BEGIN 
	      SELECT 'Error, a supplied value was out of range. Please input numeric values within the specified ranges and number of decimal places';
	END;
	
        IF EXISTS(SELECT * FROM States WHERE stateName = stateName_param) THEN
		   INSERT INTO Health VALUES (stateName_param, abortRate_param, homRate_param, drugOver_param, suicideRate_param, teenPregRate_param);
		  
	ELSE
                   INSERT INTO States VALUES(stateName_param, population_param);
                   INSERT INTO Health VALUES(stateName_param, abortRate_param, homRate_param, drugOver_param, suicideRate_param, teenPregRate_param);
        END IF;      

END; //
DELIMITER ;

-- Statements for inserting a new tuple into the Education table
-- First checks if the state we're inserting a Health tuple for already exists in the States table.
-- If it does, foregin key constraints are satisfied, so we can just perform the insertion.
-- If it doesn't exist, we have to first insert into the States table for this new state to satisfy foreign key constraints
-- The procedure also does primary key constraint error checking in case the user is trying to insert a tuple for a state that
-- already has an associated Health tuple. This error will mostly be handled on the PHP level in Phase E.

DELIMITER //
DROP PROCEDURE IF EXISTS InsertEducation //

CREATE PROCEDURE InsertEducation(IN stateName_param VARCHAR(15), IN population_param INTEGER, IN teacherSal_param INT , IN avgSAT_param INT, IN avgACT_param FLOAT(4,2),IN NAEPReading_param INT, IN NAEPMath_param INT, IN hsGradRate_param FLOAT(5,2), IN percentCollege_param FLOAT(5,2), IN eduSpending_param FLOAT(10,5))
BEGIN
        DECLARE CONTINUE HANDLER FOR 1062
        SELECT 'Error, a record for this state/territory already exists in the Education table';

        DECLARE CONTINUE HANDLER FOR 1264
        SELECT 'Error, a supplied value was out of range. Please input numeric values within the specified ranges and number of decimal places';

	DECLARE CONTINUE HANDLER FOR 4025
        SELECT 'Error, a supplied value was out of range. Please input numeric values within the specified ranges and number of decimal places';

        IF EXISTS(SELECT * FROM States WHERE stateName = stateName_param) THEN
                   INSERT INTO Education VALUES (stateName_param, teacherSal_param, avgSAT_param, avgACT_param, NAEPReading_param, NAEPMath_param, hsGradRate_param, percentCollege_param, eduSpending_param);

        ELSE
                   INSERT INTO States VALUES(stateName_param, population_param);
		   INSERT INTO Education VALUES (stateName_param, teacherSal_param, avgSAT_param, avgACT_param, NAEPReading_param, NAEPMath_param, hsGradRate_param, percentCollege_param, eduSpending_param);
                
        END IF;

END; //
DELIMITER ;

-- Statements for inserting a new tuple into the RiskFactors table
-- First checks if the state we're inserting a RiskFactors tuple for already exists in the States table.
-- If it does, foregin key constraints are satisfied, so we can just perform the insertion.
-- If it doesn't exist, we have to first insert into the States table for this new state to satisfy foreign key constraints
-- The procedure also does primary key constraint error checking in case the user is trying to insert a tuple for a state that
-- already has an associated RiskFactors tuple. This error will mostly be handled on the PHP level in Phase E.

DELIMITER //
DROP PROCEDURE IF EXISTS InsertRiskFactors //

CREATE PROCEDURE InsertRiskFactors(IN stateName_param VARCHAR(15), IN population_param INTEGER, IN cancer_param FLOAT(5,2),obesity_param FLOAT(4,2), sti_param INT)
BEGIN
        DECLARE CONTINUE HANDLER FOR 1062
        SELECT 'Error, a record for this state/territory already exists in the RiskFactors table';

        DECLARE CONTINUE HANDLER FOR 1264
        SELECT 'Error, a supplied value was out of range. Please input numeric values within the specified ranges and number of decimal places';

        DECLARE CONTINUE HANDLER FOR 4025
        SELECT 'Error, a supplied value was out of range. Please input numeric values within the specified ranges and number of decimal places';

        IF EXISTS(SELECT * FROM States WHERE stateName = stateName_param) THEN
                   INSERT INTO RiskFactors VALUES(stateName_param, cancer_param, sti_param, obesity_param);

        ELSE
                   INSERT INTO States VALUES(stateName_param, population_param);
                   INSERT INTO RiskFactors VALUES(stateName_param, cancer_param, sti_param, obesity_param);

        END IF;

END; //
DELIMITER ;

