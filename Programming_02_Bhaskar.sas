/* SAS Programming Homework - 2 */
/* Bhaskar Teja Ulichi [StudentID: 101127292] */
/* Problem#1 - a */
PROC IMPORT datafile="/home/u63048816/PG1/data/eu_sport_trade.xlsx" DBMS=xlsx 
		OUT=PG1.EU_SPORT_TRADE replace;
run;

/* Problem#1 - b */
PROC CONTENTS data=pg1.eu_sport_trade;
run;

/* Problem#2 - a */
PROC IMPORT datafile="/home/u63048816/PG1/data/np_traffic.csv" dbms=csv 
		OUT=PG1.traffic;
run;

/* Here 'replace' is not used as no specific directions are given */
 
/* Problem#2 - b */
PROC IMPORT datafile="/home/u63048816/PG1/data/np_traffic.csv" dbms=csv 
		OUT=PG1.traffic replace;
	guessingrows=max;
run;

/* Here 'replace' is used in order to modify the existing table and to make full disclosure of the previous truncated values */

/* Problem#3 - b */
PROC IMPORT datafile="/home/u63048816/PG1/data/np_traffic.dat" dbms=dlm 
		out=traffic2;
	guessingrows=max;
	delimiter='|';
run;
/* Here 'replace' is not used as no specific directions are given */
