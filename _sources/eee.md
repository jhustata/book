
# pwd

We hereby commence session 1!

First, some [cool commands](https://www.stata.com/manuals13/u27.pdf):

Next, lets compose our first .do file script together

Lookout for `structure`, `indentation`, `annotation`

These three things make the script readable 

You will lose points in your [homework](hw1.md) if you neglect these three things!

Some other day we will talk about missigness [^3]

```stata

qui {
    
    if 1 { //linux,stata
    
       pwd
       ls -l
       clear
       cat adult.do
       do adult.do 
       di c(N) " rows & " c(k) " columns"
       local shape: di c(N) " rows & " c(k) " columns"
       di "`shape'"
                
    }
    
    if 2 { //continuous
    
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
        
    }
    
    if 3 { //binary
    
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
        
        
    }

    if 4 { //multi
        
        lookfor race 
        desc DMARETHN
        capture label drop race 
        
        #delimit ;
        lab def race 
           1 "White" 
           2 "Black"
           3 "Hispanic"
           4 "Asian";
        lab values DMARETHN race; 
        #delimit cr
        
        local v: var lab DMARETHN
        putexcel A4="`v', %"
        local vl: value label DMARETHN
        
        levelsof DMARETHN, local(race)  
        return list 
        
        count if !missing(DMARETHN)
        global N=r(N)
        
        local row=5
        
        foreach l of numlist `race' {
    
            local per: lab `vl' `l'
            qui sum DMARETHN if DMARETHN==`l'
            local percent: di %3.1f r(N)*100/$N
            di "`per', % : `percent'"
            putexcel A`row' = "   `per'"
            putexcel B`row' = "`percent'"
            local row=`row' + 1
            
        }    
        
}
    
    if 5 { //missingness
        
    }
}

```

[^3]: Simulate missingess of DMARETHN and assess impact on output
