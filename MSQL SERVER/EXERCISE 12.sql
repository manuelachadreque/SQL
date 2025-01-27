--PIVOT - Exercises

/*
Exercise 1
Using PIVOT, write a query against the HumanResources.Employee table

that summarizes the average amount of vacation time for Sales Representatives, Buyers, and Janitors.

Your output should look like the image below.

*/


select * 
from(
	select 
		JobTitle
		, VacationHours
		from HumanResources.Employee
) A
PIVOT (
		AVG(VacationHours) FOR JobTitle in("Sales Representative", Buyer, Janitor)
		) B;

-- SELECT Distinct JobTitle FROM HumanResources.Employee

/*
Exercise 2


Modify your query from Exercise 1 such that the results are broken out by Gender. Alias the Gender field as "Employee Gender" in your output.

Your output should look like the image below:

*/
SELECT
	CASE WHEN GENDER ='M' THEN 'Male' ELSE 'Female' END AS GENDER
	,"Sales Representative", "Janitor", "Buyer"
FROM
(
SELECT Gender
		,JobTitle
		,VacationHours
FROM HumanResources.Employee) A
PIVOT (
	AVG(VacationHours) FOR JobTitle IN("Sales Representative", "Janitor", "Buyer") 

)B