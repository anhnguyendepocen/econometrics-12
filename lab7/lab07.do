
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab07.txt , text replace;
use Guns.dta;

gen ln_violence = ln(vio);
reg ln_violence shall, r;
dis "Adjusted R-squared is " _result(8);
/* i. */
global reg_variables "
incarc_rate density avginc pop pb1064
	pw1064 pm1029";
reg ln_violence shall $reg_variables , r;
dis "Adjust R-squared is " _result(8);
/* the presence of shall laws decreases violent vrimes by 44% on average or 36% with all else held equal. Both regressions are statistically significant.*/

/* ii. two-sample ttest */
test $reg_variables shall;

/* iii. the culture around gun usage in a state may not vary over time. For example, it is more common to carry guns in states that have open carry laws, and that culture may vary little over time within the state but varies significantly across states (Texas has a much different perception of guns than Rhode Island).*/

/* b. */

tab stateid , gen(stt);
global statevars "stt1 stt2 stt3 stt4 stt5 stt6 stt7 stt8 stt9 stt10 stt11 stt12 stt13 stt14 stt15 stt16 stt17 stt18 stt19 stt20 stt21 stt22 stt23 stt24 stt25 stt26 stt27 stt28 stt29 stt30 stt31 stt32 stt33 stt34 stt35 stt36 stt37 stt38 stt39 stt40 stt41 stt42 stt43 stt44 stt45 stt46 stt47 stt48 stt49 stt50";

dis 1 - chi2(50, 210.38*50);
dis invchi2( 50, .95)/50;

iis stateid;
tis year;
xtsum;


xtreg ln_violence shall $reg_variables, fe vce(cluster stateid);
/* This regression is more credible because its adjusted r-squared is significantly higher */

/* hausman test */
xtreg ln_violence shall $reg_variables, fe;
estimates store fe_reg_vars;
xtreg ln_violence shall $reg_variables, re;
estimates store re_reg_vars;
hausman fe_reg_vars re_reg_vars;
/*p-value is 0.0001, which is significant at the 0.01% level.*/

/*c*/

tab year, gen(yr);
global year_vars = "yr1 yr2 yr3 yr4 yr5 yr6 yr7 yr8 yr9 yr10 yr11 yr12 yr13 yr14 yr15 yr16 yr17 yr18 yr19 yr20 yr21 yr22";

reg ln_violence shall $year_vars $reg_variables $statevars, r;

test $year_vars;
dis 1- chi2(22, 13.9*22);
dis invchi2( 22, .95)/22;

xtreg ln_violence shall $year_vars $reg_variables, fe vce(cluster stateid);
/* p value is 0 for f test when we add the year variables. Additionally, the r-squared value is 95%. Because of this, this regression is more credible.*/
/*d*/

gen ln_rob = ln(rob);
xtreg ln_rob shall $year_vars $reg_variables, fe;
estimates store fe_ln_rob;

gen ln_mur = ln(mur);
xtreg ln_mur shall $year_vars $reg_variables, fe;
estimates store fe_ln_mur;

hausman fe_ln_rob fe_ln_mur;
/*e*/
/* one of the greatest concerns for the validity of this model remain in variables that vary significantly across states but vary little within a state over time. As mentioned above, this may be perceptions of guns and gun usage across states (like Texas vs. Delaware or Rhode Island), etc...*/

/*f*/
/* the effects of concealed-weapon laws on crime rates vary state-by-state and over time so these results are inconclusive.*/


log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


