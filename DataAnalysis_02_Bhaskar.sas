/* DSCI 507 */
/* Data Analysis Exercise 02 */
/* Bhaskar Teja Ulichi [101127292] */

*Problem 1;

Title;
ods noproctitle;
ods graphics / imagemap=on;

proc glm data=STAT1.GARLIC plots(only)=(boxplot diagnostics(unpack));
	class Fertilizer;
	model BulbWt=Fertilizer;
	means Fertilizer / hovtest=levene plots=none;
	run;
quit;

*Notes:
1. As the p-value is less than 0.05, we reject the null hypothesis that the means are equal
2. Checking Normality Assumption: Histogram is almost symmetric
The data points in q-q plot also donot diverge away from the reference line. 
Hence, Errors are normally distributed.
3. From Boxplots, we can say that there are no outliers in all fertilizers.
4. The p-value from the Levene's Test (0.2257) is greater than alpha (0.05). 
Hence we do not reject the null hypothesis that variances are equal over all fertilizer groups;

*Problem2 (a);
Title;
ods noproctitle;
ods graphics / imagemap=on;

proc glm data=STAT1.GARLIC plots(only);
	class Fertilizer;
	model BulbWt=Fertilizer;
	lsmeans Fertilizer / adjust=tukey pdiff alpha=.05 plots=(diffplot);
	run;
quit; 

*Notes:
From the Least Squares Means for Effect Fertilizer Table, We can say that the below Fertiizers have
Statistically significant pairwise differences between each other:
Fertilizer 1 & Fertilizer 4
Fertilizer 3 & Fertilizer 4

*Problem2 (b);
Title;
ods noproctitle;
ods graphics / imagemap=on;

proc glm data=STAT1.GARLIC plots(only);
	class Fertilizer;
	model BulbWt=Fertilizer;
	lsmeans Fertilizer / adjust=dunnett pdiff=control('4') alpha=.05 
		plots=(diffplot);
	run;
quit;
*Notes:
From the Dunnet's LSMEANS comparisons, 
We arrive at the same conclusion that:
Fertilizer 1 is statistically significantly different from Fertilizer 4 &
Fertilizer 3 is also statistically significantly different from Fertilizer 4.
Reason: Fertilizer 1 & Fertilizer 3 p-values are less than 0.05




