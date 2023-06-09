# if c(version)>16 {

[video](https://jhjhm.zoom.us/rec/share/jCsUVcLItDweTRg_DQT5yXhDFxXkwvzImR4RgXPlW5wkJMu1BbSNWwo7Rw6Nu6Wq.Tix4e3rO4wMjVzeX?startTime=1684438391000)

## 8.1 codetta

+ How would you display double-quotes `" "` within a string?

```stata
. di `"  "' 

. 

. di `"  "quote"   "'
"quote"  

. di `"  " "   "'
" "   

. di `""Strings!""'
"Strings!"

. di `"Ever heard of "for the love of the game" clause in Michael Jordans contract? "'
Ever heard of "for the love of the game" clause in Michael Jordans contract? 
```
+ You are now primed for this mind twister:

```stata

di `"`label_string' `1' "`3'""'

di `"    `label_string' `1' "`3'"     "'

di "`label_string'"
di "`1'"
di `"    "`3'"    "' //token
```

+ The program below will not run after May
+ So you should give it a trial run in June!
+ By now you should be able to edit it to allow it to work beyond May

```stata

. di c(current_date) //spaces count in strings
19 May 2023

. di strpos("`c(current_date)'","May") 
4

. di strpos("`c(current_date)'","May")>0
1

```

+ In the code-block below the first `if _N {` is equal to `if 0 {`
+ `if strpos("`c(current_date)'","May")>0 is equal to `if 1 {`
+ Just whetting your mind... 

```stata

qui {
	clear
	cls
	if _N { //background
		 helpful to label all variables but especially
		 multicategory variables as seen in q5hw1.
		 not only do you label the variable, you also 
		 label values of the variable levels (alliteration).
		 they should be labelled if at all you wish to 
	 	 efficiently produce a tidy publication-ready table1.
	 	 here we have a very condensed script to do all the above!
	}
	if strpos("`c(current_date)'","May")>0 { //methods
		 macro drop all
		 global github https://raw.githubusercontent.com/
		 global downloads jhustata/book/main/
		 global workdir `c(pwd)'
		 capture log close
		 log using hw1q5.log, replace 
	}
	if _N==0 { //results
		 import delimited "${github}${downloads}hw1.txt"
         noi di "obs: `c(N)' & vars: `c(k)'"
	}
	if _N { //conclusion
		 levelsof dx, local(dx_helper)
		 foreach i in `dx_helper' {
			tokenize `i', p("=")
			local label_string: di `"`label_string' `1' "`3'""'
	    }
	}
	if _N>0 { //acknowledgements
		 macro list //do this noisily!
         capture label drop dx
         label define dx `label_string'
         split dx, p("=") generate(dx)
         destring dx1, replace
         label values dx1 dx //alliteration
		 noi tab dx1
	}
	if 0 { //references
		 1. vincent jin, your lead ta, 05/2023
		 2. hw1q5 ph340.600
	}
    log close 
}

```
[hw1q5.log](https://raw.githubusercontent.com/jhustata/book/main/hw1q5.log)

## 8.2 stunning

```stata
use transplants, clear 
histogram varname, normal
graph export histnormal.png, replace 
```
![](histnormal.png)

```stata

. sum	age,d

		Age at	TX
					
	Percentiles	Smallest
1%	6	0
5%	20	0
10%	29	0		Obs	6,000
25%	41	0		Sum of wgt.	6,000

50%	53			Mean	50.56117
		Largest		Std. dev.	15.58661
75%	62	83
90%	68	83		Variance	242.9424
95%	71	83		Skewness	-.7483359
99%	77	87		Kurtosis	3.268634

```

## 8.3 transparency

```stata

qui {
	clear
	if _N {
		fcolor option is really neat
		when overlaying histograms
		one doesn't coverup the other
	}
	if c(N)==0 {
		global url1 https://raw.githubusercontent.com/bcaffo/
		global url2 ds4bme_intro/master/data/
		if c(version)>17 {
			di "you're good to go"
	    }
	    else {
		    set scheme stcolor
	    }
	}
	if _N<1 {
		import delimited "${url1}${url2}oasis.csv", clear
	}
	if _N {
		#delimit ;
		hist flair_10, 
		    legend(on
			    ti("Gold Lesions")
			    ring(0)
				pos(3)
				col(2)
				lab(1 "Yes")
				lab(2 "Simulation")
				lab(3 "No")
			)
			xti("Flair")
			yti("N",
			    orientation(horizontal)
			)
		    freq 
			normal 
			fcolor(orange%40) 
			addplot(hist flair_20, 
			    freq 
				lpattern(solid) 
				fcolor(midblue%50)
			)
		;
		graph export transparency.png, replace ;
		#delimit cr
	}
}
```

![](transparency.png)

## 8.4 scheme

```stata
qui {
	clear
	if _N {
		fcolor option is really neat
		when overlaying histograms
		one doesn't coverup the other
	}
	if c(N)==0 {
		global url1 https://raw.githubusercontent.com/bcaffo/
		global url2 ds4bme_intro/master/data/
		if c(version)>17 {
			set scheme s2color
	    }
	    else {
		    noi di "you're good to go!"
	    }
	}
	if _N<1 {
		import delimited "${url1}${url2}oasis.csv", clear
	}
	if _N {
		#delimit ;
		hist flair_10, 
		    legend(on
			    ti("Gold Lesions")
			    ring(0)
				pos(3)
				col(2)
				lab(1 "Yes")
				lab(2 "Simulation")
				lab(3 "No")
			)
			xti("Flair")
			yti("N",
			    orientation(horizontal)
			)
		    freq 
			normal 
			fcolor(orange%40) 
			addplot(hist flair_20, 
			    freq 
				lpattern(solid) 
				fcolor(midblue%50)
			)
		;
		graph export transparency.png, replace ;
		#delimit cr
	}
}
```

![](transparency_s2col.png)

## 8.5 punchline
```stata
if c(version)>17 { //tip 4 hw3
    set scheme s2color
}
else { //stcolor is default in v18
    di "you're good to go!"
}
```

## 8.6 chatGPT

**Yours truly:** share 20 unique conditional if code-blocks in Stata. Use a publicly available dataset to demonstrate these

Refs:

Publically available Stata [datasets](https://www.stata-press.com/data/r8/u.html)   
Example selected by chatGPT: auto

```Stata
global url https://www.stata-press.com/data/r8/
```

**ChatGPT May12 Version**: 

Sure! Here are 20 unique conditional code-blocks in Stata using the publicly available "auto" dataset:

1. Code-block with if statement and else statement:

```stata

use ${url}auto.dta //edited to include url
local nobs=c(N)
local nvars=c(k)
webuse auto, clear
if `nobs'==c(N) & `nvars'==c(k) {
	di "'webuse' is an alternative to ${url}use"
}
if foreign == 1 {
  list make
}
else {
  list mpg
}

```

This will list the make variable if the foreign variable is equal to 1, and the mpg variable otherwise.

2. Code-block with if statement and else-if statement:

```arduino
if price < 15000 {
  display "Budget car"
}
else if price < 25000 {
  display "Mid-range car"
}
else {
  display "Luxury car"
}

```

This will display a message based on the price variable, indicating whether the car is a budget car, a mid-range car, or a luxury car.

3. Code-block with nested if statements:

```arduino
if foreign == 1 {
  if mpg < 25 {
    display "High-performance foreign car"
  }
  else {
    display "Foreign car"
  }
}
else {
  if mpg < 20 {
    display "Gas-guzzling domestic car"
  }
  else {
    display "Domestic car"
  }
}

```

This will display a message based on the foreign and mpg variables, indicating whether the car is a high-performance foreign car, a foreign car, a gas-guzzling domestic car, or a domestic car.

$\vdots$

8. Code-block with if statement and local macro:

```bash
local myvar "foreign"
if "`myvar'" == "foreign" {
  list make
}
else {
  list mpg
}
```

This will define a local macro called "myvar", and then use it in an if statement to determine whether to list the make or mpg variable.

$\vdots$

## 8.7 reshape

### 8.7.1 long

+ Longitudinal data (time-varying covariates)
     + individual
	 + time
         + confounders
	     + mediators
	     + surrogate outcomes

+ Hierarchical data
     + county
	 + schools
	     + public
		 + private
		 + charter
		 + magnet 
		 
### 8.7.2 wide
  long -> wide: some loss of information + <u>drastic</u> increase in number of variables

+ Individual
     + confounder1 confounder2 $\cdots$ confounderN
	 + mediator1 mediator2 $\cdots$ mediatorN
	 + outcome1 outcome2 $\cdots$ outcomeN

+ County
    + publicSch1 publicSch2 $\cdots$ publicSchN
	+ privateSch1 privateSch2 $\cdots$ privateSchN
	+ etc.

### 8.7.3 isid

+ Quick way to determine whether a dataset is wide or long

```stata
use hw2_pra_hist.dta, clear
ds 
codebook px_id 
isid px_id
```

```stata

qui {
	clear 
	cls
	if _N {
		reshape
		long -> wide
		then reverse
	}
	if c(N)==0 { //change content of macros to match location  ... 
		global path1 ~/dropbox/2e.πρᾶξις,σ/3.acetyl.neurotrans/
		global path2 big.data/big.data.usrds
		global file 00_exposureR.dta
	}
	if _N < 1 {
		use "${path1}${path2}/$file"
	}
	if c(N) !=0 { //using simulation to eliminate disclosure risk
		noi di "obs: `c(N)', vars: `c(k)'"
		g nodisclosurerisk=usrds_id+round(runiform(1,c(N)))
		g ndr=round(runiform(300,365*2))
		sort usrds srvc_dt
		by usrds_id: egen dt=min(ndr)
		replace srvc_dt=srvc_dt+dt
		by usrds_id: egen id=min(nodisclosurerisk)
		keep id srvc_dt insulin diur antipsy
		keep id srvc_dt insulin diur antipsy
		noi l id srvc_dt insulin diur antipsy  in 1/30
		keep in 19/26
		save reshape.dta, replace 
		noi di "obs: `c(N)', vars: `c(k)'"
	}
	if _N {
		//isid id
		g visit=_n
		keep antips* insulin diur* id visit 
		reshape wide antips* diur* insulin, i(id) j(visit)
	}
	if r(N) == 1 {
		noi list
	}
	else {
		noi di "There's more than one observation"
	}
}

```

[reshape.dta](reshape.dta)

## 8.8 matcell

```stata
use transplants, clear
tab dx gender, matcell(table)
di table[4,1] //Hypertensive Male
```

## 8.9 test.do

+ takeaways from regrading hw1
+ `presubmit` homeworks in future
+ our team to check for only two things:

     1. overarching `qui {`
	 2. controlled logfile output with **no** error
	 3. shouldn't be time-consuming for student or grader 
	 4. maybe do all the above via github commits? collaboratively?
	 5. i think thats where we are headed based on the perks...

+ not allowed to submit any hw until `presubmit` clearance
+ encourage students to test their .do file at each step as it grows (share `repo` link)
+ as contrasted with checking a final product, which by then may have monstrously grown beyond anyones debugging skills
+ much more emphasis on the process, collaborative, open, decentralized repo, than a `final judgment` 

## 8.10 feedback

+ feedback welcome
+ any system without a feedback loop is like a cancer
+ so please send us an email `if & when ... ` 

## 8.11 suigeneris

```stata
#delimit ; //hw1q6
    table () (command result), 
	    command(_r_b _r_ci:logistic received_kt init_age female) 
		nformat(%5.2f _r_b _r_ci) 
		sformat("(%s)"  _r_ci ) 
		cidelimiter(-) ;
	collect label levels result _r_b "OR", modify ;
	collect label levels result _r_ci "(95% CI)", modify ;
	collect label levels 
	    command 1 "Logistic Regression Model for Age and Sex", modify;
	noi di "Question 6:" ;
	noi collect preview ;
#delimit cr
```

## 8.12 myfirst

### 8.12.1 unconditional

+ The time it takes to write the program below 
+ Is it dependent on, of independent of, `c(N)`?
+ How about manually estimating median (IQR) for each varname?
+ May this motivate you to <u>incorporate programming</u> into your workflow!

```stata
capture program drop myfirst 
quietly program define myfirst
    cls 
    qui ds 
	foreach v of varlist `r(varlist)' {
		qui sum `v', d
		qui local m_iqr: di %3.1f r(p50) "(" %3.1f r(p25) "-" %3.1f r(p75) ")"
		if c(N) < 10 {
            noi di `"The median (IQR) of "`v'" is `m_iqr' "'
		}
		else {
			noi di "Too many values, select no more than 10 varnames"
		}
	}
end 
use transplants, clear 
myfirst 
``` 

```s
The	median	(IQR)	of	"fake_id" is 3000.5(1500.5-4500.5) 
The	median	(IQR)	of	"ctr_id" is 41.0(30.0-49.0) 
The	median	(IQR)	of	"transplant_date" is 19757.0(18492.0-20902.0) 
The	median	(IQR)	of	"don_hgt_cm" is 172.0(163.0-180.0) 
The	median	(IQR)	of	"don_wgt_kg" is 79.0(66.0-93.0) 
The	median	(IQR)	of	"don_cod" is 2.0(1.0-3.0) 
The	median	(IQR)	of	"don_ecd" is 0.0(0.0-0.0) 
The	median	(IQR)	of	"dx" is 4.0(2.0-9.0) 
The	median	(IQR)	of	"race" is 2.0(1.0-4.0) 
The	median	(IQR)	of	"rec_hgt_cm" is 170.0(162.0-177.8) 
The	median	(IQR)	of	"rec_wgt_kg" is 79.0(66.2-93.4) 
The	median	(IQR)	of	"bmi" is 28.0(24.0-32.0) 
The	median	(IQR)	of	"prev_ki" is 0.0(0.0-0.0) 
The	median	(IQR)	of	"age" is 53.0(41.0-62.0) 
The	median	(IQR)	of	"peak_pra" is 0.0(0.0-14.0) 
The	median	(IQR)	of	"end_date" is 21868.0(21802.0-21901.0) 
The	median	(IQR)	of	"died" is 0.0(0.0-0.0) 
The	median	(IQR)	of	"tx_failed" is 1.0(0.0-1.0) 
The	median	(IQR)	of	"wait_yrs" is 1.8(0.6-3.5) 
The	median	(IQR)	of	"abo" is 3.0(1.0-4.0) 
The	median	(IQR)	of	"gender" is 0.0(0.0-1.0) 
The	median	(IQR)	of	"rec_hcv_antibody" is 0.0(0.0-0.0) 
The	median	(IQR)	of	"rec_work" is 0.0(0.0-1.0) 
The	median	(IQR)	of	"pretx_cmv" is 1.0(0.0-1.0) 
The	median	(IQR)	of	"rec_education" is 2.0(2.0-3.0) 
The	median	(IQR)	of	"extended_dgn" is   .(  .-  .) 

```

### 8.12.2 subcondition

```stata
capture program drop myfirst 
quietly program define myfirst
    cls 
    qui ds 
	foreach v of varlist `r(varlist)' {
		qui sum `v', d
		qui local m_iqr: di %3.1f r(p50) "(" %3.1f r(p25) "-" %3.1f r(p75) ")"
		if c(k) < 30 {
            noi di `"The median (IQR) of "`v'" is `m_iqr' "'
		}
		else {
			noi di "Too many values, select no more than 30 varnames"
		}
	}
end 
use transplants, clear 
myfirst  
di c(k)
```

```s
The median (IQR)	of	"fake_id" is 3000.5(1500.5-4500.5) 
The median (IQR)	of	"ctr_id" is 41.0(30.0-49.0) 
The median (IQR)	of	"transplant_date" is 19757.0(18492.0-20902.0) 
The median (IQR)	of	"don_hgt_cm" is 172.0(163.0-180.0) 
The median (IQR)	of	"don_wgt_kg" is 79.0(66.0-93.0) 
The median (IQR)	of	"don_cod" is 2.0(1.0-3.0) 
The median (IQR)	of	"don_ecd" is 0.0(0.0-0.0) 
The median (IQR)	of	"dx" is 4.0(2.0-9.0) 
The median (IQR)	of	"race" is 2.0(1.0-4.0) 
The median (IQR)	of	"rec_hgt_cm" is 170.0(162.0-177.8) 
The median (IQR)	of	"rec_wgt_kg" is 79.0(66.2-93.4) 
The median (IQR)	of	"bmi" is 28.0(24.0-32.0) 
The median (IQR)	of	"prev_ki" is 0.0(0.0-0.0) 
The median (IQR)	of	"age" is 53.0(41.0-62.0) 
The median (IQR)	of	"peak_pra" is 0.0(0.0-14.0) 
The median (IQR)	of	"end_date" is 21868.0(21802.0-21901.0) 
The median (IQR)	of	"died" is 0.0(0.0-0.0) 
The median (IQR)	of	"tx_failed" is 1.0(0.0-1.0) 
The median (IQR)	of	"wait_yrs" is 1.8(0.6-3.5) 
The median (IQR)	of	"abo" is 3.0(1.0-4.0) 
The median (IQR)	of	"gender" is 0.0(0.0-1.0) 
The median (IQR)	of	"rec_hcv_antibody" is 0.0(0.0-0.0) 
The median (IQR)	of	"rec_work" is 0.0(0.0-1.0) 
The median (IQR)	of	"pretx_cmv" is 1.0(0.0-1.0) 
The median (IQR)	of	"rec_education" is 2.0(2.0-3.0) 
The median (IQR)	of	"extended_dgn" is   .(  .-  .) 

. di c(k)
26

. 
end of do-file

. 

```

### 8.12.3 variant

```stata
capture program drop myfirst 
quietly program define myfirst
    cls 
    qui ds 
	foreach v of varlist `r(varlist)' {
		qui sum `v', d
		qui local m_iqr: di %3.1f r(p50) "(" %3.1f r(p25) "-" %3.1f r(p75) ")"
		if c(k) > 30 {
            noi di `"The median (IQR) of "`v'" is `m_iqr' "'
		}
		else {
			noi di "Too few varnames, you can do this manually!"
			exit 459
		}
	}
end 
use transplants, clear 
myfirst  
di c(k)
```

```s
Too few varnames,	you	can	do	this	manually!
r(459);

end of do-file

r(459);

. 


```

### 8.12.4 [knockout](https://www.genome.gov/about-genomics/fact-sheets/Knockout-Mice-Fact-Sheet)

```stata

capture program drop myfirst 
quietly program define myfirst
    cls 
    qui ds 
	foreach v of varlist `r(varlist)' {
		qui sum `v', d
		qui local m_iqr: di %3.1f r(p50) "(" %3.1f r(p25) "-" %3.1f r(p75) ")"
		if c(k) > 30 {
            noi di `"The median (IQR) of "`v'" is `m_iqr' "'
		}
		else {
			noi di "Too few varnames, you can do this manually!"
			//exit 459
		}
	}
end 
use transplants, clear 
myfirst  
di c(k)
```

```s 
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!
Too few varnames, you can do this manually!

. di c(k)
26

. 
end of do-file

. 

```

## 8.13 theline

+ toe the line
+ cross the line
+ line continuation

```
// all these examples are programmatically equivalent
// but, aesthetically, very distinct!
// copy & paste into .do file; but don't `do`!!

super-long line of code that totally sprawls out horizontally and quite literally crosses the line if line continuation techniques aren't utilized

super-long line of code that  ///
   totally sprawls out horizontally  ///
   and quite literally crosses the line  ///
   if line continuation techniques aren't utilized

super-long line of code that /*
  */ totally sprawls out horizontally /*
  */ and quite literally crosses the line /*
  */ if line continuation techniques aren't utilized

#delimit ;
   super-long line of code that 
   totally sprawls out horizontally
   and quite literally crosses the line
   if line continuation techniques aren't utilized
	;
#delimit cr 
```

## 9.14 ssc 

```stata
	if 3 {//Question 3
		
		estpost tab prev female
		mat list e(colpct)
		matrix define p=e(colpct)
		local m_p: di %3.1f p[1,2]
		local f_p: di %3.1f p[1,5]
		
		noi di "Question 3: `m_p'% among males and `f_p'% among females have history of previous transplant."
		
		noi di ""

	}
```

```

Question 2: The median [IQR] age is 54 [42-62] among males and 51 [39-61] among females.

command estpost is unrecognized
r(199);

end of do-file

r(199);


```

+ presubmit hw
+ we'll detect 3rd party programs
+ stata very poor with such documentation
+ both r & python unambiguous about libraries in each script
+ dead shepherd, now i find thy saw of might: whoever loved that loved not python or r?

## 8.15 table1_v1

```stata
do https://raw.githubusercontent.com/jhustata/book/main/table1_options.ado
do https://raw.githubusercontent.com/jhustata/book/main/ind_translator.ado

qui {
	if 0 {
		
	}
	if 1 {
		cls
		use 18_nhtable102feb2023.dta, clear 
		//g string="string"
	}
	if 2 {
		//noi ds, has(type string)
		//global string: di "`r(varlist)'"
		foreach v of varlist * {
			replace `v'=round(`v')
			levelsof `v'
			if r(r) == 2 {
				noi di "binary vars: `v'"
			}
			else if inrange(r(r),3,30) {
				noi di "categorical vars: `v'"
			} 
			else {
				noi di "continuous vars: `v'"
			}
		}
	}
	if 3 {
		#delimit ;
		noi table1_options, 
		    excel("Table1_NHANES"
		    )
		    title(
		    "Table 1. Demographic & health characteristics of NHANES, 1988-2018"
		    )
		    by(race2
		    )
		    cont(
		    acr
		    creat
		    income 
		    bmi
		    logacr 
		    egfr 
		    age
		    sbp
		    hba1c
		    glucose 
		    )
		    binary(
			female
			smk
			dm
			htn
		    )
		    multi(
			educ
		    )
		    foot(
			acr
		    creat
		    income 
		    bmi
		    logacr 
		    egfr 
		    age
		    sbp
		    hba1c
		    glucose
			female
			smk
			dm
			htn
			educ
		    )
		 ;
		#delimit cr
	}
}            

