float_hours <- function(file_name) {
  
  float_df <- read.csv(file_name, skip=4)
  
  # get the date embedded in the file name to use as a column name
  week_beginning <- substr(file_name,13,20) 
  year <- substr(week_beginning, 1,4)
  month <- substr(week_beginning, 5,6)
  day <- substr(week_beginning, 7,8)
  date <- paste0(year,".",month, ".", day)
  
  # get rid of unneeded rows, keep the Name, Project and hours columns
  rows_to_keep <- which(!float_df$Name == "CAPACITY" & !float_df$Name == "TOTAL")
  float_df2 <- float_df[rows_to_keep, c(1,5,8)]

  # add columns
  float_df2$Week <- date 
  float_df2$Actual_Hours <- NA
  float_df2$Reason_for_Discrepancy <- NA
  
  #rearrange columns
  float_df3 <- float_df2[,c(4,1,2,5,3,6)]
  
  #rename columns
  colnames(float_df3) <- c("Week","Name","Relevant Billable Projects","Actual Hours","Allocated in Float","Why were there fewer hours than allocated?")
  
  # sort by Name column
  float_df4 <- float_df3[ order(float_df3[,2]), ]
  
  write.csv(float_df4, file="float_hours.csv", row.names = FALSE)

}
