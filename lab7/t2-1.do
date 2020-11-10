
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using t2-1.txt , text replace;
use t2-1.dta;

tsset code_numeric year_numeric;
sort code_numeric year_numeric;
tab year, gen(yr);
tab code, gen(cd);

reg fhpolrigaug L.(fhpolrigaug lrgdpch) yr* if sample==1, cluster(code);

reg fhpolrigaug L.(fhpolrigaug lrgdpch) yr* cd* if sample==1, cluster(code);

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


