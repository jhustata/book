# lab3

lab2: [solutions](lab2.md)

data: [transplants.dta](transplants.dta) 

zoom: [M](https://JHUBlueJays.zoom.us/j/96760923747) [T](https://JHUBlueJays.zoom.us/j/99476415268) [W](https://jhubluejays.zoom.us/j/98628544091?pwd=ZGx5NTN1RHNzNDUrQ3c3Uys0RVYrUT09) [Th](https://JHUBlueJays.zoom.us/j/3393703103) [F](https://JHUBlueJays.zoom.us/j/8581993134)

This lab is optional; you are NOT required to complete these questions. Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. Sample responses to the lab questions will be provided separately.

1. Start Stata, open your do-file editor, write the header, and load `transplants.dta`.

2. `ctr_id` indicates the ID of the transplant center where the patient received the transplant. Count the number of recipients at each center, and store in a new variable `volume`.

3. List `ctr_id` and `volume` to see how many patients each center has. Maybe let's try this:

   `list ctr_id volume`

4. Whelp. This is not what we wanted. Generate a variable `ctr_tag` that "tags" one observation per center.

5. Now `list ctr_id` and `volume`, but just for one record per center.

6. Calculate the mean age of the patients at each center, and store in a new variable `mean_age`.

7. For each primary diagnosis subgroup (use variable `dx`), run a regression with age as the predictor and peak PRA (`peak\_pra`) as the outcome.

8. Now let's make the output cleaner. Count the number of cases within each diagnosis group. If there are more than 500 cases, run the regression and display the output. If not, display "There are fewer than 500 cases."

9. Define a program called `reg_pra`. This program will perform the same tasks as described in Question 8, but the regression will take one or more variables specified by the user as the predictor.

10. You have all your commands in your do file, right? Run your do file from the beginning and make sure your do file does exactly the same thing.
