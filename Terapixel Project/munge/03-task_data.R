#create tibble of task.x.y data

task_data = as_tibble(task.x.y)

#merge task data to gpu and app data by jobId and taskId

all_data = left_join(gpu_app_data,task_data[c("taskId","x","y","level")],by = c("taskId"))

cache('all_data')

#create summary of average properties per pixel from task data

pixel_summary = gpu_task_app_data %>%
  group_by(x,y,level) %>%
  summarise(runtime = mean(runtime),
            powerdrain = mean(powerDrawWatt),
            temp = mean(gpuTempC),
            memutil = mean(gpuMemUtilPerc),
            gpuutil = mean(gpuUtilPerc)) %>%
  arrange(desc(runtime))

cache('pixel_summary')
