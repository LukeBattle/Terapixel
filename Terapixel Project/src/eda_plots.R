# assess gpu dataset quantitative values

gputemp_plot  = ggplot(data = gpu_data, aes(x = gpuTempC)) +  
  geom_histogram() +
  labs(
    x = "gpuTempC",
    y = "Freq",
    title = "Event Name vs Runtime (Seconds)"
  )


gpupowerdraw_plot  = ggplot(data = gpu_data, aes(x = powerDrawWatt)) +  
  geom_histogram() +
  labs(
    x = "gpuTempC",
    y = "Freq",
    title = "Event Name vs Runtime (Seconds)"
  )


gpumemutil_plot  = ggplot(data = gpu_data, aes(x = gpuMemUtilPerc)) +  
  geom_histogram() +
  labs(
    x = "gpuTempC",
    y = "Freq",
    title = "Event Name vs Runtime (Seconds)"
  )


gpuutil_plot  = ggplot(data = gpu_data, aes(x = gpuUtilPerc)) +  
  geom_histogram() +
  labs(
    x = "gpuUtilPerc",
    y = "Freq",
    title = ""
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

