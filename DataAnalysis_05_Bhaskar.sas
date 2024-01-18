/* DSCI 507 Business Analytics Modelling */
/* Data Analysis Exercise 05 */
/* Bhaskar Teja Ulichi [101127292] */

/* Problem 1 */
*a) Examine the data with a vertical line plot. Put BloodP on the Y axis, DrugDose on the X axis, and then 
stratify by Disease. What information can you obtain from looking at the data?;
ods noproctitle;
ods graphics / imagemap=on;

proc glm data=STAT1.DRUG;
	class DrugDose Disease;
	model BloodP=DrugDose Disease DrugDose*Disease / ss1 ss3;
quit;

*b)Test the hypothesis that the means are equal, making sure to include an interaction term if the graphical 
analyses that you performed indicate that would be advisable. What conclusions can you reach at this point? ;
ods graphics / imagemap=on;

proc glm data=STAT1.DRUG
order = internal
plots(only)=intplot;
	class DrugDose Disease;
	model BloodP=DrugDose Disease DrugDose*Disease;
	lsmeans DrugDose*Disease / diff slice = Disease;
	store out=interact;
	format DrugDose;
	title "Model with DrugDose and Disease as interacting predictors";
quit;

proc plm restore=interact plots=all;
   slice DrugDose*Disease / sliceby=Disease adjust=tukey;
   effectplot interaction(sliceby=Disease) / clm;
run; 

/* Problem 2 */
*Using the STAT1.BodyFat2 data set, run a regression of PctBodyFat2 on the variables Age, Weight, Height, 
Neck, Chest, Abdomen, Hip, Thigh, Knee, Ankle, Biceps, Forearm, and Wrist;

ods noproctitle;
ods graphics / imagemap=on;

proc reg data=STAT1.BODYFAT2 alpha=0.05 plots(only)=(diagnostics residuals);
	model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle Biceps 
		Forearm Wrist /;
		title "Multiple Regression of PctBodyFat2";
	run;
quit;

*Compare the ANOVA table with that from the model with only Weight in the previous exercise. 
What is different?;
ods noproctitle;
ods graphics / imagemap=on;

proc reg data=STAT1.BODYFAT2 alpha=0.05 plots(only)=(diagnostics residuals);
	model PctBodyFat2=Weight/;
	title "Linear Regression of PctBodyFat2 with Weight";
	run;
quit;

*Simplifying the Model
Rerun the preceding model, but eliminate the variable with the highest p value. 
Compare the output with the preceding model;
ods noproctitle;
ods graphics / imagemap=on;

proc reg data=STAT1.BODYFAT2 alpha=0.05 plots(only)=(diagnostics residuals);
	model PctBodyFat2=Age Weight Height Neck Chest Abdomen Hip Thigh Ankle Biceps 
		Forearm Wrist /;
		title "Multiple Regression of PctBodyFat2 excluding Knee";
	run;
quit;

*More Simplifying of the Model
Again, rerun the preceding model, but eliminate the variable with the highest p value. 
Compare the output with the preceding model;
ods noproctitle;
ods graphics / imagemap=on;

proc reg data=STAT1.BODYFAT2 alpha=0.05 plots(only)=(diagnostics residuals);
	model PctBodyFat2=Age Weight Height Neck Abdomen Hip Thigh Ankle Biceps 
		Forearm Wrist /;
		title "Multiple Regression of PctBodyFat2 excluding Knee and Chest";
	run;
quit;