```

```s
continuous vars: seqn
binary vars: mortstat
continuous vars: permth_int
continuous vars: permth_exm
categorical vars: year
categorical vars: race
categorical vars: race2
binary vars: female
continuous vars: age
categorical vars: educ
continuous vars: income
binary vars: dm
binary vars: htn
binary vars: smk
continuous vars: sbp
continuous vars: dbp
continuous vars: bmi
categorical vars: hba1c
continuous vars: acr
categorical vars: logacr
continuous vars: glucose
categorical vars: creat
continuous vars: egfr
Table 1. Demographic & health characteristics of NHANES,	1988-2018
White	Black	Hispanic	Asian	Other
N=8234	N=5211	N=5524	N=2913	N=852
uACR, mg/g, median [IQR]               8 [5,14]	7 [4,15]	8 [5,14]	7 [5,13]	7 [4,13] 
Serum Creatinine, mg/dL, median [IAR]  1 [1,1]	1 [1,1]	1 [1,1]	1 [1,1]	1 [1,1] 
Income, $, median [IQR]                16579 [15,36790]	16834 [15,37404]	19012 [77,38200]	77 [15,38560]	18187 [15,37022] 
BMI, kg/m2, median [IQR]               28 [24,33]	29 [25,35]	29 [26,33]	24 [22,28]	29 [24,34] 
Log uACR, log(mg/g), median [IQR]      2 [2,3]	2 [1,3]	2 [2,3]	2 [2,3]	2 [1,3] 
eGFR, ml/min/1.73m2, median [IAR]      98 [82,115]	113 [89,133]	110 [94,126]	109 [95,124]	105 [89,123] 
Age, y, median [IQR]                   51 [34,69]	49 [32,62]	46 [31,61]	44 [31,59]	40 [27,57] 
SBP, mmHg, median [IQR]                120 [112,134]	126 [114,138]	120 [110,134]	118 [108,130]	120 [110,132] 
HBA1c, %, median [IQR]                 6 [5,6]	6 [5,6]	6 [5,6]	6 [5,6]	6 [5,6] 
Glucose, mg/L, median [IQR]            9 [9,10]	9 [9,10]	10 [9,11]	9 [9,11]	9 [9,10] 
Female, %                              50	52	53	52	47 
Smoke, %                               51	41	35	23	51 
Diabetes, %                            14	19	17	14	15 
Hypertension, %                        38	44	30	24	34 
Education, %
K-8                                3	4	26	8	4 
High school, Diploma/equivalent    34	42	39	21	31 
Some college/associate             35	36	24	19	43 
College graduate/above             28	19	11	52	23 

