**************************************
Lecture 06
**************************************

use "D:\STATA Course\Stata file\wm.dta"

tab HH7
tab HH7 [iweight = wmweight]
 
 
recode WB4(15/20 = 1 "15-20")(20/25 = 2 "20-25")(25/30 = 3 "25-30")(30/35 = 4 "30-35")(35/40 = 5 "35-40")(40/45 = 6 "40-45")(45/50 = 7 "45-50"), generate(agegroups) label(agegrp)
 
tab agegroups [iweight = wmweight]


 tab HH6 welevel [iweight = wmweight]
 tab HH6 welevel [iweight = wmweight], row
 tab HH6 welevel [iweight = wmweight], col
 tab HH6 welevel [iweight = wmweight], cell
 
 
 summarize WB4
 summarize WB4, detail
 summarize WB4 [aweight = wmweight]
 summarize WB4 [aweight = wmweight], detail
 
 
 by HH6, sort: summarize WB4, detail
 by HH6, sort: summarize WB4 [aweight = wmweight], detail
 codebook HH6
 codebook HH7
 
 keep if HH6 == 1
 summarize WB4
 keep if HH6 == 1 & HH7 == 10
 summarize WB4

 
 ********************************************
 Lecture 07
********************************************

use "D:\STATA Course\Stata file\wm.dta",clear

svyset [pw=wmweight], psu(WM1) strata(HH7A)
/* WM1 is the cluster number
HH7A is the district */

tab HH7 [iweight=wmweight]
svy: tab HH7
/* both the commands give the same result */
svy: tab HH6 welevel, row pearson
/* pearson chi-square */


use "D:\STATA Course\Stata file\multipleresponse.dta", clear

ssc install mrtab

mrtab OTHER2_1 OTHER2_2 OTHER2_3 OTHER2_4 OTHER2_5 ///
OTHER2_6 OTHER2_7 OTHER2_8 OTHER2_9 OTHER2_10 ///
OTHER2_11 OTHER2_12 OTHER2_13 OTHER2_14 OTHER2_15 ///
OTHER2_16 OTHER2_17 OTHER2_18 OTHER2_19 OTHER2_20 ///
OTHER2_21 OTHER2_22 OTHER2_23 OTHER2_24 OTHER2_25 ///
OTHER2_26 OTHER2_27
 
mrtab OTHER2_1 OTHER2_2 OTHER2_3 OTHER2_4 OTHER2_5 OTHER2_6 OTHER2_7 OTHER2_8 OTHER2_9 OTHER2_10 OTHER2_11 OTHER2_12 OTHER2_13 OTHER2_14 OTHER2_15 OTHER2_16 OTHER2_17 OTHER2_18 OTHER2_19 OTHER2_20 OTHER2_21 OTHER2_22 OTHER2_23 OTHER2_24 OTHER2_25 OTHER2_26 OTHER2_27



 outsheet using "E:\output.xlsx", replace
 
 ssc install asdoc
 asdoc tab HH7, replace
 
 

set maxvar 120000
use "D:\STATA Course\Stata file\BDIR81FL.DTA",clear


