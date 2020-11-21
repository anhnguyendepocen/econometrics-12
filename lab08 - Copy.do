
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab08-TA.txt , text replace;

use coke.dta;

/* linear probability model*/
reg coke c.pratio i.disp_pepsi, r;
margins, dydx(*); /* AME */
margins, dydx(*) atmeans; /* AME at the average */

/* PROBIT MODEL */
probit coke c.pratio i.disp_coke i.disp_pepsi, r;
margins, dydx(*);
margins, dydx(*) atmeans;

/* calc the marginal effect at the mean */
sum pratio;
scalar mean_pratio = r(mean); /* retrieve mean from most recent calculation */

sum disp_pepsi;
scalar mean_disp_pepsi = r(mean); /* retrieve mean from most recent calculation */

sum disp_coke;
scalar mean_disp_coke = r(mean); /* retrieve mean from most recent calculation */


scalar ame_at_the_average = _b[_cons] + _b[pratio]*mean_pratio + _b[1.disp_coke]*mean_disp_coke + _b[1.disp_pepsi]*mean_disp_pepsi;

/* have to take the derivative of the cumulative density function to get the normal density function. */
/* ME at the means for a continuous variable*/
display normalden(ame_at_the_average)*_b[pratio];


/* ME at means for discrete variable */
scalar coke_at_0 = _b[_cons] + _b[pratio]*mean_pratio + _b[1.disp_coke]*0 + _b[1.disp_pepsi]*mean_disp_pepsi;

scalar coke_at_1 = _b[_cons] + _b[pratio]*mean_pratio + _b[1.disp_coke]*1 + _b[1.disp_pepsi]*mean_disp_pepsi;

/* we cannot take derivatiive of discrete variable, so instead of normalden we use normal and get the value when it is one and zero and subtract them from one another. */

display normal(coke_at_1) - normal(coke_at_0);

/* now lets get AME, we need to make a new variable and get the average of that variable. */

/* use the regular variables, not the mean */
generate me_var = normalden(_b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*disp_coke + _b[1.disp_pepsi]*disp_pepsi)*_b[pratio];

sum me_var;

/* get all the effects when coke is 0 */
gen me_coke_0 = normal(_b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*0 + _b[1.disp_pepsi]*disp_pepsi);
/* get all the effects when coke is 1 */
gen me_coke_1 = normal(_b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*1 + _b[1.disp_pepsi]*disp_pepsi);

/* avg effect when coke is 0 */
sum me_coke_0;
scalar me_coke_0_val = r(mean);
/* avg effect when coke is 1 */
sum me_coke_1;
scalar me_coke_1_val = r(mean);

display me_coke_1_val - me_coke_0_val;

/* LOGIT MODEL */

logit coke c.pratio i.disp_coke i.disp_pepsi, r;
margins, dydx(*);
margins, dydx(*) atmeans;

/* ME at the means */

sum pratio;
scalar mean_pratio = r(mean);

sum disp_pepsi;
scalar mean_disp_pepsi = r(mean);

sum disp_coke;
scalar mean_disp_coke = r(mean);

scalar logit_me_pratio = _b[_cons] + _b[pratio]*mean_pratio + _b[1.disp_coke]*mean_disp_coke + _b[1.disp_pepsi]*mean_disp_pepsi;

display "The ME at the mean for Pratio in a Logit Model is "[exp(-logit_me_pratio)/((1+exp(-logit_me_pratio))^2)]*_b[pratio];