
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab02-2.txt , text replace;


use cps92_08.dta;

sum;

/* D */
ci means ahe if bachelor==0 & year==2008, level(95);
ci means ahe if bachelor==1 & year==2008, level(95);
reg ahe bachelor, r;

/* E */
gen adjustedAhe = ahe;
replace adjustedAhe = ahe*1.534 if year == 1992;

ci means adjustedAhe if bachelor==0 & year==1992, level(95);
ci means adjustedAhe if bachelor==1 & year==1992, level(95);
reg adjustedAhe bachelor, r;

/* F */
ttest adjustedAhe if bachelor==0, by(year);
ttest adjustedAhe if bachelor==1, by(year);

/* 4.1 */
reg ahe age if year==2008, r;


log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