acr                                    2.4% missing	3.2% missing	1.6% missing	1.8% missing	2.3% missing 
creat                                  4.6% missing	10.1% missing	5.0% missing	8.1% missing	6.1% missing 
income                                 1.6% missing	3.0% missing	3.3% missing	3.6% missing	2.0% missing 
bmi                                    1.5% missing	1.6% missing	1.5% missing	1.0% missing	1.6% missing 
logacr                                 2.4% missing	3.2% missing	1.6% missing	1.8% missing	2.3% missing 
egfr                                   4.6% missing	10.1% missing	5.0% missing	8.1% missing	6.1% missing 
age                                    0.0% missing	0.0% missing	0.0% missing	0.0% missing	0.0% missing 
sbp                                    7.9% missing	9.0% missing	8.4% missing	9.6% missing	8.3% missing 
hba1c                                  3.3% missing	7.5% missing	3.8% missing	6.2% missing	5.3% missing 
glucose                                4.6% missing	10.1% missing	5.0% missing	8.1% missing	6.1% missing 
female                                 0.0% missing	0.0% missing	0.0% missing	0.0% missing	0.0% missing 
smk                                    0.8% missing	2.0% missing	1.6% missing	1.1% missing	1.9% missing 
dm                                     0.0% missing	0.0% missing	0.1% missing	0.0% missing	0.1% missing 
htn                                    0.2% missing	0.1% missing	0.2% missing	0.1% missing	0.1% missing 
educ                                   3.6% missing	5.6% missing	6.8% missing	4.7% missing	8.8% missing 

