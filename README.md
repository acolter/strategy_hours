# Strategy Hours README.md
I wrote this script to find out the number of billable hours the Strategy team at 18F is clocking each week. This repo does not include either the raw data from the Tock reports or the output from the function since I'm guessing this would include PII.

To use it, download three files from the Tock Reports at https://tock.18f.gov/reports/ and put them in your working directory: 
- slim_timecard_bulk.csv
- user_data.csv
- projects.csv

Call the function using: 

<code>source("strategy_hours_bulk.R")</code>

<code>strategy_hours(end_date)</code>

Format the argument for the function using "yyyy-mm-dd" for the week ending date of the week you want (e.g., "2016-11-19"). The function will return the total number of hours and total number of billable hours entered by Strategists in Tock. The total billable hours does not include any projects listed as "FY17 Acquisition Svcs Billable." 

The function will write two csv files to your working directory:   
- all_hours.csv
- billable_hours.csv

You can import these into a spreadsheet to see which strategists worked on what projects for how many hours. The billable_hours.csv file shows which strategists worked on what billable projects for how many hours. The chapter's goal is to reach 482 billable hours per week.  

## Script
strategy_hours_bulk.R performs the following operations:
- Takes the user_data file and subsets the users who are Chapters-Strategists and current employees
- Turns that dataframe of users into a list of strategists
- Takes the slim_timecard_bulk file and subsets the users who are in the list of strategists, who have timecards for the week specified, and who have worked more than zero hours on a project
- Takes the projects.csv file and subsets the projects that are billable, leaving out any TTS Acq projects
- Turns the dataframe of billable projects into a list 
- Produces a list of strategists who have worked on billable projects
- Calculates the total billable hours
- Writes csv files of all strategist hours and all strategist billable hours
