# lab5

lab4: [solutions](lab4.md)

data: transplants.dta donors_recipients.dta donors.dta 

zoom: M T W Th F

This lab is optional; you are NOT required to complete these questions. Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. Sample responses to the lab questions will be provided separately.

1. Start Stata, open your do-file editor, layout a template for the .dofile structure described over the last 5 weeks and load `transplants.dta` in the `if 2 {` code-block or elsewhere if you deem it appropriate.

2. Let's merge this dataset with the donor dataset. First, merge with `donors_recipients.dta`, and then with `donors.dta`, without specifying any options.

   ```stata
   merge 1:1 fake_id using donors_recipients
   ```

3. What does Stata say? Interpret the output.

   ```stata
   . merge 1:1 fake_id using donors_recipients
   
       Result                           # of obs.
       -----------------------------------------
       not matched                         4,000
           from master                         0  (_merge==1)
           from using                      4,000  (_merge==2)
   
       matched                             6,000  (_merge==3)
       -----------------------------------------
   ```
   > From the bottom: 6000 observations were successfully merged. 4000 observations from the using dataset (= donors_recipients.dta) were NOT matched with the master dataset (= transplants.dta) but brought in anyways. 0 observation from the master dataset were not matched (i.e., all observations from the master dataset were matched.)

4. `transplants.dta` is our study population. We don't want to bring in extra observations by merging. Use the option `keep` and make sure we don't bring in extra observations from `donors_recipients.dta`.

   ```stata
   use transplants, clear
   merge 1:1 fake_id using donors_recipients, keep(master match) nogen
   ```

5. Let's move forward and merge with `donors.dta`.

   ```stata
   merge m:1 fake_don_id using donors, keep(master match)
   ```

6. Now we want to calculate the mean age and the number of patients at each center. Preserve the dataset and collapse it by `ctr_id`. Explore the collapsed dataset using `list`.

   ```stata
   preserve
   collapse (mean) age (count) n=fake_id, by(ctr_id)
   ```

7. Restore the dataset. The plan has changed. We want to calculate these statistics in ECD cases and non-ECD cases separately (use the variable `don_ecd`). Calculate the mean age and the number of ECD patients and non-ECD patients at each center.

   ```stata
   restore
   collapse (mean) age (count) n=fake_id, by(ctr_id don_ecd)
   ```

8. After the collapse, each center has two observations. One for ECD cases and another for non-ECD cases. Reshape the dataset into a wide format (i.e., each center has only one observation).

   ```stata
   reshape wide age n, i(ctr_id) j(don_ecd)
   ```

9. You have all your commands in your do file, right? Run your do file from the beginning and make sure your do file does exactly the same thing.
