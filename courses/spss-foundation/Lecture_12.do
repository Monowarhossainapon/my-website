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
svy: tab v013 pregnancy_outcome, row  count svy: tab pregnancy_outcome, count format(%9.3f)
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





************************************
# Survival data analysis #3
*************************************

use "D:\4th year\AST 432 Statistical Computing XI\AST-432_2024\bc_data.dta",clear

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