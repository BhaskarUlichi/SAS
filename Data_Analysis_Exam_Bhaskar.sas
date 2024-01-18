/* DSCI 507 Business Analytics Modelling */
/* Data Analysis Exam*/
/* Bhaskar Teja Ulichi [101127292] */



/* TASK#1 - Importing Data to SAS */

PROC IMPORT datafile="/home/u63048816/Exam/Exam02DataForPost.xlsx" DBMS=xlsx 
		OUT=WORK.NBAStats replace;
run;

/* TASK#2 - CREATING A MULTIPLE LINEAR REGRESSION MODEL */

*The following code helps us to answer Questions a to e of Task 2;


ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=WORK.NBASTATS outdesign(addinputvars)=Work.reg_design;
	class Season Conference / param=glm;
	model W=Age SOS ORtg Pace FTr '3PAr'n 'eFG%'n 'TOV%'n 'ORB%'n 'FT/FGA'n 
		'OppeFG%'n 'OppTOV%'n 'DRB%'n 'OppFT/FGA'n Season Conference / showpvalues 
		selection=none;
run;

proc reg data=Work.reg_design alpha=0.05 plots(only)=(diagnostics(unpack) 
		residuals observedbypredicted);
	where Season is not missing and Conference is not missing;
	ods select ParameterEstimates ResidualHistogram ResidualByPredicted 
		RStudentByPredicted ObservedByPredicted CooksDPlot RStudentByLeverage QQPlot 
		RFPlot ResidualPlot ObservedByPredicted;
	model W=&_GLSMOD / vif;
	run;
quit;

proc delete data=Work.reg_design;
run;




*The following code can be used to generate diagnostic plots to identify inflential observations
 to answer question (f);
ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=WORK.NBASTATS outdesign(addinputvars)=Work.reg_design;
	class Season Conference / param=glm;
	model W=Age SOS ORtg Pace FTr '3PAr'n 'eFG%'n 'TOV%'n 'ORB%'n 'FT/FGA'n 
		'OppeFG%'n 'OppTOV%'n 'DRB%'n 'OppFT/FGA'n Season Conference / showpvalues 
		selection=none;
run;

proc reg data=Work.reg_design alpha=0.05 plots(only label)=(rstudentbypredicted cooksd 
		dffits dfbetas);
	where Season is not missing and Conference is not missing;
	ods select RStudentByPredicted COOKSDPlot DFFITSPlot DFBETASPanel;
	model W=&_GLSMOD /;
	run;
quit;

proc delete data=Work.reg_design;
run;



/* TASK 3: Fitting a regression model using the stepwise selection procedure using Mallow’s C(p) 
as the selection criterion */

ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=WORK.NBASTATS outdesign(addinputvars)=Work.reg_design 
		plots=(criterionpanel coefficientpanel);
	class Season Conference / param=glm;
	model W=Age SOS ORtg Pace FTr '3PAr'n 'eFG%'n 'TOV%'n 'ORB%'n 'FT/FGA'n 
		'OppeFG%'n 'OppTOV%'n 'DRB%'n 'OppFT/FGA'n Season Conference / showpvalues 
		selection=stepwise
    
   (select=cp) details=steps;
run;

proc reg data=Work.reg_design alpha=0.05 plots(only)=(diagnostics(unpack) 
		residuals observedbypredicted);
	where Season is not missing and Conference is not missing;
	ods select ParameterEstimates ResidualHistogram ResidualByPredicted 
		RStudentByPredicted ObservedByPredicted CooksDPlot RStudentByLeverage QQPlot 
		RFPlot ResidualPlot ObservedByPredicted;
	model W=&_GLSMOD / vif;
	run;
quit;

proc delete data=Work.reg_design;
run;
