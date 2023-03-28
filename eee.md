# pwd

We hereby commence session 1!

First, some [cool commands](https://www.stata.com/manuals13/u27.pdf):

Next, type the following commands sequentially into the command window

```stata
pwd
ls -l
clear
do adult.do //assumes you run the script on the chapter: delimit
di c(N) " rows & " c(k) " columns"
lookfor age
local v: var lab HSAGEIR 
di "`v'"
sum HSAGEIR, detail
di "`r(p25)'"
putexcel set table1, replace 
putexcel A1="Characteristics"
putexcel A2="`v'"
putexcel B1="(N=`c(N)')"
putexcel B2="`r(p50)' (`r(p25)'-`r(p50)')"
ls -ahl
```
