pwd

cd "E:\"

mkdir "E:\StataClass1"

cd "E:\StataClass1"

use "D:\STATA Course\Stata file\bd_individual.dta", clear

**Reading a Stata data file from a website**

use http://www.stata-press.com/data/r14/systolic, clear
webuse query
use http://www.stata-press.com/data/r14/systolic, clear
webuse lifeexp
webuse apple
webuse set http://www.zzz.edu/users/~sue,clear

webuse set http://www.stata-press.com/data/r14/, clear

webuse set "http://www.stata-press.com/data/r18/", clear

****************

import delimited "D:\STATA Course\Stata file\bd_individ.csv"

insheet using "D:\STATA Course\Stata file\bd_individ.csv", clear
insheet using "D:\STATA Course\Stata file\bd_individ.txt", clear

import excel "D:\STATA Course\Stata file\bd_individ.xlsx", sheet("bd_individ") clear

import excel "D:\STATA Course\Stata file\bd_individ.xlsx", sheet("bd_individ") firstrow clear

export delimited using "C:\Users\ASUS\Downloads\test.csv", nolabel replace



** Entering data into Stata **

input hhid sex str10 location
10030 1 urban
10031 0 rural
10032 1 rural
end



**# Bookmark #2


*******************************************
lecture 03
*******************************************

** To start a log file

log using "E:\example.txt", replace

log using "E:\example.txt", append

** Here append adds new input/output to end of existing log file example.txt.

** to pause recording.
 log off 
** to resume recording. 
 log on 
** to end the log file.
log close 

******************************


** Entering data into Stata **

input hhid sex str10 location
10030 1 urban
10031 0 rural
10032 1 rural
end

** Value labels

label define gender 0 "Male" 1 "Female"
label values sex gender

codebook sex

** Labelling variables

label variable hhid "Household identification number"
label variable location "Type of area of residence"
label variable sex "Gender of the respondent"

** String to labeled numeric:
encode location, gen(nlocation)

labelbook nlocation
codebook nlocation

** Labeled numeric to string:
decode sex, gen(nsex)



save "E:\FirstData.dta",replace



** rename

use "D:\STATA Course\Stata file\bd_individual.dta",clear
rename v011 DOB
rename v012 current_age

** labelbook

labelbook V024


use "D:\STATA Course\Stata file\bd_individual.dta",clear
** browse

browse caseid v002 v003 v012 v024

browse if v012<21
browse if v024==1
browse caseid v002 v003 v012 v024 if v012<21



**list

list
list caseid v002 v003 v012 v024
list if v024==1
list caseid v002 v003 v012 v024 if v024==1

** assert

assert v012>=15 & v012<=49

assert v024>15 & v024<=49

assert v012>15 & v012<=49

** describe

**# Bookmark #1
describe
describe caseid v002 v003 v012 v024

** summarize

summarize v012
summarize v012, detail /*(to get percentiles)*/
summarize v012 if v024==1


** codebook

codebook
codebook caseid v002 v003 v012 v024

** tabulate

tabulate v024
tabulate v024 v106

tab v024
tab v024 v106


tab v024
tab v024 v106
tab v024


***********************************************
Lecture 04
***********************************************

cd "C:\Users\HP\Downloads\Stata Course"

use "C:\Users\HP\Downloads\Stata Course\bd_individual.dta", clear

label data ///
"Data on Bangladeshi females at reproductive ages"
describe

gen aggap = v730- v012 
egen nage = mean(v012), by(v106) 
gen ecb = 0
replace ecb = 1 if v212 < 18
br

recode v106 (2 3 = 2), generate(nv106)
label define newlab 0 "no education" 1 "primary" 2 "secondary or higher"
label values nv106 newlab
 
summarize v012 /*respondent'scurrentage*/
recode v012 (15/17 = 0 "<18") (18 19 = 1 "18-19") (20/29 = 2 "20-29") (30/39 = 3 "30-39") (else = .), generate(agegroups) label(agegrp)
 
keep caseid v002 v003 v012 v024 v730 v190 v024
keep if v012 >= 18
keep in 1/5 //Keepsfirstfiveobservations
 
drop v730
drop if v012 < 18

sort caseid
sort v190 v024 // Division sorted within wealth index

gsort +v190
gsort -v190
gsort v190 -v024
browse caseid v190 v024

use "C:\Users\HP\Downloads\Stata Course\faminc.dta", clear
br
reshape long faminc, i(famid) j(year)
br

