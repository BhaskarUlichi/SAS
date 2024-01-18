/* DSCI 507 Business Analytics Modelling */
/* Programming Exercise 11 */
/* Bhaskar Teja Ulichi [101127292] */


/* Problem 1 : Concatenating Like-Structured Tables */
data work.np_combine;
	set pg2.np_2015 pg2.np_2016;
	where Month in (6, 7, 8);
	CampTotal=sum(of Camping:);
	format CampTotal comma12.;
	drop CampingOther CampingTent CampingRV CampingBackcountry;
run;


/* Problem 2 - Writing Matches and Nonmatches to Separate Tables */

*(a)"ParkCode" is the common column in the pg2.np_codelookup and pg2.np_2016 tables; 

*(b) Sorting np_codelookup by ParkCode;
proc sort data=pg2.np_codelookup;
  by ParkCode;
run;

*(b) Sorting np_2016 by ParkCode, Year, Month;
proc sort data=pg2.np_2016;
  by ParkCode Year Month;
run;

* (c) Creating parkStats table;
data work.parkStats;
    merge pg2.np_2016(in=_a) pg2.np_codelookup(in=_b);
    by ParkCode;
    if _a;
    keep ParkCode ParkName Year Month DayVisits;
    format DayVisits comma12.;
run;

* (c) Creating parkOther table;
data work.parkOther;
    merge pg2.np_2016(in=_a) pg2.np_codelookup(in=_b);
    by ParkCode;
    if not _a;
    keep ParkCode ParkName;
    run;

