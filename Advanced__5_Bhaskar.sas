/* DSCI 519 Advanced Business Analytics Modelling */
/* Chapter Exercise 5 - Joins*/
/* Bhaskar Teja Ulichi [101127292] */

/* 1. Inner Joins */
proc sql;
	title1 "Employees with more than 30 years of service";
	title2 "Report as of Feb 1, 2013";
   	select A.Employee_Name "Employee Name",
      (intck('YEAR', B.Employee_Hire_Date, '01FEB2013'D)) "Years of Service"
   	from Orion.employee_addresses as A
   	inner join Orion.employee_payroll as B
   	on A.Employee_ID = B.Employee_ID
   	where intck('YEAR', B.Employee_Hire_Date, '01FEB2013'D) > 30
   	order by A.Employee_Name;
quit;


/* 2. Creating a Summary Report from Two Tables */
proc sql;
   title "Product Sales Since 2010";
   select p.Product_ID, p.Product_Name,
      sum(o.Quantity) "Total Sold"
   from orion.product_dim as p
   inner join orion.order_fact as o
   on p.Product_ID = o.Product_ID
   where o.Order_Date >= '01JAN2010'd
   group by p.Product_ID, p.Product_Name
   order by 3 DESC, 2 Asc;
quit;


/* 3. Outer Join */
proc sql;
   title "Orion Star Employees & Their Locations";
   select B.Employee_Name "Name",
      B.City, A.Job_Title
   from orion.sales as A
   Right join orion.employee_addresses as B
   on A.Employee_ID = B.Employee_ID
   order by B.City, A.Job_Title, B.Employee_Name;
quit;


/* 4. Outer Join */
proc sql;
   title "Orion Items that have never been Sold";
   select p.Product_ID, p.Product_Name, p.Product_Category
   from orion.product_dim as p
   left join orion.order_fact as o
   on p.Product_ID = o.Product_ID
   where o.Product_ID is null;
quit;

*From the output above, we can say that there are no products in the production dimension table that have never
been sold;


/* 5. Self-Join */
proc sql;
   title "Trainees and Temporary Workers Report";
   select A.Employee_ID "Employee ID",
      A.Employee_Name "Employee Name",
      B.Job_Title "Employee Job Title",
      B.Manager_ID "Manager ID",
      C.Employee_Name "Manager Name"
   from orion.employee_addresses as A
   inner join orion.staff as B
   on A.Employee_ID = B.Employee_ID
   left join orion.employee_addresses as C
   on B.Manager_ID = C.Employee_ID
   where B.Job_Title in ('Trainee', 'Temp. Sales Rep.')
   order by A.Employee_ID;
quit;



