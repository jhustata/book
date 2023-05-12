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

## 8.3 punchline
```stata
if c(version)==18 { //tip 4 hw3
    set scheme s2color
}
else { stcolor is default in v18
    di "you're good to go!"
}
```