. 
end of do-file

. 

```

## 8.16 table1_v2

```stata
do https://raw.githubusercontent.com/jhustata/book/main/table1_options.ado
do https://raw.githubusercontent.com/jhustata/book/main/ind_translator.ado

qui {
	if 0 {
		
	}
	if 1 {
		cls
		use 18_nhtable102feb2023.dta, clear 
		//g string="string"
	}
	if 2 {
		//noi ds, has(type string)
		//global string: di "`r(varlist)'"
		foreach v of varlist * {
			replace `v'=round(`v')
			levelsof `v'
			if r(r) == 2 {
				noi di "binary vars: `v'"
			}
			else if inrange(r(r),3,30) {
				noi di "categorical vars: `v'"
			} 
			else {
				noi di "continuous vars: `v'"
			}
		}
	}
	if 0 { //"knockout" codeblock
		#delimit ;
		noi table1_options, 
		    excel("Table1_NHANES"
		    )
		    title(
		    "Table 1. Demographic & health characteristics of NHANES, 1988-2018"
		    )
		    by(race2
		    )
		    cont(
		    acr
		    creat
		    income 
		    bmi
		    logacr 
		    egfr 
		    age
		    sbp
		    hba1c
		    glucose 
		    )
		    binary(
			female
			smk
			dm
			htn
		    )
		    multi(
			educ
		    )
		    foot(
			acr
		    creat
		    income 
		    bmi
		    logacr 
		    egfr 
		    age
		    sbp
		    hba1c
		    glucose
			female
			smk
			dm
			htn
			educ
		    )
		 ;
		#delimit cr
	}
}            

