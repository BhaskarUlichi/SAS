/* DSCI 519 Advanced Business Analytics Modelling */
/* Chapter Exercise 1 - Querying Columns*/
/* Bhaskar Teja Ulichi [101127292] */


*1 (a). Querying a Table;
PROC SQL;
SELECT * FROM orion.employee_payroll;
QUIT;

*1 (b). Querying a Table;
PROC SQL;
SELECT Employee_ID, Employee_Gender, Marital_Status, Salary
FROM orion.employee_payroll;
QUIT;


*2. Calculating a Column;
PROC SQL;
SELECT Employee_ID, Employee_Gender, Marital_Status, Salary, Salary/3 as Tax
FROM orion.employee_payroll;
QUIT;


*3. Creating a New Table;
PROC SQL;
CREATE Table Work.Bonus as 
SELECT Employee_ID, Salary, Salary*0.04 as Bonus
FROM orion.employee_payroll;
SELECT * From Work.Bonus;
QUIT;


*4. Simple Report;

PROC SQL;
    SELECT Employee_ID, Job_Title, Salary,
    CASE 
        WHEN Salary < 50000 THEN 'Low'
        WHEN Salary > 80000 THEN 'High'
        ELSE 'Medium'
    END AS Salary_Range
    FROM orion.staff    
    WHERE Scan(Job_Title,-1,' ') = 'Manager';
QUIT;


