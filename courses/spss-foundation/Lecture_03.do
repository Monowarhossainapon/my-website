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