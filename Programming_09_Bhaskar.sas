/* DSCI 507 Business Analytics Modelling */
/* Programming Exercise 09 */
/* Bhaskar Teja Ulichi [101127292] */

/* Problem 1 - Working with Date/Time Values */

*b;
data rainsummary;
	set pg2.np_hourlyrain;
	by Month;
	if first.Month=1 then
		MonthlyRainTotal=0;
	MonthlyRainTotal+Rain;
	if last.Month=1;
	Date=datepart(DateTime);
	MonthEnd=intnx('month', Date, 0, 'end');
run;


*c;
data rainsummary;
	set pg2.np_hourlyrain;
	by Month;
	if first.Month=1 then
		MonthlyRainTotal=0;
	MonthlyRainTotal+Rain;
	if last.Month=1;
	Date=datepart(DateTime);
	MonthEnd=intnx('month', Date, 0, 'end');
	format Date MonthEnd date9.;
	keep StationName MonthlyRainTotal Date MonthEnd;
run;

/* Problem 2 - Searching for Character Strings */
data parks;
	set pg2.np_monthlytraffic;
	where ParkName like '%NP';
	Park = substr(ParkName, 1, find(ParkName, 'NP')-1);
	Location = compbl(propcase(Location));
	Gate = tranwrd(Location, 'Traffic Count At', ' ');
	GateCode = catx('-', ParkCode, scan(Gate, 1));
run;

proc print data=parks;
	var Park GateCode Month Count;
run;



