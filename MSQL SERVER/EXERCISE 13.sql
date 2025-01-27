/*
CTEs - Exercise
For this exercise, assume the CEO of our fictional company decided that the top 10 orders per month are actually outliers that need to be clipped out of our data before doing meaningful analysis.

Further, she would like the sum of sales AND purchases (minus these "outliers") listed side by side, by month.

We've got a query that already does this (see the file "CTEs - Exercise Starter Code.sql" in the resources for this section), but it's messy and hard to read. Re-write it using a CTE so other analysts can read and understand the code.



Hint: You are comparing data from two different sources (sales vs purchases), so you may not be able to re-use a CTE like we did in the video.
	

*/

with step1 as(
SELECT OrderMonth=MONTH(OrderDate)
		,OrderYear=YEAR(OrderDate) 
		, TotalDue

		,OrderRank=ROW_NUMBER() over(partition by  Year(OrderDate), Month(OrderDate) Order by TotalDue desc)


		FROM SALES.SalesOrderHeader

		--order by YEAR(OrderDate), MONTH(OrderDate)
),

step2 as(
	SELECT OrderYear
			,OrderMonth
			,MoNtlyTotalDueExcludingOutliers=SUM(TotalDue)
	from step1
	where OrderRank>10
	group by OrderYear
			, OrderMonth
	)

select * from step2
	order by OrderYear
			,OrderMonth;

--select * from sales.SalesOrderHeader


