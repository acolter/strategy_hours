strategy_hours <- function(end_date) {
  
  # download the following files from https://tock.18f.gov/reports/ each time you want to run this function 
  # you'll need to be an authorized user to access the files
  # put them in your working directory
  # read in the files
  tock_df <- read.csv("slim_timecard_bulk.csv") # from the "Complete timecard data with fewer fields: FY2017" link
  users_df <- read.csv("user_data.csv") # from the "List of all users" link
  projects_df <- read.csv("projects.csv") # from the "List of all projects" link
  
  # create a list of strategists, use that to subset all strategist hours from the Tock data
  strategists_df <- users_df[users_df$unit %in% "Chapters-Strategists" 
                             & users_df$current_employee %in% "True",]
  strategists <- as.vector(strategists_df[,1])
  strategists_hours <- tock_df[tock_df$employee %in% strategists 
                               & tock_df$end_date %in% end_date
                               & !(tock_df$hours_spent %in% "0"),]
  
  # sort the dataframe by employee
  strategists_hours <- strategists_hours[order(strategists_hours$employee),]
  
  # create a list of billable projects that don't include TTS Acq, Federalist or PIF
  projects <- projects_df[projects_df$billable %in% "True" 
                          & !(grepl("TTS Acq",projects_df$name)) 
                          & !(grepl("Federalist",projects_df$name)) 
                          & !(grepl("PIF",projects_df$name)),]
  billable_projects <- as.vector(projects[,3])
  billable_hours <- strategists_hours[strategists_hours$project_name %in% billable_projects,]

  # calculate the total hours worked by the strategists
  total_hours <- sum(strategists_hours$hours_spent)
  
  # calculate the total billable hours worked by the strategists
  total_billable_hours <- sum(billable_hours$hours_spent)
 
  # calculate the percentage billable
  percent_billable <- total_billable_hours / total_hours

  # create csv files for all hours worked and billable hours worked
  write.csv(strategists_hours, file="all_hours.csv")
  write.csv(billable_hours, file="billable_hours.csv")
  
  # chapter cost recovery and planned revenue goals
  cr_hours_goal <- 398
  pr_hours_goal <- 301
  
  # print it all out
  print(paste("Total hours recorded by strategists:", total_hours))
  print(paste("Billable hours recorded by strategists:", total_billable_hours))
  print(paste("Billable percentage:", sprintf("%1.0f%%", 100*percent_billable)))
  print(paste("Hours off chapter cost recovery goal:", total_billable_hours - cr_hours_goal))
  print(paste("Hours off chapter planned revenue goal:", total_billable_hours - pr_hours_goal))

  }
