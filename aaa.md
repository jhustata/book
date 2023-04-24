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

# tokenize

Our teaching team is here to help!

Your instructor

1. Abimereki Muzaale muzaale@jhmi.edu 

Teaching assistants

1. Vincent Jin zjin26@jhmi.edu (Lead TA)
2. Johnathan He zhe33@jhu.edu  
3. Darien Colson-Fearo dcolson3@jhmi.edu   
4. Sophia Magalona cmagalo1@jhmi.edu  
5. Jinqiao Ma jma75@jh.edu  
6. Jianan Lu jlu84@jhmi.edu  
7. Rediet Tekalign rtekali1@jhu.edu 

Optional labs

1. [M 9:30-10:30 am](lab4.md)
2. [T 10:00-11:00 am](lab4.md) Wolfe W2207
3. [W 3:00-4:00 pm](lab4.md)
4. [Th 6:00-7:00 pm](lab4.md)
5. [F 1:00-2:00 pm](lab4.md)

Homeworks due  

1. [Fri,Apr 21,11:59 PM](hw1.md)
2. [Fri,May 5,11:59 PM](hw2.md)
3. [Fri,May 12,11:59 PM](hw3.md)

Courseplus Perks

1. Q&A on Discussion forum
2. Announcements
3. Dropbox
4. Gradebook
5. Other

Who to email? [^1]

```stata

qui {
    
    
    if 1 { //N=26
        
        cls
        clear
        set obs 26
        
        capture log close 
        log using tokenize.log, replace  
        
    }
    
    if 2 { //Int 1-26
        
        egen lastname = seq(), f(1) t(26)
        tostring lastname, replace 
        tokenize "`c(ALPHA)'" 
        
    }

    if 3 { //Tokenize
        
        forval i = 1/26 {
            
            replace lastname = "``i''" if lastname == "`i'" 
            
        }
        
    }
    
    if 4 { //Randomly
        
        set seed 340600
        g randomorder=runiform()
        sort random  
        drop random    
        
    }
    
    if 5 { //Output
        
        noi list 
        log close 
        
    }

}


```

[tokenize.log](https://raw.githubusercontent.com/jhustata/book/main/tokenize.log)

1. SLBTM -> Darien Colson-Fearo
2. YZRVU -> Sophia Magalona
3. KGHJW -> Jinqiao Ma
4. FIDXC -> Jianan Lu
5. APEON -> Rediet Tekalign

**Bonus points:** Use the `tokenize` command to append the [DEMO.XPT](https://wwwn.cdc.gov/Nchs/Nhanes/2005-2006/DEMO_D.XPT) files for [all continuous NHANES: 1999-2018](https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Demographics) into one file.[^2]
Your .do file should include only one `import sasxport5` statement.
`Search` this book for the `import sasxport5` command. Up to 1.5 bonus points

Hint: [tokenize.hint.do](tokenize.hint.do) [tokenize.hint.log](tokenize.hint.log)

Academic integrity

1. Collaboration is **strongly** encouraged
2. You should have a Github account (optional)
3. Submit your own work, acknowledging any other contributors
4. Please do cite sources of code snippets

```{seealso}

What's new this week?

1. The `lab3` solutions are available & `lab4` has gone live! 
2. You are **strongly** encouraged to attempt `lab4` questions **before** Th 04/27/23
3. Both `hw2` and `hw3` have also gone live!


```


[^1]: see chapter: [`net search`](zzz.md) for source code
[^2]: see chapter: [`net search`](zzz.md) for more on NHANES
