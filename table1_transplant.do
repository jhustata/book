cls 


if 1 {
	
     capture log close
     log using "table1_transplant.log", replace
     use transplants,clear

	
     //3.table1 user input
	 
     global title: di ///
	    "Table 1 Demographic and health characteristics of Transplant recipients"
     global excelfile: di "Table1_Recipients"
     global byvar prev_ki 
     global contvars don_hgt_cm rec_hgt_cm wait_yrs don_wgt_kg ///
	     rec_wgt_kg age bmi peak_pra 
     global binaryvars  don_ecd rec_hcv rec_work  
     global multivars rec_educat dx abo don_cod  race
     global footnotes1 don_hgt_cm rec_hgt_cm wait_yrs don_wgt_kg ///
	     rec_wgt_kg age bmi peak_pra  
     global footnotes2 don_ecd rec_hcv rec_work
     global footnotes3 rec_educat dx abo don_cod race  	
	 
}

	 
if 2 {
	
     //command
     which table1_options
     table1_options, ///           
	 title("$title") /// 
	     by($byvar) ///
		 cont($contvars) ///
		 binary($binaryvars) ///
		 multi($multivars)  ///
		 foot("$footnotes1 $footnotes2 $footnotes3") ///
		 excel("$excelfile") 


}

	 log close
