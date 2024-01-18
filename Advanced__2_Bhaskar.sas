/* DSCI 519 Advanced Business Analytics Modelling */
/* Chapter Exercise 2 - Querying Rows*/
/* Bhaskar Teja Ulichi [101127292] */


*1. Eliminating Duplicates;
PROC SQL;
	SELECT DISTINCT CITY 
	FROM orion.employee_addresses;
QUIT;


*2. Subsetting Data;
PROC SQL;
	SELECT Employee_ID, Recipients, SUM(Qtr1, Qtr2, Qtr3, Qtr4) as Total 
	FROM orion.employee_donations 
	WHERE Calculated Total > 90;
QUIT;


*3 Subsetting Data Using the ESCAPE Clause;
PROC SQL;
	SELECT Employee_ID, Recipients, 
	(CASE WHEN Qtr1 >1 then 1 ELSE 0 END +
	CASE WHEN Qtr2 >1 then 1 ELSE 0 END +
	CASE WHEN Qtr3 >1 then 1 ELSE 0 END +
	CASE WHEN Qtr4 >1 then 1 ELSE 0 END) As no_of_contribs 
	FROM orion.employee_donations 
	WHERE Recipients CONTAINS '%' AND 
	(Calculated no_of_contribs=1 or Calculated no_of_contribs=2);
QUIT;