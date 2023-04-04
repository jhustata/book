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

[340.600](https://www.jhsph.edu/courses/course/36389/2022/340.600.01/stata-programming)

1. Vincent Jin zjin2@jhmi.edu (Lead TA)
2. Johnathan He zhe33@jhu.edu  
3. Darien Colson-Fearo dcolson3@jhmi.edu   
4. Sophia Magalona cmagalo1@jhmi.edu  
5. Jinqiao Ma jma75@jh.edu  
6. Jianan Lu jlu84@jhmi.edu  
7. Rediet Tekalign rtekali1@jhu.edu

[340.700](https://www.jhsph.edu/courses/course/37447/2022/340.700.71/advanced-stata-programming)

1. Jason Haw nhaw1@jhu.edu  

Optional labs

1. [M 9:30-10:30 am](lab1.md)
2. [T 10:00-11:00 am](lab1.md)
3. [W 3:00-4:00 pm](lab1.md)
4. [Th 6:00-7:00 pm](lab1.md)
5. [F 1:00-2:00 pm](lab1.md)

Homeworks due  

1. [Fri,Apr 21,11:59 PM](hw1.md)
2. Fri,May 5,11:59 PM
3. Fri,May 12,11:59 PM

Courseplus Perks

1. Q&A on Discussion forum
2. Announcements
3. Dropbox
4. Gradebook
5. Other

Who to email? [^1]

340.600

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

#

```{seealso}
Use the `tokenize` command to append the [DEMO.XPT](https://wwwn.cdc.gov/Nchs/Nhanes/2005-2006/DEMO_D.XPT) files for [all continuous NHANES: 1999-2018](https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Demographics) into one file.[^2]
Your .do file should include only one `import sasxport5` statement.
`Search` this book for the `import sasxport5` command. Up to 1.5 bonus points
```

Hint:

[tokenize.hint.do](tokenize.hint.do)

[tokenize.hint.log](tokenize.hint.log)

#

340.700

1. Jason Haw [M 3:30-4:30 pm](https://JHUBlueJays.zoom.us/j/91524920312?pwd=MlVLNVpObGNWRzZKTUNzVVNFM2djQT09)

#

Academic integrity

1. Collaboration is **strongly** encouraged
2. You should have a Github account (optional)
3. Submit your own work, acknowledging any other contributors
4. Please do cite sources of code snippets

#

[^1]: see chapter: [`net search`](zzz.md) for source code
[^2]: see chapter: [`net search`](zzz.md) for more on NHANES
