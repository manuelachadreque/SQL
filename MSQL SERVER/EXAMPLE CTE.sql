/*
Using SQL, identify and compare the top 10 sales orders per month:

Step 1: Identify the top 10 sales orders for each month.
Step 2: Calculate the sum of the top 10 orders for each month.
Step 3: Compare the monthly total to the total of the previous month.
*/

SELECT 
		OrderYear
			,OrderMonth
			,TOP10TotalDue
			, PREV_TOP10TotalDue=LAG(TOP10TotalDue) OVER(order by OrderYear, OrderMonth)
			
FROM(

	SELECT  OrderYear
			,OrderMonth
			,TOP10TotalDue=sum(TotalDue)
	FROM(
	SELECT OrderDate
			,TotalDue
			,OrderMonth = MONTH(OrderDate)
			,OrderYear = YEAR(OrderDate)
			,OrderRank=ROW_NUMBER() OVER(partition by Month(OrderDate) order by Year(TotalDue))
		
	FROM SALES.SalesOrderHeader
	) A 
	WHERE OrderRank<=10
	group by OrderYear,OrderMonth
	) B;



	/* using cte*/
	with step_1 as (
		SELECT OrderDate
			,TotalDue
			,OrderMonth = MONTH(OrderDate)
			,OrderYear = YEAR(OrderDate)
			,OrderRank=ROW_NUMBER() OVER(partition by Month(OrderDate) order by Year(TotalDue))
		
	FROM SALES.SalesOrderHeader
	),

	STEP_2 as(
		SELECT  OrderYear
			,OrderMonth
			,TOP10TotalDue=sum(TotalDue)
		from step_1
		WHERE OrderRank<=10
		group by OrderYear,OrderMonth
	),

	step_3 aS(
			SELECT OrderYear
			,OrderMonth
			,TOP10TotalDue
			, PREV_TOP10TotalDue=LAG(TOP10TotalDue) OVER(order by OrderYear, OrderMonth)
			FROM STEP_2
	)

	select * from STEP_3;



