        #delimit ;
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

        global nchs https://ftp.cdc.gov/pub/Health_Statistics/NCHS/
        global linkage datalinkage/linked_mortality/
        global nh3 NHANES_III
		
		
		infix $varlist using "$nchs$linkage${nh3}_MORT_2019_PUBLIC.dat", clear
        
        do "${github}${jhustata}mortlab.do"
        
        drop if inlist(eligstat,2,3)
        duplicates drop
        save nh3mort,replace 
