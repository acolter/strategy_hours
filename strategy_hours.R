strategy_hours <- function() {
  
  # read in the tock file from https://tock.18f.gov/reports/
  #tock <- read.csv(tock_weekly_report) #"2016-11-06.csv"
  tock_df <- read.csv("2016-11-13.csv") 
  users_df <- read.csv("user_data.csv")
  projects_df <- read.csv("projects.csv")
  
  # create a list of strategists, subset them from the Tock data, drop unused levels
  strategists_df <- users_df[users_df$unit %in% "Chapters-Strategists" & users_df$current_employee %in% "True",]
  strategists <- paste0(as.vector(strategists_df[,1]),"@gsa.gov")
  all_hours <- tock_df[tock_df$User %in% strategists,]
  strategists_in_tock <- levels(droplevels(all_hours$User))
  
  # create a vector of billable projects from the Tock projects list
  projects <- projects_df[projects_df$billable %in% "True",]
  billable_projects <- as.vector(projects[,3])
  billable_hours <- all_hours[all_hours$Project %in% billable_projects,]
  
  # calculate total hours worked by the strategists
  total_hours <- sum(all_hours$Number.of.Hours)
  
  # calculate the total hours of billable projects for all strategists
  billable_hours <- sum(billable_hours$Number.of.Hours)

  # create csv files for all hours and billable hours
  write.csv(all_hours, file="all_hours.csv")
  write.csv(billable_hours, file="billable_hours.csv")
  
  #print it all out
  print(paste("Total hours worked by strategists:", total_hours))
  print(paste("Billable hours worked by strategists:", billable_hours))
  print(paste("All strategists are in the Tock file:", (length(strategists) == length(strategists_in_tock))))
  
}
