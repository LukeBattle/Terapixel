
#plot variation of runtime over tiles
(tile_runtime_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = runtime)) +
  geom_point() +
  labs(
    x = "x",
    y = "y",
    title = "Variation of Runtime over Tiles",
    color = "Runtime (seconds)"
  ) + scale_color_gradient2(midpoint=mean(filter(all_data,level == 12)$runtime), low="blue", mid="white",
                             high="red", space = "Lab",guide = "colourbar"))

#plot variation of % RAM usage over tiles
(tile_mem_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = MemUtilPerc)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "Variation of % RAM Usage over Tiles",
      color = "% RAM Used"
    ) + scale_color_gradient2(midpoint=mean(filter(all_data,level == 12)$MemUtilPerc), low="blue", mid="white",
                              high="red", space ="Lab"))

#plot variation of power draw over tiles
(tile_power_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = powerDraw)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "Variation of Power Draw over Tiles",
      color = "Power Draw (watts)"
    ) + scale_color_gradient2(midpoint=median(filter(all_data,level == 12)$powerDraw), low="blue", mid="white",
                               high="red", space ="Lab"))

#plot variation of temperature over tiles
(tile_temp_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = tempC)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "Variation of Temperature over Tiles",
      color = "Temperature (celsius)"
    ) + scale_color_gradient2(midpoint=median(filter(all_data,level == 12)$tempC), low="blue", mid="white",
                              high="red", space ="Lab"))

#distribution of runtime variable
(runtime_hist = ggplot(all_data) + aes(runtime) + geom_histogram(bins = 15) +
    labs(
      x = "Runtime (seconds)",
      y = "Frequency"
    ))

#distribution of temperature variable
(temp_hist = ggplot(all_data) + aes(tempC) + geom_histogram(bins = 15) +
    labs(
      x = "Temperature (celsius)",
      y = "Frequency"
    ))

#distribution of power draw variable
(power_hist = ggplot(all_data) + aes(powerDraw) + geom_histogram(bins = 15) +
    labs(
      x = "Power Draw (watts)",
      y = "Frequency"
    ))

#distribution of %RAM usage variable
(mem_hist = ggplot(all_data) + aes(MemUtilPerc) + geom_histogram(bins = 15) +
    labs(
      x = "% Memory Usage",
      y = "Frequency"
    ))

#distribution of %GPU usage variable
(gpu_hist = ggplot(all_data) + aes(GpuUtilPerc) + geom_histogram(bins = 15) +
    labs(
      x = "% GPU Usage",
      y = "Frequency"
    ))

#specify performance metrics to measure
performance_metrics = c("runtime","powerDraw","tempC","MemUtilPerc","GpuUtilPerc")

#specify how performance metrics should appear in the report
performance_metrics_report = c("Render Time (seconds)", "Power Draw (watts)", "Temperature (celsius)",
                               "% Memory Usage", "% GPU Usage")

#calculate standard deviation of performance metrics
standard_devs = apply(all_data[,performance_metrics],2,sd)

#calculate mean of performance metrics
perf_means = apply(all_data[,performance_metrics],2,mean)

#create data frame of performance metric means and standard deviations
performance_metric_table = as.data.frame(cbind("Performance Metric" = performance_metrics_report,
                                 "Mean" = perf_means,
                                 "Standard Deviation" = standard_devs))

#convert columns to numeric
performance_metric_table[,2] = as.numeric(performance_metric_table[,2])

performance_metric_table[,3] = as.numeric(performance_metric_table[,3])

#calculate coefficient of variation
performance_metric_table$CoV = performance_metric_table[,3]/performance_metric_table[,2]

#remove rownames from data frame
rownames(performance_metric_table) = c()

