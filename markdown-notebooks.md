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

Trying to wean myself from .PPT, which is suboptimal for a programming class!

## How we may share code

With MyST Markdown, you can define code cells with a directive like so:

```{code-cell}
qui {
    
    if 1 { //settings,logfile,macros
    
        cls 
        clear 
        
        capture log close 
        log using session0.log, replace 
        
        global url https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/
        global datafile DEMO.XPT 
        
        
    }
    
    if 2 { //import datafile
        
        import sasxport5 "${url}${datafile}", clear
        noi di "no of vars `c(k)' x " " no of obs " _N
    }
    
}
```

```{seealso}
Stata's help command
ChatGPT, when available
```

## More come..

```
type `pwd' into your stata command window
```
