-- Sydney Friedel and Shelby Coe
-- sfriede5 and scoe4
-- Procedures for deleting from all tables excpet States


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
           SELECT 'There was a record for this state in the table, and it was successfully deleted' AS existsCheck;
        ELSE
           SELECT 'There was not a record for this state in the table' AS existsCheck;
        END IF;

END; //
DELIMITER ;

-- Statements for delelting a tuple from the Education table.
-- There aren't any foreign key constraints with Education (or any table except States) as the referenced table,
-- so deleting a tuple from one of those relations will not result in any cascading behavior.
-- This procedure also begins a little error checking by first ensuring that such a tuple for this state actually exists in Education.

DELIMITER //
DROP PROCEDURE IF EXISTS DeleteEducation //
CREATE PROCEDURE DeleteEducation(IN stateName_param VARCHAR(15))
BEGIN
        IF EXISTS(SELECT * FROM Education WHERE stateName = stateName_param) THEN
           DELETE FROM Education WHERE stateName = stateName_param;
           SELECT 'There was a record for this state in the table, and it was successfully deleted' AS existsCheck;
        ELSE
           SELECT 'There was not a record for this state in this table' AS existsCheck;
        END IF;

END; //
DELIMITER ;

-- Statements for delelting a tuple from the Education table.
-- There aren't any foreign key constraints with Health (or any table except States) as the referenced table,
-- so deleting a tuple from one of those relations will not result in any cascading behavior.
-- This procedure also begins a little error checking by first ensuring that such a tuple for this state actually exists in Education.

DELIMITER //
DROP PROCEDURE IF EXISTS DeleteRiskFactors //
CREATE PROCEDURE DeleteRiskFactors(IN stateName_param VARCHAR(15))
BEGIN
        IF EXISTS(SELECT * FROM RiskFactors WHERE stateName = stateName_param) THEN
           DELETE FROM RiskFactors WHERE stateName = stateName_param;
           SELECT 'There was a record for this state in the table, and it was successfully deleted' AS existsCheck;
        ELSE
           SELECT 'There was not a record for this state in this table' AS existsCheck;
        END IF;

END; //
DELIMITER ;
