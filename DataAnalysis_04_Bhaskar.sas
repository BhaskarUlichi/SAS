*DSCI 507 Data Analysis Exercise 04
Bhaskar Teja Ulichi [101127292]

Problem 1;
ods noproctitle;
ods graphics / imagemap=on;
proc reg data=STAT1.BODYFAT2 alpha=0.05 plots(only)=(diagnostics(unpack) 
		residuals(unpack) fitplot);
	model PctBodyFat2=Weight /;
	run;
quit;

*(a) The null hypothesis assumes that there is no linear relationship between the independent variable and 
 the dependent variable. It means Null hypothesis assumes that the model has no predictive power.
 Here, the F-Statistic = 150.03 and the associated p-value is <0.0001. As p-value is less than alpha level (0.05),
 We reject the null hypothesis and conclude that there is statistically signficant evidence that there is 
 a linear relationship between Weight and PctBodyFat2.
 
 (b) Predicted Regression Equation:
 PctBodyFat2 = -12.05158 + 0.17439(Weight)
 
 (c)The value of RSquare = 0.3751
RSquare is a statistical measure that represents the proportion of the variance in the dependent variable that 
is explained by the independent variable(s) in a regression model. A higher R-squared value indicates that 
the independent variable(s) in the model are good predictors of the dependent variable. 
Weight in the regression model explains approximately 38% of the variance in the PctBodyFat2. It means that the 
model failed to explain around 62% of the variance in PctBodyFat2. 
So, we can say that the model is not a good fit for the data; 
