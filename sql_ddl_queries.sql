-- creating tables with the appropriate schema:

CREATE TABLE PerformanceRating (
    PerformanceID VARCHAR(100),
    EmployeeID VARCHAR(100),
    ReviewDate VARCHAR(100),
    EnvironmentSatisfaction VARCHAR(100),
    JobSatisfaction VARCHAR(100),
    RelationshipSatisfaction VARCHAR(100),
    TrainingOpportunitiesWithinYear INT,
    TrainingOpportunitiesTaken INT,
    WorkLifeBalance VARCHAR(100),
    SelfRatingID INT,
    SelfRating VARCHAR(100),
    ManagerRatingID INT,
    ManagerRating VARCHAR(100));

ALTER TABLE PerformanceRating
MODIFY COLUMN ReviewDate DATE;

CREATE TABLE Employee (
EmployeeID VARCHAR(100),
FirstName VARCHAR(100),
LastName VARCHAR(100),
Gender VARCHAR(100), Age INT,
BusinessTravel VARCHAR(100),	
Department VARCHAR(100),
DistanceFromHome_KM INT,	
State VARCHAR(50),
Ethnicity VARCHAR(100), Education INT,	
EducationField VARCHAR(100),	
JobRole	VARCHAR(100),
MaritalStatus VARCHAR(100),	Salary INT,
StockOptionLevel INT,
OverTime VARCHAR(50),
HireDate VARCHAR(50),
Attrition VARCHAR(50),
YearsAtCompany INT,
YearsInMostRecentRole INT,	
YearsSinceLastPromotion	INT,
YearsWithCurrManager INT);

ALTER TABLE Employee
MODIFY COLUMN HireDate DATE;

CREATE TABLE EducationLevel (
EducationLevelID INT,
EducationLevel VARCHAR(50))