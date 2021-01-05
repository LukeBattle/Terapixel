#create copy and convert to tibble

app_data = as_tibble(application.checkpoints)

#apply clean_date_time function to date_time in data and create list

date_time_chr = lapply(application.checkpoints$timestamp,clean_date_time)

#create list of date-times converted to datetime format

date_time = parse_date_time(date_time_chr,"%Y%m%d %H%M%S")

#change timestamp to converted date_time format

app_data$timestamp = date_time

#remove duplicates

app_data = unique(app_data)

cache('app_data')

#convert to wide format so that START and STOP are separate columns

app_wide = app_data %>%
  pivot_wider(names_from = eventType,
              values_from = timestamp)

#create runtime variable by calculating time difference from start to stop timestamp

app_wide$runtime = app_wide$STOP - app_wide$START

cache('app_wide')

