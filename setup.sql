-- Shelby Coe and Sydney Friedel
-- scoe4 and sfriede5


-- Describe the schema for the States relation
-- Each tuple contains a state's name and population

CREATE TABLE States
(
stateName       VARCHAR(15),
population      INTEGER,
PRIMARY KEY(stateName),
CHECK(population >= 0)
);


-- Describe the schema for the Demographics relation
-- Each tuple hold the demographics statistics for a particular state

CREATE TABLE Demographics
(
stateName            VARCHAR(15),
white                FLOAT(7,4),
black                FLOAT(7,4),
asian                FLOAT(7,4),
indigenous           FLOAT(7,4),
other                FLOAT(7,4),
hispanicOrLatino     FLOAT(7,4),
notHispanicOrLatino  FLOAT(8,4),
PRIMARY KEY(stateName),
FOREIGN KEY(stateName) REFERENCES States(stateName) ON DELETE CASCADE ON UPDATE CASCADE,
CHECK(white BETWEEN 0 AND 100),
CHECK(black BETWEEN 0 AND 100),
CHECK(asian BETWEEN 0 AND 100) ,
CHECK(indigenous BETWEEN 0 AND 100),
CHECK(other BETWEEN 0 AND 100),
CHECK(hispanicOrLatino BETWEEN 0 AND 100) ,
CHECK(notHispanicOrLatino BETWEEN 0 AND 100)
);


-- Describe the schema for the Economy relation
-- Each tuple contains the economic information for a given state

CREATE TABLE Economy
(
stateName                       VARCHAR(15),
percentInPoverty                FLOAT(5,2),
unemploymentRate                FLOAT(5,2),
realGDP                         FLOAT(10,2),
percentUnhoused                 FLOAT(10,9),
homelessnessRatePer10000        FLOAT(6,2),
medianIncome                    INT,     
foreignBornMedianIncome         INT, 
USBornMedianIncome              INT,                     
PRIMARY KEY(stateName),
FOREIGN KEY(stateName) REFERENCES States(stateName) ON DELETE CASCADE ON UPDATE CASCADE,
CHECK(percentInPoverty BETWEEN 0 AND 100),
CHECK(unemploymentRate BETWEEN 0 AND 100),
CHECK(realGDP >= 0),
CHECK(percentUnhoused BETWEEN 0 AND 100),
CHECK(homelessnessRatePer10000 >= 0),
CHECK(medianIncome >= 0),
CHECK(foreignBornMedianIncome >= 0),
CHECK(USBornMedianIncome >= 0)
);

-- Describe the schema for the Health relation
-- Each tuple contains the health statistics for a given state

CREATE TABLE Health
(
stateName       VARCHAR(15),
abortionRate    FLOAT(10, 7),
homicideRate    FLOAT(5, 2), 
drugOverdoses   FLOAT(5, 2),
suicideRate     FLOAT(5, 2),
teenPregnancyRate       FLOAT(5, 2),
PRIMARY KEY(stateName),
FOREIGN KEY(stateName) REFERENCES States(stateName) ON DELETE CASCADE ON UPDATE CASCADE,
CHECK(abortionRate BETWEEN 0 AND 100),
CHECK(homicideRate BETWEEN 0 AND 100),
CHECK(suicideRate BETWEEN 0 AND 100) ,
CHECK(teenPregnancyRate BETWEEN 0 AND 100)
);

-- Describe schema for the RiskFactors relation
-- Each tuple contains statistics about different health risk factors for a given state

CREATE TABLE RiskFactors
(
stateName       VARCHAR(15),
cancerMortality   FLOAT(5, 2),
STISPer100K    INT, 
obesityPrevalence   FLOAT(4, 2),
PRIMARY KEY(stateName),
FOREIGN KEY(stateName) REFERENCES States(stateName) ON DELETE CASCADE ON UPDATE CASCADE,
CHECK(cancerMortality >= 0),
CHECK(STISPer100K >= 0),
CHECK(obesityPrevalence BETWEEN 0 AND 100)
);

-- Describe the schema for the Education relation
-- Each tuple contains education statistics for a given state

CREATE TABLE Education
(
stateName       VARCHAR(15),
avgTeacherStartingSalary   INT,
avgSATScore    INT, 
avgACTScore     FLOAT(4, 2),
NAEPScoreReading        INT,
NAEPScoreMath   INT,
highschoolGradRate      FLOAT(5,2),
percentCompletingCollege       FLOAT(5, 2),
eduSpendingPerPupil     FLOAT(10, 5),
PRIMARY KEY(stateName),
FOREIGN KEY(stateName) REFERENCES States(stateName) ON DELETE CASCADE ON UPDATE CASCADE,
CHECK(avgACTScore BETWEEN 0 AND 36),
CHECK(avgSATScore BETWEEN 0 AND 1600),
CHECK(NAEPScoreReading BETWEEN 0 AND 500),
CHECK(NAEPScoreMath BETWEEN 0 AND 500),
CHECK(avgTeacherStartingSalary >= 0),
CHECK(highschoolGradRate BETWEEN 0 AND 100),
CHECK(percentCompletingCollege BETWEEN 0 AND 100),
CHECK(eduSpendingPerPupil >= 0)
);


-- Load the data from each .txt file into the appropriate table

LOAD DATA LOCAL INFILE 'state.txt'
INTO TABLE States 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'demographics.txt'
INTO TABLE Demographics 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'health.txt' 
INTO TABLE Health 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'riskFactors.txt' 
INTO TABLE RiskFactors 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'education.txt' 
INTO TABLE Education 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'economy.txt'
INTO TABLE Economy 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
