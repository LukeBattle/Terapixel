(tile_runtime_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = runtime)) +
  geom_point() +
  labs(
    x = "x",
    y = "y",
    title = "",
    color = "Runtime (seconds)"
  ) + scale_color_gradient2(midpoint=mean(filter(all_data,level == 12)$runtime), low="green", mid="white",
                             high="red", space = "Lab",guide = "colourbar"))

(tile_mem_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = MemUtilPerc)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "",
      color = "% RAM Used"
    ) + scale_color_gradient2(midpoint=mean(filter(all_data,level == 12)$MemUtilPerc), low="green", mid="white",
                              high="red", space ="Lab"))

(tile_power_plot  = ggplot(data = filter(all_data,level == 12), aes(x = x, y = y, color = powerDraw)) +
    geom_point() +
    labs(
      x = "x",
      y = "y",
      title = "",
      color = "Power Draw (watts)"
    ) + scale_color_gradient2(midpoint=median(filter(all_data,level == 12)$powerDraw), low="green", mid="white",
                               high="red", space ="Lab"))


(runtime_hist = ggplot(all_data) + aes(runtime) + geom_histogram(bins = 15) +
    labs(
      x = "Runtime (seconds)",
      y = "Frequency"
    ))

(temp_hist = ggplot(all_data) + aes(tempC) + geom_histogram(bins = 15) +
    labs(
      x = "Temperature (celsius)",
      y = "Frequency"
    ))

(power_hist = ggplot(all_data) + aes(powerDraw) + geom_histogram(bins = 15) +
    labs(
      x = "Power Draw (watts)",
      y = "Frequency"
    ))
(mem_hist = ggplot(all_data) + aes(MemUtilPerc) + geom_histogram(bins = 15) +
    labs(
      x = "% Memory Usage",
      y = "Frequency"
    ))
(gpu_hist = ggplot(all_data) + aes(GpuUtilPerc) + geom_histogram(bins = 15) +
    labs(
      x = "% GPU Usage",
      y = "Frequency"
    ))

performance_metrics = c("runtime","powerDraw","tempC","MemUtilPerc","GpuUtilPerc")

performance_metrics_report = c("Render Time (seconds)", "Power Draw (watts)", "Temperature (celsius)",
                               "% Memory Usage", "% GPU Usage")

standard_devs = apply(all_data[,performance_metrics],2,sd)

perf_means = apply(all_data[,performance_metrics],2,mean)

performance_metric_table = as.data.frame(cbind("Performance Metric" = performance_metrics_report,
                                 "Mean" = perf_means,
                                 "Standard Deviation" = standard_devs))

performance_metric_table[,2] = as.numeric(performance_metric_table[,2])

performance_metric_table[,3] = as.numeric(performance_metric_table[,3])

performance_metric_table$CoV = performance_metric_table[,3]/performance_metric_table[,2]

rownames(performance_metric_table) = c()


