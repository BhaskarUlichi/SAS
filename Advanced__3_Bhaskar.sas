/* DSCI 519 Advanced Business Analytics Modelling */
/* Chapter Exercise 3 - Presenting Data*/
/* Bhaskar Teja Ulichi [101127292] */

/*1. Enhancing Output by Ordering the Rows and Adding Titles and Formats*/

proc sql;
title "Single Male Employee Salaries";
select Employee_ID 'Employee ID',
       Salary 'Annual Salary' format=COMMA10.2,
       Salary/3 'Federal Tax Withdrawn' format=COMMA10.2
   from orion.employee_payroll
   where Marital_Status = "S"
     and Employee_Gender = "M"
     and Employee_Term_Date is missing
   order by Salary Desc;
quit;


/*2.Using Formats to Limit the Width of Columns in the Output*/

proc sql;
   title "Australian Clothing Products";
   select 
      substr(Supplier_Name, 1, 18) 'Supplier',
      substr(Product_Group, 1, 12) 'Group',
      substr(Product_Name, 1, 30) 'Product'
   from orion.product_dim
   where Product_Category = "Clothes" and Supplier_Country = "AU"
   order by Product_Name;
quit;

/*3.Enhancing Output with Multiple Techniques*/

proc sql;
   title "Orion Employees Hired at 18 or Younger";
   select Employee_ID "Employee ID",
          Salary format=COMMA10.2,
          int((Hire_Date - Birth_Date)/365.25) "Age when hired" as Age,
          catx(', ', City, Country) "Location",
          int(((today() - Hire_Date)/365.25)) "Years with Company"
   from Orion.Employees
   where calculated Age <= 18
   order by "Years with Company" descending;
quit;
