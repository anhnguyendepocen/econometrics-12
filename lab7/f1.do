
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using f1.txt , text replace;
use IncomeDem.dta;

twoway (scatter fhpolrigaug lrgdpch, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit fhpolrigaug lrgdpch, clcolor(black)), ytitle("Freedom House Measure of Democracy") xtitle("Log GDP per Capita (Penn World Tables)") title("Figure 1") subtitle("Democracy and Income, 1990s") legend(off) xscale(r(6 10.6));


log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


