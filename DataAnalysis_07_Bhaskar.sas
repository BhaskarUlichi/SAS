/* DSCI 507 Business Analytics Modelling */
/* Data Analysis Exercise 07 */
/* Bhaskar Teja Ulichi [101127292] */

*Problem 1;
*Using Other Model Selection Techniques;
*Use the STAT1.BodyFat2 data set to identify a set of “best” models;
*a. With the SELECTION=STEPWISE option, use SELECT=SBC to identify a set of candidate models that predict 
PctBodyFat2 as a function of the variables Age, Weight, Height, Neck, Chest, Abdomen, Hip, Thigh, 
Knee, Ankle, Biceps, Forearm, and Wrist;

ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=STAT1.BODYFAT2 outdesign(addinputvars)=Work.reg_design 
		plots=(criterionpanel coefficientpanel);
	model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle 
		Biceps Forearm Wrist / showpvalues selection=stepwise
    
   (select=sbc);
run;

proc reg data=Work.reg_design alpha=0.05 plots(only)=(observedbypredicted);
	ods select ObservedByPredicted;
	model PctBodyFat2=&_GLSMOD /;
	run;
quit;

proc delete data=Work.reg_design;
run;



*b. Try SELECT=AIC;
ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=STAT1.BODYFAT2 outdesign(addinputvars)=Work.reg_design 
		plots=(criterionpanel coefficientpanel);
	model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle 
		Biceps Forearm Wrist / showpvalues selection=stepwise
    
   (select=aic);
run;

proc reg data=Work.reg_design alpha=0.05 plots(only)=(observedbypredicted);
	ods select ObservedByPredicted;
	model PctBodyFat2=&_GLSMOD /;
	run;
quit;

proc delete data=Work.reg_design;
run;


/* Problem 2 (a)*/
/* Using All-Regression Techniques */

ods graphics on;
proc reg data=STAT1.BodyFat2 plots(only)=(cp);
	ALLPOSS: model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle 
		Biceps Forearm Wrist  / selection=cp rsquare adjrsq best=60;
	title "Best Models Using All Possible Selection for PctBodyFat2";
run;
quit;

