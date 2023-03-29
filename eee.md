# pwd

We hereby commence session 1!

First, some [cool commands](https://www.stata.com/manuals13/u27.pdf):

Next, type the following commands sequentially into the command window

```stata
pwd
ls -l
clear
cat adult.do
do adult.do //assumes you run the script on the chapter: delimit
di c(N) " rows & " c(k) " columns"
local shape: di c(N) " rows & " c(k) " columns"
di "`shape'"

//continuous
lookfor age
local v: var lab HSAGEIR 
di "`v'"
sum HSAGEIR, detail
return list
di "`r(p25)'"
putexcel set table1, replace 
putexcel A1="Characteristics"
putexcel A2="`v'"
putexcel B1="(N=`c(N)')"
putexcel B2="`r(p50)' (`r(p25)'-`r(p50)')"
ls -ahl

//binary
lookfor sex
codebook HSSEX 
replace HSSEX=2-HSSEX 
sum HSSEX
return list 
local v: var lab HSSEX
di "`v'"
local per: di %3.1f r(mean)*100
di "`per'"
putexcel A3="`v'"
putexcel B3="`per'"

//multi
lookfor race 
levelsof DMARETHN, local(race)  
return list 
local nlevels=r(r)
forvalues l = 1/`nlevels' {
    
    local per: value lab DMARETHN
    di "`per'"
    
}

desc DMARETHN

#delimit ;
lab def race 
   1 "White" 
   2 "Black"
   3 "Hispanic"
   4 "Asian";
lab values DMARETHN race
#delimit cr
levelsof DMARETHN, local(race)  
return list 
local nlevels=r(r)
forvalues l = 1/`nlevels' {
    
    local per: value lab race
    di "`per'"
    
}
```
