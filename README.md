# Strategy Hours README.md
I wrote this script to find out the number of billable hours the Strategy team at 18F is clocking each week. I did this mainly to practice my R programming skills, but also because while there is an existing Python script that calculates the same thing, I don't know Python. 

## Raw Data
The raw data comes from the Tock Reports at https://tock.18f.gov/reports/. You'll need to download three files each time you want to run the function and put them in your working directory: 
- slim_timecard_bulk.csv
- user_data.csv
- projects.csv

## Script
strategy_hours_bulk.R performs the following operations:
- Takes the user_data file and subsets the users who are Chapters-Strategists and current employees
- Turns that dataframe of users and turns it into a list of strategists
- Takes the slim_timecard_bulk file and subsets the users who are in the list of strategists and who have timecards for the week specified
- Takes the projects.csv file and subsets the projects that are billable
- Turns the dataframe of billable projects into a list 
- Produces a list of strategists who have worked on billable project
- Calculates the total hours and the total billable hours
- Writes csv files of all strategist hours and all strategist billable hours
