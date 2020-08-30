
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

cd C:\Users\damurphy\Desktop;

log using lab01.txt , text replace;

use auto.dta;

/* Question B. */


/* summary statistics */
sum;
/* variable information */
list;


/* Question C. */


/* inspect the 'foreign' column*/
list foreign;

/*create a column, domestic, filled with 0's*/
gen domestic=0;
/*replace the 0 with a 1 if foreign='Domestic'*/
replace domestic=1 if foreign=="Domestic";

/* inspect the 'domestic' column*/
list domestic;
sum domestic;


/* Question D. */

/* create a frequency table */
tabulate headroom;

/* calculate % */
/* 1. get count of headroom > 4 */
count if headroom > 4;

/* 3. display the percentage. */
display (5/74)*100;


/* Question E. */

/* conditional mean. */
mean mpg if domestic==1;


/* Question F. */


regress mpg weight length domestic, robust;
/* weight is significant at the 5% level because its p-value is less than .05 (it is .03) */


/* Question G. */

/* export file as CSV */
export delimited using "auto.csv", delim(",") replace;


log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */

