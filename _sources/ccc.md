---
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.11.5
kernelspec:
  display_name: Python 3
  language: python
  name: python3
---

# Markdown vs. Powerpoint

Trying to wean myself from .PPT, which is suboptimal for a programming class! This, for instance, is **much** trickier to render in .PPT

```stata

qui {
    
    if 1 { //settings,logfile,macros
        
        cls
        clear 
        
        capture log close 
        log using adultlab.log, replace 
        
        
        global url https://wwwn.cdc.gov/nchs/data/nhanes3/1a/ 
        global sasprogram adult.sas
        global datafile adult.dat
        
    }
    
    if 2 { //import adult.sas read-in commands
        
        import delimited ${url}$sasprogram

    }
    
    if 3 { //output adult.do file read-in commands  
            
        preserve 
           keep in 1387/2624
           g id=_n+2
           insobs 1
           replace v1="#delimit ;" in `c(N)'
           insobs 1
           replace v1="infix" in `c(N)'
           insobs 1
           replace v1="using ${url}$datafile ;" in `c(N)'
           insobs 1
           replace v1="#delimit cr" in `c(N)'
           replace id=1 if v1=="#delimit ;"
           replace id=2 if v1=="infix"
           replace id=`c(N)' if v1=="using ${url}$datafile ;"
           replace id=id-1 if v1=="using ${url}$datafile ;"
           replace id=`c(N)' if v1=="#delimit cr"
           sort id
           drop id
           tempfile vars
           rename v1 concat 
           format concat %-20s
           keep concat 
           save `vars'
        restore 
        
        keep in 2627/3865
        split v1, p(" = ")
        gen concat="lab var "+v11+" "+v12
        keep concat 
        format concat %-20s
        drop in `c(N)'
        tempfile labs
        save `labs'
        
        use `vars', clear
        append using `labs'
        outfile using "adult.do", noquote replace
        
        log close 
        
    }
    
}

```

```{seealso}

Stata's `help` command

ChatGPT, when available
```

## More come..

```{seealso}
Where is the output from above saved?

type `pwd' into your stata command window

```
