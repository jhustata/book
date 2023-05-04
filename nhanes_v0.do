qui {
    cls
	capture program drop nhanes_iii
	program define nhanes_iii
		qui {
		    clear 
			if c(N) { //background:r(mean) 
				stata/BE or IC: c(k) < 2048
				exam.DAT: c(k) == 2368
				this program grant access
				regardless of stata edition
			}
			if c(N)<1 { //methods:$keepvars
				timer on 1				
				global github https://raw.githubusercontent.com/
				global jhustata jhustata/book/main/
				global keepvars HSAGEIR BMPHT BMPWT HAZA8AK1 CEP GHP HAB1
				capture log close 
				log using "nhanes_iii.log", replace 
				timer off 1
			}
			if c(N)<2 { //results:.dofiles
			    timer on 2
				if c(edition_real)=="BE" | c(edition_real)=="IC" {
				    clear 
				    do ${github}${$jhustata}nhanes-alpha-if2.do 
				}
				else { 
					clear 
					do ${github}${$jhustata}nhanes-alpha-if0.do
				}
				timer off 2
			}
                count 
			    if r(N) { //conclusions:queueing
			    timer on 3
			    timer on 31
				clear
				noi di "loading adult..."
				do adult.do
				rename *,lower
				save adult.dta,replace 
				timer off 31
				timer on 32
				clear 
				noi di "loading exam..."
				do exam.do
				rename *,lower
				save exam.dta,replace 
				timer off 32
				timer on 33
				clear
				noi di "loading lab..."
				do lab.do
				rename *,lower
				save lab.dta,replace 
				timer off 33
				timer off 3
			}
			if c(k)<4*10^3 { //acknowledge:linkage
				timer on 4
				use adult, clear
				merge 1:1 seqn using exam,nogen
				merge 1:1 seqn using lab,nogen
				merge 1:1 seqn using nh3mort,nogen keep(matched)
				rm adult.dta
				rm exam.dta
				rm lab.dta
		        rm adult.do
				rm exam.do 
				rm lab.do 
				timer off 4
			}
			if c(k)>2*10^3 { //reference:dataset4class
				noi di c(k)
				timer on 5
				compress
				lab dat "NHANES 1988-1994, survey"
				save "nhanes3.dta", replace 
				timer off 5
			}			
			noi timer list 
			log close 
		}	
    end 
	capture program drop nhanes_continuous_demo
    program define nhanes_continuous_demo 
	    qui {
		    clear 
			if c(N) { //background
			    imports nhanes demographic data
			    for years 1999-2017 using
			    one import statement!
	  	    }
		    if c(N)<1 { //methods
			    global workdir c(pwd)
			    global url "https://wwwn.cdc.gov/Nchs/Nhanes"  
			    global surveys 1999 2001 2003 2005 2007 2009 2011 2013 2015 2017
			    global github https://raw.githubusercontent.com/
                global jhustata jhustata/book/main/
			    capture log close
			    log using nhanes.continuous.log,replace 
			    set max_memory .
	 	    }
		    if c(N)<3*10^5 { //results
		        timer on 3
			    tokenize "`c(ALPHA)'"
			    local Letter=1
			    foreach y of numlist $surveys {
				    local yplus1=`y'+1
				    if `y'==1999 {
					    local letter: di ""
				    }
				    else {
					    local letter: di "_``Letter''"
				    }
				    import sasxport5 "$url/`y'-`yplus1'/DEMO`letter'.XPT", clear
				    noi di "loading... `y'-`yplus1' from $url"
                    g survey="`y'-`yplus1'"
				    save "nhanes`y'.dta", replace 
	                local Letter=`Letter' + 1
				    timer off 3
			    }
		    }
	        if c(N)>0 { //conclusions
		    timer on 4
			foreach y of numlist $surveys  {
				append using "nhanes`y'"
				rm "nhanes`y'.dta"
			}
			timer off 4
		    }
		    if c(N)>0 { //acknowledgements
		        duplicates drop seqn, force 
			    lab dat "NHANES 1999-2017, demographics"
			    save nhanes_continuous_demo, replace 
		    }
	      noi timer list 
	      log close 
	    }
	end 
    capture program drop nhanes_mortality 
    program define nhanes_mortality
        qui {
		    clear 
		    if c(N) {    //background
			    creates an nhanes_mortality file
			    seqn for nhanes iii are negative 
			    this avoids confusion with 
			    those from the continuous nhanes 
		    }
		    if c(N)<1 {  //methods
		        global nchs https://ftp.cdc.gov/pub/Health_Statistics/NCHS/
                global linkage datalinkage/linked_mortality/
	            global nh3 NHANES_III
                global mort _MORT_2019_PUBLIC.dat
			    global survey 1999 2001 2003 2005 2007 2009 2011 2013 2015 2017
			    # delimit ;
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
				capture log close
				log using nhanes_mortality.log, replace 
		    }
		    if c(N)<2 {  //results
			    infix $varlist using $nchs$linkage$nh3$mort, clear
			    //1988-1994
			    replace seqn=-1*seqn
	            tempfile dat0
	            g survey="1988-1994"
	            save `dat0'
			    //1999-2018
			    local N=1
			    foreach y of numlist $survey {
			        local yplus1=`y' + 1  
   	                local nhanes NHANES_`y'_`yplus1'
                    infix $varlist using $nchs$linkage`nhanes'$mort, clear
	                tempfile dat`N'
		            g survey="`y'-`yplus1'"
	                save `dat`N''
	                local N=`N'+1
			    }
		      use `dat0',clear
		      forvalues i=1/10 {
		          append using `dat`i''
		      }
		    }
		    if c(N) {    //conclusion
			    tab survey
		    }
		    if c(N) {    //acknowledgements
			    #delimit ;
		        lab def premiss .z "Missing";
                lab def eligfmt 
			        1 "Eligible" 
				    2 "Under age 18, not available for public release" 
				    3 "Ineligible" ;
                lab def mortfmt 
			        0 "Assumed alive" 
			  	    1 "Assumed deceased" 
				    .z "Ineligible or under age 18";
                lab def flagfmt 
			        0 "No - Condition not listed as a multiple cause of death" 
	                1 "Yes - Condition listed as a multiple cause of death"	
				    .z "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available"; 
                lab def qtrfmt 
				    1 "January-March" 
	                2 "April-June" 
				    3 "July-September" 
			        4 "October-December" 
				    .z "Ineligible, under age 18, or assumed alive";
			    #delimit cr	
                lab def dodyfmt .z "Ineligible, under age 18, or assumed alive"
                lab def ucodfmt 1 "Diseases of heart (I00-I09, I11, I13, I20-I51)"                           
                lab def ucodfmt 2 "Malignant neoplasms (C00-C97)" , add 
                lab def ucodfmt 3 "Chronic lower respiratory diseases (J40-J47)"                             , add
                lab def ucodfmt 4 "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"                    , add
                lab def ucodfmt 5 "Cerebrovascular diseases (I60-I69)"                                       , add
                lab def ucodfmt 6 "Alzheimer's disease (G30)"                                                , add
                lab def ucodfmt 7 "Diabetes mellitus (E10-E14)"                                              , add
                lab def ucodfmt 8 "Influenza and pneumonia (J09-J18)"                                        , add
                lab def ucodfmt 9 "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"  , add
                lab def ucodfmt 10 "All other causes (residual)"                                             , add
                lab def ucodfmt .z "Ineligible, under age 18, assumed alive, or no cause of death data"      , add
	            replace mortstat = .z if mortstat >=.
                replace ucod_leading = .z if ucod_leading >=.
                replace diabetes = .z if diabetes >=.
                replace hyperten = .z if hyperten >=.
                replace permth_int = .z if permth_int >=.    
                replace permth_exm = .z if permth_exm >=.
	            label var seqn "NHANES Respondent Sequence Number"
                label var eligstat "Eligibility Status for Mortality Follow-up"
                label var mortstat "Final Mortality Status"
                label var ucod_leading "Underlying Cause of Death: Recode"
                label var diabetes "Diabetes flag from Multiple Cause of Death"
                label var hyperten "Hypertension flag from Multiple Cause of Death"
                label var permth_int "Person-Months of Follow-up from NHANES Interview date"
                label var permth_exm "Person-Months of Follow-up from NHANES Mobile Examination Center (MEC) Date"
                label values eligstat eligfmt
                label values mortstat mortfmt
                label values ucod_leading ucodfmt
                label values diabetes flagfmt
                label values hyperten flagfmt
                label value permth_int premiss
                label value permth_exm premiss
		    }
		    if c(k)==9 { //references
	            drop if inlist(eligstat,2,3)
	            duplicates drop 
	            save "nhanes_mortality", replace 
		    }
	     log close 
        }
    end  
}
