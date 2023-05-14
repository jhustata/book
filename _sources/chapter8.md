# if c(version)>16 {

## 8.1 codetta

![](codetta.PNG)

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

![](skewness.PNG)

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
			fcolor(midblue%40) 
			addplot(hist flair_20, 
			    freq 
				lpattern(solid) 
				fcolor(orange%50)
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
			fcolor(midblue%40) 
			addplot(hist flair_20, 
			    freq 
				lpattern(solid) 
				fcolor(orange%50)
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

## 8.6

**Yours truly:** share 20 unique conditional if code-blocks in Stata. Use a publicly available dataset to demonstrate these

Refs:

Publically available Stata [datasets](https://www.stata-press.com/data/r8/u.html)   
Example selected by chatGPT: auto

```Stata
global url https://www.stata-press.com/data/r8/
```

<u>ChatGPT May12 Version<u>: 
Sure! Here are 20 unique conditional code-blocks in Stata using the publicly available "auto" dataset:

1. Code-block with if statement and else statement:

```arduino
use ${url}auto.dta //edited to include url
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