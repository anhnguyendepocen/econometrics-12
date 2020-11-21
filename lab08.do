
#delimit;    /* make it so the semicolon signals end of each line 
                    because we can't see where the return is  */     
set more 1;  /* makes it so stata does not stop at each screen of output */
drop _all ;  /* clear all the variables in memory, if any */
capture log close; /* close any open log files */ 

log using lab08.txt , text replace;

use coke.dta;

/*linear probability model*/
reg coke c.pratio i.disp_coke i.disp_pepsi, r;
margins, dydx(*);
margins, dydx(*) atmeans;

/*probit model*/
/*marginal effect at the means*/
probit coke c.pratio i.disp_coke i.disp_pepsi, r;
margins, dydx(*);
margins, dydx(*) atmeans;

sum pratio;
scalar mpratio = r(mean);

sum disp_pepsi;
scalar mdisppepsi = r(mean);

sum disp_coke;
scalar mdispcoke = r(mean);

scalar mango = _b[_cons] + _b[pratio]*mpratio + _b[1.disp_coke]*mdispcoke + _b[1.disp_pepsi]*mdisppepsi;

display "The marginal efect at the mean for pratio is" normalden(mango)*_b[pratio];

/*marginal effect at the means for disp_coke*/
scalar apples1 = _b[_cons] + _b[pratio]*mpratio + _b[1.disp_coke]*1 + _b[1.disp_pepsi]*mdisppepsi;

scalar apples0 = _b[_cons] + _b[pratio]*mpratio + _b[1.disp_coke]*0 + _b[1.disp_pepsi]*mdisppepsi;

display apples1 apples0;

display "the predicted y-hat when disp_coke = 1 is " normal(apples1);
display "the predicted y-hat when disp_coke = 0 is " normal(apples0);
display "the marginal effct of disp_coe when x's are at their means is " normal(apples1)-normal(apples0);

/*average marginal effects for pratio*/
generate kiwi = normalden(_b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*disp_coke + _b[1.disp_pepsi]*disp_pepsi)*_b[pratio];
sum kiwi;
display "the average marginal effect is " r(mean);

/*average marginal effects for disp_coke*/
generate strawbs1 = _b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*1 + _b[1.disp_pepsi]*disp_pepsi;
generate strawbs0 = _b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*0 + _b[1.disp_pepsi]*disp_pepsi;

generate zstrawbs1 = normal(strawbs1);
generate zstrawbs0 = normal(strawbs0);

sum zstrawbs1; scalar zzstrawbs1 = r(mean);
sum zstrawbs0; scalar zzstrawbs0 = r(mean);

display "the average marginal effect of disp_cokel " zzstrawbs1 - zzstrawbs0;

/*logit model*/
logit coke c.pratio i.disp_coke i.disp_pepsi, r;
margins, dydx(*);
margins, dydx(*) atmeans;

/*marginal effect at the means*/
sum pratio;
scalar mpratio = r(mean);

sum disp_pepsi;
scalar mdisppepsi = r(mean);

sum disp_coke;
scalar mdispcoke = r(mean);

scalar mango = _b[_cons] + _b[pratio]*mpratio + _b[1.disp_coke]*mdispcoke + _b[1.disp_pepsi]*mdisppepsi;
display "The marginal efect at the mean for pratio is" [exp(-mango)/((1+exp(-mango))^2)]*_b[pratio];

/*marginal effect at the means for disp_coke*/
scalar apples1 = _b[_cons] + _b[pratio]*mpratio + _b[1.disp_coke]*1 + _b[1.disp_pepsi]*mdisppepsi;

scalar apples0 = _b[_cons] + _b[pratio]*mpratio + _b[1.disp_coke]*0 + _b[1.disp_pepsi]*mdisppepsi;

display apples1 apples0;

display "the predicted y-hat when disp_coke = 1 is " 1/[1+exp(-apples1)];
display "the predicted y-hat when disp_coke = 0 is " 1/[1+exp(-apples0)];
display "the marginal effct of disp_coe when x's are at their means is " 1/[1+exp(-apples1)]-1/[1+exp(-apples0)];

/*average marginal effects for pratio*/

generate pear = [(exp(-(_b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*disp_coke + _b[1.disp_pepsi]*disp_pepsi)))/(1+(exp(-(_b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*disp_coke + _b[1.disp_pepsi]*disp_pepsi))))^2]*_b[pratio];
sum pear;
display "the average marginal effect is " r(mean);

/*average marginal effects for disp_coke*/

generate peach1 = _b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*1 + _b[1.disp_pepsi]*disp_pepsi;
generate peach0 = _b[_cons] + _b[pratio]*pratio + _b[1.disp_coke]*0 + _b[1.disp_pepsi]*disp_pepsi;

generate logpeach1 = 1/(1+exp(-peach1));

generate logpeach0 = 1/(1+exp(-peach0));

sum logpeach1; scalar log1peach1 = r(mean);
sum logpeach0; scalar log0peach0 = r(mean);

display "the average marginal effect of disp_coke is " log1peach1-log0peach0;

log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


