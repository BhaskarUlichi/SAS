/* DSCI 507 Business Analytics Modelling */
/* Programming Exercise 07 */
/* Bhaskar Teja Ulichi [101127292] */

libname out "/home/u63048816/PG2";

*Problem 1;
*a (1) The compile-time only statements are Data, Keep, Where, Format; 
*a (2) The variable Size will be assigned one of the values "Small", "Medium", or "Large" 
based on the value of the variable Acres;

*c) Modify the program to resolve the truncation of Size. Read the first five rows from the input table.;
data np_parks;
	set pg2.np_final ;
	keep Region ParkName AvgMonthlyVisitors Acres Size;
	length Size $ 10; /*Medium has length of 6. Any size more than 6 removes truncation*/
	where Type="PARK";
	format AvgMonthlyVisitors Acres comma10.;
	Type=propcase(Type);
	AvgMonthlyVisitors=sum(DayVisits,Campers,OtherLodging)/12;
	if Acres<1000 then Size="Small";
	else if Acres<100000 then Size="Medium";
	else Size="Large";
run;

/* reading first 5 rows from input table */
proc print data=np_parks(obs=5);
run;

*d) Add PUTLOG statements;
data np_parks;
	putlog 'NOTE: START DATA STEP ITERATION';
	set pg2.np_final;
	putlog 'NOTE: Type=' Type;
	keep Region ParkName AvgMonthlyVisitors Acres Size;
	length Size $ 12;
	where Type="PARK";
	format AvgMonthlyVisitors Acres comma10.;
	Type=propcase(Type);
	AvgMonthlyVisitors=sum(DayVisits,Campers,OtherLodging)/12;
	if Acres<1000 then Size="Small";
	else if Acres<100000 then Size="Medium";
	else Size="Large";
	putlog _all_;
run;

*Problem 2;
/* Part a & b: creating temporary tables 'Camping' and 'lodging' and creating 'CampTotal' column*/
data camping;
  set pg2.np_2017;
  CampTotal = sum(CampingOther, CampingTent, CampingRV, CampingBackcountry);
  format CampTotal comma10.;
run;

data lodging;
  set pg2.np_2017;
run;

/* Part c: filtering and selecting columns for camping table */
data camping;
  set camping;
  where CampTotal > 0;
  keep ParkName Month DayVisits CampTotal;
run;

/* Part d: filtering and selecting columns for lodging table */
data lodging;
  set lodging;
  where LodgingOther > 0;
  keep ParkName Month DayVisits LodgingOther;
run;


