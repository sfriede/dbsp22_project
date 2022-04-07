DROP TABLE IF EXISTS Health;
DROP TABLE IF EXISTS RiskFactors;
DROP TABLE IF EXISTS Education;
DROP TABLE IF EXISTS Economy;
DROP TABLE IF EXISTS Demographics;
DROP TABLE IF EXISTS States;



CREATE TABLE States
(
stateName       VARCHAR(15),
population      INT,
PRIMARY KEY(stateName),
CHECK(population >= 0)
);

CREATE TABLE Demographics
(
stateName            VARCHAR(15),
white                FLOAT(5,2),
black                FLOAT(5,2),
asian                FLOAT(5,2),
indigenous           FLOAT(5,2),
other                FLOAT(5,2),
hispanicOrLatino     FLOAT(5,2),
notHispanicOrLatino  FLOAT(5,2),
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

CREATE TABLE Economy
(
stateName                       VARCHAR(15),
percentInPoverty                FLOAT(5,2),
unemploymentRate                FLOAT(5,2),
realGDP                         FLOAT(10,2),
numberUnhoused                  INT, 
medianIncome                    INT,     
foreignBornMedianIncome         INT, 
USBornMedianIncome              INT,                     
PRIMARY KEY(stateName),
FOREIGN KEY(stateName) REFERENCES States(stateName) ON DELETE CASCADE ON UPDATE CASCADE,
CHECK(percentInPoverty BETWEEN 0 AND 100),
CHECK(unemploymentRate BETWEEN 0 AND 100),
CHECK(realGDP >= 0),
CHECK(numberUnhoused >= 0),
CHECK(medianIncome >= 0),
CHECK(foreignBornMedianIncome >= 0),
CHECK(USBornMedianIncome >= 0)
);


CREATE TABLE Health
(
stateName       VARCHAR(15),
abortionRate    FLOAT(5, 5),
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

CREATE TABLE Education
(
stateName       VARCHAR(15),
avgTeacherStartingSalary   INT,
avgSATScore    INT, 
avgACTScore     INT,
NAEPScoreReading        INT,
NAEPScoreMath   INT,
highschoolGradRate      FLOAT(4,2),
percentCompletingCollege       FLOAT(4, 4),
eduSpendingPerPupil     FLOAT(10, 3),
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

LOAD DATA INFILE 'C:\Users\Sydney\Desktop\databases\health-small.csv' 
INTO TABLE Health 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE 'C:\Users\Sydney\Desktop\databases\riskFactors-small.csv' 
INTO TABLE RiskFactors 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\Users\Sydney\Desktop\databases\education-small.csv' 
INTO TABLE Education 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
