#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab03.txt , text replace;

use 04291-0001-Data;

/* I. */
reg VOL30 A5, r;
ttest VOL30, by(A5) unequal;


/* II. */
/* create new GPA variable */
generate gpa=1;
replace gpa=4.0 if F5==1;
replace gpa=3.7 if F5==2;
replace gpa=3.3 if F5==3;
replace gpa=3.0 if F5==4;
replace gpa=2.7 if F5==5;
replace gpa=2.3 if F5==6;
replace gpa=2.0 if F5==7;
replace gpa=1.7 if F5==8;
replace gpa=1.0 if F5==9;
replace gpa=. if F5==99;
replace gpa=. if F5==10;

reg gpa VOL30 if gpa !=. & gpa!=1, r;

/* B. */
display invttail(10511, .025);
display invnormal(.025);
display 1-normal(1.96);
display ttail(10511, 1.96);
save auto2, replace;
. sysuse auto;
graph twoway scatter price mpg;
graph export autograph.png, as(png) replace;
graph twoway lfitci price mpg || scatter price mpg;
graph export lfitciGraph.png, as(png) replace;

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */
