qui {
	clear 
	cls
	if c(N) { //background
		inspired by polack et al. nejm 2020
		NEJM2020;383:2603-15
		lets do some reverse engineering
		aka simulate, generate data 
		from results: reversed process!!
	}
	if c(N)<1 { //methods
		if c(os)=="Windows" {
			global workdir "`c(pwd)'\"
		}
		else {
			global workdir "`c(pwd)'/"
		}
		capture log close
		log using ${workdir}simulation.log, replace 
		set seed 340600
		set obs 37706
	}
	if c(N)==37706 { //simulation 
	    #delimit ; 
		//row1
		g bnt=rbinomial(1,.5);
		lab define Bnt 
		    0 "Placebo"  
	        1 "BNT162b2" ;
		label values bnt Bnt ;
		tab bnt ; 
		//row2
		gen female=rbinomial(1, .494); 
		label define Female  
		    0 "Male"  
			1 "Female"; 
		label values female Female; 
		tab female;
		//row3 
		tempvar dem ;
		gen `dem'=round(runiform(0,100),.1); 
		recode `dem'  
		    (0/82.9=0)  
		    (83.0/92.1=1)  
		    (92.2/96.51=2)   
		    (96.52/97.0=3)  
		    (97.1/97.2=4)  
		    (97.3/99.41=5)  
		    (99.42/100=6)  
		         , gen(race);
		lab define Race  
			0 "White"    
		    1 "Black or African American" 
			2 "Asian" 
			3 "Native American or Alsak Native"  
			4 "Native Hawaiian or other Pacific Islander"  
			5 "Multiracial"  
			6 "Not reported"; 
		label values race Race; 
		tab race;
		//row4 
		gen ethnicity=rbinomial(1,0.28);
		tostring ethnicity, replace;
		replace ethnicity="Latinx" if ethnicity=="1";
		replace ethnicity="Other" if ethnicity=="0";
		//row5 
		tempvar country;
		gen `country'=round(runiform(0,100), .1);
		recode `country'   
		    (0/15.3=0)  
			(15.4/21.5=1)  
			(21.6/23.6=2)  
			(23.7/100=3) 
			    , gen(country) ;
		label define Country 
			0 "Argentina"  
		    1 "Brazil"  
			2 "South Africa"  
			3 "United States"; 
		label values country Country; 
		tab country;
		//row7 
		gen age=(rt(_N)*9.25)+52 ; 
		replace age=runiform(16,91)  
		    if !inrange(age,16,91); 
		summ age, d ;
		local age_med=r(p50); local age_lb=r(min); local age_ub=r(max);
		gen dob = d(27jul2020) -  
		          (age*365.25) ; 
		gen dor = dob + age*365.25 + runiform(0,4*30.25); 
		//row6 
		gen over55=age>55 ; tab over55;
		//row8 
		gen bmi=rbinomial(1, .351); tab bmi; 
		//figure 3 
		g days=rweibull(.7,17,0) if bnt==0 ;
		g covid=rbinomial(1, 162/21728) if bnt==0 ; 
		replace days=rweibull(.4,.8,0) if bnt==1 ;
		replace covid=rbinomial(1, 14/21772) if bnt==1; 
		//key dates 
		gen eft = dor + days;
		//date formats
		format dob %td; format dor %td; format eft %td;
		 //kaplan-meier curve
		 stset days, fail(covid) ;
		 sts graph,  
		    by(bnt)  
		    fail per(100)  
		    tmax(119)  
		    xlab(0(7)119) 
		    ylab(0(.4)2.4, 
		        angle(360)    
			    format("%3.1f")
				)  
		    xti("Days after Dose 1")  
		    legend(off) 
		    text(
			    2.3 100 
			    "Placebo",  
			     col(navy)
				 )  
		    text(
			    .5 100 
				"BNT162b2",  
			    col(maroon)
				) ;
		graph export BNT162b2.png, replace ;
		stcox bnt ;
		drop _* age over55 days ;
		g bnt_id=round(runiform(37,37+_N)) ;
		compress  ;
		#delimit cr
		//label variables
		lab var bnt_id "Participant Identifier"
		lab var bnt "Random treatment assignment"
		lab var female "Gender at birth"
		lab var race "Self-identified race"
		lab var ethnicity "Hispanic ethnicity"
		lab var country "Country where trial was conducted"
		lab var dob "Date of birth"
		lab var dor "Date of recruitment into BNT162b2 trial"
		lab var eft "Date of exit from BNT162b2 trial"
		lab var bmi "Obese"
		lab var covid  "Covid-19 status on eft date"
		//label data
		lab data "Safety and Efficacy of the BNT162b2 mRNA Covid-19 Vaccine"
		describe
		order bnt_id dob female race ethnicity country bmi bnt eft covid 
		*replace eft=. if eft>d(15dec2020) //some folks lost to followup
		save BNT162b2, replace 

	}
  log close 
}		
