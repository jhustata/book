
# pwd

Session 1 videos: 

1. [video1](https://www.dropbox.com/s/lvbn9c2xle8qpln/pwd1.mp4?dl=0?raw=1) 
2. [video2](https://www.dropbox.com/s/swq5a16dvyd2wz5/pwd2.mp4?dl=0?raw=1)
3. [profile.do](https://jhjhm.zoom.us/rec/share/5HbRh5ALkXawkMaSsITWGJnPN3vZZJWVp9EjxgFXZiGkduS2S55VgmBTl1Bf88PD.D2VIFqpidjNeh7A8?startTime=1680959893000)

Some [basic commands](https://www.stata.com/manuals13/u27.pdf) that the folks at Stata think you ought to know, by the end of this term. So keep checking on these every week to assess your progress.

Our goal in this session is to establish rules for all .do file scripts for the next 8 weeks:

1. `Structure`
2. `Indentation`
3. `Annotation`

Every .do file will have these items:

1. `quietly {`

```stata

qui {

}

```

2. `if 0 {`

```stata

qui {

   if 0 { //background

       1. a few remarks
       2. on what motivates
       3. this .do file script
       4. using ordinary text
       5. stata will not read this block

   }

}
```

3. `if 1 {`

```stata

qui {

   if 0 { //background

       1. a few remarks
       2. on what motivates
       3. this .do file script
       4. using ordinary text
       5. stata will not read this block

   }

   if  1 { //methods

   }

}
```

The `if 1 {` block is where you'll typically define `global macros`, open a `logfile`, and determine either your `pwd`, `filepaths`, or `urls` 

It will lay out the method or strategy by which you approach the task outlined in `if 0 {`

Each numerically sequenced `if` statement followed by a `{` will serve as your lodestar as you build a **vertically** growing script as contrasted with a **horizontally** sprawling one. Within each `if int {` you'll have a block of code that serves a rather specific function and can be copied and pasted to another .do file when such a task is needed in the future or by someone else.

As you put your .do file together you'll indent (typically 4 spaces) at each level: from `qui {` to `if 0 {`, and then from each `if int {` to the block of code within.

Within any block of code you'll also indent as lower-level options and suboptions emerge in your script.

Look to the scripts throughout this book as exemplars. Notice that each block of code must be lightly annotated to describe what it does. Use the `if 0 {` for more detailed annotation. 

Because this is an academic course, we will nudge you towards these practices by removing points in your [homework](hw1.md) if you neglect these [three things](dofilestructure.pdf): structure, indentation, and annotation.

```stata

qui {
    
    if 1 { //linux,stata
    
       capture log close
       log using pwd.log, replace 
    
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
    
    log close
}

```