```

```s
continuous vars: seqn
binary vars: mortstat
continuous vars: permth_int
continuous vars: permth_exm
categorical vars: year
categorical vars: race
categorical vars: race2
binary vars: female
continuous vars: age
categorical vars: educ
continuous vars: income
binary vars: dm
binary vars: htn
binary vars: smk
continuous vars: sbp
continuous vars: dbp
continuous vars: bmi
categorical vars: hba1c
continuous vars: acr
categorical vars: logacr
continuous vars: glucose
categorical vars: creat
continuous vars: egfr

. 
end of do-file

. 

```

## 8.17 table1_v3

```stata
do https://raw.githubusercontent.com/jhustata/book/main/table1_options.ado
do https://raw.githubusercontent.com/jhustata/book/main/ind_translator.ado

qui {
	if 0 {
		
	}
	if 1 {
		cls
		use 18_nhtable102feb2023.dta, clear 
		//g string="string"
	}
	if 2 {
		//noi ds, has(type string)
		//global string: di "`r(varlist)'"
		foreach v of varlist * {
			replace `v'=round(`v')
			levelsof `v'
			if r(r) == 2 {
				rename `v' b_`v'
			}
			else if inrange(r(r),3,30) {
				rename `v' m_`v'
			} 
			else {
				rename `v' c_`v'
			}
		}
		order c_* b_* m_*
		noi list c_* in 1/10
		noi list b_* in 1/10
		noi list m_* in 1/10
	}
	if 0 { //"knockout" codeblock
		#delimit ;
		noi table1_options, 
		    excel("Table1_NHANES"
		    )
		    title(
		    "Table 1. Demographic & health characteristics of NHANES, 1988-2018"
		    )
		    by(race2
		    )
		    cont(
		    acr
		    creat
		    income 
		    bmi
		    logacr 
		    egfr 
		    age
		    sbp
		    hba1c
		    glucose 
		    )
		    binary(
			female
			smk
			dm
			htn
		    )
		    multi(
			educ
		    )
		    foot(
			acr
		    creat
		    income 
		    bmi
		    logacr 
		    egfr 
		    age
		    sbp
		    hba1c
		    glucose
			female
			smk
			dm
			htn
			educ
		    )
		 ;
		#delimit cr
	}
}            
```

```s
			
	c_seqn   c_perm~t   c_perm~m   c_age   c_income   c_sbp   c_dbp	c_bmi   c_acr   c_gluc~e   c_egfr	
			
