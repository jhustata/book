# lab5

lab4: [solutions](lab4.md)

data: [transplants.dta](transplants.dta) [donors_recipients.dta](donors_recipients.dta) [donors.dta](donors.dta)

zoom: [M](https://JHUBlueJays.zoom.us/j/96760923747) [T](https://JHUBlueJays.zoom.us/j/99476415268) [W](https://jhubluejays.zoom.us/j/98628544091?pwd=ZGx5NTN1RHNzNDUrQ3c3Uys0RVYrUT09) [Th](https://JHUBlueJays.zoom.us/j/3393703103) [F](https://JHUBlueJays.zoom.us/j/8581993134)

This lab is optional; you are NOT required to complete these questions. Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. Sample responses to the lab questions will be provided separately.

1. Start Stata, open your do-file editor, layout a template for the .dofile structure described over the last 5 weeks and load `transplants.dta` in the `if 2 {` code-block or elsewhere if you deem it appropriate.

2. Let's merge this dataset with the donor dataset. First, merge with `donors_recipients.dta`, and then with `donors.dta`, without specifying any options.

3. What does Stata say? Interpret the output.

4. `transplants.dta` is our study population. We don't want to bring in extra observations by merging. Use the option `keep` and make sure we don't bring in extra observations from `donors_recipients.dta`.

5. Let's move forward and merge with `donors.dta`.

6. Now we want to calculate the mean age and the number of patients at each center. Preserve the dataset and collapse it by `ctr_id`. Explore the collapsed dataset using `list`.

7. Restore the dataset. The plan has changed. We want to calculate these statistics in ECD cases and non-ECD cases separately (use the variable `don_ecd`). Calculate the mean age and the number of ECD patients and non-ECD patients at each center.

8. After the collapse, each center has two observations. One for ECD cases and another for non-ECD cases. Reshape the dataset into a wide format (i.e., each center has only one observation).

9. You have all your commands in your do file, right? Run your do file from the beginning and make sure your do file does exactly the same thing.
