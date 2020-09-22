
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab04-ee.txt , text replace;

use TeachingRatings.dta;

/* summarize dta */
sum;

reg course_eval beauty, r;
/* B */
reg course_eval beauty intro onecredit female minority nnenglish, r;

reg beauty age, r;

/* C */
reg beauty intro onecredit female minority nnenglish, r;
predict xtilde, resid;

reg course_eval intro onecredit female minority nnenglish, r;
predict ytilde, resid;

reg ytilde xtilde, r;

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


