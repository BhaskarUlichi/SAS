/* DSCI 507 Business Analytics Modelling */
/* Programming Exercise 10 */
/* Bhaskar Teja Ulichi [101127292] */

/* Problem 1 */
/* Creating Custom Formats Based on a Range of Values */
proc format;
    value PSIZE
        low - <10000 = "Small"
        10000 - <500000 = "Average"
        500000 - high = "Large";
run;

data np_parksize;
    set pg2.np_acres;
    ParkSize = put(GrossAcres, PSIZE.);
    format GrossAcres comma16.;
run;


/* Problem 2 */
/* Creating a Custom Format from a Table */

data type_lookup;
    set pg2.np_codeLookup(rename=(ParkCode=Start Type=Label));
    retain FmtName '$TypeFmt';
    keep Start Label FmtName;
run;

proc format cntlin=type_lookup;
run;

title 'Traffic Statistics';
proc means data=pg2.np_monthlyTraffic maxdec=0 mean sum nonobs;
    var Count;
    class ParkCode Month;
    label ParkCode='Name';
    format ParkCode $TypeFmt.;
run;
title;

