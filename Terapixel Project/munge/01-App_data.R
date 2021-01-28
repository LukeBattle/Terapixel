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

#convert to wide format so that START and STOP are separate columns, arrange by hostname and START time

app_wide = app_data %>%
  pivot_wider(names_from = eventType,
              values_from = timestamp) %>%
  arrange(hostname,START)

#create runtime variable by calculating time difference from start to stop timestamp

app_wide$runtime = as.numeric(app_wide$STOP - app_wide$START)

#create event_data to check TotalRender eventName

event_data = app_wide[c("eventName","runtime","taskId","hostname")] %>% 
  arrange(taskId) %>%
  pivot_wider(names_from = eventName,
              values_from = runtime)

#create new variable that containing sum of individual event runtimes

event_data$totalprocess = event_data$Render + event_data$Uploading + event_data$`Saving Config` + 
  event_data$Tiling

#find difference between totalrender and totalprocess

event_data$diff = event_data$totalprocess - event_data$TotalRender

cache('event_data')

#calculate differences in START time for Uploading and Tiling events

event_diff = filter(app_wide,eventName %in% c("Uploading","Tiling")) %>%
  select(eventName,taskId,START) %>%
  pivot_wider(names_from = eventName,
              values_from = START) %>%
  mutate(start_diff = Uploading - Tiling)

event_start_diff = as.numeric(event_diff$start_diff)

cache('event_start_diff')

#create dataset with just totalrender events

totalrender_data = filter(app_wide,eventName == "TotalRender")

#create list of unique hostnames

unique_app_hostname = unique(totalrender_data$hostname)

#assign task number to each task in a hostname

task_no_per_host = lapply(unique_app_hostname,assign_tr_task)

task_no_per_host = unlist(task_no_per_host)

#append task number to totalrender data

totalrender_data$task_no = task_no_per_host

cache('totalrender_data')

#create summary data for median event runtimes

event_plot_data = app_wide %>%
  group_by(eventName) %>%
  summarise(runtime = median(runtime)) %>%
  arrange(runtime)

cache('event_plot_data')

#join task number to app_wide

app_wide = app_wide %>%
  left_join(select(totalrender_data,taskId,task_no), by = c("taskId"))

cache('app_wide')


