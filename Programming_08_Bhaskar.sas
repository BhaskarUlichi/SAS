/* DSCI 507 Business Analytics Modelling */
/* Programming Exercise 08 */
/* Bhaskar Teja Ulichi [101127292] */

*Problem 1;
*Producing Multiple Totals (a);

data parkTypeTraffic;
    set pg2.np_yearlyTraffic;
    where ParkType in ('National Monument', 'National Park');
    retain MonumentTraffic ParkTraffic 0;
    format MonumentTraffic ParkTraffic comma12.;
    if ParkType = 'National Monument' then do;
        MonumentTraffic = sum(MonumentTraffic, Count);
    end;
    else if ParkType = 'National Park' then do;
        ParkTraffic = sum(ParkTraffic, Count);
    end;
run;

*Producing Multiple Totals (b);

proc print data=parkTypeTraffic;
    title 'Accumulating Traffic Totals for Park Types';
    var ParkType ParkName Location Count MonumentTraffic ParkTraffic;
    format MonumentTraffic ParkTraffic comma12.;
run;


*Problem 2;
*Generating an Accumulating Column within Multiple Groups;
/* (a) Creating a sorted copy of sashelp.shoes */
proc sort data=sashelp.shoes out=shoes_sorted;
   by Region Product;
run;

/* (b) Creating profitsummary Table*/
data profitsummary;
   set shoes_sorted;
   Profit = Sales - Returns;
run;

/* (c) Creating profitsummary2 */
data profitsummary2;
   set shoes_sorted;
   Profit = Sales - Returns;
   by Region Product;
   retain TotalProfit 0;
   if first.Product or first.Region then TotalProfit = 0;
   TotalProfit + Profit;
run;

/* (d) Including only the last rows */
data profitsummary3;
   set shoes_sorted;
   Profit = Sales - Returns;
   by Region Product;
   retain TotalProfit 0;
   if first.Product or first.Region then TotalProfit = 0;
   TotalProfit + Profit;
   if last.Product or last.Region then do;
      output;
      format TotalProfit dollar12.2;
   end;
   keep Region Product TotalProfit;
run;


