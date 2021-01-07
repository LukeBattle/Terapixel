# assess gpu dataset quantitative values

gputemp_plot  = ggplot(data = gpu_data, aes(x = gpuTempC)) +  
  geom_histogram() +
  labs(
    x = "gpuTempC",
    y = "Freq",
    title = "Event Name vs Runtime (Seconds)"
  )

gputemp_plot

gpupowerdraw_plot  = ggplot(data = gpu_data, aes(x = powerDrawWatt)) +  
  geom_histogram() +
  labs(
    x = "gpuTempC",
    y = "Freq",
    title = "Event Name vs Runtime (Seconds)"
  )

gpupowerdraw_plot

gpumemutil_plot  = ggplot(data = gpu_data, aes(x = gpuMemUtilPerc)) +  
  geom_histogram() +
  labs(
    x = "gpuTempC",
    y = "Freq",
    title = "Event Name vs Runtime (Seconds)"
  )


gpumemutil_plot

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