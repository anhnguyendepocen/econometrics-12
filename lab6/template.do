
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab06.txt , text replace;

/* 8.1 questions (a) through (g) */
use cps92_08.dta;
describe;

/* (a) */
reg ahe age female bachelor, r;
scalar age_coef = _b[age];
scalar age_diff_1 = (age_coef*26) - (age_coef*25);
display age_diff_1;
scalar age_diff_2 = (age_coef*34) - (age_coef*33);
/* the difference between both 34x33 and 26x25 should be the same. */
display age_diff_2 == age_diff_1; 
/* A one-unit change in age is associated with a .4529 unit increase in Average Hourly Earnings.*/

/* (b) */
gen ln_ahe = ln(ahe);
reg ln_ahe age female bachelor, r;
scalar age_coef_2 = _b[age];
scalar ln_age_diff_1 = (age_coef_2*26) - (age_coef_2*25);
display ln_age_diff_1;

scalar ln_age_diff_2 = (age_coef_2*34) - (age_coef_2*33);
display ln_age_diff_2;
/* the difference between both 34x33 and 26x25 should be the same. */
display round(ln_age_diff_2, .0000001) == round(ln_age_diff_1, .0000001); 
/* A one-unit change in age is associated with a 2.56% increase in average hourly earnings. */

/* (c) */
gen ln_age = ln(age);
reg ln_ahe ln_age female bachelor, r;
scalar ln_age_coef = _b[ln_age];
scalar ln_ln_age_diff_1 = (ln_age_coef*26) - (ln_age_coef*25);
display ln_ln_age_diff_1;

scalar ln_ln_age_diff_2 = (ln_age_coef*34) - (ln_age_coef*33);
display ln_ln_age_diff_2;
/* the difference between both 34x33 and 26x25 should be the same. */
display ln_ln_age_diff_2 == ln_ln_age_diff_1; 
/* A 1% change in age is associated with a .75% increase in Average Hourly Earnings. */

/* (d) */
reg ln_ahe c.age c.age#c.age female bachelor, r;
margins, dydx(*);

display (
	_b[age]*26 + _b[c.age#c.age]*(26*26)
) - (
	_b[age]*25 + _b[c.age#c.age]*(25*25)
);

display (
	_b[age]*34 + _b[c.age#c.age]*(34*34)
) - (
	_b[age]*33 + _b[c.age#c.age]*(33*33)
);
/* A one-unit change in age is associated with a 2.54% increase in average hourly earnings. */

/*
(e), (f), (g) -> look at the fit of the regression, RMSE, coefficients

*/

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


