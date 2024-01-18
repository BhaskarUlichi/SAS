*DSCI 507 Programming Exercise 05
Bhaskar Teja Ulichi [101127292]

Problem 1 (a);
title "Park Types by Region";

PROC FREQ DaTA=pg1.np_codelookup ORDER=freq;
	TABLES type*region / NOCOL;
	WHERE type not like '%Other%';
run;

Problem 1(b) Top three Park Types are: National Historic Site, National 
Monument and National Park.

Problem 1(c);
title "Selected Park Types by Region";

PROC FREQ DaTA=pg1.np_codelookup ORDER=freq;
	TABLES type*region / crosslist NOCOL plots=freqplot(groupby=row 
		scale=grouppercent orient=horizontal);
	WHERE type in ('National Historic Site', 'National Monument', 'National Park');
run;

*Problem 2(1);
PROC MEANS data=pg1.np_westweather mean min max;
	Var Precip Snow TempMin TempMax;
run;

*Problem 2(2);
PROC MEANS data=pg1.np_westweather mean min max maxdec=2;
	Var Precip Snow TempMin TempMax;
run;

*Problem 2(3);
PROC MEANS data=pg1.np_westweather mean min max maxdec=2;
	Var Precip Snow TempMin TempMax;
	CLASS year name;
	title "Weather Statistics by Year and Park";
run;