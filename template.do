
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab05.txt , text replace;

use cps92_08.dta;
drop if year==1992;

sum;

/* A. */
reg ahe age, r;
scalar first = _b[age];
scalar r2_one = e(r2_a);
/* the estimated slope is .6049863 and the estimate intercept is 1.0822 */

/* B. */
reg ahe age female bach, r;
scalar second = _b[age];
scalar r2_two = e(r2_a);
scalar se = ((.0402701)^2 + (.0365302)^2)^.5;
/* estimated effect of age on earnings? .5852144 
   95% confidence interval for coefficient on age
*/
di _b[age] - invttail(e(df_r), .025)*_se[age];
di _b[age] + invttail(e(df_r), .025)*_se[age];

/* C. */
/*
are results of the regression in b substantially different from a
regarding the effects of age and AHE? Does the regression in a seem
to suffer from OVB?
*/
scalar diff = first - second;
display normal(diff/se);
display diff/se;
/*
Z-score is .36, which is less than 1.96 so not significantly different.
*/


/* D. */
/* Bob: 26 YO, male, high school diploma */

scalar bob = .4529881*26 + 0 + 0;
display bob;
/* Alexis: 30 YO, female, college degress */
scalar alexis = .4529881*30 + -2.80451*1 + 6.935999*1;
display alexis;

/* E. */
di r2_one;
di r2_two;
/* The R2 and adjusted R2 values for regression b are similar because 
   we added variables that account for lots of the variance in average
   hourly earnings. This means that the variables we added 'fit' the model
   and are not penalized by the adjusted R2 equation.
*/

/* F. */
test female;
display 1-chi2(1, 1*311.46);

test bachelor;
display 1-chi2(1, 1*1444.22);

test female bachelor;
display 1-chi2(2, 2*780.60);
/*
Given that the the F value is 0 for each test, we reject the null in each scenario
and conclude that you cannot remove these variables from the regression.
*/

/* G. */
/*
Conditions:
1. When there is correlation between your error term and Y (meaning the omitted variable is captured in the error term)
2. When the omitted variable is correlated with the included regressor (X)
*/
/*
These conditions hold for the first regression we ran (AHE on age). This is shown by the change in the age coefficient and F tests. 
*/

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


