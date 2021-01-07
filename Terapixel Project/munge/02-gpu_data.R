#create dataset with just totalrender events

totalrender_data = filter(app_wide,eventName == "TotalRender") %>%
  arrange(hostname,START)

task_no_per_host = vector()
unique_app_hostname = unique(totalrender_data$hostname)

for (i in unique_app_hostname) {
  host_no = sum(totalrender_data$hostname == i)
  task_no_per_host = append(task_no_per_host,1:host_no)
}

totalrender_data$task_no = task_no_per_host

totalrender_data$time_interval = interval(totalrender_data$START,totalrender_data$STOP)

event_data = filter(app_wide,eventName != "TotalRender") %>%
  arrange(hostname,START)

event_data$time_interval = interval(event_data$START,event_data$STOP)

task_no_per_host = vector()
unique_app_hostname = unique(event_data$hostname)

for (i in unique_app_hostname) {
  host_no = sum(event_data$hostname == i)
  task_no_per_host = append(task_no_per_host,1:host_no)
}

event_data$task_no = task_no_per_host


#create tibble of gpu dataset

gpu_data = as_tibble(gpu)

gpu_data = unique(gpu_data)

#create list of clean date_times from gpu dataset

gpu_timestamp = lapply(gpu_data$timestamp,clean_date_time)

#convert character data_time to datetime format

gpu_datetime = parse_date_time(gpu_timestamp,"%Y%m%d %H%M%S")

#create START variable with formatted datetimes to merge with totalrender_data dataset

gpu_data$Time = gpu_datetime

cache('gpu_data')

gpu_task = numeric(length(gpu_datetime))

gpu_hostname = gpu_data$hostname

for (i in 1:length(gpu_data$hostname)) {
  gpu_task[i] = event_data$task_no[event_data$hostname == gpu_hostname[i] 
                                   & gpu_datetime[i] %within% event_data$time_interval][1]
}

gpu_data$task_no = gpu_task

gpu_app_data = left_join(event_data,gpu_data, by = c("hostname","task_no"))

gpu_app_data = na.omit(gpu_app_data)



test1 = totalrender_data[totalrender_data$hostname == gpu_hostname[49],]
test1$task_no[gpu_datetime[49] %within% test1$time_interval]

take_hostname = function(x) {
  temp = totalrender_data[totalrender_data$hostname == x,]
  return(temp)
}

hostname_filt = apply

#merge gpu_data and totalrender_data based on START/STOP and hostname

gpu_app_data = merge(totalrender_data,gpu_data[c("START","hostname","powerDrawWatt","gpuSerial","gpuTempC","gpuUtilPerc","gpuMemUtilPerc")],by = c("START","hostname"))

cache('gpu_app_data')




#create summary of gpu cards by serial number with averages for properties such as runtime, powerdrain, temp
##etc.

gpu_card_summary = gpu_app_data %>%
  group_by(gpuSerial,hostname) %>%
  summarise(runtime = mean(runtime),
            powerdrain = mean(powerDrawWatt),
            temp = mean(gpuTempC),
            memutil = mean(gpuMemUtilPerc),
            gpuutil = mean(gpuUtilPerc)) %>%
  arrange(desc(runtime))



cache('gpu_card_summary')
