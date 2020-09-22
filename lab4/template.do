
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab04.txt , text replace;

use lab04.dta;

/* detailed summary stats */
sum, detail;


/* A i. */

sort statefip;
/* sum stats of private healthcare coverage by each state */
by statefip: sum hcovpriv, detail;

/* A ii. */
tab hinscaid if age >= 25 & age <= 55 & educ <= 6 & sex == 2 & empstat == 1;
tab hinscaid if age >= 25 & age <= 55 & educ <= 6 & sex == 1 & empstat == 1;
tab hinscaid if age >= 25 & age <= 55 & educ <= 10 & sex == 2 & empstat == 1;
tab hinscaid if age >= 25 & age <= 55 & educ <= 10 & sex == 1 & empstat == 1;


/* A iii. */
ttest hinscaid if empstat==2 | empstat==3, by(empstat) unequal unpaired;

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


