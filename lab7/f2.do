
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using f2.txt , text replace;
use f2.dta;

twoway(scatter s5fhpolrigaug s5lrgdpch, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit s5fhpolrigaug s5lrgdpch, clcolor(black)), ytitle("Change in Freedom House Measure of Democracy") xtitle("Change in Log GDP per Capital (Penn World Tables)") title("Figure 2") subtitle("Change in Democracy and Change in Income, 1970-1995") legend(off);

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


