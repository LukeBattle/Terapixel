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
              values_from = timestamp) %>%
  arrange(hostname,START)

#create runtime variable by calculating time difference from start to stop timestamp

app_wide$runtime = as.numeric(app_wide$STOP - app_wide$START)

#create event_data to check TotalRender eventName

event_data = app_wide[c("eventName","runtime","taskId","hostname")] %>% 
  arrange(taskId) %>%
  pivot_wider(names_from = eventName,
              values_from = runtime)

event_data$totalprocess = event_data$Render + event_data$Uploading + event_data$`Saving Config` + 
  event_data$Tiling

event_data$diff = event_data$totalprocess - event_data$TotalRender

cache('event_data')

#use calculated runtimes to recalculate incorrect TotalRender task runtime

app_wide = app_wide[c("eventName","runtime","taskId","hostname","jobId")] %>%
  pivot_wider(names_from = eventName,
              values_from = runtime)

app_wide$TotalRender = app_wide$Render + app_wide$Uploading + app_wide$`Saving Config` + app_wide$Tiling

app_wide = app_wide %>%
  pivot_longer(c("Render","Uploading","Saving Config","TotalRender","Tiling"),names_to = "eventName", values_to = "runtime" )


cache('app_wide')

#create dataset with just totalrender events

totalrender_data = filter(app_wide,eventName == "TotalRender")

unique_app_hostname = unique(totalrender_data$hostname)

task_no_per_host = lapply(unique_app_hostname,assign_tr_task)

task_no_per_host = unlist(task_no_per_host)

totalrender_data$task_no = task_no_per_host

cache('totalrender_data')

event_plot_data = app_wide %>%
  group_by(eventName) %>%
  summarise(runtime = mean(as.numeric(runtime))) %>%
  arrange(runtime)

cache('event_plot_data')



