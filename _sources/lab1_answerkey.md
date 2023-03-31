# EPIDEMIOLOGY 340.600: STATA PROGRAMMING AND DATA MANAGEMENT

## Lab 1



### Part 1

6/28/2021



**Overview**: Write Stata commands to solve the following questions. Keep them in a text file. In the second half of today's class you will learn how to put them in a ".do file" or script to run all of the commands at the same time. For now, put them in a text file and copy/paste one line at a time into Stata to get the answers.



**Write Stata commands to answer the following questions**:

1. How many total patients are in the dataset? **2000**
2. The variable `dx` represents diagnosis and `age` represents patient age. How many patients were age 50-60 and had diabetes as their primary diagnosis at the time of transplant? **29**
3. The variable `wait_yrs` represents the amount of time a patient spent on the transplant waitlist prior to transplant. How many patients waited longer than 5 years for a transplant? **214**
4. What is the age, race (variable: `race`), and Hepatitis C status (variable: `rec_hcv_antibody`) of patient with ID=493? **75/1 (white) / negative**
5. What are the mean ages at transplant for male and female recipients? (Hint: consider tab, sum) (Variable: `gender` 0=Male, 1 = Female). **50.96; 49.52**
6. Generate a variable called `age_categories` that is 0 for children (ages\<18), 1 for adults (18-60), and 2 for senior citizens (\>60). What is the mean number of years patients spent on the waitlist in each age group? (Hint: consider tab, sum) **0.71y; 2.48y; 2.27y**



### Part 2

**Overview**: write a .do file which imports `transplants.dta` and performs the data management/ exploratory data analysis tasks described below using the slides we have discussed in class. Your .do file must be called `lab1_yourname_.do` (for example: `lab1_allanmassie.do`) and must create a log file called lab1\__yourname_.log. Your .do file should follow conventions for .do file structure described in class. Do not submit your log files as part of the assignment. Copy your saved commands from lab 1 part I into this do file and use comments to indicate the code for each question.



**Tasks**:

1. Type `describe` to see a list of all variables. Which ones don't have a variable label? Write code to give a variable label to all variables that don't yet have one. Then run `describe` again to show the labeled variables. **Any description is fine**

2. Variable `abo` represents blood type and is coded as 1=A, 2=B, 3=AB, 4=O. Variable `prev` represents whether the patient has had a previous transplant and is coded 0=No, 1=Yes. Create a value label for `prev` that labels 0 as "No" and 1 as "Yes". Put the command `tab abo prev` in your script, to produce the following output (with `xxxx` filled in):

   ```stata
              |    Prev Kidney Tx
          abo |         0          1 |     Total
   -----------+----------------------+----------
          1=A |       613        107 |       720 
          2=B |       226         23 |       249 
         3=AB |       104         12 |       116 
          4=O |       800        115 |       915 
   -----------+----------------------+----------
        Total |     1,743        257 |     2,000
   ```

3. Generate a new variable called `bmi_whocat`, representing WHO categories of BMI. BMI category should have the following values: missing if BMI is missing; 1 (labeled "underweight") if BMI\<18.5; 2 (labeled "normal") if BMI is 18.5-25; 3 (labeled "overweight") if BMI is 25.1-30; 4 (labeled "obese") if BMI is 30.1=40.

   ```stata
    bmi_whocat |      Freq.     Percent        Cum.
   ------------+-----------------------------------
             1 |         51        2.77        2.77
             2 |        629       34.13       36.90
             3 |        632       34.29       71.19
             4 |        531       28.81      100.00
   ------------+-----------------------------------
         Total |      1,843      100.00
   ```

4. List the ID and age of every patient who is older than 80. List them in order with the oldest patient first.

   ```stata
          1535    85  
          1636    84  
          1592    84  
           736    82  
          1527    82  
           911    82  
           647    81  
          1061    81  
          1435    81  
   ```

**Before turning in: make sure your .do file runs in Stata, without producing any errors!**