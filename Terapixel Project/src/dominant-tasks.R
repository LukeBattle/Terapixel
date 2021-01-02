
library(ProjectTemplate)
load.project()

str(application.checkpoints)

#check NAs

sum(is.na.data.frame(application.checkpoints))



#change options to show three d.p.

op = options(digits.secs = 3)

#use options(op) to reset options

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


colnames(gpu_data)


length(unique(gpu$hostname))

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


unique(app_data$jobId)

max(gpu_app_data$runtime)



#create plot of runtime vs pixel

(task_runtime_plot  = ggplot(data = filter(pixel_summary,level == 12), aes(x = x, y = y, color = as.numeric(runtime))) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = ""
    ))


