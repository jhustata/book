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

+ The program below will not not run after May
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

## 9.10 feedback

+ feedback welcome
+ any system without a feedback loop is like a cancer
+ so please send us an email `if & when ... ` 

## 9.11 suigeneris

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

## 9.12 myfirst

### 9.12.1 unconditional

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

### 9.12.2 subcondition

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

### 9.12.3 variant

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

Too few varnames,	you	can	do	this	manually!
r(459);

end of do-file

r(459);

. 


```

### 9.12.4 [knockout](https://www.genome.gov/about-genomics/fact-sheets/Knockout-Mice-Fact-Sheet)

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

