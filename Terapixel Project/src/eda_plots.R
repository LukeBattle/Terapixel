# assess gpu dataset quantitative values

gputemp_plot  = ggplot(data = gpu_data, aes(x = gpuTempC)) +  
  geom_histogram(bins =30) +
  labs(
    x = "Temperature (celsius)",
    y = "Frequency",
    title = "Temperature Distribution "
  )


gpupowerdraw_plot  = ggplot(data = gpu_data, aes(x = powerDrawWatt)) +  
  geom_histogram(bins=30) +
  labs(
    x = "Power Draw (watts)",
    y = "Frequency",
    title = "Power Draw Distribution"
  )


gpumemutil_plot  = ggplot(data = gpu_data, aes(x = gpuMemUtilPerc)) +  
  geom_histogram(bins = 30) +
  labs(
    x = "% RAM Used",
    y = "Frequency",
    title = "% Memory Utilised Distribution"
  )


gpuutil_plot  = ggplot(data = gpu_data, aes(x = gpuUtilPerc)) +  
  geom_histogram(bins =30) +
  labs(
    x = "% GPU Core Used",
    y = "Frequency",
    title = "% GPU Core Used Distribution"
  )


runtime_plot  = ggplot(data = filter(app_wide,eventName == "TotalRender"), aes(x = as.numeric(runtime))) +  
  geom_histogram() +
  labs(
    x = "runtime",
    y = "Freq",
    title = ""
  )


perc_waiting_time = ggplot() + aes(vm_waiting_times) + geom_histogram(binwidth = 0.75)



#plot to show significance of zeroes

(zero_plot  = ggplot(data = filter(gpu_data,hostname == "04dc4e9647154250beeee51b866b0715000000" & 
                                     Time < "2018-11-08 08:00:00"), aes(x = Time, y = gpuMemUtilPerc)) +  
  geom_line() +
  labs(
    x = "Time",
    y = "gpuMemUtilPerc",
    title = "Time vs % RAM usage"
  ))


(zero_plot2  = ggplot(data = filter(gpu_data,hostname == unique_hostnames[1] & 
                                      Time < "2018-11-08 08:00:00"), aes(x = Time, y = gpuMemUtilPerc)) +  
    geom_line() +
    labs(
      x = "Time",
      y = "gpuMemUtilPerc",
      title = "Time vs % RAM usage"
    ))

vm_waiting_times[1]

(abstract_plot = ggplot(app_wide, aes(task_no, runtime, color = eventName)) +
  stat_summary(fun = mean, geom = "line") + 
  stat_summary(fun = mean, geom = "point") + 
  labs(
    x = "Task Number",
    y = "Average Runtime (seconds)",
    title = "Average Runtime vs Task Number for each Event",
    color = "Event"
  ))

