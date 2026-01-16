***********************************************
Lecture - 05
***********************************************

** Simple bar chart

use "D:\STATA Course\Stata file\birthwt.dta"

graph bar (count), over(low) ///
ytitle("Frequency") ///
title("Frequency distribution of low") ///
note("Source: Baystate Medical Centre, Springfield, MA")

graph bar (count), over(low)

graph bar, over(low) /*gives a percentage bar graph */



** Multiple bar charts
graph bar (count), over(race) over(low)
graph bar, over(race) over(low)

** stacked bar charts
graph bar, over(race) over(low) stack asyvars
/*treat first over() group as yvars*/

** pie charts
graph pie, over(low)

graph export "D:\STATA Course\Graph.png", as(png) name("Graph")


*******************************

tab age
recode age (14/18 = 1 "under 18")(18/45 = 2 "18+"),gen(nage)
tab nage

graph bar ,over(nage)
graph pie ,over(nage)
*******************************

keep if WB4 < 30
save "D:\STATA Course\Stata file\wm1.dta"
use "D:\STATA Course\Stata file\wm.dta", clear
keep if WB4 >= 30
save "D:\STATA Course\Stata file\wm2.dta"
use "D:\STATA Course\Stata file\wm.dta", clear
codebook WB5
tab disability HH7A
tab disability HH6
