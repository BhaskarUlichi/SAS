/* DSCI 507 - Business Analytics Modeling */
/* Programming Excercise 03 */
/* Bhaskar Teja Ulichi [101127292] */
/* Problem 1 (a)*/
proc print data=pg1.np_summary;
	var Type ParkName;
	WHERE ParkName like '%Preserve%';
run;

/* Note: Here, the wild card '%' is used at the end of Preserve as the question specifies that we need */
/* to print rows that include 'Preserve' instead of rows that end with 'Preserve' */

/* Problem 1 (b) - The codes used in the table for preserves are : PRE, PRESERVE and NPRE. */

/* Creating a Listing Report for Missing Data - a */
proc print data=pg1.eu_occ;
	WHERE Hotel is missing and Shortstay is missing and Camp is missing;
run;
/* A total of 101 rows are included in the results of the above code  */

/* Creating a Listing Report for Missing Data - b */
proc print data=pg1.eu_occ;
	WHERE Hotel GT 40000000;
run;
/* The results of the above code contain the months 07 and 08  */

/* Problem 2 (b) */
PROC SORT DATA=pg1.np_largeparks out=park_clean nodupkey dupout=park_dups;
	By _all_;
run;