use "C:\Users\HP\Downloads\Stata Course\kids.dta", clear
br
reshape wide age, i(famid) j(birth)
br

use "C:\Users\HP\Downloads\Stata Course\bd_individual.dta", clear
keep if v012 >= 18
save adults.dta
count

use "C:\Users\HP\Downloads\Stata Course\bd_individual.dta", clear
keep if v012 < 18
save nonadults.dta
count 

append using adults.dta
count

use "C:\Users\HP\Downloads\Stata Course\bd_individual.dta", clear
keep caseid v001 v002 v003 v010 v024 v025 v106
sort caseid
save demographic.dta

use "C:\Users\HP\Downloads\Stata Course\bd_individual.dta", clear
keep caseid v119 v120 v121 v122 v123 v124 v125
sort caseid
save wealth.dta

append using demographic.dta
count

use "C:\Users\HP\Documents\wealth.dta"
merge 1:1 caseid using "C:\Users\HP\Documents\demographic.dta"

use "C:\Users\HP\Downloads\Stata Course\data1.dta", clear
merge 1:m household_id using "C:\Users\HP\Downloads\Stata Course\data2.dta"

use "C:\Users\HP\Downloads\Stata Course\data2.dta", clear
merge m:1 household_id using "C:\Users\HP\Downloads\Stata Course\data1.dta"

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
 
 
 
log using "output.log", replace
set logtype pdf
 
set maxvar 120000
use "D:\STATA Course\Stata file\BDIR81FL.DTA",clear


***********************************

use "D:\STATA Course\Stata file\wm1.dta"

merge 1:1 HH1 HH2 LN WM1 using "D:\STATA Course\Stata file\wm2.dta"

save "D:\STATA Course\Stata file\wm.dta"



*******************************************
**# Lecture 12 #2

***********************************************

pregnancy_outcome
respondent_working_status
age in 5-year groups =v013
highest educational level =v106
husband/partner's education level=v701
wealth_index
type of place of residence= v025
division = v024
husbands_working_status

cluster number =v001
women's individual sample weight (6 decimals) =v005
stratification used in sample design =v023

**** we want to assess whether working status of women have any influence on negative pregnancy outcome or not.



*** Increase stata's variable capacity by set maxvar command.
 
 set maxvar 12000
use "D:\4th year\AST 432 Statistical Computing XI\AST-432_2024\BD_2022_DHS_09252024_916_182769-20241104T035233Z-001\BD_2022_DHS_09252024_916_182769\BDIR81DT\BDIR81FL.DTA",clear


* creating our dependent outcome variable (negative pregancy outcome)
 
drop if p30_01 == .
recode p30_01 (2/4= 1 "negative")(1 =0 "positive"), gen(pregnancy_outcome)


