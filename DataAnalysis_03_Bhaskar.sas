*DSCI 507 Data Analysis Exercise 03
Bhaskar Teja Ulichi [101127292];

*Problem 1 (a)
Scatter Plots and Correlations for the Variables Age, Weight and Height with PctBodyFat2;
ods noproctitle;
ods graphics / imagemap=on;

proc corr data=STAT1.BODYFAT2 pearson plots=scatter(ellipse=none nvar=3 
		nwith=3);
	var Age Weight Height;
	with PctBodyFat2;
run;

*Scatter Plots and Correlations for Circumference Variables with PctBodyFat2;

ods noproctitle;
ods graphics / imagemap=on;

proc corr data=STAT1.BODYFAT2 pearson plots=scatter(ellipse=none nvar=10 
		nwith=10);
	var Neck Chest Abdomen Hip Thigh Knee Ankle Biceps Forearm Wrist;
	with PctBodyFat2;
run;

*1.  straight lines are appropriate for describing linear relationships between variables. 
However, in this case, None of the relationships between the given variables with PctBodyFat2 is linear.
Hence, Straight lines are not adequate to describe the relationships.

2. We can observe a few outliers in almost all of the relationships with PctBodyFat2. 
In general, these can be due to measurement errors, anomalies or even genuine. Only an investigation into
these outliers provide us with insights on to the extent to which they can impact our analysis

3. Abdomen has the highest correlation coefficient (0.813) with PctBodyFat2
3(a) The p-value for the correlation coefficient of Abdomen with PctBodyFat2 is <0.0001
3(b) The null hypothesis for a correlation coefficient is that there is no correlation between the variables.
As the p-value is less than alpha level(0.05), there is significant evidence against the null hypothesis.
Hence, we reject the null hypothesis. 
Conclusion: There is statistically significant correlation between  Abdomen and PctBodyFat2;


*Problem 1(b);
ods noproctitle;
ods graphics / imagemap=off;

proc corr data=STAT1.BODYFAT2 nosimple best=5;
	var Age Weight Height Neck Chest Abdomen Hip Thigh Knee Ankle Biceps Forearm Wrist;
		title "Correlations and Scatter Plot Matrix of Predictors";
run;

*There are many notable relationships between the predictors. Relationships with statistically significant 
evidence for correlation with coefficients greater than 0.7 include but not limited to the below relationships:
Weight & Hip, Neck & Weight, Chest & Abdomen, Thigh & Hip.

Problem 1 (c);



