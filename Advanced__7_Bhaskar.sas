/* DSCI 519 Advanced Business Analytics Modelling */
/* Chapter Exercise 7 - Creating Tables*/
/* Bhaskar Teja Ulichi [101127292] */


/* 1.Creating a Table and Adding Data Using a Query */
proc sql;
   create table orion.employees as
   select 
      A.Employee_ID,
      B.Employee_Hire_Date as Hire_Date format=MMDDYY10.,
      B.Salary format=COMMA12.2,
      B.Birth_Date format=MMDDYY10.,
      B.Employee_Gender as Gender,
      A.Country,
      A.City
   from orion.employee_addresses as A
   inner join orion.employee_payroll as B
   on A.Employee_ID = B.Employee_ID
   where B.Employee_Term_Date is null
   order by year(B.Employee_Hire_Date), 3 desc;
quit;

*1.b Retrieving Employees table;
proc sql;
Select * from orion.employees;
quit;



/* 2. Creating a Table by Defining Its Structure and Adding Data */
proc sql;
   create table orion.rewards 
   (
      Purchased num format=COMMA9.2,
      Year num format=4.,
      Level char(8),
      Award char(50)
   );
   insert into orion.rewards (Purchased, Year, Level, Award) 
   values (200, 2012, 'Silver', '25% Discount on one item over $25')
   values (300, 2012, 'Gold', '15% Discount on one order over $50')
   values (500, 2012, 'Platinum', '10% Discount on all 2012 purchases')
   values (225, 2013, 'Silver', '25% Discount on one item over $50')
   values (350, 2013, 'Gold', '15% Discount on one order over $100')
   values (600, 2013, 'Platinum', '10% Discount on all 2013 purchases');
quit;

*Retrieving Rewards Table;
proc sql;
Select * from orion.rewards;
quit;


/* 3. Creating and Using a View to Provide Consolidated Information */
proc sql;
   create view orion.t_shirts as
   select
      A.Product_ID,
      A.Supplier_Name format=$20.,
      A.Product_Name,
      B.Unit_Sales_Price as Retail_Price label = "Retail Price"
   from orion.product_dim as A
   inner join orion.price_list as B
   on A.Product_ID = B.Product_ID
   where upcase(A.Product_Name) like '%T-SHIRT%';
quit;

*3.b Displaying Data from T-Shirts table;
proc sql;
   title "T-Shirts Report";
   select *
   from orion.t_shirts
   order by Supplier_Name, Product_ID;
quit;


*3.c Displaying T-shirts under $20;
proc sql;
   title "T-Shirts under $20";
   select Product_ID, Product_Name, Retail_Price
   from orion.t_shirts
   where Retail_Price < 20.00
   order by 3;
quit;
