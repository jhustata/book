# lab2sol

lab1: [solutions](lab1.md)

data: transplants.dta

zoom: M T W Th F

This lab is optional; you are NOT required to complete these questions. Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. Sample responses to the lab questions will be provided on Friday April 14, 2023.

1. Start Stata, open your do-file editor, write the header, and load `transplants.dta`.

2. Calculate the mean value of age using `sum`.

   ```stata
   sum age
   ```

3. Stata should have some values in the memory as `r()` values. Ask Stata to display the list of the `r()` values.

   ```stata
   return list
   ```

4. Display the mean value. Store the mean value as a local macro `mean`. Display the local macro `mean`.

   ```stata
   disp r(mean)
   local mean: di %2.1f r(mean)
   ```

5. Now let’s try something more useful. Calculate the mean value of age. Print the following sentence: `The mean age is XX.X years`. Replace `XX` with correct values. Round to tenths (e.g. 35.2 years). 

   ```stata
   di "The mean age is `mean' years."
   ```

6. Calculate the median (IQR) of age. Print the following sentence: `The median [IQR] age is XX [XX-XX] years`. Replace `XX` with correct values. Round to whole numbers (e.g. 37 years). 

   ```stata
   sum age, detail
   local p50: di %2.0f r(p50)
   local p25: di %2.0f r(p25)
   local p75: di %2.0f r(p75)
   
   di "The median [IQR] age is `p50' [`p25'-`p75'] years"
   ```

7. Calculate the standard deviation of age among patients with blood type O (`abo==4`). Print the following sentence: `The SD of age among patients with blood type O is XX.X`. Replace `XX` with correct values. Round to tenths (e.g. 8.2). 

   ```stata
   sum age if abo==4
   local abo4: di %2.1f r(sd)
   
   di "The SD of age among patients with blood type O is `abo4'."
   ```

8. Regress BMI on age and sex (using `regress bmi age gender`) without displaying the regression output. Print the following sentence: `Per 1-year increase in age, BMI increases by X.XX`. Replace `XX` with the regression coefficient of age. Round to hundredths (e.g. 0.74). 

   ```stata
   quietly regress bmi age gender
   local age_b: di %3.1f _b[age]
   
   di "Per 1-year increase in age, BMI increases by `age_b'."
   ```


9. Now we will do the same thing, but using a program. Define a program named `bmi_age`. This program will regress BMI on age and sex without displaying the regression output, and print: `Per 1-year increase in age, BMI increases by X.XX`. Replace `XX` with the regression coefficient of `age`. Round to hundredths (e.g. 0.74). 

   ```stata
   capture program drop bmi_age
   program define bmi_age
   
       quietly regress bmi age gender
       local age_b: di %3.1f _b[age]
       
       di "Per 1-year increase in age, BMI increases by `age_b'."
       
   end
   ```


10. You have all your commands in your do file, right? Run your do file from the beginning and make sure your do file does exactly the same thing.
