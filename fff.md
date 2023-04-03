# r(mean)

Let's start session 2 by creating a dataset. Then we'll explore return values, macros, and our first programs with it.

Place this [nhanes.ael.do](nhanes.ael.do) in your `pwd` before running the script below.

Your goal is to successfully run the .do file script rather than to interprete it

Then our first two commands will be: 

&nbsp;&nbsp;&nbsp; `sum hsageir`

&nbsp;&nbsp;&nbsp; `return list`

```stata

qui {
	
	if 0 { background:survey,cohort,chapter:`net search'
		
		1. import nhanes iii
		2. adult,exam,lab
		3. mortality-linkage 
		4. non-parametric survival
		5. semi-parametric survival
		
	}
	
	if 1 { //methods:macros,.dofiles,github 
		
		cls
		clear 
		capture log close
		log using nh3andmort.log,replace 
		
		timer clear 
		timer on 1
		
		#delimit ;
        global varlist  
           seqn 1-6  
           eligstat 15  
	       mortstat 16  
	       ucod_leading 17-19  
           diabetes 20  
	       hyperten 21  
	       permth_int 43-45  
	       permth_exm 46-48 ;
	    #delimit cr

	    global nchs https://ftp.cdc.gov/pub/Health_Statistics/NCHS/
        global linkage datalinkage/linked_mortality/
	    global nh3 NHANES_III
        global mort _MORT_2019_PUBLIC.dat
		
		global mortlab1 https://raw.githubusercontent.com/jhustata/
		global mortlab2 jhustata.github.io/main/mortlab.do
		
		timer off 1
		
	}
	
	if 2 { //mortality,codebook,eligibility
		
		timer on 2 
		
		infix $varlist using $nchs$linkage$nh3$mort, clear
		
		do "${mortlab1}${mortlab2}"
		
		drop if inlist(eligstat,2,3)
		duplicates drop
		save nh3mort,replace 
		
		timer off 2
		
	}
	
	if 3 { //survey,baseline:adult,exam,lab
	
	    timer on 3
		
		do nhanes.ael.do 
		
		timer on 31
		clear
		do adult.do
		rename *,lower
		save adult.dta,replace 
		timer off 31

		timer on 32
		clear 
		do exam.do
		rename *,lower
		save exam.dta,replace 
		timer off 32

		timer on 33
		clear 
		do lab.do
		rename *,lower 
		save lab.dta,replace 
		timer off 33
		
		timer off 3
		
	}
	
	if 4 { //link survey->mortality after merge
				
		timer on 4
		
		clear
		use adult 
		merge 1:1 seqn using exam,nogen
		merge 1:1 seqn using lab,nogen 
		merge 1:1 seqn using nh3mort,nogen keep(matched)

		timer off 4		
		
	}
	
	if 5 { //save analytic file
		
		timer on 5
		
		compress 
		lab dat "NHANES 1988-1994, survey & mortality"
		noi save "nh3andmort.dta", replace
		
		timer off 5
		
	}
	
	if 6 { //kaplan-meier curve,cox regression
		
		timer on 6
		lookfor mort
		codebook mortstat
		lookfor follow
		g years=permth_exm/12

		lookfor health
		codebook hab1
		global subgroup: var lab hab1
	
		stset years, fail(mortstat)

		#delimit ;
		sts graph if inrange(hab1,1,5),
		   by(hab1)
		   fail
		   ti("Morality in NHANES III",pos(11))
		   subti("by self report: ${subgroup}",pos(11))
		   yti("%",orientation(horizontal))
		   xti("Years")
		   per(100)
		   ylab(0(20)80,
		       format(%3.0f)
			   angle(360)
		   )
		   legend(on
		       lab(1 "Excellent")
			   lab(2 "Good")
			   lab(3 "Fair")
			   lab(4 "Bad")
			   lab(5 "Poor")
			   ring(0)
			   pos(11)
			   col(1)
			   order(5 4 3 2 1)
		   )
		   note("Source: RDC/NCHS/CDC/DHHS")  
		;
		#delimit cr
		
		graph export nh3andmort.png,replace 
		
		stcox i.hab1 if inrange(hab1,1,5)

    	   timer off 6
		   
	}
	
		noi timer list 
		noi timer clear
		log close 

}
		

 
```

