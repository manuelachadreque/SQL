/*
Recursive CTEs - Exercises
Exercise 1


Use a recursive CTE to generate a list of all odd numbers between 1 and 1000.

Hint: You should be able to do this with just a couple slight tweaks to the code from our first example in the video.

*/

--select 1 as mynumber;

with oddnumbers as(

	select 1 as mynumber
	union all
	select mynumber+2
	from oddnumbers
	where mynumber<=1000
)

select * from oddnumbers
OPTION(MAXRECURSION 1000);


/*
Exercise 2


Use a recursive CTE to generate a date series of all FIRST days of the month (1/1/2021, 2/1/2021, etc.)

from 1/1/2020 to 12/1/2029.

Hints:

Use the DATEADD function strategically in your recursive member.

You may also have to modify MAXRECURSION.

*/
with FirstDaysMonth AS 
	(

	SELECT CAST('01/01/2021' AS date) AS FirstDay
	UNION ALL

	SELECT 
	DATEADD(MONTH, 1, FirstDay) 
	FROM FirstDaysMonth
	WHERE  FirstDay<CAST('12/01/2029' AS DATE)
	)

SELECT * FROM FirstDaysMonth
OPTION (MAXRECURSION 110);
