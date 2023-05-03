qui {
	qui {
		if c(N) { //background
			1.produce twoway plot 
			2.us mortality: 1959-2017
			3.jhustata.github.io/book/jjj.html
		}
		if c(N)<1 { //methods
			capture log close 
			log using nber.twoway.log,replace 
			set max_memory .
		}
		if c(N)<2 { //results
		    timer on 2
			use year datayear using mort1959_2017 
			noi di "obs:`c(N)', vars:`c(k)'"
			timer off 2
		}
		if c(N)>3 {
			timer on 3
			g deaths=1
			replace year=datayear if missing(year)
			replace year=year+1900 if inrange(year,79,95)
			replace year=year+1900+60 if year==9
			replace year=year+1900+60 if year==8 in 1/20295198
			replace year=year+1900+70 if inrange(year,0,7)
			replace year=year+1900+70 if year==8 in 33014266/43014266
			collapse (sum) deaths,by(year)
			lab data "Collapsed:deaths/year"
			save nbertwoway.dta,replace
			timer off 3
		}
		if c(N)==59 {
			twoway scatter deaths year, /*
			    */ti("Mortality in the United States, 1959-2017",pos(11)) /*
				*/yti("N",orientation(horizontal)) /*
				*/xti("Year") /*
				*/note("Source: https://data.nber.org/mortality/")
			graph export mortality.png, replace 
		}
		else {
			noi di "obs:`c(N)'<59"
		}
	  timer list 
      log close
	}
}
