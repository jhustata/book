** Use this code to test your deliverables for Assignment 2

clear all

capture log close test
log using test_yourname.log, text replace name(test)


****************************
**** Question 1         ****
****************************

//replace the name of the do file accordingly
do assignment2_yourname.do

//check if your code generates correct responses to Question 1


****************************
**** Question 2         ****
****************************

use transplants, clear
// This is just an example and this does not mean that we will test your program on transplants.dta
// Remember, unilogit is a program. A program should run on any dataset on any variable.

unilogit age gender wait_yrs, outcome(died)
unilogit age gender wait_yrs if age>60, outcome(died)



log close test
