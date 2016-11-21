strategy_hours <- function(end_date) {
  
  # download the following files from https://tock.18f.gov/reports/ each time you want to run this function 
  # you'll need to be an authorized user to access the files
  # put them in your working directory
  # read in the files
  tock_df <- read.csv("slim_timecard_bulk.csv")
  users_df <- read.csv("user_data.csv") # from the "List of all users" link
  projects_df <- read.csv("projects.csv") # from the "List of all projects" link
  
  # create a list of strategists, use that to subset all strategist hours from the Tock data
  strategists_df <- users_df[users_df$unit %in% "Chapters-Strategists" & users_df$current_employee %in% "True",]
  strategists <- as.vector(strategists_df[,1])
  strategists_hours <- tock_df[tock_df$employee %in% strategists & tock_df$end_date %in% end_date,]

  # create a list of billable projects from the projects list
  projects <- projects_df[projects_df$billable %in% "True",]
  billable_projects <- as.vector(projects[,3])
  billable_hours <- strategists_hours[strategists_hours$project_name %in% billable_projects,]
  
  # calculate the total hours worked by the strategists
  total_hours <- sum(strategists_hours$hours_spent)
  
  # calculate the total billable hours worked by the strategists
  total_billable_hours <- sum(billable_hours$hours_spent)
  
  # calculate the percentage billable
  percent_billable <- total_billable_hours / total_hours
  
  # find out how many strategists appear in the Tock data
  strategists <- as.vector(strategists_df[,1])
  strategists_in_tock <- levels(droplevels(strategists_hours$employee))

  # create csv files for all hours worked and billable hours worked
  write.csv(strategists_hours, file="all_hours.csv")
  write.csv(billable_hours, file="billable_hours.csv")
  
  # print it all out
  print(paste("Total hours worked by strategists:", total_hours))
  print(paste("Billable hours worked by strategists:", total_billable_hours))
  print(paste("Percentage of billable hours worked:", percent_billable))
  print(paste("All strategists are in the Tock file:", (length(strategists) == length(strategists_in_tock))))
  
}

