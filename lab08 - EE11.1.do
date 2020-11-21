
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab08-EE.txt , text replace;

use Smoking.dta;

/* (A) */
/* I. all workers -> 24.23% */
sum smoker;
/* II. all workers affected by bans -> 21.2% */
sum smoker if smkban == 1;
/* III. all workers not affected by bans -> 28.9% */
sum smoker if smkban == 0;


/* (B) */
reg smoker smkban, r;
/* Given a smoking ban, the number of smokers is 7.8 percentage points lower in comparison to when there is not a smoking ban.*/
/* SE = .0089, Coef = -.078*/
scalar t_stat = (-.078 - 0)/(.0089);
display t_stat;
/* t-stat is -8.76, meaning that the results are statistically significant and we reject the null hypothesis.*/

/* (C) */
gen age_sq = age^2;
global variable_list_1 "female age age_sq hsdrop hsgrad colsome colgrad black hispanic";
reg smoker smkban $variable_list_1, r;
/* in (B), with no control variables, the estimated effect was a decrease of 7.8% of smoking employees when a smoking ban in in effect. In this regression, that effect drops from 7.8% decrease to a 4.7% decrease. This means that the regression in (B) with no control variables is likely to be subject to OVB. There are several 'real-life' explanations for this: High school dropouts may be more likely to smoke, or males may be more likely to smoke than females. Including these additional control variables removes a majority of the linear relationship that was previously being captured in the error term, leading to a more accurate estimate.*/

/* (D) */
scalar reg_c_t_stat = (-.04724 - 0)/(.0089);
display reg_c_t_stat;
/* The t-stat is roughly -5.31, so we reject the null hypothesis in favor of the alternative at the 5% level.*/

/* (E) */
/* f-test including all variables that are related to 'education' */
/* testing that smoking does not depend on education means testing that the coefficients for all education-related variables are 0. */
. test hsdrop hsgrad colsome colgrad;
/* the p-value is 0, so we reject the null hypothesis at the 1% significance level in favor of the alternative hypothesis. This means that we can conclude the coefficients on education are not 0 and smoking DOES depend on the level of education. The coefficients from regression (C) are hsdrop: .3227, hsgrad: .2327, colsome: .1642, colgrad: .04479, so we can see that as education increases the effect on smoker decreases. */
log close;