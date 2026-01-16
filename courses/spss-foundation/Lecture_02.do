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
