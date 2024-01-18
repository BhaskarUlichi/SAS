*DSCI 507 Programming Exercise 06
Bhaskar Teja Ulichi [101127292];

*Problem 1 (a);
libname out "/home/u63048816/PG1/output";

ODS RTF FILE = "/home/u63048816/PG1/output/ParkReport.rtf" STARTPAGE=NO style=journal;
ods noproctitle;

title "US National Park Regional Usage Summary";

proc freq data=pg1.np_final;
    tables Region /nocum;
run;

proc means data=pg1.np_final mean median max nonobs maxdec=0;
    class Region;
    var DayVisits Campers;
run;

title2 'Day Visits vs. Camping';
proc sgplot data=pg1.np_final;
    vbar  Region / response=DayVisits;
    vline Region / response=Campers ;
run;
title;

ods proctitle;
ODS RTF CLOSE;

*Problem 1 (c);
ODS RTF FILE = "/home/u63048816/PG1/output/ParkReport.rtf" STARTPAGE=NO style=journal;
ods noproctitle;

title "US National Park Regional Usage Summary";

proc freq data=pg1.np_final;
    tables Region /nocum;
run;

proc means data=pg1.np_final mean median max nonobs maxdec=0;
    class Region;
    var DayVisits Campers;
run;

ODS RTF style = SASDOCPRINTER;
title2 'Day Visits vs. Camping';
proc sgplot data=pg1.np_final;
    vbar  Region / response=DayVisits;
    vline Region / response=Campers ;
run;
title;

ods proctitle;
ODS RTF CLOSE;

*Problem 1 (d);
options nodate; 
ODS RTF FILE = "/home/u63048816/PG1/output/ParkReport.rtf" STARTPAGE=NO style=journal;

ods noproctitle;

title "US National Park Regional Usage Summary";

proc freq data=pg1.np_final;
    tables Region /nocum;
run;

proc means data=pg1.np_final mean median max nonobs maxdec=0;
    class Region;
    var DayVisits Campers;
run;

ODS RTF style = SASDOCPRINTER;
title2 'Day Visits vs. Camping';
proc sgplot data=pg1.np_final;
    vbar  Region / response=DayVisits;
    vline Region / response=Campers ;
run;
title;

ods proctitle;
ODS RTF CLOSE;
options date;

