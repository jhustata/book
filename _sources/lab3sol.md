# lab3

lab2: [solutions](lab2.md)

data: [transplants.dta](transplants.dta) 

zoom: M T W Th F  

This lab is optional; you are NOT required to complete these questions. Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. Sample responses to the lab questions will be on Friday April 21, 2023.

1. Start Stata, open your do-file editor, write the header, and load `transplants.dta`.

2. `ctr_id` indicates the ID of the transplant center where the patient received the transplant. Count the number of recipients at each center, and store in a new variable `volume`.

   ```stata
   bysort ctr_id: gen volume=_N
   ```

3. List `ctr_id` and `volume` to see how many patients each center has. Maybe let's try this:

   `list ctr_id volume`

4. Whelp. This is not what we wanted. Generate a variable `ctr_tag` that "tags" one observation per center.

   ```stata
   egen ctr_tag=tag(ctr_id)
   ```

5. Now `list ctr_id` and `volume`, but just for one record per center.

   ```stata
   list ctr_id volume if ctr_tag==1
   ```

6. Calculate the mean age of the patients at each center, and store in a new variable `mean_age`.

   ```stata
   bys ctr_id: egen mean_age=mean(age)
   ```

7. For each primary diagnosis subgroup (use variable `dx`), run a regression with age as the predictor and peak PRA (`peak_pra`) as the outcome.

   ```stata
   forvalue i=1/9 {
           regress peak_pra age if dx==`i'
   }
   ```

8. Now let's make the output cleaner. Count the number of cases within each diagnosis group. If there are more than 500 cases, run the regression and display the output. If not, display "There are fewer than 500 cases."

   ```stata
   forvalue i=1/9 {
       qui count if dx==`i'
       if r(N)>500 {
             regress peak_pra age if dx==`i'
       } 
       else {
             di "There are fewer than 500 cases."
       }
   }
   ```

9. Define a program called `reg_pra`. This program will perform the same tasks as described in Question 8, but the regression will take one or more variables specified by the user as the predictor.

   ```stata
   capture program drop reg_pra
   program define reg_pra
       syntax varlist
   
       forvalue i=1/9 {
           qui count if dx==`i'
           if r(N)>500 {
                 regress peak_pra `varlist' if dx==`i'
           } 
           else {
                 di "There are fewer than 500 cases."
           }
         }
   
   end
   ```

10. You have all your commands in your do file, right? Run your do file from the beginning and make sure your do file does exactly the same thing.