* creating our exposure/ explanatory variable (women's working status)

drop if v717 == 98
drop if v717 == .
recode v717(0 = 0 "not work") (1/9 =1 "working"), gen (respondent_working_status)

* creating confounders that can incluence both y and x variable (mostly x variable)

* educational status of husband
drop if v701==8

* wealth index
recode v190 (1/2 =1 "poor")(3=2 "middle")(4/5=3 "Rich"), gen(wealth_index)



* husband's working status
drop if v705 == .
drop if v705 == 98
recode v705(0 = 0 "not work") (1/9 =1 "working"), gen (husbands_working_status)



* keeping our y, x and confunder variables along with survey weight adjustment variables


keep pregnancy_outcome respondent_working_status v013 v106 v701 wealth_index v025 v024 husbands_working_status v001 v005 v023

save "D:\4th year\AST 432 Statistical Computing XI\AST-432_2024\AST 432 pregnancy outcome.dta",replace

******************************************* without survey weight adjustment ******************************************************************
use "D:\4th year\AST 432 Statistical Computing XI\AST-432_2024\AST 432 pregnancy outcome.dta",clear

*univariate

tab pregnancy_outcome
tab respondent_working_status
tab v013
tab v024
tab v025
tab v106
tab v701
tab wealth_index
tab husbands_working_status

*Bivariate

tab respondent_working_status pregnancy_outcome, row chi
tab v013 pregnancy_outcome, row chi
tab v024 pregnancy_outcome, row chi
tab v025 pregnancy_outcome, row chi
tab v106 pregnancy_outcome, row chi
tab v701 pregnancy_outcome, row chi
tab wealth_index pregnancy_outcome, row chi
tab husbands_working_status pregnancy_outcome, row chi



* Multivariable model
* binary logistic regression model
* conducting the model without husband's educational model as it is not significant at 5% level of significance.

logit pregnancy_outcome i.respondent_working_status i.v013 i.v024 i.v025 i.v106 i.wealth_index ,or allbase

***** interpret the result yourself





*************************************** with survey weight adjustment ******************************************************************

*Adjust survey weight according to the sampling technique

gen sw=v005/1000000
svyset [pweight=sw], psu (v001) strata(v023)


*univariate

svy: tab pregnancy_outcome, count format(%9.3f)
svy: tab respondent_working_status, count format(%9.3f)
svy: tab v013, count format(%9.3f)
svy: tab v024, count format(%9.3f)
svy: tab v025, count format(%9.3f)
svy: tab v106, count format(%9.3f)
svy: tab v701, count format(%9.3f)
svy: tab wealth_index, count format(%9.3f)
svy: tab husbands_working_status, count format(%9.3f)



svy: tab pregnancy_outcome, percent format(%9.3f)
svy: tab respondent_working_status, percent format(%9.3f)
svy: tab v013, percent format(%9.3f)
svy: tab v024, percent format(%9.3f)
svy: tab v025, percent format(%9.3f)
svy: tab v106, percent format(%9.3f)
svy: tab v701, percent format(%9.3f)
svy: tab wealth_index, percent format(%9.3f)
svy: tab husbands_working_status, percent format(%9.3f)



*bivariate

svy: tab respondent_working_status pregnancy_outcome, row  count format(%9.3f)
svy: tab v013 pregnancy_outcome, row  count format(%9.3f)
svy: tab v024 pregnancy_outcome, row  count format(%9.3f)
svy: tab v025 pregnancy_outcome, row count format(%9.3f)
svy: tab v106 pregnancy_outcome, row  count format(%9.3f)
svy: tab v701 pregnancy_outcome, row  count format(%9.3f)
svy: tab wealth_index pregnancy_outcome, row  count format(%9.3f)
svy: tab husbands_working_status pregnancy_outcome, row  count format(%9.3f)



svy: tab respondent_working_status pregnancy_outcome, row  percent format(%9.3f)
svy: tab v013 pregnancy_outcome, row  percent format(%9.3f)
svy: tab v024 pregnancy_outcome, row  percent format(%9.3f)
svy: tab v025 pregnancy_outcome, row percent format(%9.3f)
svy: tab v106 pregnancy_outcome, row  percent format(%9.3f)
svy: tab v701 pregnancy_outcome, row  percent format(%9.3f)
svy: tab wealth_index pregnancy_outcome, row  percent format(%9.3f)
svy: tab husbands_working_status pregnancy_outcome, row  percent format(%9.3f)


* Multivariable model
* Only respondent's working  status, division and type of residence found significant (5%) in bivariate analysis after adjusting for survey weight.



svy: logit pregnancy_outcome i.respondent_working_status i.v024 i.v025, or allbase




*****Do you find any difference in the result after  adjusting survey weight???

**************************************************************************************

*******************************************
logit pregnancy_outcome i.respondent_working_status i.v013 i.v024 i.v025 i.v106 i.wealth_index ,or allbase

***without servay weight 

logit pregnancy_outcome i.respondent_working_status i.v024 i.v025, or allbase

lroc

estat gof



*****************************************


logit pregnancy_outcome, or
estimate store m1
logit pregnancy_outcome i.respondent_working_status,or

estimate store m2

lrtest m2 m1




ttest v201, by( respondent_working_status)

oneway v201 v024
tabstat v201, by( v024) stat(mean)

poisson v201 i.respondent_working_status i.v024, irr





**************************************
**# Survival data analysis #3
20/01/2025
**************************************

use "D:\4th year\AST 432 Statistical Computing XI\AST-432_2024\bc_data.dta"

stset rectime censrec

*stset Syvival_time censring_indicator

* univariate Analysis
stsum
tab censrec
tab hormon
tab chemo

* kaplan_Meier Survival estimate
* Ovetrall
sts graph
* Hormon
sts graph ,by( hormon)
* Chemo
sts graph ,by( chemo )

*Log-rank test
sts test hormon
sts test chemo

sts graph ,by( chemo ) gwood level(95)
sts graph ,by( hormon ) gwood level(95)

* the effect of hormon , people who receive chemo 
sts graph if (chemo ==2),by( hormon)

** merge Two graph 

sts graph if (chemo ==1),by( hormon) gwood name(n_chemo ,replace)
sts graph if (chemo ==2),by( hormon) gwood name(y_chemo ,replace)

gr combine n_chemo y_chemo ,col (2)