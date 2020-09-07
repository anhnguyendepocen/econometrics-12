
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab02.txt , text replace;


use cpsmar2016.dta;

tab a_maritl if a_sex == 2 & 30 <= a_age & a_age < 40;
tab a_maritl if a_sex == 1 & 30 <= a_age & a_age < 40;



sum wsal_val if peioocc==3850 & wsal_val>0 & a_wkstat == 2, detail;
sum wsal_val if peioocc==4760 & wsal_val>0 & a_wkstat == 2, detail;
sum wsal_val if peioocc==120 & wsal_val>0 & a_wkstat == 2, detail;
tab peioocc if peioocc==100;
sum wsal_val if peioocc==100 & wsal_val>0 & a_wkstat == 2, detail;
tab peioocc if peioocc==1050;
sum wsal_val if peioocc==1050 & wsal_val>0 & a_wkstat == 2, detail;

histogram wsal_val if peioocc==3850 & wsal_val>0 & a_wkstat == 2, normal;
histogram wsal_val if peioocc==4760 & wsal_val>0 & a_wkstat == 2, normal;
histogram wsal_val if peioocc==120 & wsal_val>0 & a_wkstat == 2, normal;
histogram wsal_val if peioocc==100 & wsal_val>0 & a_wkstat == 2, normal;
histogram wsal_val if peioocc==1050 & wsal_val>0 & a_wkstat == 2, normal; 


gen nevermarried = 0;
replace nevermarried=1 if a_maritl ==7;

ci proportions nevermarried if a_sex==2, level(99);
/* we can be 99% confident that the population proportion of women who have 
	have never been married will lie between 43.86% and 44.69% */



log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */