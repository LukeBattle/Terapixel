
#create tibble of gpu dataset

gpu_data = as_tibble(gpu)

gpu_data = unique(gpu_data)

#create list of clean date_times from gpu dataset

gpu_timestamp = lapply(gpu_data$timestamp,clean_date_time)

#convert character data_time to datetime format

gpu_datetime = parse_date_time(gpu_timestamp,"%Y%m%d %H%M%S")

#create START variable with formatted datetimes to merge with totalrender_data dataset

gpu_data$Time = gpu_datetime

gpu_data = gpu_data %>%
  arrange(hostname,Time)

cache('gpu_data')

unique_hostnames = unique(gpu_data$hostname)

cache('unique_hostnames')

task_no_gpu = lapply(unique_hostnames,assign_task_no)

task_no_gpu = unlist(task_no_gpu)

gpu_data$task_no = task_no_gpu

gpu_summary = gpu_data[gpu_data$gpuMemUtilPerc!=0,] %>%
  group_by(hostname,task_no,gpuSerial) %>%
  summarise(powerDraw = mean(powerDrawWatt),
            tempC = mean(gpuTempC),
            MemUtilPerc = mean(gpuMemUtilPerc),
            GpuUtilPerc = mean(gpuUtilPerc))

cache('gpu_summary')


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

gpu_card_summary_exc_first_tasks = filter(gpu_app_data,task_no>2) %>%
  group_by(gpuSerial,hostname) %>%
  summarise(runtime = mean(runtime),
            powerdrain = mean(powerDraw),
            temp = mean(tempC),
            memutil = mean(MemUtilPerc),
            gpuutil = mean(GpuUtilPerc)) %>%
  arrange(desc(runtime))

cache('gpu_card_summary_exc_first_tasks')

colour_map = 1:1024

slow_cards = as.data.frame(cbind("gpuSerial" = gpu_card_summary_exc_first_tasks$gpuSerial,
                                 "runtime_exc" = gpu_card_summary_exc_first_tasks$runtime, colour_map)) %>%
  left_join(gpu_card_summary[c("gpuSerial","runtime","hostname")], by = c("gpuSerial")) %>%
  rename(runtime_inc = "runtime") %>%
  pivot_longer(c("runtime_inc","runtime_exc"), names_to = "runtime_env", values_to = "avg_runtime")

cache('slow_cards')

avg_diff = slow_cards %>%
  pivot_wider(names_from = runtime_env,
              values_from = avg_runtime) %>%
  mutate(runtime_diff = runtime_inc - runtime_exc) %>%
  select(runtime_diff)

cache('avg_diff')

vm_waiting_times = lapply(unique_hostnames,waiting_time_perc)

vm_waiting_times = unlist(vm_waiting_times)

cache('vm_waiting_times')


