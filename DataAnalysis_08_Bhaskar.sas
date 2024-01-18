/* DSCI 507 Business Analytics Modelling */
/* Data Analysis Exercise 08 */
/* Bhaskar Teja Ulichi [101127292] */

/* Problem 1 */
*Examining Residuals;
ods noproctitle;
ods graphics / imagemap=on;

proc reg data=STAT1.BODYFAT2 alpha=0.05 plots(only)=(QQ RESIDUALBYPREDICTED RESIDUALS);
	model PctBodyFat2=Abdomen Weight Wrist Forearm /;
	title 'Examining Residuals - Body Fat Percentage';
	run;
quit;



*Generating Potential Outliers;
ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=STAT1.BODYFAT2 outdesign(addinputvars)=Work.reg_design 
		plots=(criterionpanel);
	model PctBodyFat2=Abdomen Weight Wrist Forearm / showpvalues 
		selection=stepwise
    
   (slentry=0.05 slstay=0.05 select=sl);
run;

proc reg data=Work.reg_design alpha=0.05 plots(only label)=(rstudentbypredicted 
		cooksd dffits dfbetas);
	ods select RStudentByPredicted COOKSDPlot DFFITSPlot DFBETASPanel;
	ods output RSTUDENTBYPREDICTED=Rstud 
           COOKSDPLOT=Cook
           DFFITSPLOT=Dffits 
           DFBETASPANEL=Dfbs;
	model PctBodyFat2=&_GLSMOD /;
	run;
quit;


*RStudent - Influences;
title;
proc print data=Rstud;
run;

*Cook - Influencers;
proc print data=Cook;
run;

*DFFITS - Influencers;
proc print data=Dffits;
run;

*DFBS - Influencers;
proc print data=Dfbs;
run;

*Merging all Influencential Observations;
data influential;
/*  Merge datasets from above.*/
   merge  Rstud
          Cook
          Dffits
          Dfbs;
   by observation;

/*  Flag observations that have exceeded at least one cutpoint;*/
   if (ABS(Rstudent)>3) or (Cooksdlabel ne ' ') or Dffitsout then
        flag=1;
   array dfbetas{*} _dfbetasout: ;
   do i=2 to dim(dfbetas);
        if dfbetas{i} then flag=1;
   end;

/*  Set to missing values of influence statistics for those*/
/*  that have not exceeded cutpoints;*/
   if ABS(Rstudent)<=3 then RStudent=.;
   if Cooksdlabel eq ' ' then CooksD=.;

/*  Subset only observations that have been flagged.*/
   if flag=1;
   drop i flag;
run;

title;
proc print data=influential;
   id observation;
   var Rstudent CooksD Dffitsout _dfbetasout:;
run;



proc delete data=Work.reg_design;
run;


*Assessing Collinearity;
ods noproctitle;
ods graphics / imagemap=on;

proc reg data=STAT1.BODYFAT2 alpha=0.05 plots(only)=(observedbypredicted);
	model PctBodyFat2=Age Weight Height Neck Chest 
		Abdomen Hip Thigh Knee Ankle Biceps Forearm Wrist / vif;
	run;
quit;

