/* DSCI 507 Business Analytics Modelling */
/* Data Analysis Exercise 06 */
/* Bhaskar Teja Ulichi [101127292] */

*Problem 1;
*Using Significance Level Model Selection Techniques;

*(a) STEP-WISE SELECTION;
ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=STAT1.BODYFAT2 outdesign(addinputvars)=Work.reg_design 
		plots=all;
	model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle 
		Biceps Forearm Wrist / showpvalues selection=stepwise
    
   (slentry=0.05 slstay=0.05 select=sl) details=steps;
run;

proc delete data=Work.reg_design;
run;

*(b) FORWARD SELECTION with default SLENTRY;
ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=STAT1.BODYFAT2 outdesign(addinputvars)=Work.reg_design 
		plots=(criterionpanel);
	model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle 
		Biceps Forearm Wrist / showpvalues selection=forward 
    
   (slentry=0.5 select=sl) details=steps;
run;

proc delete data=Work.reg_design;
run;

*(c) FORWARD SELECTION With Slentry = 0.05; 
ods noproctitle;
ods graphics / imagemap=on;

proc glmselect data=STAT1.BODYFAT2 outdesign(addinputvars)=Work.reg_design 
		plots=(criterionpanel);
	model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle 
		Biceps Forearm Wrist / showpvalues selection=forward 
    
   (slentry=0.05 select=sl) details=steps;
run;

proc delete data=Work.reg_design;
run;