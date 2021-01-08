
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




task.x.y %>%
  count(totalrender_data$taskId)

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

(power_runtime_plot  = ggplot(filter(gpu_app_data, hostname == "04dc4e9647154250beeee51b866b0715000000"), 
                              aes(x = powerDraw, y = as.numeric(runtime))) +
  geom_point() +
  labs(
    x = "Power Draw (Watts)",
    y = "Seconds",
    title = "Power Draw vs runtime"
  ))


#plot temp vs runtime

(temp_runtime_plot  = ggplot(filter(gpu_app_data, hostname == "04dc4e9647154250beeee51b866b0715000000"), 
                             aes(x = tempC, y = as.numeric(runtime))) +
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

(task_runtime_plot  = ggplot(data = filter(all_data,level == 12), aes(x = y, y = (-1*x), color = as.numeric(runtime))) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = ""
    ))

(task_runtime_plot  = ggplot(data = filter(all_data,level == 12), aes(x = y, y = (-1*x), color = MemUtilPerc)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = ""
    ))

dim(unique(app_task_data[c("x","y")]))


#check that task_no is assigned correctly

unique_app_task = function(hostn) {
  return(length(unique(app_data[app_data$hostname == hostn,]$taskId)))
  
}

unique_app_tasks = lapply(unique_hostnames,unique_app_task)

unique_app_tasks = numeric(1024)
count = 1
for (i in unique_hostnames) {
  filt_data = filter(totalrender_data,hostname == i)
  unique_app_tasks[count] = max(filt_data$task_no)
  count = count +1
}

unique_gpu_tasks = numeric(1024)
count = 1
for (i in unique_hostnames) {
  filt_data = filter(gpu_data,hostname == i)
  unique_gpu_tasks[count] = max(filt_data$task_no)
  count = count +1
}

sum(unique_app_tasks == unique_gpu_tasks)

gpu_summary %>%
  count(hostname,task_no) %>%
  filter(n > 1)

gpu_summary %>%
  count(hostname,task_no) %>%
  filter(n > 1)

totalrender_data %>%
  count(hostname,task_no) %>%
  filter(n > 1)

sum(totalrender_data$hostname == gpu_summary$hostname) == length(gpu_summary$hostname)

sum(totalrender_data$task_no == gpu_summary$task_no) == length(gpu_summary$hostname)

gpu_app_data %>%
  count(taskId) %>%
  filter(n > 1)
