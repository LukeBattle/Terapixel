# assess gpu dataset quantitative values

#distribution of temperature performance metric
gputemp_plot  = ggplot(data = gpu_data, aes(x = gpuTempC)) +  
  geom_histogram(bins =30) +
  labs(
    x = "Temperature (celsius)",
    y = "Frequency",
    title = "Temperature Distribution "
  )

#distribution of power draw performance metric
gpupowerdraw_plot  = ggplot(data = gpu_data, aes(x = powerDrawWatt)) +  
  geom_histogram(bins=30) +
  labs(
    x = "Power Draw (watts)",
    y = "Frequency",
    title = "Power Draw Distribution"
  )

#distribution of % RAM usage performance metric
gpumemutil_plot  = ggplot(data = gpu_data, aes(x = gpuMemUtilPerc)) +  
  geom_histogram(bins = 30) +
  labs(
    x = "% RAM Used",
    y = "Frequency",
    title = "% Memory Utilised Distribution"
  )

#distribution of % GPU usage performance metric
gpuutil_plot  = ggplot(data = gpu_data, aes(x = gpuUtilPerc)) +  
  geom_histogram(bins =30) +
  labs(
    x = "% GPU Core Used",
    y = "Frequency",
    title = "% GPU Core Used Distribution"
  )

#distribution of runtime
runtime_plot  = ggplot(data = filter(app_wide,eventName == "TotalRender"), aes(x = as.numeric(runtime))) +  
  geom_histogram() +
  labs(
    x = "runtime",
    y = "Freq",
    title = ""
  )


#plot to show significance of zeroes
(zero_plot  = ggplot(data = filter(gpu_data,hostname == "04dc4e9647154250beeee51b866b0715000000" & 
                                     Time < "2018-11-08 08:00:00"), aes(x = Time, y = gpuMemUtilPerc)) +  
  geom_line() +
  labs(
    x = "Time",
    y = "gpuMemUtilPerc",
    title = "Time vs % RAM usage"
  ))

#plot to show significance of zeroes in different hostname
(zero_plot2  = ggplot(data = filter(gpu_data,hostname == unique_hostnames[1] & 
                                      Time < "2018-11-08 08:00:00"), aes(x = Time, y = gpuMemUtilPerc)) +  
    geom_line() +
    labs(
      x = "Time",
      y = "gpuMemUtilPerc",
      title = "Time vs % RAM usage"
    ))

#plot to be used for abstract, showing variation of average runtime over each event in each task number
(abstract_plot = ggplot(app_wide, aes(task_no, runtime, color = eventName)) +
  stat_summary(fun = mean, geom = "line") + 
  stat_summary(fun = mean, geom = "point") + 
  labs(
    x = "Task Number",
    y = "Average Runtime (seconds)",
    title = "Average Runtime vs Task Number for each Event",
    color = "Event"
  ))

