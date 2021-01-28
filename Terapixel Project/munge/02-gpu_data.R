
#create tibble of gpu dataset

gpu_data = as_tibble(gpu)

gpu_data = unique(gpu_data)

#create list of clean date_times from gpu dataset

gpu_timestamp = lapply(gpu_data$timestamp,clean_date_time)

#convert character data_time to datetime format

gpu_datetime = parse_date_time(gpu_timestamp,"%Y%m%d %H%M%S")

#create Time variable with formatted datetimes

gpu_data$Time = gpu_datetime

#arrange gpu_data by hostname and time

gpu_data = gpu_data %>%
  arrange(hostname,Time)

cache('gpu_data')

#create list of unique hostnames in gpu

unique_hostnames = unique(gpu_data$hostname)

cache('unique_hostnames')

#use list of unique hostnames to assign task number to gpu data per hostname

task_no_gpu = lapply(unique_hostnames,assign_task_no)

task_no_gpu = unlist(task_no_gpu)

#add task number to gpu_data

gpu_data$task_no = task_no_gpu

# create summary of gpu data, summarising back hostname, task number and gpuSerial. Takes mean 
# values of each performance metric in each task

gpu_summary = gpu_data[gpu_data$gpuMemUtilPerc!=0,] %>%
  group_by(hostname,task_no,gpuSerial) %>%
  summarise(powerDraw = mean(powerDrawWatt),
            tempC = mean(gpuTempC),
            MemUtilPerc = mean(gpuMemUtilPerc),
            GpuUtilPerc = mean(gpuUtilPerc))

cache('gpu_summary')

#join gpu_summary to totalrender_data

gpu_app_data = left_join(totalrender_data,gpu_summary, by = c("hostname","task_no"))

cache('gpu_app_data')


#create summary of gpu cards by serial number with averages for properties such as runtime, powerdrain, temp
##etc. Arrange by runtime with slowest top

gpu_card_summary = gpu_app_data %>%
  group_by(gpuSerial,hostname) %>%
  summarise(runtime = mean(runtime),
            powerdrain = mean(powerDraw),
            temp = mean(tempC),
            memutil = mean(MemUtilPerc),
            gpuutil = mean(GpuUtilPerc)) %>%
  arrange(desc(runtime))

cache('gpu_card_summary')

#create summary as above but excluding first two tasks

gpu_card_summary_exc_first_tasks = filter(gpu_app_data,task_no>2) %>%
  group_by(gpuSerial,hostname) %>%
  summarise(runtime = mean(runtime),
            powerdrain = mean(powerDraw),
            temp = mean(tempC),
            memutil = mean(MemUtilPerc),
            gpuutil = mean(GpuUtilPerc)) %>%
  arrange(desc(runtime))

cache('gpu_card_summary_exc_first_tasks')

#create list of numbers to be assigned to each GPU

colour_map = 1:1024

#create dataframe by merging gpu_card_summary and gpu_card_summary_exc_first_tasks. Shows 15 slowest
# gpu cards at top, to be used with plot

slow_cards = as.data.frame(cbind("gpuSerial" = gpu_card_summary$gpuSerial,
                                 "runtime_inc" = gpu_card_summary$runtime, colour_map)) %>%
  left_join(gpu_card_summary_exc_first_tasks[c("gpuSerial","runtime","hostname")], by = c("gpuSerial")) %>%
  rename(runtime_exc = "runtime") %>%
  pivot_longer(c("runtime_inc","runtime_exc"), names_to = "runtime_env", values_to = "avg_runtime")

cache('slow_cards')

#calculate the average difference between runtime average including first two tasks and without them

avg_diff = slow_cards %>%
  pivot_wider(names_from = runtime_env,
              values_from = avg_runtime) %>%
  mutate(runtime_diff = runtime_inc - runtime_exc) %>%
  select(runtime_diff)

cache('avg_diff')

#calculate % of time VM spent idle from beginning of first task to end of the final one

vm_waiting_times = lapply(unique_hostnames,waiting_time_perc)

vm_waiting_times = unlist(vm_waiting_times)

cache('vm_waiting_times')


