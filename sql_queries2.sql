-- we'll be focusing on understanding Atlas Labs diversity and inclusion metrics and building multiple 
-- visuals to track individual employee performance reviews
-- Current employees by age groups, gender
SELECT COUNT(*), gender,
	(CASE 
		WHEN Age < 20 THEN "under 20"
        WHEN Age >= 20 AND Age < 30 THEN "20-29"
        WHEN Age >= 30 AND Age < 40 THEN "30-39"
        WHEN Age >= 40 AND Age < 50 THEN "40-49"
        ELSE "over 50"
	END) AS AgeBins
FROM Employee
WHERE Attrition = "No"
GROUP BY AgeBins, gender
ORDER BY AgeBins, COUNT(*) DESC;

-- Answering some questions:
-- What percentage of current employees are female between the ages 40-49? 45.10%

WITH cte1 AS (
	SELECT *	
	FROM Employee
	WHERE Age >= 40 AND Age < 50 AND Attrition = "No"
)
SELECT ROUND((SELECT COUNT(*) FROM cte1 WHERE Gender = "Female") / COUNT(*) * 100, 2) AS ratio
FROM cte1;

-- Current employees by marital status
SELECT MaritalStatus, COUNT(*) AS count_of_employees
FROM Employee
WHERE Attrition = "No"
GROUP BY MaritalStatus
ORDER BY count_of_employees DESC;

-- Current employees and their average salary by Ethnicity
SELECT Ethnicity, ROUND(AVG(Salary), 0) AS average_salary, 
	COUNT(CASE WHEN Attrition = "No" THEN 1 ELSE 0 END) AS total_current_empl
FROM Employee
GROUP BY Ethnicity 
ORDER BY average_salary DESC;

-- Creating table full name & review date
SELECT CONCAT(LastName, " ", FirstName) AS full_name, ReviewDate
FROM Employee e
	JOIN PerformanceRating pr ON e.EmployeeID = pr.EmployeeID;

-- Latest Review Date of each employee and full name
SELECT CONCAT(LastName, " ", FirstName) AS full_name, MAX(ReviewDate)
FROM Employee e
	JOIN PerformanceRating pr ON e.EmployeeID = pr.EmployeeID
GROUP BY full_name;

-- Latest environment score within current employees for specific employee
WITH cte AS (
    SELECT 
        CONCAT(FirstName, " ", LastName) AS full_name, 
        ReviewDate, 
        EnvironmentSatisfaction,
        ROW_NUMBER() OVER (PARTITION BY CONCAT(FirstName, " ", LastName) ORDER BY ReviewDate DESC) AS row_num
    FROM Employee e
    JOIN PerformanceRating pr ON e.EmployeeID = pr.EmployeeID
    WHERE Attrition = "No" AND EnvironmentSatisfaction IS NOT NULL
)
SELECT 
    full_name, 
    ReviewDate, 
    EnvironmentSatisfaction
FROM cte
WHERE row_num = 1 AND full_name = "Estelle Chung";