1.	-53616        109        108      85      12625     157      94	29      44         11       52	
2.	-53594        315        314      26      29691     124      83	37       3          9      134	
3.	-53593        327        326      23      25221     123      83	21       2         10      110	
4.	-53592        310        310      19      92696      96      67	19      31          8      141	
5.	-53589          6          5      81      21443     129      72	35      26         14       86	
			
6.	-53586        318        317      45      49876     130      83	53       2         10      111	
7.	-53585        178        177      58          .     135      65	18       2         26      110	
8.	-53583        337        336      51      22527     113      70	22      20          9      120	
9.	-53582        156        155      63      15174     116      70	21       5          9       83	
10.	-53581        116        114      35      56148     129      90	25       9         10      117	
			

	
	b_mortstat   b_female   b_dm   b_htn   b_smk 
	-
1.	Assumed deceased          0      0       1       0 
2.	Assumed alive          1      0       1       0 
3.	Assumed alive          0      0       0       0 
4.	Assumed alive          1      0       0       0 
5.	Assumed deceased          1      0       1       1 
	-
6.	Assumed alive          1      0       0       0 
7.	Assumed deceased          0      1       1       1 
8.	Assumed alive          1      0       0       1 
9.	Assumed deceased          0      0       0       1 
10.	Assumed deceased          0      0       0       1 
	

		
	m_year     m_race   m_race2                            m_educ	m_hba1c   m_logacr   m_creat 
		-
1.	1988-1998      White         .   High school, Diploma/equivalent	6          4         1 
2.	1988-1998      White         .   High school, Diploma/equivalent	5          1         1 
3.	1988-1998      White         .            College graduate/above	5          1         1 
4.	1988-1998   Hispanic         .   High school, Diploma/equivalent	4          3         1 
5.	1988-1998      White         .   High school, Diploma/equivalent	5          3         1 
		-
6.	1988-1998      White         .            Some college/associate	6          1         1 
7.	1988-1998      Black         .   High school, Diploma/equivalent	8          0         1 
8.	1988-1998      White         .   High school, Diploma/equivalent	5          3         1 
9.	1988-1998   Hispanic         .                               K-8	6          2         1 
10.	1988-1998      Black         .   High school, Diploma/equivalent	5          2         1 
		

. 
end of	do-file

. 

```

## 8.18 table1_v4

```stata
do https://raw.githubusercontent.com/jhustata/book/main/table1_options.ado
do https://raw.githubusercontent.com/jhustata/book/main/ind_translator.ado

