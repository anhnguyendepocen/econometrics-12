#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab03-ee.txt , text replace;

use cps92_08;

sum;

/* a */
reg ahe age, r;
display ttail(15315, 16.72);
/* reject at 10%, 5%, and 1% level */

/* b */
reg ahe age, r level(92);
display invnormal(.04); /* 4% on each tail */

/* c */
reg ahe age if bachelor == 0, r;
display ttail(8644, 8.64);
/* significant at 10%, 5%, and 1% */

/* d */
reg ahe age if bachelor == 1, r;
display ttail(6671, 17.86);

/* e */
/* use coeffs from c and d */

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */
