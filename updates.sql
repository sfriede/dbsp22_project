
-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4

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
	IF EXISTS(SELECT * FROM Health WHERE stateName = stateName_param) THEN
	   SELECT 'invalid' AS PKCheck;
	ELSE
		IF EXISTS(SELECT * FROM States WHERE stateName = stateName_param) THEN
	   	     INSERT INTO Health VALUES (stateName_param, abortRate_param, homRate_param, drugOver_param, suicideRate_param, teenPregRate_param);
	   	ELSE 
		     INSERT INTO States VALUES(stateName_param, population_param);
	     	     INSERT INTO Health VALUES(stateName_param, abortRate_param, homRate_param, drugOver_param, suicideRate_param, teenPregRate_param);
	     	END IF;
		SELECT 'valid' AS PKCheck;
	END IF;

END; //
DELIMITER ;

-- For Phase E, we will be writing prepared statements in PHP to call this stored procedure using user input
-- This will look something like '$stmt = $conn->prepare('CALL InsertHealth(?, ?, ?, ?, ?, ?, ?);' and then the binding of parameters and execution.
-- For now, we'll just show the SQL statements to call this stored procedure using some predetermined values

CALL InsertHealth('Puerto Rico', 123456, 0.033333, 4.23, 40.3, 12.34, 14.54);

-- Statements for delelting a tuple from the Health table.
-- There aren't any foreign key constraints with Health (or any table except States) as the referenced table,
-- so deleting a tuple from one of those relations will not result in any cascading behavior.
-- This procedure also begins a little error checking by first ensuring that such a tuple for this state actually exists in Health.

DELIMITER //
DROP PROCEDURE IF EXISTS DeleteHealth //
CREATE PROCEDURE DeleteHealth(IN stateName_param VARCHAR(15))
BEGIN
	IF EXISTS(SELECT * FROM Health WHERE stateName = stateName_param) THEN
	   DELETE FROM Health WHERE stateName = stateName_param;
	   SELECT 'valid' AS existsCheck;
	ELSE
	   SELECT 'invalid' AS existsCheck;
	END IF;

END; //
DELIMITER ;

-- Again, for Phase E, we will be writing prepared statements in PHP to call this stored procedure using user input.
-- For now, we'll just show the SQL statements to call this stored procedure using some predetermined values

CALL DeleteHealth('Puerto Rico');

-- Stored procedure for deleting a tuple from the States table. This table is referenced in the foreign key
-- constraints for all other tables, so deleting this tuple will have a cascading effect and also delete the tuples
-- for this state from those relation. Again, a little error checking is performed by first ensuring such a tuple actually exists in States

DELIMITER //
DROP PROCEDURE IF EXISTS DeleteStates //
CREATE PROCEDURE DeleteStates(IN stateName_param VARCHAR(15))
BEGIN
	IF EXISTS(SELECT * FROM States WHERE stateName = stateName_param) THEN
	   DELETE FROM States WHERE stateName = stateName_param;
	   SELECT 'valid' AS existsCheck;
	ELSE
	   SELECT 'invalid' AS existsCheck;
	END IF;
END; //
DELIMITER ;

-- Again, for Phase E, we will be writing prepared statements in PHP to call this stored procedure using user input.
-- For now, we'll just show the SQL statements to call this stored procedure using some predetermined values
CALL DeleteStates('Puerto Rico');
