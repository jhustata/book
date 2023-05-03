			quietly {
				if c(N) { //background 
					1. adapted from chapter:twoway
					2. jhustata.github.io/book/jjj.html
					3. downloaded 59 files from...
					4. data.nber.org/mortality/
					5. ultimately use urls
				}
				if c(N)<1 { //methods
					timer on 1
				    capture log close
					log using nberv050223.log, replace 
					timer off 1
				}
				if c(N)<2 { //results
					timer on 2
					forvalues i=1959/2017  {
						timer on 21
						noi di "loading ...mort`i'.csv"
						import delimited mort`i'.csv, /*
						    */encoding(UTF-8) clear 
						timer off 21
						timer on 22
						noi di "saving ...mort`i'.dta"
						save mort`i'.dta,replace 
						timer off 22
					}
					timer off 2
				}
				if c(N)>3 { //conclusions
					timer on 3
					compress 
					lab data "mortality in the united states, 1959-2017"
					save mort1959_2017.dta,replace 
					timer off 3
				}
			  log close 
			}