qui {
	if 0 {
		
	}
	if 1 {
		cls
		use 18_nhtable102feb2023.dta, clear 
		//g string="string"
	}
	if 2 {
		//noi ds, has(type string)
		//global string: di "`r(varlist)'"
		foreach v of varlist * {
			replace `v'=round(`v')
			levelsof `v'
			if r(r) == 2 {
				rename `v' b_`v'
			}
			else if inrange(r(r),3,30) {
				rename `v' m_`v'
			} 
			else {
				rename `v' c_`v'
			}
		}
		order c_* b_* m_*
		//noi list c_* in 1/10
		//noi list b_* in 1/10
		//noi list m_* in 1/10
		foreach v of varlist * {
	        //di "`v'"
	        global v: di substr("`v'",3,.)
	        rename `v' $v
        }
	}
	if 1 {  
		#delimit ;
		noi table1_options, 
		    excel("Table1_NHANES"
		    )
		    title(
		    "Table 1. Demographic & health characteristics of NHANES, 1988-2018"
		    )
		    /*by(race2
		    )*/
		    cont(
		    acr
		    creat
		    income 
		    bmi
		    logacr 
		    egfr 
		    age
		    sbp
		    hba1c
		    glucose 
		    )
		    binary(
			female
			smk
			dm
			htn
		    )
		    multi(
			educ
		    )
		    foot(
			acr
		    creat
		    income 
		    bmi
		    logacr 
		    egfr 
		    age
		    sbp
		    hba1c
		    glucose
			female
			smk
			dm
			htn
			educ
		    )
		 ;
		#delimit cr
	}
}            
```

```s
Table 1. Demographic & health characteristics of NHANES, 1988-2018
uACR, mg/g, median [IQR]                7 [ 4,14]
Serum Creatinine, mg/dL, median [IAR]   1 [ 1, 1]
Income, $, median [IQR]                22846 [8193,44091]
BMI, kg/m2, median [IQR]               27 [24,32]
Log uACR, log(mg/g), median [IQR]       2 [ 1, 3]
eGFR, ml/min/1.73m2, median [IAR]      107 [88,125]
Age, y, median [IQR]                   46 [30,63]
SBP, mmHg, median [IQR]                121 [111,134]
HBA1c, %, median [IQR]                  5 [ 5, 6]
Glucose, mg/L, median [IQR]             9 [ 9,10]
Female, %                              52
Smoke, %                               46
Diabetes, %                            12
Hypertension, %                        31
Education, %
K-8                               15
High school, Diploma/equivalent   42
Some college/associate            24
College graduate/above            19
acr:                    2.0% missing
creat:                  5.1% missing
income:                 5.4% missing
bmi:                    1.6% missing
logacr:                 2.0% missing
egfr:                   5.1% missing
age:                    0.0% missing
sbp:                    6.0% missing
hba1c:                  4.0% missing
glucose:                5.1% missing
female:                 0.0% missing
smk:                    4.3% missing
dm:                     0.1% missing
htn:                    0.6% missing
educ:                   5.7% missing


```

## 8.19 table1_v5

+ autoencodes varnames
+ binary, categorical, continuous
+ then impliments table1_afecdvi.ado

## 8.20  parameters

+ grades
+ $\mu,   \sigma$
+ inferences
    + $\mu   =$ A
	    + program define name
		+ flexible 
		+ user-defined input
		+ default if user distracted
		+ with caveats & subconditions
		+ mindful of c(os), c(version_real)
		+ also of 3-party libraries
		+ still yet to figure out the latter 
	+ $\sigma   =$ B
	    + doesn't illustrate knowledge of above
		+ hasn't presubmitted hw to test for 3-party libraries
		+ output isn't controlled using `qui {` & `noi di "..."`
		+ fundamentally wrong Stata syntax
		+ any error when script runs on our machines

## 8.21 ado

```stata
update all
```

```stata

. update all
(contacting https://www.stata.com)

Update status
Last check for updates:  23 May	2023
New update available:    none		(as of 23 May	2023)
Current update level:    15 May	2023	(what's new)

Possible actions

Do nothing; all files are up to	date.

. 


```

```stata
sysdir
```

```stata

. sysdir
STATA:	/Applications/Stata/
BASE:	/Applications/Stata/ado/base/
SITE:	/Applications/Stata/ado/site/
PLUS:	/Users/d/Library/Application Support/Stata/ado/plus/
PERSONAL:	/Users/d/Documents/Stata/ado/personal/
OLDPLACE:	~/ado/

. 

```

```stata

ls /Applications/Stata/

```

```stata

. ls /Applications/Stata/

total 56
drwxrwxr-x@  3 d     admin	96	May	23	10:26	StataSE.app/
drwxrwxr-x   4 root  admin	128	Apr	30	12:22	ado/
-rw-rw-r--   1 root  admin	12766	Apr	24	11:28	auto.dta
drwxrwxr-x  39 root  admin	1248	Apr	24	11:28	docs/
-rw-rw-r--   1 root  admin	24	Apr	24	11:28	isstata.180
-rw-rw-r--   1 d     admin	92	Apr	26	16:13	stata.lic
-rw-r--r--   1 d     admin	3485	May	23	10:30	update.log
drwxrwxr-x   7 root  admin	224	Apr	24	11:28	utilities/

. 


```

```stata
ls /Applications/Stata/ado/base/
```

```stata


. ls /Applications/Stata/ado/base/

total 8
drwxrwxr-x     2 d     admin     64	May	23	10:26	0/
drwxrwxr-x     2 d     admin     64	May	23	10:26	1/
drwxrwxr-x     3 root  admin     96	May	23	10:26	2/
drwxrwxr-x     2 d     admin     64	May	23	10:26	3/
drwxrwxr-x     2 d     admin     64	May	23	10:26	4/
drwxrwxr-x     2 d     admin     64	May	23	10:26	5/
drwxrwxr-x     4 root  admin    128	May	23	10:26	6/
drwxrwxr-x     2 d     admin     64	May	23	10:26	7/
drwxrwxr-x     2 d     admin     64	May	23	10:26	8/
drwxrwxr-x     2 d     admin     64	May	23	10:26	9/
drwxrwxr-x  1644 root  admin  52608	May	23	10:26	_/
drwxrwxr-x   213 root  admin   6816	May	23	10:26	a/
drwxrwxr-x   512 root  admin  16384	May	23	10:26	b/
drwxrwxr-x   795 root  admin  25440	May	23	10:26	c/
drwxrwxr-x   331 root  admin  10592	May	23	10:26	d/
drwxrwxr-x   381 root  admin  12192	May	23	10:26	e/
drwxrwxr-x  1155 root  admin  36960	May	23	10:26	f/
drwxrwxr-x   684 root  admin  21888	May	23	10:26	g/
drwxrwxr-x   167 root  admin   5344	May	23	10:26	h/
drwxrwxr-x   350 root  admin  11200	May	23	10:26	i/
drwxrwxr-x   104 root  admin   3328	May	23	10:26	j/
drwxrwxr-x     5 root  admin    160	May	23	10:26	jar/
drwxrwxr-x    32 root  admin   1024	May	23	10:26	k/
drwxrwxr-x   294 root  admin   9408	May	23	10:26	l/
drwxrwxr-x  1349 root  admin  43168	May	23	10:26	m/
drwxrwxr-x   169 root  admin   5408	May	23	10:26	n/
drwxrwxr-x    85 root  admin   2720	May	23	10:26	o/
drwxrwxr-x   554 root  admin  17728	May	23	10:26	p/
drwxrwxr-x     4 root  admin    128	May	23	10:26	py/
drwxrwxr-x    72 root  admin   2304	May	23	10:26	q/
drwxrwxr-x   200 root  admin   6400	May	23	10:26	r/
drwxrwxr-x    38 root  admin   1216	Apr	24	11:28	resource/
drwxrwxr-x  1068 root  admin  34176	May	23	10:26	s/
drwxrwxr-x   905 root  admin  28960	May	23	10:26	style/
drwxrwxr-x   410 root  admin  13120	May	23	10:26	t/
drwxrwxr-x   148 root  admin   4736	May	23	10:26	u/
-rw-rw-r--     1 d     admin     12	May	23	10:26	update
drwxrwxr-x   154 root  admin   4928	May	23	10:26	v/
drwxrwxr-x   113 root  admin   3616	May	23	10:26	w/
drwxrwxr-x   371 root  admin  11872	May	23	10:26	x/
drwxrwxr-x    44 root  admin   1408	May	23	10:26	y/
drwxrwxr-x    81 root  admin   2592	May	23	10:26	z/


```

```stata
ls /Users/d/Documents/Stata/ado/personal/
```

```stata

ls:	/Users/d/Documents/Stata/ado/personal/:	No	such	file	or	directory

. 

```

+ Probably a folder Stata expects you to create and utilize for 3rd-party .ado files
+ Every student should be aware of their location
+ Install libraries via `ssc` command in .do file script to avoid crashing on collaborators machine
+ This, of course, also applies to hw since it simulates a collaboration

```stata
which coefplot
```

```stata
. which coefplot
/Users/d/Library/Application	Support/Stata/ado/plus/c/coefplot.ado
*! version 1.8.6  22feb2023	Ben Jann

. 

```

+ Above `coefplot` command is, clearly, from a third-party
+ Maybe write a "screener" script which tests every command?

```stata

global commandlist if g sum coefplot tokenize //built-in commands appear blue
local n: di wordcount("$commandlist")
forval i=1/`n' {
	local command: di word("$commandlist",`i')
	which "`command'"
}
```

```stata
. global commandlist if g sum coefplot tokenize //built-in commands	appear	blue

. local n: di wordcount("$commandlist")

. forval i=1/`n' {
2.         local command: di word("$commandlist",`i')
3.         which "`command'"
4. }
built-in command:  if
built-in command:  generate
built-in command:  summarize
/Users/d/Library/Application Support/Stata/ado/plus/c/coefplot.ado
*! version 1.8.6  22feb2023  Ben Jann
built-in command:  tokenize

. 
end of do-file

. 

```

In the above example we can already see that coefplot appears white 


```stata
global commandlist if g sum coefplot tokenize estpost //built-in commands appear blue
local n: di wordcount("$commandlist")
forval i=1/`n' {
	local command: di word("$commandlist",`i')
	which "`command'"
}
```

```stata
. global commandlist if g sum coefplot tokenize estpost //built-in	commands	appear	blue

