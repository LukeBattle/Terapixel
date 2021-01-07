
library(ProjectTemplate)
load.project()

str(application.checkpoints)

#check NAs

sum(is.na(application.checkpoints))

sum(is.na(gpu))

sum(is.na(task.x.y))

# Check duplicates

dim(application.checkpoints)[1] - dim(unique(application.checkpoints))[1]

duplicate_app_rows = application.checkpoints[duplicated(application.checkpoints),]

duplicate_gpu_rows = gpu[duplicated(gpu),]

dim(task.x.y)[1] - dim(unique(task.x.y))[1]

view(filter(gpu,timestamp == duplicate_gpu_rows$timestamp))

dim(gpu)[1] - dim(unique(gpu))[1]

#change options to show three d.p.

op = options(digits.secs = 3)

#use options(op) to reset options



runtime_plot

length(unique(filter(gpu_data,gpuUtilPerc == 0)$gpuSerial))

sum(gpu$gpuUtilPerc < 25)

gpu_data2 = gpu_data[gpu_data$gpuUtilPerc!=0,]

#create plot to show varying average runtimes for each event 

event_runtime_plot  = ggplot(data = app_wide, aes(x = eventName, y = runtime)) +  
    stat_summary(fun = mean, geom = "col") +
    labs(
      x = "Event Type",
      y = "Seconds",
      title = "Event Name vs Runtime (Seconds)"
    )

event_runtime_plot


#check runtime max in datasets
max(totalrender_data$runtime)
max(app_wide$runtime)

dim(task.x.y)

str(task.x.y)

str(gpu)

str(application.checkpoints)

class(task.x.y$taskId[1])

length(unique(task.x.y$jobId))

unique(task.x.y[c("jobId","level")])

length(unique(app_data$hostname))

#plot runtime vs powerdraw

(power_runtime_plot  = ggplot(data = gpu_app_data, aes(x = powerDrawWatt, y = as.numeric(runtime))) +
  geom_point() +
  labs(
    x = "Power Draw (Watts)",
    y = "Seconds",
    title = "Power Draw vs runtime"
  ))

#plot temp vs runtime

(temp_runtime_plot  = ggplot(data = gpu_app_data, aes(x = gpuTempC, y = as.numeric(runtime))) +
    geom_point() +
    labs(
      x = "TempC",
      y = "Seconds",
      title = "TempC vs runtime"
    ))


unique_hostname = unique(gpu$hostname)
hostname_count = numeric(length(unique_hostname))
count = 1
for (i in unique_hostname) {
  hostname_count[count] = sum(gpu$hostname == i)
  count = count + 1
}

hostname_count_df = cbind(unique_hostname,hostname_count)

unique_app_hostname = unique(application.checkpoints$hostname)
app_hostname_count = numeric(length(unique_app_hostname))
count = 1
for (i in unique_app_hostname) {
  app_hostname_count[count] = sum(application.checkpoints$hostname == i)
  count = count + 1
}

app_hostname_count_df = cbind(unique_app_hostname,app_hostname_count)


unique(app_data$jobId)

max(gpu_app_data$runtime)

#calculate runtime of whole render process from app_data

max(totalrender_data$STOP)- min(totalrender_data$START)

max(gpu_data$START) - min(gpu_data$START)

max(date_time) - min(date_time)

unique(gpu_task_app_data$level)

mean(filter(gpu_task_app_data,level==4)$runtime)

mean(filter(gpu_task_app_data,level==8)$runtime)

mean(filter(gpu_task_app_data,level==12)$runtime)


#create plot of runtime vs pixel

(task_runtime_plot  = ggplot(data = filter(app_task_data,level == 12), aes(x = x, y = y, color = as.numeric(runtime))) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = ""
    ))

dim(unique(app_task_data[c("x","y")]))

