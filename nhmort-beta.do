qui {
	
     capture log close
     global date: di %td date(c(current_date),"DMY")
     log using "12_nhmort$date.log", replace
     version 12

     global start = clock(c(current_time),"hms")/10^3	

     //1.data
     global nchs https://ftp.cdc.gov/pub/Health_Statistics/NCHS/
     global linkage datalinkage/linked_mortality/
	 global nh3 NHANES_III
     global mort _MORT_2019_PUBLIC.dat
     global varlist ///
         seqn 1-6 ///
         eligstat 15 ///
	     mortstat 16 ///
	     ucod_leading 17-19 ///
         diabetes 20 ///
	     hyperten 21 ///
	     permth_int 43-45 ///
	     permth_exm 46-48 
	 
	 //1988-1994
	 infix $varlist using $nchs$linkage$nh3$mort, clear
	 replace seqn=-1*seqn
	 tempfile dat0
	 g survey="1988-1994"
	 save `dat0'
     
	 //1999-2018
     local N=1

     foreach y of numlist 1999 2001 2003 2005 2007 2009 2011 2013 2015 2017 {
         local yplus1=`y' + 1  
         	
	     local nhanes NHANES_`y'_`yplus1'
         infix $varlist using $nchs$linkage`nhanes'$mort, clear
	     tempfile dat`N'
		 g survey="`y'-`yplus1'"
	     save `dat`N''
	     local N=`N'+1
     }
	 
	 use `dat0', clear
     forvalues i=1/10 {
	
	     append using `dat`i''
		 
     }
	
	
}


quietly {
	
	 //2.values
     lab def premiss .z "Missing"
     lab def eligfmt 1 "Eligible" 2 "Under age 18, not available for public release" 3 "Ineligible" 
     lab def mortfmt 0 "Assumed alive" 1 "Assumed deceased" .z "Ineligible or under age 18"
     lab def flagfmt 0 "No - Condition not listed as a multiple cause of death" ///
	                      1 "Yes - Condition listed as a multiple cause of death"	///
						  .z "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available"
     lab def qtrfmt 1 "January-March" ///
	                     2 "April-June" ///
						 3 "July-September" ///
						 4 "October-December" ///
						 .z "Ineligible, under age 18, or assumed alive"
     lab def dodyfmt .z "Ineligible, under age 18, or assumed alive"
     lab def ucodfmt 1 "Diseases of heart (I00-I09, I11, I13, I20-I51)"                           
     lab def ucodfmt 2 "Malignant neoplasms (C00-C97)"                                            , add
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
	
}

quietly {
	
	 //3.define
	 
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

     noi des 
	 
	 //eligibility
	 drop if inlist(eligstat,2,3)
	 duplicates drop 

	 keep seqn mortstat permth_int permth_exm 
	 save "11_nhmort$date", replace 
	 
	 //big data!
	 noi di ""
	 noi di "rows x columns:"
	 noi count
	 ds 
	 noi di wordcount(r(varlist))
	 
     global finish  = clock(c(current_time),"hms")/10^3
     global duration = round(($finish - $start)/60,1)

     noi di "runtime = $duration minute(s)"	 
	 
	 log close
}

