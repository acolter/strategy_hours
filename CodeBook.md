# Code Book
This code book will describs the variables, the data, and any transformations or work performed to clean up the data.

The slim_timecard_bulk.csv file contains the timesheet information from Tock. It includes the following variables: 
- project_name
- employee
- start_date
- end_date
- hours_spent
- billable
- mbnumber

The user_data.csv file lists all 18F employees. It contains the following variables: 
- user
- current_employee
- is_18f_employee
- is_billable
- unit

The projects.csv file list all the projects that 18F is working on and whether they are billable. It contains the following variables: 
- id
- client
- name
- description
- billable
- start_date
- end_date
- active
- profit_loss_account
