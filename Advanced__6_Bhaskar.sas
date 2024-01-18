/* DSCI 519 Advanced Business Analytics Modelling */
/* Chapter Exercise 6 - Sub Queries*/
/* Bhaskar Teja Ulichi [101127292] */


/* 1. Using a Noncorrelated Subquery */

*1.a;
PROC Sql;
	SELECT AVG(Total_Retail_Price) "MeanPrice" 
	FROM orion.order_fact 
	WHERE Order_Type=1;
quit;

*1.b;
proc sql;
	TITLE "Customers with Average Retail Price Exceeding Company Average";
	SELECT Customer_ID, AVG(Total_Retail_Price) "MeanPrice" 
	FROM orion.order_fact 
	WHERE Order_Type=1 
	GROUP BY Customer_ID 
	HAVING AVG(Total_Retail_Price) > (SELECT AVG(Total_Retail_Price) FROM orion.order_fact WHERE Order_Type=1);
quit;

/* 2. Using a Noncorrelated Subquery */

*2.a;
proc sql;
   TITLE "Employees with Current Month Anniversary";
   SELECT Employee_ID
   FROM orion.employee_payroll
   WHERE month(Employee_Hire_Date) = month(today());
quit;

*2.b;
proc sql;
   TITLE1 "MEMO";
   TITLE2 "Employees with Current Month Anniversaries";
   SELECT A.Employee_ID,
      substr(A.Employee_Name, index(A.Employee_Name, ',')+2) "FirstName" length=15 label='First Name',
      substr(A.Employee_Name, 1, index(A.Employee_Name, ',')-1) "LastName" length=15 label='Last Name'
   from orion.employee_addresses as A
   where A.Employee_ID in 
   (
      SELECT Employee_ID
      FROM orion.employee_payroll
      WHERE month(Employee_Hire_Date) = month(today())
   )
   order by 3;
quit;



/* 3. Building Complex Queries with In-Line Views */

*3.a;
proc sql;
   TITLE "Departmental Salary Totals";
   SELECT B.Department, sum(A.Salary) "Dept_Salary_Total"
   FROM orion.employee_payroll as A
   INNER JOIN orion.employee_organization as B
   ON A.Employee_ID = B.Employee_ID
   GROUP BY B.Department;
quit;

*3.b;
proc sql;
   TITLE "Employee Information by Department";
   SELECT A.Employee_ID, A.Employee_Name "Name",
      B.Department
   FROM orion.employee_addresses as A
   INNER JOIN orion.employee_organization as B
   ON A.Employee_ID = B.Employee_ID;
quit;


*3.c;
proc sql;
   TITLE "Employee Salaries as a percent of Department Total";
   SELECT 
      E.Department,
      E.Employee_Name,
      P.Salary,
     (P.Salary / D.Dept_Salary_Total) label = "Percent" format = percent7.1
   FROM (
      SELECT A.Employee_ID, A.Employee_Name, B.Department
      FROM orion.employee_addresses as A
      INNER JOIN orion.employee_organization as B
      ON A.Employee_ID = B.Employee_ID
   ) AS E
   INNER JOIN orion.employee_payroll as P
   ON E.Employee_ID = P.Employee_ID
   INNER JOIN (
      SELECT B.Department, sum(A.Salary) as Dept_Salary_Total
      FROM orion.employee_payroll as A
      INNER JOIN orion.employee_organization as B
      ON A.Employee_ID = B.Employee_ID
      GROUP BY B.Department
   ) as D
   ON E.Department = D.Department
   order by E.Department, 4 DESC;
quit;