. local n: di wordcount("$commandlist")

. forval i=1/`n' {
2.         local command: di word("$commandlist",`i')
3.         which "`command'"
4. }
built-in command:  if
built-in command:  generate
built-in command:  summarize
/Users/d/Library/Application Support/Stata/ado/plus/c/coefplot.ado
*! version 1.8.6  22feb2023  Ben Jann
built-in command:  tokenize
command estpost not found as either built-in or ado-file
r(111);

end of do-file

r(111);


```

```stata
ssc install estpost
ssc install coefplot
```

```stata

. ssc install estpost
ssc install: "estpost" not found at SSC, type search estpost
(To find all packages at SSC that start with e, type ssc describe e)
r(601);

. ssc install coefplot
checking coefplot consistency and verifying not already installed...
all files already exist and are up to date.

. 

```

## 8.22 dofile

```stata
qui {
	cls
	clear 
	if _N { //background
		1. done in the spirit of a workflow that incorporates collaboration
		2. you, the student, programmer, and collaborator must be mindful
		3. mindful of the library of third-party programs you've installed
		4. these may not necessarily be installed on your collaborators' machine
		5. as we grade your hws we'll act like frustrated collaborators if... 
		6. we run your .do file and get errors on our machine
		7. so we are not permanently incorporating a codeblock to address this
		8. edit ${workdir} before you share your code with collaborators!!!!!!!!
	}
	if c(N)==_N { //method
		#delimit ; 
		global commandlist 
		    qui  
		    cls 
		    clear 
			if
			coefplot 
			help
			tokenize 
			pwd
			program
			capture 
			twoway 
			local 
		    ; 
		#delimit cr
		local n: di wordcount("$commandlist")
		forval i=1/`n' {
			local command: di word("$commandlist",`i')
			noi which "`command'"
		}
		if c(os) == "Windows" { //paths with back "\" slashes
			global workdir `c(pwd)'  
		}
		else { //paths with forward "/" slashes
			global workdir `c(pwd)' 
		}
		capture log close
		log using statalibrary.log, replace 
		set more off
	}
	if _N < 1 { //results
		//etc.
	}
}
```

```stata
built-in command:  quietly
built-in command:  cls
/Applications/Stata/ado/base/c/clear.ado
*! version 4.4.0  26feb2021
built-in command:  if
/Users/d/Library/Application Support/Stata/ado/plus/c/coefplot.ado
*! version 1.8.6  22feb2023  Ben Jann
/Applications/Stata/ado/base/h/help.ado
*! version 1.0.1  18sep2019
built-in command:  tokenize
built-in command:  pwd
built-in command:  program
built-in command:  capture
/Applications/Stata/ado/base/t/twoway.ado
*! version 1.2.1  22jun2012
built-in command:  local

. 
end of do-file

. 

```