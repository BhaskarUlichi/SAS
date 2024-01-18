/* DSCI 519 Advanced Business Analytics Modelling */
/* Chapter Exercise 4 - Summarizing Data*/
/* Bhaskar Teja Ulichi [101127292] */

/*1.Summarizing Data */

proc sql;
   title "Cities Where Employees Live";
   select City, count(*) 'Count'
   from ORION.Employee_Addresses
   group by City
   order by City;
quit;


/*2. Using SAS Functions*/
proc sql;
   title "Age at Employment";
   select Employee_ID,
          Birth_Date 'Birth Date' format=MMDDYY10.,
          Employee_Hire_Date 'Hire Date' format=MMDDYY10.,
          int((Employee_Hire_Date - Birth_Date) / 365.25) 'Age'
   from ORION.Employee_Payroll;
quit;


/* 3.Summarizing Data*/

proc sql;
   title "Customer Demographics: Gender by Country";
   select 
      Country,
      count(*) 'Customers',
      sum(Gender = 'M') 'Men',
      sum(Gender = 'F') 'Women',
      sum(Gender = 'M')/count(*) 'Percent Male' format percent7.0
   from Orion.Customer
   group by Country
   order by 5;
quit;



/*4.Summarizing Data in Groups*/

proc sql;
   title "Countries with More Female than Male Customers";
   select 
      Country,
      sum(Gender = 'M') 'Male Customers',
      sum(Gender = 'F') 'Female Customers'
   from Orion.Customer
   group by Country
   having sum(Gender = 'F') > sum(Gender = 'M')
   order by 3 desc;
quit;


/*5. Advanced Summarizing Data in Groups*/

proc sql;
   title "Number of Employees by Country and City";
   select 
      Upcase(Country) 'Country', 
      City,
      count(*) 'Employees'
   from ORION.Employee_Addresses
   group by 1, 2
   order by 1, 2;
quit;


