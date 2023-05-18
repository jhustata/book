# if c(version)>16 {

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

+ comes in handy when your command or output includes a double-quote within a string

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

### 8.7.1 wide

+ Baseline
+ End
+ Survival
+ 'Twixt': blackbox

### 8.7.2 long

+ Time-varying covariates
     + confounders
	 + mediators
	 + surrogate outcomes

### 8.7.3 isid

+ Quick way to determine whether a dataset is wide or long

```stata
use hw2_pra_hist.dta, clear
ds 
codebook px_id 
isid px_id
```