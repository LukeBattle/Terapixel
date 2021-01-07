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

gpu_data = gpu_data %>%
  arrange(hostname,Time)

unique_hostnames = unique(gpu_data$hostname)

task_no_gpu = lapply(unique_hostnames,assign_task_no)

task_no_vec = unlist(task_no_gpu)

gpu_data$task_no = task_no_vec

gpu_summary = gpu_data[gpu_data$gpuMemUtilPerc!=0,] %>%
  group_by(hostname,task_no,gpuSerial) %>%
  summarise(powerDraw = median(powerDrawWatt),
            tempC = median(gpuTempC),
            MemUtilPerc = median(gpuMemUtilPerc),
            GpuUtilPerc = median(gpuUtilPerc))


gpu_app_data = left_join(totalrender_data,gpu_summary, by = c("hostname","task_no"))

cache('gpu_app_data')


#create summary of gpu cards by serial number with averages for properties such as runtime, powerdrain, temp
##etc.

gpu_card_summary = gpu_app_data %>%
  group_by(gpuSerial,hostname) %>%
  summarise(runtime = mean(runtime),
            powerdrain = mean(powerDraw),
            temp = mean(tempC),
            memutil = mean(MemUtilPerc),
            gpuutil = mean(GpuUtilPerc)) %>%
  arrange(desc(runtime))



cache('gpu_card_summary')
