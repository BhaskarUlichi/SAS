/* DSCI 507 Business Analytics Modelling */
/* Programming Exercise 12 */
/* Bhaskar Teja Ulichi [101127292] */


/* Problem 1: Using Nested Iterative DO Loops (DATA Step with No SET Statement) */


*Problem 1(a) & (b);

data retirement;
	do Year=1 to 6;
		Invest+10000;
		output;
	end;
run;

title1 'Retirement Account Balance per Year';

proc print data=retirement noobs;
	format Invest dollar12.2;
run;

title;


*Problem 1(c) & (d);

data retirement;
	do Year=1 to 6;
		Invest + 10000;
		do Quarter=1 to 4;
			Invest + (Invest*(0.075/4));
		end;
		output;
	end;
run;

title1 'Retirement Account Balance per Year';

proc print data=retirement noobs;
	format Invest dollar12.2;
run;

title;

*Problem 1(e);

data retirement;
	do Year=1 to 6;
		Invest + 10000;
		do Quarter=1 to 4;
			Invest + (Invest*(0.075/4));
		end;
		output;
	end;
	drop Quarter;
run;

title1 'Retirement Account Balance per Year';

proc print data=retirement noobs;
	format Invest dollar12.2;
run;

title;

/* Problem 2:Using a Conditional DO Loop  */


*Problem 2(a);
data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	IncrDayVisits=IncrDayVisits*1.06;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;

*Problem 2(b) & 2(c);

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits;
	do until (IncrDayVisits >100000);
		IncrDayVisits=IncrDayVisits * 1.06;
		output;
	end;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;


*Problem 2(d),2(e) & 2(f);

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0; 
	do until (IncrDayVisits > 100000);
		IncrDayVisits=IncrDayVisits * 1.06;
		Year+1; 
		output;
	end;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year; 
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;

*Problem 2(g) - How many years did it take until the number of visitors exceeded 100,000 for each 
national monument?
African Burial Ground National Monument - 14
Booker T. Washington National Monument - 25
Fort Stanwix National Monument - 2;


*Problem 2(h);

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0;
	do until(IncrDayVisits >100000);
		Year + 1;
		IncrDayVisits=IncrDayVisits * 1.06;
	end;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;


*Problem 2(i) - Using Do Until;

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0;
	do while (IncrDayVisits <=100000);
		Year + 1;
		IncrDayVisits=IncrDayVisits * 1.06;
		output;
	end;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;


*Problem 2(i) - Viewing Only the Number of Years;

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0;
	do while (IncrDayVisits <=100000);
		Year + 1;
		IncrDayVisits=IncrDayVisits * 1.06;
	end;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;